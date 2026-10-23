Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795326;
	b=CeKg8Ffo9dG3hZFjbLQc2bf/byGaY16VY+7OG+5Y47P50pOwcoAW0ZcpCfWRtdwmuYyy
	 l7OuQh6edXy2T6kA0e8LhbP1lhCMy0i18SP0sYDlWJ+OsKN8LqCJKLr3ndo5qdjrUos+S
	 iaql5YivB/C7bBd//U1AWdiphwwk6eHdodihFI+kUTybfuYtXVLA1wztegOXhm4ECKRAY
	 RQBW5kwQ59Rkz+VmtGwGXkSEkU1v0+qewTgVxwOyToQjcg4dqveLAl0BoZV9HuYm/c4NS
	 nwpvyib2Kj5K6uSrLUG/6bZ8TUCn2/qyOmITSQAyOmwIazTxx/T7BHKDDrnZAlaQEnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4wNHCh54AAWOk3FutPjsVsjqvlf9bK+9IRjfMX0W13o=;
	b=NpFuzlCyewY/3zaTkw+yOhUGw1pB9jKQHca3pJgFda3rMEWFw8rtR+JkyXNoSOKhI3+D
	 tzRggGKDM33H+zMQXnKtU1rF24DvJeXtK6qN9ostk9P9zA7CKjLs6uiFVZljgs/U0rsW+
	 3xCDCNM+7nb4lDeikIDVOUaM2W3lRsTqJzLoTJL0HCo5yvopx+1Ha1uWJj2oYlSCmxqbT
	 Rs2MU5NCOUobcuzYBprcTIPR+RkpFyQ6UHv+jK3PVMMqvW+f/DA0js7zMJU6hHDIphIa5
	 6gwGWl5Hkqb6WRWqOGf8nUZqZiVJZXBErP+YTM9GKbP3pz8oyNYXMTQEGXyl8ObQscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+xRvqpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83274606A321;
	Fri, 23 Oct 2026 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+xRvqpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AEA1F01828;
	Fri, 23 Oct 2026 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795326;
	bh=4wNHCh54AAWOk3FutPjsVsjqvlf9bK+9IRjfMX0W13o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j+xRvqpwXo3YV5EnvWdCGlSJRFzPk5JZV6B4fEY1aVhn/OPu3YsMhudVEiorvn60N
	 xS9ckhoBCEfM6RN7xqzWydG/Q2wmeKP8/Wi/B1gWO/zF8aAJkUmFAZ/q/bYKpkm/3/
	 tYdNNtPsFfXt/csyhsM4JAYZ5+wKAZ+zPbn67IJwq9FPfyQZ/FTwMYkfYpkuwzcR2/
	 obSzLhxrzBIxPN/ZyrVYYgnOuEhLOurWJXaaiN6dRXAo6tMQr5eGuOaKBGbSGJtUVi
	 602FW790balM50S54Anu4h0yC74XyEBYBKuGKWE14+h+cH1Pe+oHCHWArAO0Ox9G9W
	 c9D+3u0HoyujQ==
Subject: Re: [PATCH net 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
From: netdev-bot+sashiko@kernel.org
To: opensource@grische.xyz
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de,
 stable@vger.kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, aaro.koskinen@nokia.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 22:42:04 +0000
Message-ID: <179279532482.3134.8732796861806998047@kernel.org>
In-Reply-To: <20261020190319.884375-4-opensource@grische.xyz>
References: <20261020190319.884375-4-opensource@grische.xyz>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] dwmac1000_dma_operation_mode_rx() now sets CSR6.DT
  (DMA_CONTROL_DT) on every dwmac1000 core, whichever descriptor format…

--

net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets

This patch sets DMA_CONTROL_DT in dwmac1000_dma_operation_mode_rx(). With
that bit set, the dwmac1000 MAC hands up frames that fail the Rx checksum
offload check instead of dropping them. The aim is to make VXLAN over IPv6
with zero UDP checksums work, with the driver marking those frames
CHECKSUM_NONE.

Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
Link: https://github.com/freifunk-gluon/gluon/issues/3783

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index 3ac7a7949529c..00c8d4dfb553b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -129,6 +129,8 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  {
>  	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>  
> +	csr6 |= DMA_CONTROL_DT;

[Severity: High]
Does this work on dwmac1000 cores that use normal descriptors?

DT is now set no matter which descriptor format is in use. Only the
enhanced descriptor parser turns checksum-only errors into csum_none, via
enh_desc_get_rx_status()->enh_desc_coe_rdes0().

stmmac_hw_init() reads enh_desc and rx_coe from separate HW capability
bits:

    priv->plat->enh_desc = priv->dma_cap.enh_desc;
    ...
    if (priv->dma_cap.rx_coe_type2)
        priv->plat->rx_coe = STMMAC_RX_COE_TYPE2;

stmmac_dwmac1_quirks() then picks ndesc_ops whenever enh_desc is 0. So the
driver allows a core with normal descriptors and Type-2 Rx COE.

ndesc_get_rx_status() can only return good_frame or discard_frame. It
never sets csum_none, and nothing in the driver checks
RDES0_PAYLOAD_CSUM_ERR from descs.h:

    if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
        ...
        if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
            x->ipc_csum_error++;
        ...
        ret = discard_frame;
    }

If ES is set for the checksum error, stmmac_rx() now drops the frame in
software and counts it as an rx error. Wouldn't VXLAN over IPv6 with zero
UDP checksums still be broken on these cores?

The comment in enh_desc_get_rx_status() says the databook does not
require ES for payload-only checksum errors. If ES is clear in that case,
ndesc_get_rx_status() returns good_frame, and stmmac_rx() does:

    if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
        (status & csum_none))
        skb_checksum_none_assert(skb);
    else
        skb->ip_summed = CHECKSUM_UNNECESSARY;

Could a frame with a bad L4 checksum, which the hardware used to drop, now
reach the stack marked CHECKSUM_UNNECESSARY?

Either way, this part of the commit message would not hold for normal
descriptors:

  "CoE remains enabled, so the driver still sees the error status and
   marks the skb CHECKSUM_NONE for the stack to verify."

Would it make sense to set DT only when enhanced descriptors are in use,
or to make ndesc_get_rx_status() report csum_none for checksum errors?

> +
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable RX store and forward mode\n");
>  		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020190319.884375-1-opensource%40grische.xyz
