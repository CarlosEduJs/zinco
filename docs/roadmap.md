# Zinco Project Roadmap

## Introduction

This document outlines the strategic roadmap for Zinco, a self-hosted, developer-controlled workflow meta-framework. It details the planned development phases, key features, and long-term vision, aiming to provide transparency and guide community contributions. This roadmap is a living document and may evolve based on community feedback, technological advancements, and project priorities.

## Vision & Principles

Zinco's core vision is to empower developers with an open-source, high-performance, and fully controllable solution for background jobs and durable workflows. Our guiding principles include:

*   **Developer Control**: Full ownership of data and infrastructure.
*   **Performance & Efficiency**: Leveraging Zig for a lean, fast core.
*   **Exceptional Developer Experience (DX)**: Intuitive TypeScript SDK and an embeddable dashboard.
*   **Flexibility**: Adaptable to various deployment environments and existing tech stacks.
*   **Observability**: Built-in tools for deep insights into workflow execution.

## Phase 0: Foundations & Architectural Design (Completed)

*   **Objective**: Establish core architectural principles and validate the Zig + TypeScript approach.
*   **Key Achievements**:
    *   Defined Zinco's philosophy as an injectable, self-hosted meta-framework.
    *   Architected a hybrid model leveraging Zig for the high-performance core (orchestrator, scheduler, worker runtime, locks, job claiming) and TypeScript for the SDK, API, DSL, and dashboard.
    *   Conducted in-depth research on Inter-Process Communication (IPC) strategies (Shared Memory vs. Unix Domain Sockets), recommending UDS for initial implementation due to reliability and ease of adoption.
    *   Documented the initial technical architecture and IPC strategy.

## Phase 1: MVP - "Core Ignition"

*   **Objective**: Deliver a functional, stable core capable of executing basic background jobs and simple workflows within the user's environment.
*   **Key Features**:
    *   **Zig Core Engine**: Initial implementation of the orchestrator, scheduler, job claiming, and worker runtime in Zig.
    *   **TypeScript SDK**: Basic API for defining `task()` and `workflow()` with `step.run()`.
    *   **PostgreSQL Persistence**: Schema definition and implementation for storing job and workflow states in PostgreSQL.
    *   **IPC via Unix Domain Sockets**: Robust communication layer between the Zig core and Node.js/Bun worker processes.
    *   **Basic Local Development Dashboard**: A React component library providing a minimal UI to view active jobs and their status.
    *   **Structured Logging**: All core events and job outputs are logged in a structured (JSON) format.
    *   **CLI Tooling**: `zinco dev` command to start the local Zig core and worker, `zinco trigger` for manual job invocation.
*   **Target Audience**: Early adopters and developers seeking a performant, self-hosted job queue.

## Phase 2: Core Feature Expansion - "Workflow Resilience"

*   **Objective**: Enhance Zinco with advanced workflow capabilities, improved reliability, and comprehensive observability.
*   **Key Features**:
    *   **Durable Execution**: Implement `step.sleep()` for pausing workflows and `step.retry()` for configurable retries within jobs and steps.
    *   **Advanced Job Scheduling**: Introduce cron-based scheduling for recurring tasks.
    *   **Dead Letter Queues (DLQ)**: Automatic handling and storage of failed jobs for later inspection and re-processing.
    *   **Full OpenTelemetry Integration**: Comprehensive tracing, metrics, and enhanced logging across the Zig core and TypeScript execution.
    *   **Enhanced Dashboard**: Interactive timeline view for workflows, detailed job logs, and manual event triggering for testing and debugging.
    *   **SQLite Support**: Optional embedded SQLite for zero-config local development and testing environments.
    *   **Error Handling**: Robust error propagation and reporting mechanisms.
*   **Target Audience**: Developers building complex, long-running, and resilient workflows.

## Phase 3: Ecosystem & Scale - "Distributed Power"

*   **Objective**: Expand Zinco's capabilities for distributed environments, offer more persistence options, and broaden language support.
*   **Key Features**:
    *   **Redis Backend Support**: Implement Redis as an alternative, high-performance backend for job queues and state management.
    *   **Alternative Database Support**: Add support for MySQL as a persistence option.
    *   **HTTP-Driven Orchestrator Mode**: Full implementation of the optional mode where the Zig orchestrator communicates with application endpoints via HTTP, enabling serverless deployments.
    *   **SDKs for Other Languages**: Initial SDKs for Python and/or Go, allowing jobs to be written in other languages while leveraging the Zinco core.
    *   **Advanced Dashboard Features**: Workflow dependency visualization, analytics, and custom dashboard extensions.
    *   **Community Contributions**: Establish clear guidelines and processes for external contributions.
*   **Target Audience**: Teams with diverse tech stacks, distributed systems, and high-scale requirements.

## Phase 4: Advanced Capabilities & Long-term Vision - "Innovation & Extensibility"

*   **Objective**: Explore cutting-edge features, further optimize performance, and build a vibrant ecosystem around Zinco.
*   **Key Features**:
    *   **Hybrid IPC (UDS + Shared Memory)**: Implement optional Shared Memory for ultra-high-throughput data transfer for specific use cases (e.g., large data processing, streaming logs).
    *   **Pluggable Storage Backends**: Allow developers to bring their own storage solutions for state persistence.
    *   **Event-Driven Architecture Enhancements**: Advanced event filtering, routing, and transformation capabilities.
    *   **Multi-Tenancy Support**: Features for isolating workflows and data across multiple tenants within a single Zinco deployment.
    *   **AI/ML Workflow Integrations**: Specialized steps and connectors for common AI/ML tasks and frameworks.
    *   **Visual Workflow Builder**: A graphical interface within the dashboard for designing and visualizing complex workflows.
    *   **Formal Plugin System**: Allow community-driven extensions for new integrations and functionalities.

## Disclaimer

This roadmap is a strategic outline and is subject to change. Specific timelines and feature priorities may be adjusted based on project progress, community feedback, and resource availability. We encourage active participation and feedback from the community to help shape the future of Zinco.
