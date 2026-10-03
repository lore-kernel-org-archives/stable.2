Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DA403B0E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021567; cv=none; b=TA9BMJipSfM219DkwGDj92kNhGxQiedEcQ/CpyZiMngQ6syGFDrf6ckcQ0droWaM31jDeB0qiISPiiNLBWKh06nqwUhERg8Y7gJfsxZ+iW85gJcLIz2IKhy8TZODOzCcYV8cOjDrUaUMGgUVrcwcIh034/sGTnGdJ4pQV7y34Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021567; c=relaxed/simple;
	bh=AhBhz2g8QOQdLAartJLkmrx6kQngKini7GtXYuK8bX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn9LiX1H5YaSYySa8vCyI4y7iE16OrIqPE3mq6/qUlgPnmiGAgMbqrcLGZQOxJQYBQUmBMWTMh1OuhkMSk0LjTTqBVFhvzSn94v4yhGCl4+069Bm0+eaB9TH37/SjVQZlDBQ0xCAP2Hk0DvD9VNS9LwGSkC5mWRe7y53JR8aZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=RVzQVoOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qJawxZ6T; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="RVzQVoOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qJawxZ6T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C874AEC0404
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 05:59:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 03 Oct 2026 05:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791021564;
	 x=1791107964; bh=cP/WTIDnkCui6QvszsvKLen2QAUJz/e/MHFvKQJHrlI=; b=
	RVzQVoOJ+HxEI1D4t+gpq1lSBcPrQ9+2bu//JD8wJ5VJ/SXuzthUXILyvGMscG7e
	oy4vwBpVS+tJ9CO3dHyZauQTmzaxXBDSdaD/lVnhNGvkC8Js3pLCyptSatN5DuAN
	C6VB1A9pI+xDIlqDVN0+Vlp3bpD8WBdOiEVIhA7cNaNnknQtUiI3c1TMNZyEQQUu
	6DJxP8wMuGc/9+DxYX0Ff4B0+tJ8eWKrZB7IwLUiVfDBYikzCrSULD9qm/z8ex9I
	xPXw+cnRiBgUs6NjfcW7OSM63A6Kj0Vpi5t55Y0n69S911xG3fnkVUng1ZjlNFns
	obwA2d1ju1UewlUSPIzy9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791021564; x=
	1791107964; bh=cP/WTIDnkCui6QvszsvKLen2QAUJz/e/MHFvKQJHrlI=; b=q
	JawxZ6TwhMmx5z8bTy5txMRv1lgb1GZHH2q+wrA18844lbIQeFDcV1M4g43zgLNd
	zDpxEt9G8q9q/54PrWLCdyXtTV3M6yFWSHVW7bn80KPwAWcSAj7FfeD72qwz8Z1Q
	awu+yZZ2UblRTpxpt5Q/HIU3IQI1iQhls60JQjo4Cc022NJAa34y0lYVm7cmP0V0
	1Yz/8fWswl1E3mSK6l9B3zfUn2zaXS+DyGI+pW5fIJZljNv3B1NmLh7wuR2/p9LZ
	8dTC32jOwAR3PipX01gNBoNccnC6U/GDJPtl3DvbM9vg2I/6e1aJBfGxl1PzqLMM
	JLwxjWNQFfCHMXoDGyG3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791021564; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QKNG8HMW5UaFlk86smbaKs4M1D4qQn+ROdaoKSf40SvQwEz
	tyNJeugYKafNsz47z0kURRIXMomX9/DEDm3XIfnyozeGboM7zfmxmfo3whBrXKM0
	NLPrPtT7QG119dRz8cR2C9b2G3VW8u0yKhBX/VuPzggRjBHFzfR4v9gxyABT3Hju
	4oHwNyuvo9/KhyIhkRWhAGKFf7Bx14DNmmiulSgQalXJeZwDL1FQPU1BJZ6l5gjr
	eZtf3hcWUMkzfTMIaOIPcb4TchaqP6LCKNcHmJ+5xiA3UZZA+VdIMK3RuTvUY2rL
	71o/VrCk/HN7GS3ZBb4t8t6wRvAE7bYyDPlX+cg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RuEVffO7XrVzizN3qEFynoxGdQDEfl/WGc7afRp+YCA=:AhBhz2g8QOQdLAartJLkmrx6kQngKini7GtXYuK8bX0=;
X-ME-Sender: <xms:-9HAaqq3dyqBnDsHszExX0kwdzLc29yn6uM6Jkxgak1oXUctclQPsQ>
    <xme:-9HAat02NJGF2QsLU7zql4auXoL84a4p_pV-LL3CdNg39i-E_jxgz4TznOX203sbe
    pHYlrFYpFSQEVIihrEagqd-Ee2H59Y4gSkxmjOHwvWAFrGsQeYohxhO>
