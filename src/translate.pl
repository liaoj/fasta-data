#!/usr/bin/perl
# Translate DNA

my %codon_table = (
    'TTT', 'F',      'CTT', 'L',      'ATT', 'I',      'GTT', 'V',
    'TTC', 'F',      'CTC', 'L',      'ATC', 'I',      'GTC', 'V',
    'TTA', 'L',      'CTA', 'L',      'ATA', 'I',      'GTA', 'V',
    'TTG', 'L',      'CTG', 'L',      'ATG', 'M',      'GTG', 'V',
    'TCT', 'S',      'CCT', 'P',      'ACT', 'T',      'GCT', 'A',
    'TCC', 'S',      'CCC', 'P',      'ACC', 'T',      'GCC', 'A',
    'TCA', 'S',      'CCA', 'P',      'ACA', 'T',      'GCA', 'A',
    'TCG', 'S',      'CCG', 'P',      'ACG', 'T',      'GCG', 'A',
    'TAT', 'Y',      'CAT', 'H',      'AAT', 'N',      'GAT', 'D',
    'TAC', 'Y',      'CAC', 'H',      'AAC', 'N',      'GAC', 'D',
    'TAA', 'Stop',   'CAA', 'Q',      'AAA', 'K',      'GAA', 'E',
    'TAG', 'Stop',   'CAG', 'Q',      'AAG', 'K',      'GAG', 'E',
    'TGT', 'C',      'CGT', 'R',      'AGT', 'S',      'GGT', 'G',
    'TGC', 'C',      'CGC', 'R',      'AGC', 'S',      'GGC', 'G',
    'TGA', 'Stop',   'CGA', 'R',      'AGA', 'R',      'GGA', 'G',
    'TGG', 'W',      'CGG', 'R',      'AGG', 'R',      'GGG', 'G'
);

sub translate_dna {
	my ($cds_file, $prot_file) = @_;
	
    unless( open(CDS_FH, $cds_file) ) {
        print STDERR "Cannot open file \"$cds_file\"\n\n";
        exit;
    }

    unless( open(OUT_FH, ">$prot_file") ) {
        print STDERR "Cannot open file \"$output_file\"\n\n";
        exit;
    }

    my @filedata = <CDS_FH>;
    close CDS_FH;
    foreach my $line (@filedata) {
		# if it is an annotation line, print it directly
	    if($line =~ /^>/) {
	        print OUT_FH $line;
	    } else {
			# otherwise, translate every 3 bases into a protein and print the protein
		    for ( my $pos = 0 ; $pos < length($line) ; $pos += 3 ) {
				my $codon = substr($line, $pos, 3);
				print OUT_FH $codon_table{$codon};
			}
			print OUT_FH "\n";
	    }
	}
	close OUT_FH;
}

my $cds_file = "../Prunus_mume_scaffold.fasta";
my $prot_file = "../Prunus_mume_scaffold_protein.fasta";
translate_dna($cds_file, $prot_file);
print "output protein sequences to file $prot_file\n";
