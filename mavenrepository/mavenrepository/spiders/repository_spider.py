import scrapy

class RepositorySpider(scrapy.Spider):
    name = "repository"

    def start_requests(self):
        urls = [
            f'https://mvnrepository.com/popular?p={i}' for i in range(1, 11)
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse_index_page)

    def parse_index_page(self, response):
        for detail_page in response.css('h2.im-title > a:not(.im-usage)'):
            yield response.follow(detail_page, self.parse_artifact_page)

    def parse_artifact_page(self, response):
        link = response.css('#snippets table a')[0]
        yield response.follow(link, self.parse_version_page)

    def parse_version_page(self, response):
        maybe_jars = response.css('a.vbtn::attr(href)').getall()
        jar_urls = [url for url in maybe_jars if url.endswith('.jar')]
        if jar_urls:
            yield {'url': jar_urls[0]}
        else:
            yield None
