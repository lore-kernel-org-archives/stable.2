Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33647492E26;
	Fri, 18 Sep 2026 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762238; cv=none; b=Ca8KVgh3IUQWwf/B4sXoQTqWytml7Aa976HnkOf1D0H5Yl+QwCVS4ez2czHoFMwoEsWnFtYWlkwMoPeJ/qwyV6KueqTCgTdwkXa0SObeYBbsnPKnPWvw1yXe7ze8cUpmg9txUq5Afh+c0zxHt6YtfhUiL2gs48Ek+V8QwAIiNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762238; c=relaxed/simple;
	bh=hkIw7zFGx6FzXsWIzPFaO6mhHbNUTJ1Tx5WZHrJbPVs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NWSRsc+Yy1hWd1FdSmYuJMn9scDfHGnBPDPXLMTu3aqegPcJBrCG4CLSmy6UDRU4hJ9/AyDnvJSRtEaNgAeG9S0dL8xMfAyejdHs7O6EON3SZPh1XJksGWTeKQHl1JTRYJre9OJBNU5WLG5xrdnMorYu28yHLmkOy9We+Ut5lbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=iaS9PGQI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="iaS9PGQI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D5BDA8E53;
	Fri, 18 Sep 2026 22:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789762230; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MbZ4PjXhvExVlTqbwqbIHq7pRdDYaSJpFUR4LtFdkNw=;
	b=iaS9PGQIRAkL0FExUmM2zFgrEgM9ns7IHpnlChwiaJ0q1GZkZY5oYztjVbLcs0buYpq4a5
	5lkLC7FV7CFnYbRW7hw7EZGV0qmkJWUMj0lA93pTugH4MldC3oZ7sW2P9NaN9VkMio9nsC
	fez4dQggz5YGnzZD6qU4xNs9Op/UIwrBqbN3UysprTj0HAXlqnzET0vti5pvS0Gg/9QvPf
	WSWOcUGp3WIXUNb3jEZPJcr3rFkyRtBPqbPV6xZdfqAlr4v/famlVV77MYpfTkLIkwhvsO
	52rjAGN/MEA7HfC3b3qz5c0gsG1Obv3YQTnao8yTrCeB3Wkc5IRSqlwsu4fb6g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 22:10:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Sean Anderson <sean.anderson@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: macb: fix dma_alloc_coherent() leak on
 macb_alloc() error paths
In-Reply-To: <20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com>
References: <20260918-macb-alloc-leak-v1-1-aba9a3d4f6e3@bootlin.com>
Message-ID: <f66297b8318f8217778b786d3b02b2e5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 18.9.2026 21:53, Théo Lebrun wrote:
> Fix 3 leaks in macb_alloc() error paths:
> - Tx buffer allocated but crossing a 4G boundary: Tx leaked.
> - Rx buffer allocation fails: Tx leaked.
> - Rx buffer allocated but crossing a 4G boundary: Tx & Rx leaked.
> 
> This is because our error handling calls macb_free(bp) which in turn
> frees the buffers stored in bp->queues[0], but nothing has been stored
> in there. Fix by storing allocated buffers into bp->queues[0] ASAP.
> 
> Fixes: 78d901897b3c ("net: macb: single dma_alloc_coherent() for DMA 
> descriptors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index b8234ac4b602..8e5c034dc3a4 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2749,14 +2749,24 @@ static int macb_alloc(struct macb *bp)
> 
>  	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
>  	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
> -	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
> +	if (!tx)
> +		goto out_err;
> +	/* Record the buffer so that the error path frees it. */
> +	bp->queues[0].tx_ring = tx;
> +	bp->queues[0].tx_ring_dma = tx_dma;
> +	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
>  		goto out_err;
>  	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx 
> (mapped %p)\n",
>  		   size, bp->num_queues, (unsigned long)tx_dma, tx);
> 
>  	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
>  	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
> -	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
> +	if (!rx)
> +		goto out_err;
> +	/* Record the buffer so that the error path frees it. */
> +	bp->queues[0].rx_ring = rx;
> +	bp->queues[0].rx_ring_dma = rx_dma;
> +	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
>  		goto out_err;
>  	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx 
> (mapped %p)\n",
>  		   size, bp->num_queues, (unsigned long)rx_dma, rx);
> 
> ---
> base-commit: 994db8ab9d90c64dd641b7ead6efe2eaea7a50dc
> change-id: 20260918-macb-alloc-leak-ef38989605c7
> 
> Best regards,
> --
> Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
