$latex  = 'uplatex -synctex=1';
$bibtex = 'upbibtex --kanji-internal=uptex';
$dvipdf  = 'dvipdfmx %O -o %D %S';
$makeindex = 'upmendex %O -o %D %S';
if ($^O eq 'darwin') {
    $pdf_previewer = 'open -a Preview';
} elsif ($^O eq 'linux') {
    $pdf_previewer = 'evince';
}
$pdf_mode = 3;                  #  3 = create pdf file by dvipdf
$pdf_update_method = 0;         #  0 =  auto update
