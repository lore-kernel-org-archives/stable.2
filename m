Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4843FD96B;
	Thu, 24 Sep 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246808; cv=none; b=HVsu3MVYIEthRbHyEhBWGAm/tClmdU0S59iTXjFURovt+9zwNW3I2L+HrUhEhrpuMcp+NI3GPhq9Qud2gGpBFh5tE7WHqgxGVoHk6/PlnI1RGb3JnqmdR238ehleAHIDHHCSYJD9iHRmB0cHaaTPKIYvw8v7CJMf245pyYLuOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246808; c=relaxed/simple;
	bh=pexZf/lQWtuVxEygmxSvzl6d8CItj5/N0Rz0PZcxpaY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1JSD10kmJzsWyZXen8p6UUdT05yFhFooQBeckKX8Xe10a3nodKnDEcl5HQKMaerbr6uFStJJLSV6UFN38XhVMaBY6gjC1fONeZL5qaJxRqWR7LdCVZzzhBrJP7u9nx9YPcYd+Cul/D6sk/jdto3fbbHwwZ5pT5nNlfp/KLikuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3Dbduyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3Dbduyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD981F000FF;
	Thu, 24 Sep 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246805;
	bh=pHwjyd75jGXUA28aQ8EhKH5vE+R5WhiWoZJE1UJa0W4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B3Dbduyr3JmYwWReoyQlsQGv9XPzKelGrn19zLIfHBCv0wvTvoAdX9pBGzzUYWyT/
	 ri9EaAHfZ1af8ehO1b8GP1d+lCIrLGoJr+4vBIijg5HkreCiM0txbUefaAqxkSKmWf
	 5DiNxeUVI0fC6PEFEQjTTKdxLg4EO/GXt9x2t+xTf0jP+SM3QWK4MThVV6xNJQj2rY
	 +Q4rbwWdkdD6/cySQJFi8OXr3SZk+SxVEyglxVC/uwhlG5ocjlBLpWrKP4zK4Ot+C9
	 AP3w4lkafbsO8PpJhGUzPasZ4bTIFlBhWLwy9V6EUMetXS2oCGO7IVlbPJ5ZcCfvQr
	 LVqFmknBNolTQ==
Subject:
 Re: [PATCH net v2 1/9] gve: increment work_done for XDP and error packets
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:44 +0000
Message-ID: <179024680434.2160803.7562423537279284993@kernel.org>
In-Reply-To: <20260922194533.631387-2-joshwash@google.com>
References: <20260922194533.631387-2-joshwash@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes only a NAPI `work_done`
  accounting fix, but the patch also changes the semantics of the…
- [Medium] The newly added receive packet/byte accounting for XDP-
  consumed packets is unreachable for AF_XDP zero-copy buffers, so the…

--

gve: increment work_done for XDP and error packets

The DQO RX poll loop now increments work_done for every end-of-packet
completion instead of only for completions that produced an SKB, so XDP
and error packets are charged against the NAPI budget. The packet and
byte counters were moved into a separate rx_packets accumulator plus a
new increment on the XDP non-PASS path.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 5cf242b285577..c3f4a76b0fac5 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -932,6 +932,10 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>  		if (xdp_act != XDP_PASS) {
>  			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
>  					 buf_state);
> +			u64_stats_update_begin(&rx->statss);
> +			rx->rpackets++;
> +			rx->rbytes += compl_desc->packet_len;
> +			u64_stats_update_end(&rx->statss);
>  			return 0;
>  		}

[Severity: Medium]
Is this new accounting reachable for AF_XDP zero-copy buffers?

gve_rx_dqo() dispatches those buffers before the xprog block above:

	xprog = READ_ONCE(priv->xdp_prog);
	if (buf_state->xsk_buff)
		return gve_rx_xsk_dqo(napi, rx, compl_desc, buf_state, xprog);

