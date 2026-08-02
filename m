Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDD27707;
	Sun,  2 Aug 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673054; cv=none; b=S9lyavA3s8utYUnROnES1159/ZHnlbjS0gR5WwheSdYInxYNB8CzIjgzg7JZiG1CybLNEZMwGrkx9IKRM+gdAEvdiPF/Cfp6Z+dD7zqolkzotqya7DUoGTTLNQ28lF+TgZVM+w3x2TAy16+teXNBA1P/kfS633IGHMfzofAuluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673054; c=relaxed/simple;
	bh=HgGYV561t8qwSkZD7dAcdSJ+jGDfuwWUt57mi4tmoV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKDtQrs44UKNOn4kUXS2tCHd+mziw7ZefFL60ikUCWRkljRw38ceYec2t+TiPtojQ4UYwJnD1HBIUYEyR1rr7Ips20P4nS8HcMF+VrGrNv+HIkj76D2ALGvANRGuc5YOAiMf6t3D3stmm+n/KUDsGHRhIsh6dmSE9kf5nUDauZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=crEx7/h2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qmqs1f+6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="crEx7/h2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qmqs1f+6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 53B97EC0175;
	Sun,  2 Aug 2026 08:17:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 02 Aug 2026 08:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785673051;
	 x=1785759451; bh=kOVOozUerfv0Ofu3hPnHDoC5+w0yzLhd6prywMLE4Rs=; b=
	crEx7/h2aTDilq8KZ0P+wK8pD0oYrEEeSw1M8rF15iF38DRZve+YFOdVK1PByLV4
	yak2zbPNDOYTfC6pg0HzWPLWRkwDikS6NYpLJaO5MnnUd14B0LN8mt54IBBY+i1p
	ZmrW2H2BsWFHTiy5hE0qUrizoSX1ps3rvRPrTpLCx0V/CArsxvjwZUmxLjEBHufC
	6Pc/PqmK6uZ47e9eGheRqAwQoCkNmQBMoEUmVFf1v3gg3qWi/CF5oZe1rkxT8piU
	PwYI039MoGDwkJ/MqB23bDVT3qMyrV037adctINtYkoLP4WD1Fk2uzkELfAoiKCo
	kL4r97fujlFgPiSfLlmp+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785673051; x=
	1785759451; bh=kOVOozUerfv0Ofu3hPnHDoC5+w0yzLhd6prywMLE4Rs=; b=Q
	mqs1f+66mr+ssFeAjv2kEpe3R99sbERx01/Y11fxb0Fhh+QLh5suzmDd52NvQ9bC
	7BZ7rr/aQ1qngTgbFiFIaxMSN7NCcC5c6jY1M9XXk8bfAtLFHViErrRQqF6JxSrS
	MNPbouOw3qVV+gLURBz/6c9MYehIYnEJe9CT5LQ2DzS0eB0kx95qmopZID+ysRZx
	xWbzmdtzI104k2yD+RSc4rwryyc3MLEE64rJkxPoOWQcaNyZaTTTw4aLg94PVdSS
	iKBCpD27a/zukW8mpYYlYYTA3EUxqpMNT0OEcQ+mpAsYCrEJOH6s92yv5iNChBIO
	cBAixmzrJB6DYW9YaQBYQ==
X-ME-Sender: <xms:WjVvav5PzbO6ACkz8ts2qEXQAxtz-VU_SPmEZq9-kbB1V0TBfIJGDA>
    <xme:WjVvakeCj6SjeIQ2GHO6cVZg791F0DmQAB3vxxgOzoERiYedajfetegWtzFpI9lDg
    txkUCRELb8mgLaanLTVNRCTIj9V6pB-dlIQrTyF1GCfhlDxNO1Qtlo>
