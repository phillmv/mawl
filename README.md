# MAWL: Make a WebLog!

MAWL is a zero-configuration static site generator that takes markdown or html files and spits out a blog-like website.

MAWL is opinionated, yet fully customizable, and was designed for busy people who know how to make websites but have other things to do.

## Goals

- Literally, get a website with zero-configuration.
  - In goes a repository with markdown files & images & pdfs, etc, and out comes a _fully functioning blog-like website_.
  - Press a button to add the GitHub Action, and then it gets published thru GitHub Pages, that kind of thing.
  - I mean it! Just you and markown, or html.
- But if you're feeling fancy, you can also override the default templates & sass stylesheets & do whatever you need to do.
  - I'm not here to judge. You do you, friend.

## Examples

I'm currently cleaning these up, so for now they're a bit scattered:

- For a simple example, see: https://phillmv.github.io/public2/ aka https://github.com/phillmv/public2 , or

- For a fancy example, see http://okayfail.com aka https://github.com/phillmv/okayfail.com/tree/master/source

## Features

- Reverse chronological timeline of entries
- Write entries in markdown or html
- File-based routing, i.e. the file paths in your folder are exactly what you get in the final site.
- Browse entries by #tag, or @mention
- RSS feeds, one for the whole site, and one per #tag and per @mention
- Customize anything you want using templates in ERB and Sass. Or don't!

## Who is this for?

- Programmers who need to write notes or documentation in an easy-to-share-way but gated inside their Organization's single-sign-on for confidentiality reasons.
- Academics who really should be sharing their research in an open way so they can reach a wider audience, but lack the wherewithal to put a website together.
- Activists who organize online and write extremely compelling and interesting threads on twitter, but really can't be arsed to make a whole friggin' website 'cos it's a big pain in the ass, and so instead all of their interesting content just fades from view, buried in the timeline, unreachable by searching, lost in time like tears in rain.

I assume you understand what html, markdown, a website, and a GitHub repository is. To customize things you'll need to know a bit of CSS, Sass, and some eRuby.

## What do you mean by Markdown files?

I mean, files ending in `.md` or `.markdown` whose contents look like this:

```
---
occurred_at: 2021-12-31
---

# hello world, this is our title

this is valid markdown, with a yaml front-matter. add #tags or @mention people as you wish.
```

will be converted to html. Also, any non markdown files will be copied over as well.

Strictly speaking, the frontmatter is optional. If there is no frontmatter, MAWL will use the file's timestamp.

The following keys are supported:

```
occurred_at: <timestamp> # sets the date an entry occurred at
hide: <boolean> # prevents an entry from appearing in the timeline
subject: <string> # forcibly sets an entry title
```

## Can you provide more extensive documentation and examples?

I'm getting this off the ground. For now, the best example really is my personal site: https://github.com/phillmv/okayfail.com/tree/master/source

- Inside each entry, in the frontmatter, you can define `occurred_at` for specifying a particular date. You can also set `hide: true` to avoid showing the entry in the timeline.
- The `.site/` folder is special, and so is the `.site/config.yaml` file. You can override views by adding templates to `.site/views/`.
- If you want to customize css, put all of your stuff inside `stylesheets/application.css.scss`.

More to come! Feel free to file an issue or bug me on [twitter](https://twitter.com/phillmv).

## Getting Started

Add the following to your own repo, under the `.github/workflows/mawl.yml` file path.

```yaml
name: MAWL

on:
  workflow_dispatch:
  push:
    branches: [main]

jobs:
  build_and_deploy:
    name: Make a Weblog
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & deploy to GitHub Pages
        uses: phillmv/mawl@main
```

You may also define a `CNAME`, an `INPUT_FOLDER` (i.e. my-repo/docs) and a target `GITHUB_REPOSITORY` which will host the GitHub Page.
