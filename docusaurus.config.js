// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require("prism-react-renderer/themes/nightOwlLight");
const darkCodeTheme = require("prism-react-renderer/themes/nightOwl");

/** @type any} */
const mermaid = require("mdx-mermaid");

const { NODE_ENV } = process.env;
const isProduction = true ?? NODE_ENV === "production";

const colors = {
  gray: { 500: "#64748b" },
  blue: { 500: "#5b51ff" },
  red: { 500: "#ef4444" },
  green: { 500: "#00c079" },
  yellow: { 500: "#facc15" },
  cyan: { 500: "#06b6d4" },
};

const redocConfig = {
  options: {
    nativeScrollbars: false,
  },
  theme: {
    colors: {
      primary: {
        main: colors.blue["500"],
      },
      success: {
        main: colors.green["500"],
      },
      warning: {
        main: colors.yellow["500"],
      },
      error: {
        main: colors.red["500"],
      },

      responses: {
        info: {
          color: colors.cyan["500"],
        },
      },
      http: {
        get: colors.green["500"],
        post: colors.blue["500"],
        put: colors.gray["500"],
        delete: colors.red["500"],
      },
    },

    typography: {
      fontSize: "16px",
      fontWeightRegular: "400",
      fontWeightBold: "500",
      fontWeightLight: "300",
      fontFamily: "'Inter', sans-serif",
      headings: {
        fontFamily: "'Inter', sans-serif",
        fontWeight: "400",
      },
      code: {
        fontSize: "14px",
        fontFamily: "'JetBrains Mono', monospace",
      },
    },

    logo: {
      gutter: "0px",
    },

    rightPanel: {
      // width: "40%",
    },
  },
};

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "belo engineering",
  tagline: "Make it simple, make it belo",
  url: "https://tech.belo.app",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.png",
  organizationName: "belo",
  projectName: "mimir",

  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          remarkPlugins: [mermaid],
        },
        blog: {
          showReadingTime: true,
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
    [
      "redocusaurus",
      {
        specs: [
          {
            spec: isProduction
              ? "https://api.stg.belo.app/v1/docs/json"
              : "http://localhost:3000/v1/docs/json",
            route: "/v1/",
          },
          {
            spec: "https://api.stg.belo.app/v2/docs/json",
            route: "/v2/",
          },
          {
            spec: "https://api.stg.belo.app/v1/docs/json",
            route: "/_v3/",
          },
        ],

        theme: redocConfig,
      },
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: "",
        logo: {
          alt: "belo",
          src: "img/logo.png",
        },
        items: [
          {
            to: "/blog",
            label: "Blog",
            position: "right",
          },
          {
            type: "doc",
            docId: "introduction",
            position: "right",
            label: "Docs",
          },
          {
            type: "dropdown",
            label: "API",
            position: "right",
            items: [
              {
                href: "/v1",
                label: "V1",
              },
              {
                href: "/v2",
                label: "V2",
              },
              {
                href: "/v3",
                label: "V3",
              },
            ],
          },

          // {
          //   to: "/pricing",
          //   label: "Pricing",
          //   position: "right",
          // },

          {
            href: "https://comunidad.belo.app",
            position: "right",
            className: "ph-lg ph-discord-logo",
            "aria-label": "Discord",
          },
          {
            href: "https://twitter.com/belo_app",
            position: "right",
            className: "ph-lg ph-twitter-logo",
            "aria-label": "Twitter",
          },
          {
            href: "https://github.com/belo-app/mimir",
            position: "right",
            className: "ph-lg ph-github-logo",
            "aria-label": "GitHub repository",
          },
        ],
      },
      footer: {
        copyright: `${new Date().getFullYear()} - Designed with ❤️ by 🦄 who believe in internet magic money - belo`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
