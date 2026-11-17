Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927275;
	b=AXtqdXAl+SkbPCYE3ir+8oOTDm6QbxS2NwjVgpmVu5CwPuCSBAvPPw1PWqaLAHS0pEhV
	 l8RI1rVxUBojOd43ltbn2jSlK1OZPb1zNLdDIRZEcX+i5RR7rp87QP6q4Joa/5SKfMFBj
	 CxWuBgxsGOAtn6tsxlEV1EFzbo0pr7+fKdSRSo8YUH99RQA0dzeKG/a0QSSTC+IOsgozK
	 BFIahHhlVsExzRWbr+bV4Aq+JJt2m2BxJCJ17KFk7FbNYac8Hq08Re/DQuadfzjELLpJL
	 9yLMddpe8cavulPxqpWiqiKPyKEnw6uXrT3b6XH7cnW5k5MMjlFW2cNecRh9m5dpvxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927275;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=2Wq9AE25iea427W8wiH0e2Ewq13PobRIAnClSSphGUw=;
	b=PKmQNH6IIFizgIwlh6tL75QJGKHKabViGqitq3j2jbqYiaK3Ly6Wa17ENFSqrNfsXlLC
	 DiT/mlRsNTzQdiyhiPzY9FcMDOF+bDlszNneVdkh+zxdyxh0RAtGM+UboVwdGxDy67Io8
	 c3EgHYKCzkuGRfvJ7XHiZPgjngMBiAUX/ZS4I66k11JJeDPXVExt5rQf6tkE/SoXSCt+6
	 iZhdlNUCirh021tXgcC+DbuvI5s8TY67vtWwYlwMVqLZgPCvjJnJsMOIB4YQ1NULlUy9/
	 OkeRpuYsf7qtv98KyeFytfi50OOF5Z0YfvlKQRgezKMN1F1AHY7hX8jZdzIV18g6vhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RldvSNBi;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B29606A336
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B29606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RldvSNBi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D4D73C79A9B;
	Tue, 17 Nov 2026 14:54:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49E9E5FD6A;
	Tue, 17 Nov 2026 14:54:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D187511BC0026;
	Tue, 17 Nov 2026 15:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794927271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2Wq9AE25iea427W8wiH0e2Ewq13PobRIAnClSSphGUw=;
	b=RldvSNBih/YepnuGq2MmKOY6A9rIpEumELC0ddV1Qgq3r8IhTrV9lLpBVSihJHenq/I5Vm
	nd/D9MLgGB234C7uQ88P5bQwFSTY+e4TDToHLYcXFPrmuKPTqcBi7dLVsJw32RGbjuDYJq
	DSpyU8dNw+tl5D0GFkjGBp4MDLolXdsuoCK7TJlQvzelGr+QaF4TV9f8tpXJQK6ktyC3U1
	ZIIWLKrlz+S+q7+hhl7LD9tk/gm5zD17LNzTyrGIkcrpSZqz3fehRtbOjXHyJO9Z+zne/f
	+TVHU/jYSpNFMwbDgip6SnNlQIpAKn1oCFtg8VOPxoboHaMQCZd36nFYvjiQvQ==
Message-ID: <d06c6f0c-a0cc-4b6c-a0ec-eb459ea0eaef@bootlin.com>
Date: Tue, 17 Nov 2026 15:54:22 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: honour Rx checksum errors in the
 AF_XDP zero-copy path
To: Christian Schmidbauer <opensource@grische.xyz>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Oleksij Rempel
 <o.rempel@pengutronix.de>, stable@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Ong Boon Leong <boon.leong.ong@intel.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261114133640.3285413-1-opensource@grische.xyz>
 <20261114133640.3285413-2-opensource@grische.xyz>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261114133640.3285413-2-opensource@grische.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/14/26 14:36, Christian Schmidbauer wrote:
> Commit ee0aace5f844 ("net: stmmac: Correctly handle Rx checksum offload
> errors") taught stmmac_rx() to honour the csum_none status, but
> stmmac_dispatch_skb_zc() still ignores it and sets CHECKSUM_UNNECESSARY
> for every IP frame whenever the checksum offload engine (CoE) is
> enabled.
> 
> Since commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
> dropping checksum-error packets") dwmac4 delivers such frames instead of
> dropping them, so this path receives them.
> 
> Mark the skb CHECKSUM_NONE when csum_none is set, as stmmac_rx() does.
> 
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7ffed295eb14..3e5803db19b4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5547,7 +5547,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
>  
>  static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  				   struct dma_desc *p, struct dma_desc *np,
> -				   struct xdp_buff *xdp)
> +				   struct xdp_buff *xdp, int status)
>  {
>  	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
>  	struct stmmac_channel *ch = &priv->channel[queue];
> @@ -5575,7 +5575,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  
>  	skb->protocol = eth_type_trans(skb, priv->dev);
>  
> -	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> +	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
> +	    (status & csum_none))
>  		skb_checksum_none_assert(skb);
>  	else
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -5789,7 +5790,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		switch (res) {
>  		case STMMAC_XDP_PASS:
> -			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp);
> +			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp,
> +					       status);
>  			xsk_buff_free(buf->xdp);
>  			break;
>  		case STMMAC_XDP_CONSUMED:

