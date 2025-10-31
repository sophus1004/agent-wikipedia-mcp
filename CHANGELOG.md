# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.6.0] - 2025-09-12

### Added
- CLI now accepts `--access-token` to avoid argparse errors and align with user expectations. This is currently a no-op with a clear warning because FastMCP SSE does not provide built-in authentication.

### Changed
- Documentation: Added security notes for SSE transport and guidance to secure endpoints via reverse proxy or network controls.

### Fixed
- Prevented error when passing `--access-token` (addresses GitHub Issue #30).

## [1.5.8] - 2025-08-10

### Changed
- Documentation: Added `--host` usage and Docker/Kubernetes examples (bind `0.0.0.0` and port mapping) for SSE transport.

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Fixed
- **Google ADK Compatibility**: Fixed compatibility with Google ADK agents by removing `anyOf` schemas from optional parameters that were incompatible with Google's function calling API. Changed parameter type declarations to generate clean, simple schemas while maintaining backward compatibility.
  - `summarize_article_for_query.max_length`: `Optional[int] = 250` → `int = 250`
  - `summarize_article_section.max_length`: `Optional[int] = 150` → `int = 150`
  - `extract_key_facts.topic_within_article`: `Optional[str] = None` → `str = ""` (with automatic conversion)

### Added
- **Google ADK Compatibility Tests**: Added comprehensive tests to ensure all tool schemas remain compatible with Google ADK agents.

## [1.5.6] - 2024-08-05

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- **Wikipedia Coordinates Feature**: Implemented new `get_coordinates` functionality to retrieve latitude, longitude, and metadata for Wikipedia articles. This includes support for multiple coordinate systems, graceful handling of missing pages and articles without coordinates, and compatibility with existing language variants and country codes.
- **Google ADK Compatibility Tests**: Added comprehensive tests to ensure all tool schemas remain compatible with Google ADK agents.

### Fixed
- **Google ADK Compatibility**: Fixed compatibility with Google ADK agents by removing `anyOf` schemas from optional parameters that were incompatible with Google's function calling API. Changed parameter type declarations to generate clean, simple schemas while maintaining backward compatibility.

## [1.5.5] - 2024-07-26

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- **Comprehensive Country/Locale Support**: Introduced new CLI arguments `--country` (`-c`) and `--list-countries` to enable intuitive selection of Wikipedia content based on country or locale codes (e.g., `US`, `China`, `Taiwan`). The server now automatically maps these codes to appropriate Wikipedia language variants (e.g., `US` to `en`, `CN` to `zh-hans`, `TW` to `zh-tw`). This feature includes:
  - `--country <CODE_OR_NAME>`: Specifies the country/locale for Wikipedia content. Supports both ISO 3166-1 alpha-2 codes (e.g., `JP`, `DE`) and full country names (e.g., `Japan`, `Germany`), with case-insensitive matching for full names.
  - `--list-countries`: Displays a comprehensive list of all supported country/locale codes and their mapped Wikipedia languages, along with usage examples.
- **Extensive Testing**: Added a new test module `tests/test_cli_country.py` with comprehensive unit and integration tests for all country/locale functionalities, including:
  - Validation of CLI arguments and help messages.
  - Verification of country-to-language resolution.
  - Conflict detection when `--country` and `--language` are used together.
  - Successful server startup with various country codes.

### Fixed
- **Improved Country/Locale Error Handling**: Enhanced error messages for unsupported country/locale codes, providing clearer guidance and suggesting the `--list-countries` option.

## [1.5.4] - 2025-07-15

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- **Configurable Port**: Added optional `--port` argument for SSE transport (default: 8000). Enables running multiple server instances on the same host without port conflicts.
  ```bash
  # Run on custom port
  wikipedia-mcp --transport sse --port 8080
  
  # Multiple instances on different ports
  wikipedia-mcp --transport sse --port 8081 &
  wikipedia-mcp --transport sse --port 8082 &
  ```

- **Optional Caching**: Added `--enable-cache` flag for Wikipedia API response caching. Improves performance for repeated queries by caching results in memory using LRU cache (maxsize=128).
  ```bash
  # Enable caching for better performance
  wikipedia-mcp --enable-cache
  
  # Combine with other options
  wikipedia-mcp --transport sse --port 8080 --enable-cache --language ja
  ```

### Changed
- **Dependency Migration**: Migrated from `mcp==1.10.0` to `fastmcp>=2.3.0` for enhanced SSE transport capabilities and modern MCP features including configurable port support.
- **Import Updates**: Updated server implementation to use `from fastmcp import FastMCP` instead of the legacy MCP server import.

### Technical Notes
- Port configuration only applies to SSE transport; STDIO transport ignores the port parameter
- Caching is disabled by default to maintain backward compatibility
- When caching is enabled, the following methods are cached: search, get_article, get_summary, get_sections, get_links, get_related_topics, summarize_for_query, summarize_section, extract_facts
- Cache statistics can be accessed programmatically via `client.method.cache_info()` when caching is enabled

## [Unreleased]

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


## [1.5.2] - 2025-06-13

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- Added command-line argument `--language` (`-l`) to `wikipedia-mcp` to specify the Wikipedia language for the server (e.g., `wikipedia-mcp --language ja`). This enhancement allows users to easily configure the language at startup. (Related to GitHub Issue #7).

### Changed
- **Docker Improvements**: Reverted Dockerfile to use proper MCP-compatible approach with PyPI installation
- **MCP Studio Compatibility**: Restored stdio transport for proper MCP client communication
- **Package Installation**: Now uses `pip install wikipedia-mcp` (recommended approach) instead of local file copying
- **Environment Configuration**: Restored proper Python environment variables for containerized deployment
- **Dependency Cleanup**: Removed unnecessary HTTP server dependencies (uvicorn) from requirements

### Fixed
- Fixed Docker container to work properly with MCP Studio and Claude Desktop
- Restored proper MCP protocol compliance using stdio transport instead of HTTP

## [1.5.1] - 2024-06-03

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- Added an optional `language` parameter to `create_server` function in `wikipedia_mcp.server` to allow configuring the `WikipediaClient` with a specific language (e.g., "ja", "es"). Defaults to "en". (Fixes GitHub Issue #7).

### Changed
- N/A

### Fixed
- Corrected assertions in CLI tests (`tests/test_cli.py`) to accurately reflect the behavior of the `stdio` transport in a non-interactive subprocess environment. Tests now expect and verify `subprocess.TimeoutExpired` and check `stderr` for startup messages, ensuring robust testing of CLI startup and logging levels.

## [1.5.0] - 2025-05-31

## [1.5.7] - 2025-08-06

### Added
- Initial release for version 1.5.7

### Changed
- 

### Fixed
- 


### Added
- New tool: `summarize_article_for_query(title: str, query: str, max_length: Optional[int] = 250)` to get a summary of a Wikipedia article tailored to a specific query.
- New resource: `/summary/{title}/query` for the `summarize_article_for_query` tool.
- New tool: `summarize_article_section(title: str, section_title: str, max_length: Optional[int] = 150)` to get a summary of a specific section of a Wikipedia article.
- New resource: `/summary/{title}/section/{section_title}` for the `summarize_article_section`