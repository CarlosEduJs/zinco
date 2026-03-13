# Zinco: The Self-Hosted, Developer-Controlled Workflow Meta-Framework

## The Problem with Modern Workflow Orchestration

In today's complex application landscape, managing background jobs and long-running workflows is crucial. Developers often turn to powerful tools like Trigger.dev, Inngest, or Temporal to handle tasks such as email sending, video processing, or data synchronization. While these platforms offer robust solutions, they frequently come with trade-offs:

*   **SaaS Lock-in**: Many solutions operate as Software-as-a-Service (SaaS), requiring developers to send sensitive data to external cloud providers. This raises concerns about data sovereignty, compliance, and vendor lock-in.
*   **Complex Self-Hosting**: For those opting for self-hosted alternatives, the setup and maintenance can be daunting, often involving intricate Docker deployments, Kubernetes configurations, or managing external message brokers like Redis or Kafka.
*   **Developer Experience Gaps**: Local development and debugging can be cumbersome, requiring tunnels, mock servers, or complex environment setups that break the natural flow of development.

## Introducing Zinco: Your Workflow, Your Control

Zinco emerges as a revolutionary meta-framework designed to empower developers with **complete control** over their background jobs and durable workflows. Inspired by the capabilities of leading orchestration platforms but fundamentally rejecting the SaaS model, Zinco is built on a philosophy of being **injectable, self-hosted, and deeply integrated** into your existing application stack.

Our vision for Zinco is to provide a high-performance, highly observable, and incredibly developer-friendly solution that runs entirely within your infrastructure, leveraging the tools and databases you already use.

## Core Philosophy: Injected, Not Imposed

Zinco is not a platform you deploy *alongside* your application; it's a set of powerful libraries and binaries you integrate *into* your application. This fundamental difference ensures:

*   **Data Sovereignty**: All job states, payloads, and execution logs reside exclusively within your database, under your direct control. No sensitive data ever leaves your perimeter.
*   **Seamless Integration**: Zinco's SDK and dashboard components are designed to feel like native extensions of your application, not external services.
*   **Zero-Overhead Local Development**: Develop and debug workflows locally without complex setups, tunnels, or external dependencies. Zinco works where your code works.

## The Zinco Architecture: A Hybrid Powerhouse (Zig + TypeScript)

Zinco's innovative architecture combines the best of two worlds: the raw performance and efficiency of **Zig** for its core orchestration engine, and the developer-friendly productivity of **TypeScript** for its SDK and application-facing components.

### The Zig Core: Performance at the Edge

The heart of Zinco is a lean, compiled binary written in **Zig**. This choice is deliberate, enabling Zinco to achieve unparalleled performance and resource efficiency for critical infrastructure components:

*   **Orchestrator**: Manages job queues, state transitions, and workflow execution with minimal latency.
*   **Worker Runtime**: Efficiently spawns and monitors Node.js/Bun processes for job execution, handling resource management and fault tolerance.
*   **Scheduler**: Provides precise and low-overhead scheduling for time-based jobs and workflow steps.
*   **Locks & Job Claiming**: Implements robust and performant concurrency control mechanisms to ensure reliable job distribution and prevent race conditions.

By leveraging Zig, Zinco can offer near-native performance, making it suitable for even the most demanding workloads while consuming minimal CPU and memory resources.

### The TypeScript Layer: Unmatched Developer Experience

While Zig handles the heavy lifting, **TypeScript** provides the intuitive and productive interface for developers:

*   **SDK**: A type-safe, easy-to-use SDK allows developers to define jobs and workflows directly within their TypeScript/JavaScript applications, leveraging familiar syntax and IDE support.
*   **Workflow DSL**: A Domain-Specific Language (DSL) for defining complex, durable workflows with steps, retries, and pauses, all within the comfort of TypeScript.
*   **Embeddable Dashboard**: A React-based component library for the dashboard, allowing developers to integrate a powerful monitoring and management interface directly into their existing web applications (e.g., Next.js, Remix). This means your existing authentication and authorization systems can protect your workflow dashboard.

### Dual Operation Modes for Flexibility

Zinco supports two primary operation modes, catering to diverse deployment needs:

1.  **Database-Connected Worker (Default)**: For maximum simplicity, a Zig-powered CLI worker connects directly to your application's database (e.g., PostgreSQL via Prisma) to pick up and execute jobs. This mode offers low latency and requires no public HTTP endpoints.
2.  **HTTP-Driven Orchestrator (Optional)**: For serverless environments or greater decoupling, a lightweight Zig orchestrator can communicate with your application via a dedicated HTTP endpoint. This mode enables durable execution across distributed systems with ease.

## Key Differentiators: Why Zinco?

*   **True Self-Hosting & Data Sovereignty**: Your data stays yours. Zinco operates entirely within your infrastructure, eliminating concerns about external data exposure or vendor lock-in.
*   **Hybrid Performance (Zig + TS)**: Achieve the best of both worlds: the raw speed and efficiency of Zig for core operations, combined with the development velocity and type safety of TypeScript for application logic.
*   **Seamless Developer Experience**: Define, trigger, and monitor workflows with an intuitive TypeScript SDK and an embeddable React dashboard that integrates with your existing authentication.
*   **Zero-Config Local Development**: For local environments, Zinco's Zig core can optionally utilize an embedded SQLite database, offering a truly zero-setup experience.
*   **Comprehensive Observability**: Built-in OpenTelemetry integration provides structured logs, metrics, and traces, giving you deep insights into your workflow executions.
*   **Robust Error Handling**: Configurable retries, Dead Letter Queues (DLQs), and alert integrations ensure your workflows are resilient to failures.

## Future Vision

Zinco is committed to continuous evolution, with a roadmap that includes support for additional databases (Redis, MySQL), advanced scheduling (cron), SDKs for other languages (Python, Go), and enhanced dashboard visualizations.

## Join the Zinco Movement

Zinco is more than just a framework; it's a movement towards empowering developers with control, performance, and an unparalleled experience in building resilient and scalable applications. We invite you to explore Zinco and redefine how you build and manage your workflows.
