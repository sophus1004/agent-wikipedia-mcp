"""
Wikipedia MCP Server - A Model Context Protocol server for Wikipedia integration.
"""

__version__ = "1.7.0"
"""
Wikipedia MCP Server package.
"""
from .server import create_server

__all__ = ["create_server"]
