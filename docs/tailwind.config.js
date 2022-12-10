/** @type {import('tailwindcss').Config} */

const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./output/**/*.html",
    "./src/**/*.{html,md,liquid,erb,serb,rb}",
    "./frontend/javascript/**/*.js",
  ],
  safelist: ["pre.highlight"],
  theme: {
    extend: {
      screens: {},
      fontFamily: {
        // https://fonts.google.com/share?selection.family=Nunito:ital,wght@0,200;0,400;0,700;0,900;1,400%7CSource%20Code%20Pro:ital,wght@0,400;0,600;0,700;1,400;1,600;1,700
        sans: ["Nunito", ...defaultTheme.fontFamily.sans],
        mono: ["Source Code Pro", ...defaultTheme.fontFamily.mono],
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
