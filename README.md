SimplePageManager
=================

Simple Page Manager - A Ruby-application to generate static webpages (json-files instead of a database)


Draft
=====

![SPM Draft](https://raw.github.com/iboard/spm/master/doc/spm-drafts.png "Simple Page Manager - Draft")


Examples
========

    app = Application.new(:development)
    app.run(:create, id: 1, title: 'First Page, body: "Lorem ipsum....")
    app.run(:create, id: 2, title: 'Second Page, body: "Lorem ipsum....")
    app.run(:build_pages)
    app.run(:index, output: "index.html", format: :html)

    Outputs =>

    ...data_development/
        1.json
        2.json
    ...html_development/
        index.html
        1.html
        2.html
        assets/pages.css

RSpec
=====

    rspec --format d --color spec/

    Outputs =>

    Application
      should exit with 0 if no errors
      should exit with -n if any errors
      should create the version-page run(:version)
      should create data-file run(:create, 1, '...', '...')
      should update data-file run(:update, 1, '...', '...')
      should clean up the output path run(:clean_pages)
      should build output files for all pages run(:build_pages)
      should create the index page run(:index)
      should create assets/pages.css

    PageRenderer
      should render a page with a given template

    Page
      should store id and title
      should find a page by it's id

    TemplateFinder
      should initialize a template

    Template
      should load template file

    Finished in 0.12523 seconds
    14 examples, 0 failures


For more information RTFC ;-)


License
=======

Public Domain Dedication
------------------------

This work is a compilation and derivation from other previously released works. With the exception of
various included works, which may be restricted by other licenses, the author or authors of this code
dedicate any and all copyright interest in this code to the public domain. We make this dedication for
the benefit of the public at large and to the detriment of our heirs and successors. We intend this
dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this
code under copyright law.

(c) 2012 by Andreas Altendorfer, <andreas@altendorfer.at>