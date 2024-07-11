# Syphon
A simple scanner leveraging Elixir's concurrency & distributed architecture.

```elixir
# exemple usage with the -Pn scan
map = [
  # {"127.0.0.1", ["-Pn"]}, # specific -Pn flag for localhost
  {"google.com", ["-T4"]} # use default flags
]
Scan.targets map, ["-sV"], 10000
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