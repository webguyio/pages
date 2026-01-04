# Pages

Create custom SEO-friendly pages within Discourse's layout.

## Features

- Simple admin interface
- Custom meta titles and descriptions
- Clean URLs (`/pizza` instead of `/t/12345`)
- Pages stay within Discourse's header/footer/sidebar layout
- HTML content support

## Installation

```bash
cd /var/discourse
nano containers/app.yml
```

Add to hooks section:
```yaml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/webguyio/pages.git
```

Then rebuild:
```bash
./launcher rebuild app
```

## Usage

1. Go to Admin > Plugins > Pages
2. Click "New Page"
3. Fill in title, slug, and HTML content
4. Add optional SEO meta title and description
5. Save

Your page is live at `https://yoursite.com/your-slug`

## Settings

- `pages_enabled` - Enable/disable plugin (default: true)

## License

Public Domain