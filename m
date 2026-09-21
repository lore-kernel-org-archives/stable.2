Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7837AA74;
	Mon, 21 Sep 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973701; cv=none; b=GBvWs6S/6hoMr2cLwRTXYfWXz4L4frp2VTH+Xxrazp9Bx3NUIpLdLnMKxUzqFk9hKwE0644wglnavaZbRjam7StNIEksaPhsE75IkWvGZKjsaCA8xPeNyH5QEHEs54QdNQsDjgC3X6Mxb7guJOJVIWmLRqY4sd4Xl+qCOn4Z9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973701; c=relaxed/simple;
	bh=Wqdzul/RkVw3gqtsOxxs6+ITzaKeQvxZRMNRHbJcIZ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Nm4SloRspLHsQE1fnd8LLnJZVdoVbZq/DMaF+ldLdgVorN4FTb0TTeZGyzYn7M6tgBUpj1REiCyN1h5IIpXAQVRExjKGUBd/Qp862J6E0wXaoiS+WdH58ZPoABL1BsRcE7Se7kZAe1/MJyGZGjH911ukwVcrqFJ8FmGLJca/pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2Eu+RwxK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2Eu+RwxK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5D00A4A18;
	Mon, 21 Sep 2026 08:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789973686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I63gHzSd1pkTiqmiNk94iSWcKLtu/lpe2EZV8jJ1XyU=;
	b=2Eu+RwxKZKR6VsDnw8OU0XB6deIwblXZeAVR6Cv4hyTr05HiKSZ7/VAyqZ6U+2KX/3EcBt
	Xnj2GT35XAx8KICrPAVezawsJ0jKJJ5S+t2R0a+gSqUdyJIy0bHwupHtLGLUHeD0rGgyL5
	URdoDOLuEuIumSk3SbOjKV6gkdfMv2JVOAL0cMQu6L6oQJCF6p04EWQ2TZujyFcD+um8pb
	24VWdsuDlL0XQc04+KXLS/d2tQt+QLHzcbvSM7LKe/A+mJ62SQbz36no6cIG536CnL3SMt
	ipQ2E5gjmwdljcpYk0HcQv0zvJOQ5SfaPw4dQyWll6ty1g5DYgNOhExAL3ffeg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 08:54:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Sean Anderson <sean.anderson@linux.dev>,
 Antoine Tenart <atenart@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] net: macb: never give hardware a NULL RX buffer
In-Reply-To: <20260918-macb-close-v1-1-221d916b7961@bootlin.com>
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
 <20260918-macb-close-v1-1-221d916b7961@bootlin.com>
Message-ID: <c431bd54f9e26158a10bdfd6a4d606b0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 22:32, Théo Lebrun wrote:
> The refill logic is simple: iterate over all pending rx slots, allocate
> SKB (& DMA map) if needed and hand it off the to hardware by clearing
> the RX_USED flag.
> 
> If the refill operation fails mid-way, it early returns leaving the
> following slots untouched. In the normal case that is fine, because all
> slots have been properly initialised (and might have been already used
> by HW meaning they won't be reused). When slots have not been
> initialised however, we are in trouble.
> 
> After dma_alloc_coherent() of the rx ring buffer, all slots have NULL
> pointers and RX_USED cleared meaning HW will try using them. Ensure
> this does not happen by setting the RX_USED flag on all slots before
> calling refill at buffer alloc, in gem_init_rx_ring(). That way even if
> refill fails on an alloc/dma_map, the HW won't try using NULL pointers
> as buffers.
> 
> Theoretical bugfix, never encountered in practice. To reproduce,
> introduce memory pressure (less than 512 SKBs of free memory) and open
> the interface.
> 
> Note that this codepath also hits at resume, on HRESP errors and on
> set_ringparam (while interface is running).
> 
> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index b8234ac4b602..751fa9e68099 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2785,9 +2785,14 @@ static int macb_alloc(struct macb *bp)
> 
>  static void gem_init_rx_ring(struct macb_queue *queue)
>  {
> +	unsigned int i;
> +
>  	queue->rx_tail = 0;
>  	queue->rx_prepared_head = 0;
> 
> +	for (i = 0; i < queue->bp->rx_ring_size; i++)
> +		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
> +
>  	gem_rx_refill(queue);
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Regards
Nicolai
