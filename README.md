# Syphon
A simple scanner leveraging Elixir concurrency & distributed architecture.

```elixir
# exemple usage with the -Pn scan
Scan.targets ["127.0.0.1"], ["-Pn"], 10000
```

## Installation

```elixir
def deps do
  [
    {:syphon, git:"https://github.com/noctisatrae/syphon.git", tag: "0.1.0"}
  ]
end
```

