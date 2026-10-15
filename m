Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384181684B0;
	Thu, 15 Oct 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082286; cv=none; b=N170yXyMUl9QQQZQXfO0o2E9t+rYQJvgSFFw+KjMs8/bFdQh5qYf4wowBgB8Qy/IF20ALMBBBPN8fykpP9fGyo400s8unzefTXqrHhrCFXTnZAeOEB7zcwsbkKDYfkFb1q1wYs04jGZ+9qUECTkPURnm0El/uJon9raVdtIwbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082286; c=relaxed/simple;
	bh=Tl7HxDIjipe6m0Tk68nbEwxwsLEDgSoQIfiIh2CtkBU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ToyZ/bm88Yozm9B7pgGy+ENrGyvc1Vmy1A6laHPMe7uEoNDwpTnc6GhbeABFzPkcLUqmKqsvdCvuLcp5hSHdJFExCT+rHEVcoWyc7iHjIbyuR4MNeHR9zlvllTc5JVGseNsiGtWjwVNOalcqddURi0yQH+Yuve27ubqZZIrypXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBoGsk0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBoGsk0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D651C1F000C5;
	Thu, 15 Oct 2026 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082273;
	bh=J8Ghc916VwV8YIfUc/Uxibbm6amSUje62iHNzWirMC8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nBoGsk0e/eI4m/vubZcic2PC5Ky37MpdXmuDv6mijgTCJAPULtRp67iFNzqAmqZ5J
	 4kaqXLdAxERaH/H1U5jEj5ukSV+2DFA5mNx/vvrWUFrDNXHOp/cUX34rqgKQInbf5a
	 SjX01y94O+QZYmamUqKZJpjG+1t7LVYWIFXO14BbdZbyZlzx/QaemnXOdtHMe1/of4
	 ysWgMcis2jblNUDGjoVuT3wI25zoqb0Qhy/be2Ap071SvChzrlX++quul3ChtmGWnn
	 aXEAxtIXzc7jiaoXQgaB0RU9EIRsoqbCBvtw10Xs86enXMcotEmnrednGh3O1tI/5/
	 CwIWOmakaJ5/g==
Subject: Re: [PATCH net v2 1/3] can: dev: prevent bus-off recovery when the
 interface is not running
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Thu, 15 Oct 2026 16:37:52 +0000
Message-ID: <179208227237.1406898.11528789185033827404@kernel.org>
In-Reply-To: <tencent_196A2433801631CD2FA42998465E26316105@qq.com>
References: <tencent_196A2433801631CD2FA42998465E26316105@qq.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Split-frame drop accounting in stmmac_rx_zc() is inconsistent
  per frame and per core.

Pre-existing issues:
- [High] stmmac_dispatch_skb_zc() (stmmac_main.c:5533) sets
  `skb->ip_summed = CHECKSUM_UNNECESSARY` for every IP frame when RX COE…
- [Medium] priv->xstats.rx_dropped and priv->xstats.rx_errors are device-
  wide unsigned longs.

--

net: stmmac: drop split frames on AF_XDP zero-copy RX

