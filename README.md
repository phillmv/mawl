# mawl: Make A Weblog!

mawl is a zero-configuration static site generator.

Given a repository with markdown or html files, mawl uses GitHub Actions to 
- create a static bloggish website
  - with a timeline,
  - and rss feeds,
  - and tags,
- and publishes it to GitHub Pages.

mawl is opinionated, but flexible, and was designed for busy people who know how to make websites but have other things to do.

## How does it work?

1. Write markdown or html files
2. Install action in your repo
3. Website comes out

A file with a path like this:
- `foo/bar/example.md`, will end up 
- `foo/bar/example.html`

**Example:** This [repository](https://github.com/phillmv/public2), generates [this site](https://phillmv.github.io/public2/).

## Getting started

First we have to add the [Action](https://docs.github.com/en/actions) to your repository, and make sure [GitHub Pages is turned on](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site#creating-your-site).

Pick a repository, and create a file with the path of:

`.github/workflows/mawl.yml`

and paste in:

```yaml
name: mawl

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

Then, write content!

Files ending with `.markdown`, `.md` and `.html` will get added to the site's timeline. For customization options, see below.

Once you're done, [turn on GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site#creating-your-site) and make sure the `gh-pages` branch is selected.

Congratulations! You have a website.

## Goals

- Literally, get a static website with zero-configuration.
- But also if you're feeling fancy, do your own thing, I'm not here to judge, do your own thing. 

I still have TODO docs on how to customize templates & what all the options are.

## Examples

I'm currently cleaning these up, so for now they're a bit scattered:

- For a simple example, see: https://phillmv.github.io/public2/ aka https://github.com/phillmv/public2 , or

- For a fancy example, see http://okayfail.com aka https://github.com/phillmv/okayfail.com/tree/master/source


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

## How do I customize the site? / Can you provide more extensive documentation and examples?

You can set a custom header title & description by creating either of two files:

- `_title.md` and
- `_description.md`

You can also overhaul all of the CSS and every template with your own custom code. I'm still getting this project off the ground, so for now, the best example really is my personal site: https://github.com/phillmv/okayfail.com/tree/master/source

- The `.site/` folder is special, and so is the `.site/config.yaml` file.
- You can override views by adding templates to `.site/views/`.
- If you want to customize css, put all of your stuff inside `stylesheets/application.css.scss`.

More to come! Feel free to file an issue or bug me on [twitter](https://twitter.com/phillmv).

## More Options

(You may also define a `CNAME`, an `INPUT_FOLDER` (i.e. my-repo/docs) and a target `GITHUB_REPOSITORY` which will host the GitHub Page, i.e. in the `.github/workflows/mawl.yml` file,

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
        with:
          CNAME: 'example.com'
          INPUT_FOLDER: 'docs'
          GITHUB_REPOSITORY: 'foobar/github-page'
```

