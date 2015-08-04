#!/usr/bin/perl
# Read a fasta file and compute N50, N90
use fasta;

sub statistic {
    my($percent, @lines) = @_;

    # sort lines descendingly with line length as sorting key
    @lines = sort { length($b) <=> length($a) } @lines;
    # initialize total length
    my $total = 0;
    foreach my $line (@lines)  {
        $line_length = length($line);
		# add to total length
        $total += $line_length;
    }
    # start to compute N50, N90,... statistic
    my $accumulate = 0;
    my $line_length = 0;
    foreach my $line (@lines)  {
        $line_length = length($line);
		# the length of sequence so far
        $accumulate += $line_length;
		# if the ratio of $accumulate and $total is larger than $percent, 
		# current value of $line_length is the answer.
        if ($accumulate / $total >= $percent) {
            last;
        }
    }

    return $line_length;
}

my $filename = "../plum_0630.scafSeq.FG";
my @lines = get_lines($filename, 1);
my $N50 = statistic(0.5, @lines);
print "N50: ", $N50, "\n";
my $N90 = statistic(0.9, @lines);
print "N90: ", $N90, "\n";

# N50: 1580070
# N90: 1085026
