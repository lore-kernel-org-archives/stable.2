Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEB27FB0E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023492; cv=none; b=olamcH0+On+yh71RLSUahwqdLIcfZsKXQIHEjuieEZIqQMHYEG2CbtcFBnrY6zL5PbKToQg6Q1MQnoiwH0fAql+eX4BmJgFony8nt0J7rDo5t2IrNcrmh5XCsjz47jz2O4dlugCZvZPZ0JCQU0Vonb7gl7JZ8KT0TDS86Hu75qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023492; c=relaxed/simple;
	bh=Iuj8eEALz44CQqthTbjR76qCcfOgWSdYKv4kWbeBxAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcbsDOOj3FplTBqqpqjRcAV3rG2eRc6jJCmmZLC2psK9sUH6eWLnRt0xdwUs5NwG2kTGgmzATMh0Fi6hywAl2PFfjnz8Y5qqhzhKOLmTx3GfsjJzEOAJT1TcqRRdec4hymbPL7dDR5VJdMBgbuguwCgzaNUP4I8DsPx9lls2SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rq4yHfjK; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rq4yHfjK"
Message-ID: <fa89cba0-e9e5-49af-beb9-13b2fa94ca19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786023477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqUxzqGOpPJdwXbsyUGY1DU6gotHKjUskbv5j+h3a64=;
	b=rq4yHfjKRCJcj47tsl1w/fqvuc4Kiv9cg2v5m5FC+1+JigamKewQaFzq10TOPCiKi03ihE
	rTdfmuRqbS0U3sL4oWua2eYFKz0wM9XpA3zFhlMZuoseavh51o8VmgCHEkO97A1pyLYmEd
	iOcuUrBDrFwkqbWVWQ/TrP7ErM1XCzA=
Date: Thu, 6 Aug 2026 14:37:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] net: ravb: handle unavailable PTP clock
To: xuanqiang.luo@linux.dev, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, niklas.soderlund@ragnatech.se, kuba@kernel.org
Cc: paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 masaru.nagai.vx@renesas.com, sergei.shtylyov@cogentembedded.com,
 luoxuanqiang@kylinos.cn, stable@vger.kernel.org
References: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
 <20260806095126.57803-2-xuanqiang.luo@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260806095126.57803-2-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/08/2026 10:51, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PTP clock is registered by ravb_open(), not ravb_probe(). Therefore,
> priv->ptp.clock is NULL between register_netdev() and the first open, and
> ethtool -T triggers a NULL dereference in ptp_clock_index().
> 
> ptp_clock_register() may also return an error pointer, which can reach
> ptp_clock_index() or ptp_clock_unregister().
> 
> Normalize registration errors to NULL and only query or unregister the
> clock when it is present. Leave phc_index at -1 when no PHC is registered,
> while preserving the static hardware timestamping capabilities.
> 
> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/renesas/ravb_main.c |  3 ++-
>   drivers/net/ethernet/renesas/ravb_ptp.c  | 12 ++++++++++--
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5f88733094d0f..3a9d9f8718216 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
>   			(1 << HWTSTAMP_FILTER_NONE) |
>   			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>   			(1 << HWTSTAMP_FILTER_ALL);
> -		info->phc_index = ptp_clock_index(priv->ptp.clock);
> +		if (priv->ptp.clock)
> +			info->phc_index = ptp_clock_index(priv->ptp.clock);
>   	}
>   
>   	return 0;
> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 226c6c0ab945b..eaf07cb8eadfa 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -315,6 +315,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
>   void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
>   {
>   	struct ravb_private *priv = netdev_priv(ndev);
> +	struct ptp_clock *clock;
>   	unsigned long flags;
>   
>   	priv->ptp.info = ravb_ptp_info;
> @@ -327,7 +328,13 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
>   	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
>   	spin_unlock_irqrestore(&priv->lock, flags);
>   
> -	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
> +	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
> +	if (IS_ERR(clock)) {
> +		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
> +		clock = NULL;
> +	}
> +
> +	priv->ptp.clock = clock;
>   }
>   
>   void ravb_ptp_stop(struct net_device *ndev)
> @@ -337,5 +344,6 @@ void ravb_ptp_stop(struct net_device *ndev)
>   	ravb_write(ndev, 0, GIC);
>   	ravb_write(ndev, 0, GIS);
>   
> -	ptp_clock_unregister(priv->ptp.clock);
> +	if (priv->ptp.clock)
> +		ptp_clock_unregister(priv->ptp.clock);
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
