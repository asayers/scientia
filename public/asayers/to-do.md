% Textore Change Log
% Alex Sayers

Technologies
========

 - Pandoc for markdown -> tex
 - pdflatex (with some wrapper?) for tex -> pdf
 - moustache for templating

To Do
====

- Figure out why Essay template produces a blank page
- Use js on doc#show to query for pdf readiness (a couple of times a second?)
- Don't write so many temporary files :S
- Make doc.regenerate a sidekiq worker, so it can be called synchronously (by doc#update) or async (by tem/bib#update)
- Prevent username updating
- Rewrite template system, using handlebars
- Add bib file to folder during render
- Get metadata rendering in HTML view
- Ensure all html is escaped! Look into XSS.
- Find out where html bullets went (css? normalise?)
- Add private boolean field to Document
- Add timer to flash notices (fade out)
- Retrieve more informative error messages
- Add url-change warning (javascript) to #edit
- In user#show, use html for document previews (span-level only)
- Tighten up SQL queries
- Make document edit field use a monospace font
- Syntax highlighting! (md and latex)
- Lock down sign-ups
- Add icons to description grid (placeholder/font-awesome)
- Add grid-lines to description grid?


Under Consideration
---------------------------

- Isolate MathJax to document#show?
- Replace compass with bourbon?
- Change name? (Sapientum?)
- Move metadata out of body?
- Move document preview into iframe?
- Separate stylesheet for doc preview?
- Button to generate bibtex snipped for document.
- Autogenerate full textore bibliography.
- Sandbox pdflatex/pandoc
- Change rtex for rubbr?
- Add description column to template? (and document?)

Completed
=======

- ~~Escape HTML in markdown for safety~~
- ~~Fix bibliographic style stuff~~
- ~~Add errors column to Document~~
- ~~Add error field to document#show~~
- ~~Get pdf worker to update errors~~
- ~~Change "nil" template selection so it displays as "default"~~
- ~~Replace pdf with nil in doc#regenerate, and check for nil in the view, changing the button to "generating..." (disabled).~~
- ~~Add big ol' BETA message to home page (and every other?)~~
- ~~Add pdf column to templates~~
- ~~Add default doc to root~~
- ~~Expand markdown edit pane, remove caption~~
- ~~Add user detail-editing~~
- ~~Change documents' "markdown" column to "body"~~
- ~~Seed root user~~
- ~~Move welcome doc to root~~
- ~~Validate doc and template owned by same user~~
- ~~Add bibliographies~~
- ~~Add custom latex templates~~
- ~~Replace username by "you" on document#show for documents you own~~
- ~~Allow direct latex input (inline in markdown? Separate input mode?)~~
- ~~Hide edit and delete controls when a document isn't owned by current_user~~
- ~~Respond_to .md and add view control~~
- ~~Fix overflowing controls on document#show~~
- ~~Add ability to clone others' templates~~
- ~~Add template selector (own templates) to doc#edit~~
- ~~Icon grid description thing~~
- ~~Figure out why "essay" template messes up tables~~
- ~~Add sign up button to home page~~
