# Syphon
A simple scanner leveraging Elixir's concurrency & distributed architecture.

```elixir
# exemple usage with the -Pn scan
Scan.targets ["127.0.0.1"], ["-Pn"], 10000
```

This will save the scan results into a text file, and automatically sort scans by date & host.

## Installation

```elixir
def deps do
  [
    {:syphon, git:"https://github.com/noctisatrae/syphon.git", tag: "0.1.0"}
  ]
end
```

