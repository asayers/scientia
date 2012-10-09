Textore
=======


Textore is a tool which allows you to publish academic papers with ease. Documents are written in Extended Markdown, and are rendered to pdf using the Latex typesetting system. The following is how you'd write a typical document in Textore.

Each document is associated with a template, written in latex, which defines the formatting of the resultant pdf. Templates can also be used to extend the features available to you when writing your documents; you could, for instance, use a template which provides multi-column support, or the ability to change the font colour. Textore uses the full TexLive implementation, so there are is vast number of Latex packages available. (One caveat: you cannot reference additional files, such as images or fonts---yet.) You can write your own templates, or, if you find one you like made by someone else, simply clone it to start using it with your own documents.

Textore also features bibliography support. Simply write (or clone) a bibliography file and associate it with a document to start referencing works listed in it. Bibliographies are written in bibtex format, and are referenced using the syntax demonstrated above.