and gve_rx_xsk_dqo() takes its own non-PASS exit, which updates only
xdp_actions[] via gve_xsk_done_dqo() and leaves rx->ctx.skb_head NULL:

	if (xprog) {
		xdp_act = bpf_prog_run_xdp(xprog, xdp);
		buf_len = xdp->data_end - xdp->data;
		if (xdp_act != XDP_PASS) {
			gve_xsk_done_dqo(priv, rx, xdp, xprog, xdp_act);
			gve_free_buf_state(rx, buf_state);
			return 0;
		}
	}

With the reworked loop below, such a completion bumps work_done and then
hits "if (!rx->ctx.skb_head) continue;", so it is never added to
rx_packets/bytes either. Should a DQO queue running zero-copy with a
program that mostly returns XDP_DROP/XDP_TX/XDP_REDIRECT keep reporting
0 rx_packets/rx_bytes while the same program on the copy path now
reports them?

The GQI path counts XDP-consumed packets in rpackets/rbytes
(gve_rx_no_hsplit() does "ctx->total_size += frag_size; goto
finish_ok_pkt;"), so the DQO zero-copy path looks like the only
remaining outlier.

[Severity: Medium]
The commit message only describes the work_done change:

    Ensure every packet is accounted for in work_done by incrementing
    work_done before checking for the existence of a SKB.

Could it also mention that rx->rpackets/rx->rbytes semantics change?
XDP_DROP/XDP_ABORTED/XDP_TX/XDP_REDIRECT packets on the non-zero-copy
DQO path did not previously contribute to these counters, and
gve_get_stats() folds them into rtnl_link_stats64 rx_packets/rx_bytes:

	packets = priv->rx[ring].rpackets;
	bytes = priv->rx[ring].rbytes;
	...
	s->rx_packets += packets;
	s->rx_bytes += bytes;

The note "corrected stat counting for packets relative to work_done"
sits below the --- separator, so it will not be part of the git history,
and the patch carries Fixes: 293b49361f91 plus Cc: stable@vger.kernel.org.

> @@ -1090,6 +1094,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
>  	struct gve_rx_ring *rx;
>  	struct gve_priv *priv;
>  	u64 xdp_redirects;
> +	u32 rx_packets = 0;
>  	u32 work_done = 0;
>  	u64 bytes = 0;
>  	u64 xdp_txs;
> @@ -1150,13 +1155,14 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
>  		/* Free running counter of completed descriptors */
>  		rx->cnt++;
>  
> -		if (!rx->ctx.skb_head)
> -			continue;
> -
>  		if (!compl_desc->end_of_packet)
>  			continue;
>  
>  		work_done++;
> +
> +		if (!rx->ctx.skb_head)
> +			continue;
> +
>  		pkt_bytes = rx->ctx.skb_head->len;
>  		/* The ethernet header (first ETH_HLEN bytes) is snipped off
>  		 * by eth_type_trans.
> @@ -1164,6 +1170,9 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
>  		if (skb_headlen(rx->ctx.skb_head))
>  			pkt_bytes += ETH_HLEN;
>  
> +		rx_packets++;
> +		bytes += pkt_bytes;
> +
>  		/* gve_rx_complete_skb() will consume skb if successful */
>  		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
>  			gve_rx_free_skb(napi, rx);

[Severity: Medium]
Related to the commit message question above: moving "bytes += pkt_bytes"
ahead of the gve_rx_complete_skb() failure branch means packets the
driver drops here (and also counted in rx_desc_err_dropped_pkt) now add
their bytes to rx_bytes, where previously they did not. Is that change
intended, and should it be described in the changelog?

> @@ -1173,7 +1182,6 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
>  			continue;
>  		}
>  
> -		bytes += pkt_bytes;
>  		rx->ctx.skb_head = NULL;
>  		rx->ctx.skb_tail = NULL;
>  	}
> @@ -1187,7 +1195,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
>  	gve_rx_post_buffers_dqo(rx);
>  
>  	u64_stats_update_begin(&rx->statss);
> -	rx->rpackets += work_done;
> +	rx->rpackets += rx_packets;
>  	rx->rbytes += bytes;
>  	u64_stats_update_end(&rx->statss);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com