X-ME-Received: <xmr:-9HAailyrBV8lHAo4UHNjxzG2s6NCruTjkUxYXE9huDAvervEoMpfssM334KsX7wRMvAEB64JGn1UvuBWQBdS8qcCbB8KRc>
X-ME-Proxy-Cause: dmFkZTFujBsgDkwPibKstalTlHYzYb9Z9h3kj+ybdGu08NC6Nps2ra8ealwpVZbTiTyyJa
    IQJTogV4yx1pJzX/5ndI5LQw999aQO1JQ+mi1XaEVjm0T9ti/jEhZEMPcURUFlBt55Jdo1
    HU/r7nU+JddfTYsanHPJ3KnjH8NOgFPRYN3Tvv7rAAiqZ3AwLUqKzxYItnk3j2iBXMLeL5
    a2QsM7UTtKEaFON86+cr5DwFPc0L+mJb2ktP/KQJrZ9Ekwkk6jxiM/c2ET0odzX4CPu3OL
    r/Fhetvk6E+FpZkvg89CeqcdvlszACu7yB/9tfGxt43+LF5FaV00MeR/bPPy5/VEbXB3lj
    p0pxnZv8mXgmeYII2SL6uzSx6M1M+C4rh9hL2QVfvYDo/pg/bFeK47GG6TWOmDgPIre48W
    cZt/tTlRnZywRSqysIcqdqvXRdkKGdOdOwlUg+EQCIvLw9ikKysPaSrVqZNpWbymu+yrpo
    tYxbPPZV7FyQJlNIKWeREVzZIfovNrYm7FFQgTCn4vs2nipJlBTYmAwVG8likF5eiuFxaY
    b0FVJ9uiWH6vE8b0bsd1IpkpcPsw0tGXl05sujj8/D7LlQtabLoRAFps2W7IK8RpQpU+uL
    UY1aaeHi967d0yq3DH1Z/AjXSIYItAZ71LWOjrVAeHDxKTK+v/dTN7Z8aGaA
X-ME-Proxy: <xmx:-9HAapaw55IoJrXQyDz34c-4msQ0VLtnDVF3BDTJ-myz-Jjc1Pt5_w>
    <xmx:-9HAak-HEHZ-iNO4QCff0t5ToJMggPzjgc1pMafqdQJrezHVVLPfww>
    <xmx:-9HAapEWT54xBo7t4c7wzscN2kD4T3lEc7_vp99P6Fw5okHbbB2noQ>
    <xmx:-9HAaudyWkSDWMhVef2WwgXlUyWLQFS5l4yOIfyDQSes_LVcOs3A7w>
    <xmx:_NHAas4wUcw7SbKNf9Wti7u3ul6-rEk5_VFaiTj_9QLJI2wcXNboTI4O>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 05:59:23 -0400 (EDT)
Date: Sat, 3 Oct 2026 11:59:21 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Jiale Yao <yaojiale02@163.com>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 6/7] net: ravb: release managed IRQs before
 freeing netdev
Message-ID: <20261003095921.GB1933679@ragnatech.se>
References: <20261003085940.493951-1-yaojiale02@163.com>
 <20261003085940.493951-7-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003085940.493951-7-yaojiale02@163.com>

Hi Jiale,

On 2026-10-03 16:59:37 +0800, Jiale Yao wrote:
> ravb_remove() frees the netdev before devres releases the managed IRQs.
> The handlers use the netdev as their data pointer, so an interrupt during
> that window can access freed memory. Probe error paths have the same
> ordering problem.
> 
> Keep the netdev manually managed and place only the IRQ resources in a
> dedicated devres group. Release the group after unregistering the netdev
> and before freeing it, and release it on probe failures as well. This
> keeps the existing runtime PM error handling unchanged.
> 
> This issue was found by a static analysis method used in our research.

What happened to switching to use devm_alloc_etherdev_mqs() instead of 
adding this complex thing, as we discussed in v2?

Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Fixes: 32f012b8c01c ("net: ravb: Move getting/requesting IRQs in the probe() method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791..ab4703888778 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2963,28 +2963,35 @@ static int ravb_probe(struct platform_device *pdev)
>  		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
>  	}
>  
> +	if (!devres_open_group(&pdev->dev, priv, GFP_KERNEL)) {
> +		error = -ENOMEM;
> +		goto out_reset_assert;
> +	}
> +
>  	error = ravb_setup_irqs(priv);
>  	if (error)
> -		goto out_reset_assert;
> +		goto out_release_irq_group;
> +
> +	devres_close_group(&pdev->dev, priv);
>  
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		error = PTR_ERR(priv->clk);
> -		goto out_reset_assert;
> +		goto out_release_irq_group;
>  	}
>  
>  	if (info->gptp_ref_clk) {
>  		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>  		if (IS_ERR(priv->gptp_clk)) {
>  			error = PTR_ERR(priv->gptp_clk);
> -			goto out_reset_assert;
> +			goto out_release_irq_group;
>  		}
>  	}
>  
>  	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>  	if (IS_ERR(priv->refclk)) {
>  		error = PTR_ERR(priv->refclk);
> -		goto out_reset_assert;
> +		goto out_release_irq_group;
>  	}
>  	clk_prepare(priv->refclk);
>  
> @@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	clk_unprepare(priv->refclk);
> +out_release_irq_group:
> +	devres_release_group(&pdev->dev, priv);
>  out_reset_assert:
>  	reset_control_assert(rstc);
>  out_free_netdev:
> @@ -3144,6 +3153,7 @@ static void ravb_remove(struct platform_device *pdev)
>  		return;
>  
>  	unregister_netdev(ndev);
> +	devres_release_group(dev, priv);
>  	if (info->nc_queues)
>  		netif_napi_del(&priv->napi[RAVB_NC]);
>  	netif_napi_del(&priv->napi[RAVB_BE]);
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
