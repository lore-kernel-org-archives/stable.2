Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C0367B86;
	Thu, 16 Jul 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234956; cv=none; b=X3Er+uju0XjDmlKCWcQLCB9JoPNTYlGDIbWXfL4sPYVHqvFJRnJwNsxF+l4ted4cS0YMTu39cnFizjt3jJjbpnlParAd+2xV5WRO19gLtOy3YLrgphi16b27mQ0WEXNVsKIQ+oVUZylDmrGk8BSt6xToIG6A9wqVHb6CfXn/ZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234956; c=relaxed/simple;
	bh=SrjnLYLum9Z46rma6nqV2wDFJDz5Q6fyW7Z2D3kDqJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5T/BFPoqmzEUN6YIep4nlhtWBz8Hp8i8Oqe2e6d8YbEafUQIN4KjEXE/a3gMa99XsMDxYIe4kyqlrfLTI7PsP4yj+rzHiebZ5FcvijrZgo2+jftY908P7fPZxFqAIIkBBEdHCzr/pe6vg672C+13o2UaFao7bGjqqvS8V080M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuGvw+A0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuGvw+A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E41F000E9;
	Thu, 16 Jul 2026 20:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784234954;
	bh=/auF3QwCn6DkvYe4mWReEKGzDw3FjlfykMkHq6oG8O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WuGvw+A09QbHon0C2djMML9mRJR6ScHWGLqGNZ2+u9LO1LCoEz+Y0Qwn9vwK3+dst
	 iEs945e3WU++xoimCWIpmsIisL2Z8Och/YiaBJOyjdT42ivKWsurQuyA6gv1Mtk3Z8
	 gJeitL5/8EcgudG0kA48HM+JNch8eewsA9+jmpn6Tzlnizr+YPgmphao0zeVEdxTLZ
	 dARqg17l3yc7unnd086hSSpZcPtzCnw/U8eM8CpjUziFkLPC6Ye7fmISiFiVjxeqIA
	 ilVU5t8gRbGgXrbZtC9h4QZTywvR43gNawR58Zlbj4bB2fIRZiAP27EuqLIC/BgtrK
	 7nPMMLS85ultQ==
Date: Thu, 16 Jul 2026 15:49:14 -0500
From: Rob Herring <robh@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: saravanak@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] of/address: Fix NULL bus dereference in
 of_pci_range_parser_one()
Message-ID: <20260716204914.GA1262499-robh@kernel.org>
References: <20260706114731.57353-1-ccaione@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706114731.57353-1-ccaione@baylibre.com>

On Mon, Jul 06, 2026 at 01:47:17PM +0200, Carlo Caione wrote:
> The bus matching rework made of_match_bus() return NULL for nodes
> with ranges/dma-ranges but no local #address-cells. parser_init()
> stored that NULL bus, and the range iterator later dereferenced it.
> 
> Reject such nodes in parser_init(), leaving an explicit empty iterator
> for callers that ignore the init return. Keep the DMA limit walk guarded
> by a non-empty dma-ranges property, and only clamp the limit when at
> least one complete range was parsed.
> 
> Fixes: 64ee3cf096ac ("of/address: Rework bus matching to avoid warnings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> 
> ---
> Changes in v2:
> - Validate na/pna/ns in parser_init() with OF_CHECK_COUNTS() /
>   OF_CHECK_ADDR_COUNT()
> - Link to v1: https://lore.kernel.org/r/20260706095651.48839-1-ccaione@baylibre.com
> ---
>  drivers/of/address.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index cf4aab11e9b1..fd2468b89579 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -753,6 +753,7 @@ EXPORT_SYMBOL(of_property_read_reg);
>  static int parser_init(struct of_pci_range_parser *parser,
>  			struct device_node *node, const char *name)
>  {
> +	const __be32 *range;
>  	int rlen;
>  
>  	parser->node = node;
> @@ -761,12 +762,20 @@ static int parser_init(struct of_pci_range_parser *parser,
>  	parser->ns = of_bus_n_size_cells(node);
>  	parser->dma = !strcmp(name, "dma-ranges");
>  	parser->bus = of_match_bus(node);
> +	parser->range = NULL;
> +	parser->end = NULL;
>  
> -	parser->range = of_get_property(node, name, &rlen);
> -	if (parser->range == NULL)
> +	range = of_get_property(node, name, &rlen);
> +	if (!range)
>  		return -ENOENT;
>  
> -	parser->end = parser->range + rlen / sizeof(__be32);
> +	if (!parser->bus ||
> +	    !OF_CHECK_COUNTS(parser->na, parser->ns) ||
> +	    !OF_CHECK_ADDR_COUNT(parser->pna))
> +		return -EINVAL;
> +
> +	parser->range = range;
> +	parser->end = range + rlen / sizeof(__be32);
>  
>  	return 0;
>  }
> @@ -792,7 +801,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	int na = parser->na;
>  	int ns = parser->ns;
>  	int np = parser->pna + na + ns;
> -	int busflag_na = parser->bus->flag_cells;
> +	int busflag_na;
>  
>  	if (!range)
>  		return NULL;
> @@ -800,6 +809,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	if (!parser->range || parser->range + np > parser->end)
>  		return NULL;
>  
> +	busflag_na = parser->bus->flag_cells;
> +
>  	range->flags = parser->bus->get_flags(parser->range);
>  
>  	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
> @@ -976,8 +987,8 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
>  		np = of_root;
>  
>  	ranges = of_get_property(np, "dma-ranges", &len);
> -	if (ranges && len) {
> -		of_dma_range_parser_init(&parser, np);
> +	if (ranges && len && !of_dma_range_parser_init(&parser, np) &&
> +	    of_range_count(&parser)) {

Why do we need of_range_count() here?

>  		for_each_of_range(&parser, &range)
>  			if (range.cpu_addr + range.size > cpu_end)
>  				cpu_end = range.cpu_addr + range.size - 1;
> -- 
> 2.55.0
> 
