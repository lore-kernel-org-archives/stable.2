Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B6485507;
	Tue, 13 Oct 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866139; cv=none; b=awMQnJZcNvCH/DgF/Cn9XAx3uAg3zhWrvfKnCD7CTEYNe+4/lGdiBng5b5Ib3ztYTdyGbr/cRz9b5n5Y65ZojUy0Ycx2dTMq+ecjqDm99or4ZVOtaLizX3wv92dD9+u9SRVuB7QWxdp+batRXTF7xXK/syua5MWBaZVthYkTJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866139; c=relaxed/simple;
	bh=Tfr6dvHzRV+70FHAgTz1TLAjPYBHw+Yd0piT4b891Hs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fB7sXQljCm4ScHenCULuen4oMOYtQm+IJjdcJwPKxoe7XEKLBlDWJSfnKMNylo/mccxdz0YimSOR27oE18dHdo3XqFV6iT+evP6CoNjioDCR1RpO8zB+EgQF/HcjR89mFNc9SixII66IImIctOy+RmbgxBBLpatl8Rqo2JNJewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbfWgguS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbfWgguS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBE31F00893;
	Tue, 13 Oct 2026 04:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791866137;
	bh=SPCI5H7VsZ2fQG972JLDNRfK05GncDQslo1Z5y4FNbg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jbfWgguSJj5MkRPNyW59qf0qrWgHaYbF07NTIQd9lEsMmEi4Dk3veWXho5XSAmlBc
	 tk4Z7pPism42eM2QMB+gLE5afw+p9uWKCxrGDXcdTmf2MC9nwQ06sURiQ5AUVchZ3m
	 e28et8x5jIJuaSdRoafVCgYuO0jx7foowSbY2XOJnUOf36wvaC1btv+gTKnl0nVbe6
	 /29/7BcgxhwM6KAkxYKtAWug/t7vtkFk3H7HUIGredO01d+2rlB08gU7JsbpfFjCie
	 NYnW9Bm/HYka11i+FYa4X4PV6dAEsOZxBP6ErDJqeyoFCXnwOH/SrRkzkTBMY+f+A/
	 Hjt0XqTEuGszg==
Subject: Re: [PATCH net v3 2/5] eth: fbnic: validate the Rx completion offset
 and length
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: alexanderduyck@fb.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, daskald@meta.com,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, daniel.zahka@gmail.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 04:35:36 +0000
Message-ID: <179186613625.434549.4689508518886265061@kernel.org>
In-Reply-To: =?utf-8?q?=3C5b7c2618b56d35f50b6847d565a0050cf2a7f371=2E1791775?=
 =?utf-8?q?409=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
References: =?utf-8?q?=3C5b7c2618b56d35f50b6847d565a0050cf2a7f371=2E17917754?=
 =?utf-8?q?09=2Egit=2Eyhlee=40isslab=2Ekorea=2Eac=2Ekr=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] fbnic_pkt_prepare()
  (drivers/net/ethernet/meta/fbnic/fbnic_txrx.c) still lets a device-…
- [Low] The commit message says the derived frame end and truesize are
  clamped "so a FIN descriptor cannot push them past the page".

Pre-existing issues:
- [Medium] In fbnic_add_rx_frag(), fbnic_page_pool_get_data() takes a
  fragment reference by decrementing rx_buf->pagecnt_bias (line 782).

--

eth: fbnic: validate the Rx completion offset and length

This commit adds checks on the header offset and length in
fbnic_pkt_prepare() and on the payload offset and length in
fbnic_add_rx_frag(). Completions that fall outside the 4K fragment are
dropped. It also clamps the derived header frame end and the payload
truesize to the fragment.

> exceeds the fragment, via the drop path. Clamp the derived frame end and
> truesize to the fragment so a FIN descriptor cannot push them past the
> page. A maximum-size header (offset 192, length 3584) stays inside the
> fragment and is still accepted.

[Severity: Low]

Is this description accurate? The FIN branches already produce values
inside the fragment:

	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);

	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);

So both new min() calls change only non-FIN completions. The new in-code
comments describe this correctly, but the commit message says the
opposite.

The clamp also changes in-spec traffic. Take the 192/3584 example without
FIN. fbnic_hdr_pg_end() returns ALIGN(4288, 128) - 192 = 4160. Before this
patch, the shinfo sat at 3840..4160, past the fragment. After it,
frame_sz is 4096.

Could the commit message say that the clamp fixes an overrun on valid
non-FIN descriptors? It could also note that the clamp reduces frame_sz
and the charged truesize for them, since this is headed to stable.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index 305fe6d2f511f..7dda59bba14ee 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> @@ -1037,13 +1037,34 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>  		return;
>  	}
>  
> -	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);

[ ... ]

