import pytest
from httpx import AsyncClient

from showcase.app import app


@pytest.mark.asyncio
async def test_hello_world():
    async with AsyncClient(app=app, base_url="http://") as client:
        response = await client.get("/hello")

    assert response.status_code == 200
    assert response.content == b"Hello, world!"
