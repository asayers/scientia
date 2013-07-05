This is a half-finished document publishing platform I was working on. Users write documents using Markdown, which is then converted into latex and spliced into a template. The template can be user-defined, and is written in latex/liquid. The user can also attach their own bibtex databases. Updated documents are added to a queue (in Redis) for asynchronous recomilatation.

The killer feature was supposed to be the ability to share templates. Bibliographic databases could also be shared. With a suffiently large latex-savvy userbase, users less familiar with latex could get away with only writing markdown by cloning templates from other users.

Anyway, it's in a more-or-less working state. I abandoned the idea when I discovered that [many][1] [similar][2] [things][3] [already][4] [exist][5].


[1]: https://www.writelatex.com/
[2]: http://www.scribtex.com/
[3]: https://www.sharelatex.com/
[4]: https://notex.ch/
[5]: https://github.com/yoavram/markx



Scientia Communis
=================

Remember to install
- texlive-most
- rubber
- imagemagick
- ghostscript (otherwise RMagic can't open pdfs)



Scientia is a tool which allows you to publish academic papers with ease. Documents are written in Extended Markdown, and are rendered to pdf using the Latex typesetting system. The following is how you'd write a typical document in Scientia.

Each document is associated with a template, written in latex, which defines the formatting of the resultant pdf. Templates can also be used to extend the features available to you when writing your documents; you could, for instance, use a template which provides multi-column support, or the ability to change the font colour. Scientia uses the full TexLive implementation, so there are is vast number of Latex packages available. (One caveat: you cannot reference additional files, such as images or fonts---yet.) You can write your own templates, or, if you find one you like made by someone else, simply clone it to start using it with your own documents.

Scientia also features bibliography support. Simply write (or clone) a bibliography file and associate it with a document to start referencing works listed in it. Bibliographies are written in bibtex format, and are referenced using the syntax demonstrated above.
