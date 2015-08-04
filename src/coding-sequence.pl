#!/usr/bin/perl
# Extract CDS
use fasta;

sub extract_cds {
	my ($gff_file, $cds_file, %fasta_lines) = @_;
	
    unless( open(GFF_FH, $gff_file) ) {
        print STDERR "Cannot open file \"$gff_file\"\n\n";
        exit;
    }

    unless( open(OUT_FH, ">$cds_file") ) {
        print STDERR "Cannot open file \"$cds_file\"\n\n";
        exit;
    }

    my @filedata = <GFF_FH>;
    close GFF_FH;
	my $mRNA_sequence = "";
	my $mRNA_label = "";
	my $mRNA_start = 0;
	my $mRNA_end = 0;
    foreach my $line (@filedata) {
		# split each line using tab (\t) as separator
		my @fields = split(/\t/, $line);
		# find mRNA line
		if ($fields[2] eq "mRNA") {
			# print the last mRNA sequence if there is any
			if (length($mRNA_sequence) > 0) {
				print OUT_FH ">$mRNA_label mRNA $mRNA_start $mRNA_end\n";
				print OUT_FH $mRNA_sequence, "\n";
			}
			# initial the next mRNA sequence
			$mRNA_sequence = "";
			# get the label of the mRNA sequence
			$mRNA_label = $fields[0];
			($mRNA_start, $mRNA_end) = ($fields[3], $fields[4]);
		}
		# find CDS line
		if ($fields[2] eq "CDS") {
			# get the label of the sequence
			my $cds_label = $fields[0];
			# get the sequence from dict $fasta_lines using $cds_label as the search key
			my $sequence = $fasta_lines{$cds_label};
			# get the start and end positions from line fields
			my ($start, $end) = ($fields[3], $fields[4]);
			my $size = $end - $start + 1;
			# extract the subsequence
			my $subseq = substr($sequence, $start, $size);
			# append to mRNA sequence
			$mRNA_sequence .= $subseq;
		}
	}
	close OUT_FH;
}

my $fasta_file = "../plum_0630.scafSeq.FG";
# get lines from fasta file
my %fasta_lines = get_line_dict($fasta_file, 0);
my $gff_file = "../Prunus_mume_scaffold.gff";
my $cds_file = "../Prunus_mume_scaffold.fasta";
extract_cds($gff_file, $cds_file, %fasta_lines);
print "output CDS to file $cds_file\n";