This patch fixes stmmac_rx_zc() so that split frames are drained as
errored, and the last fragment is no longer handed to XDP as a fresh
frame. It also changes the legacy normal and enhanced descriptor
callbacks to report rx_not_ls together with discard_frame for non-last
descriptors.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> index 0512536012251..297e2428a8f9b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
> @@ -184,7 +184,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
>  
>  	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
>  		x->rx_length++;
> -		return discard_frame;
> +		return discard_frame | rx_not_ls;
>  	}
>  
>  	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> index c4b613564f87c..d19bf7ca4db38 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
> @@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
>  
>  	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
>  		x->rx_length++;
> -		return discard_frame;
> +		return discard_frame | rx_not_ls;
>  	}
>  
>  	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f0835be2f65a7..10ea72cbf889a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5695,18 +5695,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats,
>  						  rx_q->dma_erx + entry);
> -		if (unlikely(status == discard_frame)) {
> -			xsk_buff_free(buf->xdp);
> -			buf->xdp = NULL;
> -			dirty++;
> +
> +		if (unlikely(status & discard_frame)) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}
>  
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
>  		if (unlikely(error)) {
> +			xsk_buff_free(buf->xdp);
> +			buf->xdp = NULL;
> +			dirty++;
> +
> +			if (status & rx_not_ls)
> +				goto read_again;
> +
>  			count++;
>  			continue;
>  		}
> @@ -5715,8 +5718,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (likely(status & rx_not_ls)) {
>  			xsk_buff_free(buf->xdp);
>  			buf->xdp = NULL;
> +			rx_dropped++;
> +			error = 1;

[Severity: Medium]

Is the split-frame drop accounting here consistent across descriptor
formats?

The legacy callbacks now return discard_frame | rx_not_ls for every
non-last descriptor. So the discard branch above runs first for each of
those descriptors, and there is no !error guard:

    if (unlikely(status & discard_frame)) {
        error = 1;
        if (!priv->hwts_rx_en)
            rx_errors++;
    }

On dwmac100/dwmac1000, a frame spanning N descriptors would then add N-1
to rx_errors. It adds 0 to rx_dropped, while count / rx_pkt_n goes up
only once for the frame. The new rx_dropped++ in this 1:1 block can never
be reached on those cores.

On dwmac4 (and similarly xgmac), dwmac4_wrback_get_rx_status() returns a
bare rx_not_ls for non-last descriptors:

	if (likely(!(rdes3 & RDES3_LAST_DESCRIPTOR)))
		return rx_not_ls;

That means this block does rx_dropped++ and sets error = 1. If the last
descriptor has RDES3_ERROR_SUMMARY set, the discard branch also does
rx_errors++. The same dropped frame then shows up in both rx_dropped and
rx_errors.

Later in the series, stmmac_rx() is changed to count only once, using
(!error && (status & discard_frame)). Should stmmac_rx_zc() get the same
treatment, so each dropped frame is counted once in either rx_errors or
rx_dropped?

>  			dirty++;
> -			count++;
>  			goto read_again;
>  		}
>  

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch. The
new rx_dropped++ feeds into an unsynchronized accumulation at the end of
stmmac_rx_zc():

	priv->xstats.rx_dropped += rx_dropped;
	priv->xstats.rx_errors += rx_errors;

These are device-wide unsigned longs. They are updated with a plain +=
from per-queue NAPI contexts that can run at the same time on different
CPUs. stmmac_rx() does the same thing, and stmmac_get_stats64() reads
them without any locking.

Can concurrent NAPI polls on different queues lose increments to these
counters?

[Severity: High]

This isn't a bug introduced by this patch, but it is in the same receive
path. On XDP_PASS, stmmac_rx_zc() calls stmmac_dispatch_skb_zc() without
passing status. That function marks every IP frame as verified when RX
COE is enabled:

stmmac_dispatch_skb_zc() {
    ...
	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
		skb_checksum_none_assert(skb);
	else
		skb->ip_summed = CHECKSUM_UNNECESSARY;
    ...
}

On dwmac4, dwmac4_wrback_get_rx_status() reports L4 payload checksum
failures only as csum_none, without discard_frame:

	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
		x->ip_payload_err++;
		ret |= csum_none;
	}

Also, dwmac4_dma_rx_chan_op_mode() sets MTL_OP_MODE_DIS_TCP_EF, so the
hardware forwards these frames instead of dropping them.

Suppose a frame with a bad TCP/UDP checksum arrives on a ZC queue and
the XDP program passes it. Could it reach the stack as
CHECKSUM_UNNECESSARY and hand corrupted payload to applications?

The non-ZC stmmac_rx() handles this case:

	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
	    (status & csum_none))
		skb_checksum_none_assert(skb);

This still seems to be the case at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_196A2433801631CD2FA42998465E26316105%40qq.com
