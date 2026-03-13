# Zinco

**Zinco** is a self-hosted, developer-controlled meta-framework for background jobs and durable workflows. Built for high performance and total data sovereignty, it combines the raw power of **Zig** with the exceptional developer experience of **TypeScript**.

## Vision

Zinco is designed to be **injected, not imposed**. It runs entirely within your infrastructure, leveraging your existing database and authentication systems while providing features typically found in premium SaaS workflow orchestrators.

## 📖 Documentation

For a deep dive into the project, check out our documentation:

- [**The Zinco Idea**](docs/ideia.md) - Why we built Zinco and the problems it solves.
- [**Technical Architecture**](docs/arch.md) - Detailed breakdown of the Zig core, TS layer, and IPC.
- [**Security Measures**](docs/security.md) - Comprehensive security measures for Zinco.
- [**Security Policy**](SECURITY.md) - Instructions for reporting vulnerabilities.
- [**Project Roadmap**](docs/roadmap.md) - Our journey from MVP to distributed power.

---

## Quick Tips

> [!TIP]
> **Data Sovereignty First**: Since Zinco uses your own PostgreSQL or SQLite, you can query job states directly in your SQL editor for debugging or custom reporting.

> [!TIP]
> **Hybrid Performance**: Logic written in TypeScript is executed by high-performance Zig-managed workers. Keep your application code clean while the core handles the heavy lifting.

> [!TIP]
> **Embeddable Dashboard**: Use the React component library (coming soon) to integrate the Zinco dashboard directly into your existing admin panels.

---

## License

[MIT](LICENSE)