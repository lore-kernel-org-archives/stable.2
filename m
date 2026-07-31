Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3B369D54;
	Fri, 31 Jul 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522357; cv=none; b=nLUclYOwa7R65t4dJRdfNG9xS6ur0eMh2PFmnOK/xYLk+pms0VUNtNdKIZ6Ax6mzNs01R87rWEhnfXCN6IirG3g07aLlIfEm8ESVVnC3RYhQdS8Q2choPF9KH2PnmWPnwp1sgLG0lALvxaPKK2JCmThcEXllEn61tVtbcq4skEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522357; c=relaxed/simple;
	bh=5hrjQvx8iD4ZGilQxrqNhRE8ZL0ZwlJeVccvLXrcZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGGBcxxEtxpMKaYiSi5+SZD1KpikqSopt3TBHSCtNd1vivZ5oMKTOp2ioJfXjDy9s/H/U1FWRqSRQ6UodcENo7r3VNbnng/mPhtXLDu2LGdQAuoT6ohnPWjo5Kmumyy6T4EUYzCRLvOk/IwEL140lMokhh37P971aaNiPWjbnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=rPeux+L8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQIAn15P; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="rPeux+L8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQIAn15P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BE51EEC00CD;
	Fri, 31 Jul 2026 14:25:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 14:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785522354;
	 x=1785608754; bh=VpAACdbqgoMRRMEGfSGLAzDOa8c9oJaR04sPjU09qWs=; b=
	rPeux+L8qKZi7SRMfiKPk7z8HZOxM/cjCtLPhoa7B8db4L42Uei1gW/lQa8HyN/7
	L9QT4jpr7UexJYPKV6AUxKEK4FGxjGGTdim8Myy2xMUSnzkODjl1Sg6oxL7JMn5Y
	3ttuqCEhMuu7PB5WL6rObkxvrYol7H3fG0R6fGQnSOcVc3hQkKxAtKVqS0nTHEHU
	dkkVKhrg2aER6OAj+Bm2bUcmiiBdrK7eu6USVb7FpL7bLeAWNH4ljki9VPpUj3xK
	SjhOF1WcRqQVXmC2TmU3ckUlA0s5BsG/kmiaNK3UsHgkoalP9lNl2fSVqpw3eOVE
	wcwFuENFbI/0jlCYP4Ls/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785522354; x=
	1785608754; bh=VpAACdbqgoMRRMEGfSGLAzDOa8c9oJaR04sPjU09qWs=; b=D
	QIAn15PfdM1aYWGY2YTogtOZuFC/Vu96IPflXHCP9me03YaJoPjqBp/MLxDpUlBV
	AGZhWM3VfTwj/4P4SktOXpF2dH+ujVqYHtQduYeAo23QLRSRVmbsSOnjsrmcosrj
	ybH12ohi3bzev6qgsVOEA7Ri+fg6C49qcKoBtlErp/EUPUFDt36PSO5HgQzTll6Q
	BJvTnZCn1c+QfS+yXWx5u9I05hHw//K+pvTGLg8htWz5GR+YHIcGUnLFXx0TxSCD
	KofPg9b1Ykssr8NLyIYoR6pUfho1Bik1CBbsRFsBtZxEd8m/pxFYKSajCL3AxBdq
	svvPsfiep9DOj3y0gdiog==
X-ME-Sender: <xms:sehsagE3TPbilb0_Dqvg-M7iHpiCBf4O3bPHxvfS7Xub_tUa0B-N8A>
    <xme:sehsao6Q6Ig8gDx8EL6vwGlyBoWp_X_GjDHX7WLkWCcPQ-g-sZrcS2JjpQWwcAUtG
    oyxBnFu5MYFUwH0IG5Qtx84xiH7wzN43mUhLoB4VS1V1o_qlzDN7MGU>
