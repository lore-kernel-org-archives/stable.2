Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A038AC7D;
	Mon, 21 Sep 2026 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973757; cv=none; b=B5QpXOsYB9PGNpzAxxTroDm134/TjyITc/7h9mSQg/MS27WvPZ/G64AoH7HY2umxSwrIzErE6St5UzuEQugcThaDePzaWIG0NWvngZhTNQ1kIs+TfilOGAMH0LeBVj637etB5GQb+YzamQSPVct8rRNYzK/jEU6tTUqK9fRa6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973757; c=relaxed/simple;
	bh=XiIfzSX6PZCft8fqwRogTTe7wN49PqK3X7vuYl7Q4ks=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GiuwdpsvdUe4ZhQs+DlRpAWDwbOy0oXgd4/VqxkXSzFTu0occMyjHDaPfhhWwnjIErk/Z6YpND94CnAq1r3P63HUsDLjOyWdj0FSzw5EwdzV1iIabvt49FUaeeGvZrYxUlBbtN8Wwzxtzw3jn6LwksfSxoR0vtEAzFq+yKRT2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=IYSPiiNQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="IYSPiiNQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77733A02B3;
	Mon, 21 Sep 2026 08:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789973752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gJXINMxHoTpT+eASelt2HiUG7zsQyjA5b84tpgrjVOs=;
	b=IYSPiiNQQ07JzENNm217fmfBzFM9m800Xwh6BFl9LE1hCVqBmFNifaKY/vYLmwh5TpiOXy
	Jl7HtwsRxxmSLIOBSn2mZHrO7q49tM227BUXGxrpTYoOTAsR3vnc0IGk5YWwZmtTJigel6
	tOm39qGM5x3rI8tKhRn+MNkeW5jEg1thTRDDFdVkNER+mVBlGoIkG6AN7tWvbFlr0iN7fQ
	2OlY2XpWi/UY30BUFoLnfPYwHRY6mFA/jDd2Bmud7EoaWFwo752FXv2RLXP8/rYQcpgLNv
	QWg9p9sz9HkXyn2hT7j2pc6LwpwfOYVeAGuWnEW+cGUbkYlHDxPAnSYYJ5SJTg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 08:55:51 +0200
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
Subject: Re: [PATCH 3/3] net: macb: quiesce IRQs and drain BH on interface
 close
In-Reply-To: <20260918-macb-close-v1-3-221d916b7961@bootlin.com>
References: <20260918-macb-close-v1-0-221d916b7961@bootlin.com>
 <20260918-macb-close-v1-3-221d916b7961@bootlin.com>
Message-ID: <4b1d4821feaf593336cd321b8899d04e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 22:32, Théo Lebrun wrote:
> The macb_close() operation is facing races as it disables IRQs late in
> its sequence and keeps BH primitives alive while shutdown.
> 
> Non exhaustive list of races that could occur:
> 
>  - macb_tx_error_task() could be scheduled and access the buffers freed
>    by macb_close().
> 
>  - macb_tx_error_task() or macb_hresp_error_task() might re-enable
>    interrupts after the IDR write in macb_close().
> 
>  - macb_close() calls napi_disable() meaning that if
>    macb_tx_error_task() occurs later, it will deadlock on 
> napi_disable()
>    that shouldn't be called if NAPI is already disabled.
> 
>  - macb_hresp_error_task() might reinit every RX/TX ring under
>    macb_close()'s foot.
> 
>  - macb_interrupt() might re-enable NAPI just after it has been
>    disabled by macb_close().
> 
> Instead, disable all our primitives one by one:
>  - (1) mask and sync on IRQ handlers,
>  - (2) drain any scheduled bp->hresp_err_bh_work,
>  - (3) drain any scheduled queue->tx_error_task,
>  - (4) drain queue->napi_rx/napi_tx,
>  - (5) drain bp->tx_lpi_work.
> 
> Careful! Ordering is important because our scheduling primitives can
> wake each other up. Recap table:
> 
> |               |   enable/disable   |           schedule            |
> |               |----|-------|-------|------|----|----|--------|-----|
> |               |IRQs|napi_tx|napi_rx|tx_lpi|napi|napi|tx_error|hresp|
> | Context       |    |       |       | task | rx | tx |  task  |task |
> |===============|====|=======|=======|======|====|====|========|=====|
> | open          | X  |   X   |   X   |      |    |    |        |     |
> | link_up       | X  |       |       |      |    |    |        |     |
> | link_down     | X  |       |       |      |    |    |        |     |
> | close         | X  |   X   |   X   |      |    |    |        |     |
> | enable_tx_lpi |    |       |       |  X   |    |    |        |     |
> | swap          | X  |   X   |   X   |  X   |    |    |        |     |
> | suspend       | X  |   X   |   X   |      |    |    |        |     |
> | resume        | X  |   X   |   X   |      |    |    |        |     |
> |---------------|----|-------|-------|------|----|----|--------|-----|
> | irq & netpoll | X  |       |       |      | X  | X  |   X    | X   |
> |---------------|----|-------|-------|------|----|----|--------|-----|
> | napi_rx       | X  |       |       |      | X  |    |        |     |
> | napi_tx       | X  |       |       |  X   |    | X  |        |     |
> |---------------|----|-------|-------|------|----|----|--------|-----|
> | tx_error_task | X  |   X   |       |      |    |    |        |     |
> | hresp task    | X  |       |       |      |    |    |        |     |
> 
> As example, one ordering constraint that can be deduced from the table:
> napi_tx can schedule tx_lpi_task meaning napi_tx must be disabled
> before tx_lpi_task, else we risk napi_tx re-enabling tx_lpi_task after
> it has been disabled by macb_close().
> 
> We do *not* use IDR masking to shutdown IRQs because that risks
> conflicting with BH primitives we have not disabled yet. For example if
> we writel(IDR) in macb_close() and napi_rx is pending then IRQs might
> be unmasked by the NAPI poll. As for why we do not use disable_irq():
> we will have situations where we are quiesced but want to listen to
> some IRQs and (minor reason) we register shared IRQ handlers so we
> shouldn't disable the full IRQ line.
> 
> Instead we introduce a bool that tells macb_interrupt() to self-disarm.
> Its default value is true as we start closed. It gets set to false
> while interface is active. Reading into my crystal ball, we'll reuse
> that flag in suspend/WOL, set_ringparam and change_mtu (context swap).
> 
> Note that old IRQ handler tried preventing a race with close by
> self-disarming based on netif_running(). This might work, but it does
> not prevent a race with the error codepath of macb_open() which needs
> to run with IRQs dis-armed but netif_running() returns true during that
> time.
> 
> Fixes: e86cd53afc59 ("net/macb: better manage tx errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Regards
Nicolai
