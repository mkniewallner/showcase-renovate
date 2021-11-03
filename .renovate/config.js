module.exports = {
  repositories: [
    "mkniewallner/showcase-renovate",
  ],
  username: "mkv-renovate[bot]",
  gitAuthor: "Self-hosted Renovate Bot <93540633+mkv-renovate[bot]@users.noreply.github.com>",
  hostRules: [
    {
      matchHost: "https://gitlab.com/api/v4/projects/30941368/packages/pypi/simple",
      username: process.env.GITLAB_PYPI_SECRET_NAME,
      password: process.env.GITLAB_PYPI_SECRET,
    },
  ],
};
