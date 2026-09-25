Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA54908A7;
	Fri, 25 Sep 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346047; cv=none; b=pwoxL8PkqmnO+NZgx7XBGhfeCgF9jsw1jaPfZmx8ojnDrrkt011DSfZ9ct+rZ88GlXNpJD/5xEeeoHUsDY5C157J9JBIdNBp1QuGGwdnOqGE8RM1a6gwYSYMDZ4M+rhB/tVCde8a0MLUT+sDbU0CjWNFWznW60pUnMJv9vwwaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346047; c=relaxed/simple;
	bh=pewVATMvxz/0zBB01FspS2JmEEjcCbKPPr8kOnzaOIw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aInn7tOPnSDu/RxQKVNXx0elsBCEfcihy7b0fJUQjhyVSQ/faRCqzGOzPmv22fJOFw3W84A3ACv6I5dzLp7GlKJYV0ATCsBiVdq+v9xviBB+KRVqpPMd3mGtD255BXSG3JGzdcO9D1Pcun9/P+0XcDpfdfl1bTzM4wvAS1td65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=08RUWRXH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="08RUWRXH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 320AEA4AA0;
	Fri, 25 Sep 2026 16:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790346043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xHNc+9RxFcyweFVUILwsomUzPT50njlhC3Ylpa7bSF4=;
	b=08RUWRXHrNrL6HpPGmFAtE3fg9wPszBuZh0Ywcga9MxXPB2HrkZ8La6YKfPd2AAKJV8Efa
	a5xt09enksAbajA/e3ge5cnzxX8+7j0BRDe71zR3SFqWwkPBZgJpFBr9fmJkDtbrwmdT30
	PzWtQZpN5BOatjI7XIcUDQWkPNAIN55DfYFzC32Wmk+mxxtPqGiZy63JuU9R8uXRjxJhBH
	6Obxu54CRzHgmMC19MEFoBdjsEtGN4rJ2gWKDRaa8WvruQvwlisxdalo6JFWk3BHvW/0oB
	Gd91NKng4Y3Jo8po0j7zX3sD5RUWeE5k/1yDkV8bbpMpJO0TAXs9Zf9R8BnSQA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 16:20:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Sean Anderson <sean.anderson@linux.dev>, Antoine Tenart
 <atenart@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: macb: propagate RX ring refill errors
In-Reply-To: <20260925-macb-close-v2-2-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
 <20260925-macb-close-v2-2-360efa565914@bootlin.com>
Message-ID: <6d02388cd50d823b913d59ee890cc707@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 25.9.2026 15:59, Théo Lebrun wrote:
> gem_rx_refill() is responsible for Rx SKB allocation, including at 
> open,
> but its prototype indicates a void return value.
> 
> Therefore we change the code to propagate allocation and DMA mapping
> errors back up the stack, making sure the open fails if no descriptors
> were allocated. Change all those to return errno-style ints:
>  - gem_rx_refill()
>  - its parent gem_init_rx_ring()
>  - its grand-parent gem_init_rings()
>  - the macbgem_ops.mog_init_rings function pointer
>  - its grand-uncle macb_init_rings()
> 
> We tolerate some allocation failures: we accept running with the rx 
> ring
> only partially filled with successful descriptors. It is important we
> refuse the zero-valid-descriptor case: nothing would ever trigger a
> refill, which only happens once a frame has been received.
> 
> Theoretical bugfix, never encountered in practice. To reproduce,
> introduce memory pressure (less than 512 SKBs of free memory) and open
> the interface. I expect the last queue to be unusable because it has
> zero usable rx buffers.
> 
> Note that other callers of refill (resume, HRESP error task, NAPI)
> cannot do anything useful with that error and keep their best-effort
> refill, hoping it will improve.
> 
> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
