Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AB479889;
	Thu, 24 Sep 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246811; cv=none; b=TAHP1A4EX072hk+L6KTY1/lRL27cn0XSRrkGfVKNAisbfzpXsX+VnqdQ+XhFP8wyZlMtix/Rz60cBl+fWQ3X+rsE4n4oBa1Y7sDewa79uBgzkbtOEkPAWf+ThlW+S7tCWIwUHU6wKJdpB1pC5o5nu+ZhCp+tsclH89PGEmfTPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246811; c=relaxed/simple;
	bh=no3wGvmoZGDnKHIWdqSVFOWKvThPxPwZp/0yRpmP/WM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLfSAs2gytWIaKGY2gC0bs+50y5LxE/TU0gcXJSA1ZTDgbIXSm0lyi9Zn6v78+/QKXHQRCKmlKNAY+YeBmlLD0yZEJSXFYVw5QZ9Q/rnqhjwDCSS6PMTgroRmUKBP4W9ScUIXqKgXPLk6LFFujiM60kk6hEeqPwSTyr9yPohS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oApTv4im; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oApTv4im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D79E1F000FF;
	Thu, 24 Sep 2026 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246809;
	bh=77ssgNlGM4tH9+2JYjhDB35IU0KYqTKpl8FhXiCGU3M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oApTv4imZ2+k2smsUR+z8jcRnOcejt7bgp1mdhpanWRc1iOLkayeF3UaqMSahym9b
	 bdEcDzzIOxhI/tzUFMp4UC1kSZhi9EO3x0y62MIGjBTKZ/Y1ORw/1B46vz/3AW1pgJ
	 33rNDNRdeEP91mpyPimzLMwk+FVTJ0QcN5ABsPhA0Dzlz4SzMCNuYjih6dZ/gC2Ait
	 KdYLCDpW/8vidG+d9b26RrhR/SIwcMQXu+7/kIXcLDR/pQTVq4x/JZrRw+7cT7iPza
	 /SFxfv2sQ2POvOhNU9Fq57LjLKPuiTon9qI6TfVcTwCw7gd5zLk8pUDonMhEKy97cl
	 VTjpXxJsE5Gdw==
Subject: Re: [PATCH net v2 6/9] gve: fix NULL dereference from premature XSK
 pool DMA unmap
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:47 +0000
Message-ID: <179024680795.2160803.17777234688397869415@kernel.org>
In-Reply-To: <20260922194533.631387-7-joshwash@google.com>
References: <20260922194533.631387-7-joshwash@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gve_xsk_pool_disable()
  (drivers/net/ethernet/google/gve/gve_main.c), this patch moves the…

--

gve: fix NULL dereference from premature XSK pool DMA unmap

This patch moves the XSK pool DMA unmap in gve_xsk_pool_disable() to a new
unmap_and_return label at the end of the function. The goal is to keep
the pool mapped until the rings no longer use it. This fixes a race where
RX NAPI calls xsk_buff_dma_sync_for_cpu() after pool->dev has been set
to NULL.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 3712ff364cbd5..49ae2b8c6a270 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1681,22 +1681,18 @@ static int gve_xsk_pool_disable(struct net_device *dev,

[ ... ]

>  	clear_bit(qid, priv->xsk_pools);
>  
> -	pool = xsk_get_pool_from_qid(dev, qid);
> -	if (pool)
> -		xsk_pool_dma_unmap(pool,
> -				   DMA_ATTR_SKIP_CPU_SYNC |
> -				   DMA_ATTR_WEAK_ORDERING);
> -
>  	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
> -		return 0;
> +		goto unmap_and_return;
>  
>  	/* Stop and start RDA queues to repost buffers. */
>  	if (!gve_is_qpl(priv) && priv->xdp_prog) {

[Severity: Medium]
Does the RDA branch right after this still skip the new unmap? The
unchanged code that follows is:

	if (!gve_is_qpl(priv) && priv->xdp_prog) {
		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
		if (err)
			return err;
	}

Before this patch the unmap ran before this branch, so every exit
unmapped the pool. Now xsk_pool_dma_unmap() is only called at
unmap_and_return. If gve_configure_rings_xdp()->gve_adjust_config()
fails, the bare return skips it.

That failure can come from gve_queues_mem_alloc() returning -ENOMEM
before gve_close(), from gve_close(), or from gve_queues_start().

The XSK core does not recover from this. xp_disable_drv_zc() in
net/xdp/xsk_buff_pool.c only warns and continues the teardown:

	err = pool->netdev->netdev_ops->ndo_bpf(pool->netdev, &bpf);

	if (err)
		WARN(1, "Failed to disable zero-copy!\n");

Would that leak pool->dma_pages, the xsk_dma_map reference and the IOMMU
mappings for the UMEM pages?

The error path in gve_xsk_pool_enable() does unmap the pool when
gve_configure_rings_xdp() fails:

err_xsk_pool_dma_mapped:
	clear_bit(qid, priv->xsk_pools);
	xsk_pool_dma_unmap(pool,
			   DMA_ATTR_SKIP_CPU_SYNC |
			   DMA_ATTR_WEAK_ORDERING);
	return err;

Could the disable path do the same, for example with
"goto unmap_and_return"?

This also seems to go against the commit message, which says pools are
DMA unmapped "in all scenarios".

This is a pre-existing issue, but the same early return also skips
napi_disable_locked(), gve_unreg_xsk_pool() and napi_enable_locked(). On
the gve_queues_mem_alloc() failure path the old rings are still live.
Their rx->xsk_pool and tx->xsk_pool would then keep pointing at a pool
that the core goes on to free.

A later commit in this series, "gve: ensure XDP mem model is registered
when disabling XSK pools", appears to fix this. It replaces the
gve_configure_rings_xdp() block with gve_restart_rings(), and every path
falls through to unmap_and_return. So the problem looks limited to this
intermediate commit. It would still matter for bisection, or for a stable
backport that takes this patch without the later one, since this patch
is tagged Cc: stable.

> @@ -1725,7 +1721,14 @@ static int gve_xsk_pool_disable(struct net_device *dev,
>  			napi_schedule(napi_tx);
>  	}
>  
> -	return 0;
> +unmap_and_return:
> +	pool = xsk_get_pool_from_qid(dev, qid);
> +	if (pool)
> +		xsk_pool_dma_unmap(pool,
> +				   DMA_ATTR_SKIP_CPU_SYNC |
> +				   DMA_ATTR_WEAK_ORDERING);
> +
> +	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com
