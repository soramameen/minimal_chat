# Agent Guidelines for minimal_chat

This repository is a minimal Ruby on Rails application using Hotwire (Turbo + Stimulus) and Importmaps.

## 1. Build, Lint, and Test Commands

Use the `bin/` executables for most tasks.

### Testing (Minitest)
*   **Run all tests:**
    ```bash
    bin/rails test
    ```
*   **Run a single test file:**
    ```bash
    bin/rails test test/models/message_test.rb
    ```
*   **Run a specific test line:**
    ```bash
    bin/rails test test/models/message_test.rb:15
    ```
*   **Run system tests:**
    ```bash
    bin/rails test:system
    ```

### Linting & Security
*   **Run RuboCop (Linting):**
    ```bash
    bin/rubocop
    ```
    *   To fix auto-correctable issues: `bin/rubocop -A`
*   **Run Brakeman (Security):**
    ```bash
    bin/brakeman
    ```
*   **Audit JS dependencies:**
    ```bash
    bin/importmap audit
    ```

### Development
*   **Start the server (and background jobs):**
    ```bash
    bin/dev
    ```
    *   Or just Rails: `bin/rails server`
*   **Console:**
    ```bash
    bin/rails console
    ```
*   **Database Setup:**
    ```bash
    bin/rails db:prepare
    ```

## 2. Code Style & Conventions

Adhere strictly to standard Rails conventions (The Rails Way).

### Ruby / Rails
*   **Style:** Follow the "Omakase" Rails style enforced by `rubocop-rails-omakase`.
    *   Indentation: 2 spaces.
    *   Strings: Prefer double quotes `""`.
    *   Hash Syntax: Ruby 1.9+ style `{ key: value }`.
*   **Controllers:**
    *   Use `before_action` for common setup.
    *   Use `respond_to` blocks to handle `html`, `json`, and `turbo_stream` formats.
    *   Use `params.expect` (Rails 8+) for strong parameters when possible, or `params.require(...).permit(...)` if stuck on older patterns (but prefer modern).
*   **Models:**
    *   Keep logic in models (Fat Model, Skinny Controller).
    *   Use callbacks (e.g., `after_create_commit`) for real-time updates via Turbo Streams.
*   **Views:**
    *   Use ERB (`.html.erb`).
    *   Use partials for reusable components (e.g., `_form.html.erb`, `_message.html.erb`).
    *   Use Turbo Frames and Streams for partial page updates.

### JavaScript (Importmaps + Stimulus)
*   **Location:** `app/javascript/`
*   **Controllers:** Stimulus controllers in `app/javascript/controllers/`.
*   **Naming:** kebab-case file names (e.g., `hello_controller.js`) map to `data-controller="hello"`.
*   **Imports:** Use ESM imports. No build step (Webpack/esbuild) is involved; libraries are pinned via `bin/importmap`.

### Error Handling
*   Let exceptions crash in development for visibility.
*   Use Rails `rescue_from` in `ApplicationController` for specific global error handling if needed.
*   In forms, handle validation errors by rendering the form again with status `:unprocessable_entity`.

## 3. Workflow for Agents
1.  **Read Context:** Always read related files (Controller, Model, View, Test) before editing.
2.  **Verify:** Run tests (`bin/rails test`) after changes.
3.  **Lint:** Run `bin/rubocop` to ensure style compliance.
4.  **No New Frameworks:** Do not introduce React, Vue, or heavy JS bundlers unless explicitly asked. Stick to Hotwire.
