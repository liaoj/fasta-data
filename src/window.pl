#!/usr/bin/perl
# Count GC in sliding window
use fasta;

sub sliding_window {
    my($size, $sequence) = @_;

	my @count = ( );
	for ( my $pos = 0 ; $pos < length($sequence) ; $pos += $size) {
		# create a substring starting from $pos and having a length of $size
		my $subseq = substr($sequence, $pos, $size);
		# count number of Gs in the substring
		my $g = ($subseq =~ tr/G//);
		# count number of Cs in the substring
		my $c = ($subseq =~ tr/C//);
		# put the count fo GC in array $count
		push(@count, $g + $c);
	}
	
	return @count
}

my $filename = "../plum_0630.scafSeq.FG";
# get lines from fasta file
my @lines = get_lines($filename, 1);
# join all the lines to get a single sequence
my $sequence = join('', @lines);
# count GC within a sliding window
my @count = sliding_window(250, $sequence);
# print the GC counts
open (OUT, '>../GC-count.txt');
print "output GC count to ../GC-count.txt\n";
foreach my $n (@count) {
	print OUT $n, "\n";
}
