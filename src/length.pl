#!/usr/bin/perl
# Read a fasta file and extract the sequence data
use fasta;

sub count {
    my (@lines) = @_;

    my ($n, $g, $c, $total) = (0, 0, 0, 0);
    foreach my $line (@lines)  {
		$total += length($line);
		# the tr operator counts the number of a particular character in a string
		$n += ($line =~ tr/N//);
		$g += ($line =~ tr/G//);
		$c += ($line =~ tr/C//);
    }

    return ($n, $g, $c, $total);
}

my $filename = "../plum_0630.scafSeq.FG";
my @lines = get_lines($filename, 0);
my ($n, $g, $c, $total) = count(@lines);
print "Total Length: ", $total, "\n";
print "Effective Length: ", $total - $n, "\n";
print "N Length: ", $n, "\n";
print "GC Length: ", $g + $c, "\n";
print "GC Rate: ", ($g + $c) / $total, "\n";

# Total Length: 60233856
# N Length: 2596440
# GC Length: 21508836
# GC Rate: 0.357088810651604