X-ME-Received: <xmr:WjVvaqzVFY4vGyldzSuF5ZsPa3P_xblTmHM7JnzH8_rKJiJXBRXaq1_1HI_0i-JDXIbV-9JnTV-qA7b05pDCXMVJw7IYWdE>
X-ME-Proxy-Cause: dmFkZTEC5wvd9yc8IU6JaHtsdk+wjDxP7W4KN90UqulSlS/oLHRcivJYO/wB/q/e1T91+M
    hJ+3jeFGoZL44f6VRelJ5u8GPU3XhW6gwWwyU2qj9/mdGn+0Y3HIVlZe4Zykeu1RKcdhxz
    LjrllYw111UpuHBA6t6au6PiyRIsL8m662JmsmCM6QswHFrw1Pot3+Ku/rKl/6uy0aED8D
    Pg+NM3Oj0rfSiJot2BKdRgrblqMwjgjAyTFF8X74dzy4QV2vjXVD+RPe7Nx2b58JFOr1SJ
    qhAaMu3mMvId8QLd8Bh40nMoKycnVRE1HUtN7OfSoSLzgZWcYaKYlkXHy2ZTT/HWmYgKgH
    UDIAvALI+m5lBoRHzHY9XnRQpbNvwYzbSys2nOmI2HgXJgCjFlTm1YOOZb7TcourFB9uBp
    EGK7VnZGLc+01djrJWzoVFvBR0JDVWkGVchy9zo8d/buL538HbooaElDSg7585XskKztT9
    PPCwpl2NDJb+qYreNqBpoDYJnK/JBcuxGM2j+Inn80CFvoQ3tqe6Kc+LJ9ijHr4zqJSecc
    Vcavqv3ExYKoZR0rwE4OkJb9Nr0gWS2OhS87G5oA9ps0cKNWmxchJHUvTgtm7AiyrW5iVA
    VMzaIOuu6KqhbNL5JEy96rxe/bxrjzoLUwczSvY0Z0oRu02ghJLx9YaUNb6A
X-ME-Proxy: <xmx:WjVvaioCtYAP8EsbTiYjprhRSAuLonyv5QtBvGn5m9wNYTu7vnYRQA>
    <xmx:WjVvagw5dxrSStm8Z6XxiyTY7NRusnnJGr4BMZuXWIc2cQS4VfwU7Q>
    <xmx:WjVvauomSegJ8fuDsK-De4ebnA35ureXk5XpP2Wp9lftjcEPgzjlNQ>
    <xmx:WjVvaodtmhh5XMe36BJClMtWCJmfvSNlfrAm1HhId3ux2CzAuAxznw>
    <xmx:WzVvalx8rSHqIAL2VWeonSKousjvkjl9uxHdctDOxRo_y92jvn9VsJdF>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 08:17:29 -0400 (EDT)
Date: Sun, 2 Aug 2026 14:17:27 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ravb: fix use-after-free in ravb_get_ts_info
Message-ID: <20260802121727.GA2716708@ragnatech.se>
References: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802090750.116215-1-xuanqiang.luo@linux.dev>

Hi Xuanqiang,

On 2026-08-02 17:07:50 +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PHC is registered by ravb_open() and unregistered by ravb_close().
> However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> clock. Since the netdev remains registered after ndo_stop, get_ts_info
> can still pass the dangling pointer to ptp_clock_index(), resulting in a
> use-after-free.
> 
> Clear the pointer after unregistering the clock and only advertise hardware
> timestamping support when a PHC is available.
> 
> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks for re spinning this,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2:
> - Only advertise hardware timestamping support when a PHC is available
>   (Niklas Söderlund).
> 
> v1: https://lore.kernel.org/all/20260731063254.71260-1-xuanqiang.luo@linux.dev/
> 
>  drivers/net/ethernet/renesas/ravb_main.c | 2 +-
>  drivers/net/ethernet/renesas/ravb_ptp.c  | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 5f88733094d0..f22cff05ba35 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1768,7 +1768,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
>  
> -	if (hw_info->gptp || hw_info->ccc_gac) {
> +	if ((hw_info->gptp || hw_info->ccc_gac) && priv->ptp.clock) {
>  		info->so_timestamping =
>  			SOF_TIMESTAMPING_TX_SOFTWARE |
>  			SOF_TIMESTAMPING_TX_HARDWARE |
> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 226c6c0ab945..fc8c601ed3a5 100644
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
> 2.51.0
> 

-- 
Kind Regards,
Niklas Söderlund
