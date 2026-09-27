Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783883B3C17;
	Sun, 27 Sep 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524902; cv=none; b=QNtPMfRcEzSCOP+iyyeBPSmRIvBxMY626NVbOJ0m//lh7329m04Fqmwl5iz6ZisAQd8I48LImrwwYpCZoke4gYmu/DKZkpYxZaMweAzgUt1IuaKH7WQ0EQIb5cHCtlUQzfXyxTn5l7jPXdKTCvNqIC0t/eQMY7H3/GoadKI6K+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524902; c=relaxed/simple;
	bh=QKjyFzQFESEOV87npH/ZVOVFrduCd1HjBLpLmsLFlfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smztxdwis91jJq51F6479mGimJSq0/9kYb+BnYlxR5kLKxPliYXIs9vdxfzgSUIxjq8Hxx07nufCcHmAWT+ThYQzfcweqiS4OfKjwqd0onhNQRGiToEH01Dg3fooSLD5gy9Ys0Akx/T0q8PyEi1nD8/DXYXTkUGYZjWK7PA4b7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=j1KOMry9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVFRWIFr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="j1KOMry9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVFRWIFr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01A407A0060;
	Sun, 27 Sep 2026 12:01:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 27 Sep 2026 12:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790524898;
	 x=1790611298; bh=0zuplpuVZWgGMTC2nxNOGM1NvWiIFzH5W1G4banFKks=; b=
	j1KOMry99UyfgtbkGpL1IGgnZ98yaE23BgbyfzfKGd9C268jAZwH8eqLbVG9gKV+
	Ab4Vz0+Sj6EUFGa3wFKqJ+evOqiu6Wv4W+5xoVeny84pL+4JQkwxMynvm/sSVYqq
	VuplKz6jRUxjoJ3irmFhg50OKkSx+r+iL6+d21D5tqr4dY9itGHfirwejAR3ZA0G
	cBiNJYqoHZbkAzpNWrqpd7F1m6QW8zUS182bpjZoDnBnJmoDSEsWQtiLSnbKhhok
	IcMJyV74w2beM+Z87Im5/oTxxW1Y0lc201ASgQO/iefwhhkNeils0KpQZieah0h2
	1q96bxapxXWwD0NlYZpb1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790524898; x=
	1790611298; bh=0zuplpuVZWgGMTC2nxNOGM1NvWiIFzH5W1G4banFKks=; b=i
	VFRWIFrwDwWEm685MPHyxGtxTvUP99hWilFE9zq6tDopw/KoWMnW9BBZyMzLWyok
	2zs2dL+Lc8kyh/njlCCnPejuHIlQO8D5NFtzmKHOuXN+cybc5Ed3TMlP/jWCMqkM
	5lo9oIPSeTvh1s6ZaHzHqX0wFTdySKDPJxTS1UOtS+2cuhH8d4ntgOuPZPSHc9ze
	2cArI3eLWbpXro9Z291Ctj4xF/mO53DjDH79FXIFspUKCn5oUecXvEBsQOxw47aT
	u+6qI4ebMAMZg4aRqIPE4EJaoSfgSsMu7bmN+SlJfFP+esDX+H6YvyK35eHAuRWe
	177fE4iV1jPkz/955MSZw==
X-ME-Sender: <xms:4T25ao_D2fDoBqKdxmynf9sLPNH9b3Ue13AjYWFdNYllgmlzjfMlZg>
    <xme:4T25aonI6ZbwZZG46vmi7DJNJchOBFYqCNa8O8t_PuMUtvVBzgAouRPHtSLjla6ZS
    NmDXkzd7IZIVeJTG6HJqtWdQiAjTq3cMLfMfP4PijHKQS8ozwnaCxEt>
X-ME-Received: <xmr:4T25atbXtKuIWwVuE26dddPlknNKtVsGXxBXpOh_LDVE4qI8GOaVDzwvja1Z8Kt_6DVZBbObzZqK4f8z5DBxb2tIqVLpOa8>
X-ME-Proxy-Cause: dmFkZTGabjLNdShx2e8Je0zOPYz8yhq6splHMkyFigOoSkm3a9NK72vVEfV9d0NtrGX8pc
    LOnq7UniaR7T0J5IVm+7GSEBSoQJGlrVGFlm19mH1TATVrAM401h2zssX57D9IvE31ik0e
    /v4bO+MzgdmMmMQPSl0wekbUJlSDB+pHwKXRvpOaKjJAZ7TCGiHpiPtx6ulk+hXbq3rIxd
    tPYZLxI8op2eFnvZ9dJ5E0kBP87TqAAEOnuAmxbHMuVjQu9mvvXEySY+NhoBYaGrY8rJqN
    n4Re6gTxhnWiOB24QwkGcBuKDCYFdsUwkadsMEj4tpTa54at2Y88H5g/bkdo9yf8GPQrGX
    25WXpS0efwRLNMZua7fTevwuWmxVfE/4fDyU3R/Pnh85h2ZLMVUecCea17nsRYYOWqTZj4
    0N/2x/E2iS6mt0FW43LPagr1crXkbqzGqMje/bIUucRG6zqytyJngw0LNwU6gcVyQ7ILjQ
    1EFWItccgIVgJ+v/xOhg8rMo3CglW/eiMBKpKAAHYRM0Pdqf+3Jt5L//G+bfiVnvdggPkc
    sGlymBJpBAIpUdSRgpLzzf/TGr6GBVtkOnPigfc8V4aisOoOsHbzXPAB3qlm5HhM/pKyxj
    96gGLuZf8w6KSG0PLIfCBYiyK6b+VMrjzMJW5aKXqDJn/c9LBlvbH0rSkCjw
