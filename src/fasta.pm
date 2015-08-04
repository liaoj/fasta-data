# returns a dict whose key is sequence label and value is sequence string
sub get_line_dict {

    my($filename, $discardN) = @_;
    my @filedata = (  );

    unless( open(GET_FILE_DATA, $filename) ) {
        print STDERR "Cannot open file \"$filename\"\n\n";
        exit;
    }

    @filedata = <GET_FILE_DATA>;
    close GET_FILE_DATA;
    # create an empty dict
    my %lines = ( );
    # the sequence label
    my $label = '';
    foreach my $line (@filedata) {
        # discard blank line
        if ($line =~ /^\s*$/) {
            next;
        # discard comment line
        } elsif($line =~ /^\s*#/) {
            next;
        # save sequence label
        } elsif($line =~ /^>(\w+)/) {
            $label = $1;
            next;
        # keep line
        } else {
            # remove non-sequence data (in this case, whitespace)
            $line =~ s/\s//g;
            # remove Ns from sequence if necessary
            if ($discardN != 0) {
                $line =~ tr/N//d;
            }
            # add to dict
            $lines{$label} = $line;
        }
    }

    return %lines;
}

# returns an array of sequence strings from a FASTA file
sub get_lines {

    my($filename, $discardN) = @_;
    my @filedata = (  );

    unless( open(GET_FILE_DATA, $filename) ) {
        print STDERR "Cannot open file \"$filename\"\n\n";
        exit;
    }

    @filedata = <GET_FILE_DATA>;
    close GET_FILE_DATA;
    my @lines = ( );
    foreach my $line (@filedata) {
        # discard blank line
        if ($line =~ /^\s*$/) {
            next;
        # discard comment line
        } elsif($line =~ /^\s*#/) {
            next;
        # discard fasta header line
        } elsif($line =~ /^>/) {
            next;
        # keep line, add to array
        } else {
            # remove non-sequence data (in this case, whitespace)
            $line =~ s/\s//g;
            # remove Ns from sequence if necessary
            if ($discardN != 0) {
                $line =~ tr/N//d;
            }
            # add to list
            push (@lines, $line);
        }
    }

    return @lines;
}

sub print_sequence {

    my($sequence, $length) = @_;

    # Print sequence in lines of $length
    for ( my $pos = 0 ; $pos < length($sequence) ; $pos += $length ) {
        print substr($sequence, $pos, $length), "\n";
    }
}

1;