> +	if (unlikely(hdr_pg_off < FBNIC_RX_HROOM ||
> +		     hdr_pg_off + len > FBNIC_BD_FRAG_SIZE)) {
> +		pkt->add_frag_failed = true;
> +		return;
> +	}
>  
>  	/* Short-cut the end calculation if we know page is fully consumed */
>  	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
>  	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
>  

[ ... ]

> +	hdr_pg_end = min(hdr_pg_end, FBNIC_BD_FRAG_SIZE);
> +
> +	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
> +
>  	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
>  	frame_sz = hdr_pg_end - hdr_pg_start;
>  	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);

[Severity: High]

Does the new upper bound in fbnic_pkt_prepare() leave room for the
skb_shared_info that napi_build_skb() puts at the end of the frame?

The check only rejects hdr_pg_off + len > FBNIC_BD_FRAG_SIZE. The frame
also has to hold FBNIC_RX_TROOM, which is
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)), or 320 bytes on x86_64.

Take a non-FIN completion with hdr_pg_off = 4000 and len = 64. It passes
the check (4064 <= 4096), and then:

  fbnic_hdr_pg_end(4000, 64) = ALIGN(4576, 128) - 192 = 4416
  hdr_pg_end = min(4416, FBNIC_BD_FRAG_SIZE)        = 4096
  hdr_pg_start = 4000 - 192                         = 3808
  frame_sz = 4096 - 3808                            = 288

That frame_sz then reaches the core skb builder:

  fbnic_clean_rcq()
    fbnic_run_xdp()                (no program, or XDP_PASS)
      fbnic_build_skb()
        xdp_build_skb_from_buff()
          napi_build_skb(hard_start, 288)
            __finalize_skb_around()
              size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

Can this subtraction wrap to 0xFFFFFFE0? If so, skb_shinfo() points about
4 GiB past head, and the memset() of the shinfo writes there. That looks
like the same __build_skb_around() memset crash quoted in the commit
message.

Any hdr_pg_off above 3968 gives frame_sz below 320, with or without FIN.
FIN completions already had this before the patch. A non-FIN frame,
though, always had frame_sz >= len + 512. For these completions, the new
min() clamp turns a short overrun past the fragment into a write about
4 GiB away.

A second case is when frame_sz is large enough but the shinfo overlaps
packet data. With hdr_pg_off = 192 and len = 3900, the frame is clamped
to frame_sz = 4096, and the shinfo starts at fragment offset 3776, on top
of received bytes. napi_build_skb() zeroes it. The unchecked __skb_put()
in xdp_build_skb_from_buff() then leaves skb->tail (4092) past skb->end
(3776).

Wouldn't a later skb_put() on that skb hit skb_over_panic()?

With an XDP program attached, xdp_buff_add_frag() also writes nr_frags
and frags[] into those overlapping packet bytes. The program can read and
modify them. fbnic_put_pkt_buff() later trusts them for
page_pool_put_full_netmem().

The driver programs the device with MIN_TROOM = FBNIC_RX_TROOM in
fbnic_config_drop_mode_rcq(). FBNIC_HDS_THRESH_MAX is also defined as:

  (4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)

The commit message's maximum example (192 + 3584 = 3776) ends exactly at
4096 - FBNIC_RX_TROOM.

Should the check be something like this instead?

	hdr_pg_off + len + FBNIC_RX_TROOM > FBNIC_BD_FRAG_SIZE

That still accepts the 192/3584 case. It also keeps frame_sz >= len + 512
with no overlap. The last patch in the series leaves this check
unchanged.

> @@ -1091,11 +1112,25 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
>  		return;
>  	}
>  
> -	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> -
>  	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
>  		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
>  

[ ... ]

> +	truesize = min(truesize, FBNIC_BD_FRAG_SIZE - pg_off);
> +
> +	netmem = fbnic_page_pool_get_data(qt, pg_idx);
> +

[Severity: Medium]

This isn't a bug introduced by this patch, but does fbnic_add_rx_frag()
leak the sub1 page reference taken here when xdp_buff_add_frag() fails?

fbnic_page_pool_get_data() decrements rx_buf->pagecnt_bias. Further down,
the failure path only marks the packet:

	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
	if (unlikely(!added)) {
		pkt->add_frag_failed = true;
		netdev_err_once(nv->napi.dev,
				"Failed to add fragment to xdp_buff\n");
	}

When the buffer already holds MAX_SKB_FRAGS fragments, the netmem never
reaches shinfo->frags[], so fbnic_put_pkt_buff() never puts it.
fbnic_page_pool_drain() then unrefs with the reduced bias, and the page
never goes back to the pool.

This patch only moves the fbnic_page_pool_get_data() call below the new
checks. A later patch in this series, "eth: fbnic: return the page
reference taken for a dropped Rx fragment", adds
qt->sub1.rx_buf[pg_idx].pagecnt_bias++ on this path, so the leak is gone
by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791775409.git.yhlee%40isslab.korea.ac.kr