X-ME-Proxy: <xmx:4T25agOygzcovoxr9Dh1lFPzuAWeIUyjQyh7YtVnGvlBDVxTkg3sAQ>
    <xmx:4T25ale7S4m_ENvPataRznOML0DZeJ7iCQUO69y906_uH1lSFN5mBw>
    <xmx:4T25auEJvxup5nxclTiA49IscZYveZAfyMTdcahvdJjdP0q03XQoiQ>
    <xmx:4T25aoumCX4y33fgxe8K6Z2nYpj9XVsaCg9jHatEuY84ANX9A30CAg>
    <xmx:4j25arw-F_DCeoTpZmtqaUp3QTBnrAnoxwtl1PpuFW-HfgLZGg0imp9->
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 12:01:37 -0400 (EDT)
Date: Sun, 27 Sep 2026 18:01:34 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Jiale Yao <yaojiale02@163.com>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
Message-ID: <20260927160134.GI1099675@ragnatech.se>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-7-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927144741.1320558-7-yaojiale02@163.com>

Hi Jiale,

On 2026-09-27 22:47:39 +0800, Jiale Yao wrote:
> ravb_remove() frees the netdev before devres releases the managed IRQs.
> The handlers use the netdev as their data pointer, so an interrupt during
> that window can access freed memory. Probe error paths have the same
> ordering problem.
> 
> The remove callback also returns when runtime resume fails. That leaves
> the netdev registered while the driver core still releases its managed
> resources. A running interface already holds a runtime PM reference, so
> the extra get cannot invoke a failing resume. A resume failure therefore
> occurs while the interface is down and ndo_stop() will not be called.
> 
> Place the IRQ resources in a dedicated devres group and release it before
> freeing the netdev. Continue unregistering and freeing software resources
> when runtime resume fails, but skip the unmatched runtime PM put.

Would it not make more sens to rework the driver to allocate the ndev 
using devm too instead of adding a complex devres group? AFIK 
s/alloc_etherdev_mqs/devm_alloc_etherdev_mqs/ would allocate the ndev 
with devm too?

> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Fixes: 48f894ab07c4 ("net: ravb: Add runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791..a25f5ac7062f 100644
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
> +		goto out_release_irqs;
> +
> +	devres_close_group(&pdev->dev, priv);
>  
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		error = PTR_ERR(priv->clk);
> -		goto out_reset_assert;
> +		goto out_release_irqs;
>  	}
>  
>  	if (info->gptp_ref_clk) {
>  		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>  		if (IS_ERR(priv->gptp_clk)) {
>  			error = PTR_ERR(priv->gptp_clk);
> -			goto out_reset_assert;
> +			goto out_release_irqs;
>  		}
>  	}
>  
>  	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>  	if (IS_ERR(priv->refclk)) {
>  		error = PTR_ERR(priv->refclk);
> -		goto out_reset_assert;
> +		goto out_release_irqs;
>  	}
>  	clk_prepare(priv->refclk);
>  
> @@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	clk_unprepare(priv->refclk);
> +out_release_irqs:
> +	devres_release_group(&pdev->dev, priv);
>  out_reset_assert:
>  	reset_control_assert(rstc);
>  out_free_netdev:
> @@ -3141,9 +3150,10 @@ static void ravb_remove(struct platform_device *pdev)
>  
>  	error = pm_runtime_resume_and_get(dev);
>  	if (error < 0)
> -		return;
> +		dev_warn(dev, "failed to resume device: %d\n", error);
>  
>  	unregister_netdev(ndev);
> +	devres_release_group(dev, priv);
>  	if (info->nc_queues)
>  		netif_napi_del(&priv->napi[RAVB_NC]);
>  	netif_napi_del(&priv->napi[RAVB_BE]);
> @@ -3153,7 +3163,8 @@ static void ravb_remove(struct platform_device *pdev)
>  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>  			  priv->desc_bat_dma);
>  
> -	pm_runtime_put_sync_suspend(&pdev->dev);
> +	if (error >= 0)
> +		pm_runtime_put_sync_suspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(dev);
>  	clk_unprepare(priv->refclk);
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
