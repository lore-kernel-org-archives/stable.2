Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419A3E5A33;
	Mon,  5 Oct 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234995; cv=none; b=qYAu099n33HIFyPyUA4N82t3BnQ+SI1hGSYDmqdQTNu10AFo8XFBG6Ld2CBXB5a+vNaZRDPuD7YMxBHex0t6h1T1fyInCC0KlKQd2dTuH+CoLzDDqw4eDuLPoHPNWvzLeq0RRTAYwu3f934TuiGHxtz0LCGtqEQZfBl+NxJkQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234995; c=relaxed/simple;
	bh=LO1J7bob4991rz5cYh3HMP9AtOg22//J0+f124dtHYA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZR/bHiMS13qRI761vQ0pZq+VwUCkjqC8wmrsoXyEqYAmCQAjra4DKowDzLq2IMPPB7r/lATqLbhArIXIAsJ5c7MKIcdy4O5TSV039Tnj1hR0G/Yktd33PdQsJ0RsqYjPm0+qLKC4YzYsBpQQA2Z9n7Xh4gGQEFINzc+06FHQ5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Zjn/Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Zjn/Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3AF1F000FF;
	Mon,  5 Oct 2026 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234990;
	bh=GxjGPAdbTyWkLNOx6DyvChvOCeh+LjtpxWD/8SPN/T4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T2Zjn/YvgGxax7u4MrUGgo/D9q7To56Huux8cqyni3X8TGdTZFpzcUXAqBWiu79Ns
	 ONI0/sUJUZG/HgLWID/BlnVlMWAmGm5gAY6M/m1r2FljwURF1D3H03J2MO+mADmGln
	 6e9x81r+Qt315TM+aFZFcEaIjyvejoHFGSPHeQhl+QPSsGR7526HEGbEfUag8FBVde
	 WRsTCZW5nIieVZTJEolXzneYRKapIFykfuqtxW3+8MXytuvbR47RZCnUcnWobN2X+n
	 xJ3pwY5wpA1+4uDKyuRyCCZURgswcR/MrEcyb33BMjt/EA/jljWlA+Vi/EP82ImSiO
	 //Dec2hJaUhHw==
Subject:
 Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 21:16:29 +0000
Message-ID: <179123498942.434549.13440734253618262332@kernel.org>
In-Reply-To: <20261005023812.130639-1-edumazet@kernel.org>
References: <20261005023812.130639-1-edumazet@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete for short non-linear skbs, and for them it
  changes the wire frame for the worse.

--

bnxt_en: fix DMA mapping length for padded small packets

This patch replaces skb_pad() with skb_put_padto() in the normal_tx path
of bnxt_start_xmit(). After the change, skb->len and skb_headlen() include
the padding, so dma_map_single() maps the whole padded buffer. The pad
variable and the rewrite of the last BD length are removed.

Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d7728d0c5b6e6..7ea27e81e88c5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  normal_tx:
> -	if (length < BNXT_MIN_PKT_SIZE) {
> -		pad = BNXT_MIN_PKT_SIZE - length;
> -		if (skb_pad(skb, pad))
> -			/* SKB already freed. */
> -			goto tx_kick_pending;
> -		length = BNXT_MIN_PKT_SIZE;
> +	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +		/* SKB already freed. */
> +		goto tx_kick_pending;
>  	}
> -
> +	length = skb->len;
> +	len = skb_headlen(skb);

[Severity: High]
What happens here when the skb is non-linear and shorter than
BNXT_MIN_PKT_SIZE?

bnxt_start_xmit() reads last_frag and tx_buf->nr_frags earlier, before
any padding:

	last_frag = skb_shinfo(skb)->nr_frags;
	...
	tx_buf->nr_frags = last_frag;

For a non-linear skb, skb_put_padto()->__skb_pad() skips the tailroom
fast path and calls skb_linearize(). __pskb_pull_tail() then:

  - copies the frags into the head
  - calls skb_frag_unref() on each one
  - sets nr_frags to 0

The frags[] slots themselves are not cleared.

After that, len = skb_headlen(skb) covers all 52 padded bytes, but
last_frag still holds the old count. TX_BD_CNT(last_frag + 2) and
SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag) still count the old
fragments. The frag loop also still runs over them:

	for (i = 0; i < last_frag; i++) {
		frag = &skb_shinfo(skb)->frags[i];
		...
		mapping = skb_frag_dma_map(&pdev->dev, frag, 0, len,
					   DMA_TO_DEVICE);

This emits a BD for each stale frag, and TX_BD_FLAGS_PACKET_END is set on
the last stale BD:

	txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);

As an example, take a 42-byte frame with a 14-byte linear head and one
28-byte frag. AF_PACKET PACKET_TX_RING can build one through
tpacket_fill_skb(). The head BD would describe 52 bytes and the stale frag
BD another 28. Wouldn't that put an 80-byte frame on the wire, with the
payload duplicated?

The NIC would also DMA-read pages that the skb no longer holds a
reference on. If this skb held the last reference, those pages could
already be freed or recycled.

The completion path in __bnxt_tx_int() (last = tx_buf->nr_frags) and the
tx_dma_error unwind path also trust the stale count.

bnxt sets NETIF_F_SG, so the core does not linearize these skbs first.
They reach normal_tx whenever the push path is skipped, for example when
tx_push_thresh is 0, the ring is not empty, or lflags is set.

The old code mapped the same stale frags, so that part is not new. Its
total descriptor length still came to 52, though, because the pad was
added to the last BD. The oversized frame with duplicated data seems to
come from this change. It also doesn't match this part of the commit
message:

  so that dma_map_single() maps the full buffer and the descriptor
  length is consistent.

Could the padding be done before length, len, last_frag and
tx_buf->nr_frags are read, and before the free_size check? Or could
last_frag and tx_buf->nr_frags be read again after skb_put_padto()
succeeds?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005023812.130639-1-edumazet%40kernel.org
