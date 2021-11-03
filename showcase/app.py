from starlette.applications import Starlette
from starlette.requests import Request
from starlette.responses import PlainTextResponse
from starlette.routing import Route


async def hello_world(_: Request) -> PlainTextResponse:
    return PlainTextResponse("Hello, world!")


app = Starlette(routes=[Route("/hello", hello_world)])