X-ME-Received: <xmr:sehsauezSIY9iJzYWNSLUGasSNFy03TvVTvRMXRSVvgkhS2pWsGkBPOBYiXDgkvpBbz1PEdi6iIk-iiINeJxTOOmA8YdMLg>
X-ME-Proxy-Cause: dmFkZTFQPpKbqkOATKwKJ3fqlldu1+bwpEwGWqF0uPl515rMbwU0CsJuHcYKpYfu9DdlgR
    lOviYcTMc7rBrXZ0cXNaL/4RwcxTfWqik2GTJeaSLO7f8a4+DAazghdEBuMYNycdOpADM2
    9yJrjGY9icJ2L3s4FUldGoFp75xtZNwkGtyC3oxyQx2PvTNoMehUzjvkhCgCq6m3IL+1Ii
    9Apzm/ubd7nUQ7l4GkC0a2IvA1Ou4ipK+E0qoOiv4pCWZ9bK9Dgb0hQoF1zuNRfRod2Ztx
    3d6j0IF2MdcLngNcaw+TFCLoN9dknSbszSeHV6xokAS4giVmnC1DcXOsvmJbVdrLB20qmz
    5qTiA3mWQJn8Q8ROo/4hOheJ5pP7+5iat776+p1tRx5t7C2kyVif+gBSu8OB7JCGYKEHgD
    IEtsu3d6e6vyRFG07aBJGhcLKdQpCupmK7dPdXAIqM2NPHlGj+RkN9jjvL0598p9fJnEIk
    RHpDBcvwrc5LdSuDv5dzFVqCV9YtflDSwW9NDYtuV4rZlsGuGgJo/52U0rMT0R4pgZNwTx
    sjSgD2EjRXfMxXNmp4E8VgcudevygXtN1qHaHC0IBOOFnnnrDU9A55BvXrUXWyJkf6FtQu
    JU8tadvmBg+1v4VThNJtdTY/bpOQWLoKWg8+DH9GX2anRBtrRrFPAgTEdsIg
X-ME-Proxy: <xmx:sehsakmjaupJUhUXsAJyYid3JiM9LhdZWAXaNVvZdn-TYM8TQr4Now>
    <xmx:sehsaj-tIrZgSq1zAtn0EFn6cqUNZPvN6pEwWNs4TIufC3v5Gh7uCQ>
    <xmx:sehsaqFys5MuPeK2nyiSuGb3lwX_UbIgm1FOyECP5doNVcV81pH4oA>
    <xmx:sehsanIUlxNFVXEn_mc0Zlhk12azjqktH-TnhomPQnKtlPAWeSbudA>
    <xmx:suhsakTJ7_PhVNS0xfk5CqUMNsTNgt7AfohotVdSkLgsiWMijlah-Tas>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 14:25:52 -0400 (EDT)
Date: Fri, 31 Jul 2026 20:25:50 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: xuanqiang.luo@linux.dev
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: ravb: fix use-after-free in ravb_get_ts_info
Message-ID: <20260731182550.GA3091634@ragnatech.se>
References: <20260731063254.71260-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731063254.71260-1-xuanqiang.luo@linux.dev>

Hello Xuanqiang,

Thanks for your work.

On 2026-07-31 14:32:54 +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PHC is registered by ravb_open() and unregistered by ravb_close().
> However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> clock. Since the netdev remains registered after ndo_stop, get_ts_info
> can still pass the dangling pointer to ptp_clock_index(), resulting in a
> use-after-free.
> 
> Clear the pointer after unregistering the clock and only query the index
> while a clock is registered.
> 
> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> I don't have access to RAVB hardware to reproduce the issue. To aid
> review, see the similar PHC lifetime fix merged as commit 8da13e6d63c1
> ("net: macb: fix use-after-free access to PTP clock").
> 
>  drivers/net/ethernet/renesas/ravb_main.c | 3 ++-
>  drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5f88733094d0f..3a9d9f8718216 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1779,7 +1779,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  			(1 << HWTSTAMP_FILTER_NONE) |
>  			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>  			(1 << HWTSTAMP_FILTER_ALL);
> -		info->phc_index = ptp_clock_index(priv->ptp.clock);
> +		if (priv->ptp.clock)
> +			info->phc_index = ptp_clock_index(priv->ptp.clock);

While this avoids the lifetime issue, the fix is incomplete. The info 
structure will still report HW clock support but there is no PTP clock 
index.

I have a pending series which cleans up most, if not all, of this issue.  
Could you check [1] and see if that covers your concern? I will post a 
new version of that series as soon as vacation time is over and the Gen4 
PTP driver itself is merged.

1.  https://lore.kernel.org/all/20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se/

>  	}
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 226c6c0ab945b..fc8c601ed3a5e 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -337,5 +337,8 @@ void ravb_ptp_stop(struct net_device *ndev)
>  	ravb_write(ndev, 0, GIC);
>  	ravb_write(ndev, 0, GIS);
>  
> -	ptp_clock_unregister(priv->ptp.clock);
> +	if (priv->ptp.clock) {
> +		ptp_clock_unregister(priv->ptp.clock);
> +		priv->ptp.clock = NULL;
> +	}
>  }
> -- 
> 2.43.0

-- 
Kind Regards,
Niklas Söderlund
