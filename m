Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CEF483BC8;
	Thu, 24 Sep 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246817; cv=none; b=n+lRYTNs3MlPSwotai1rDXjbxRch287KQJXi9gvSpkzRtKmCTUEIQUEihd4j+PcGUO14tRlcWW+c+rFeE4e5HylCKIAvqcw1BnbB1S84aFcBLfWQ7sTOvCNBLh/d4SAMrkfnFXOHbPedDnKjpqWnxoE8w4b0CWCG8lElTDWMWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246817; c=relaxed/simple;
	bh=SWvb68TOOvKVFx4aoJuAFdMU6OY0qkaPdNl3q8uKe0A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECmgM/zvNrrTXmjaVriLF5hkDdXRep81+n+3pwJMX/5b4E0jCt1PMBHoIwYBdK/J0Lo+4CBFfv6lEVDISCZBkKJ7Hq1NZNunlMZZOX5RqR0QoJjD49eIh8oLzQmtC1ZI2n2MvsRiK5Yilz9zatGtWq2W2Q3yIzBfj7gBTi8plU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cllj7ZK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cllj7ZK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D481F000FF;
	Thu, 24 Sep 2026 10:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246815;
	bh=fpvNu9a4YjrqadxJvpRYsMvmWzz3IOyT2Tl4WoOE9fQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cllj7ZK/lkpF5VBYuHy9NVNj4qRyBp3ptkxZrLgpVs7cg1MSEwaXNfKMFJykGxjdh
	 R6/KpYcrppcr+kgTySuc2aYmzm3la4XPy/pP+6j85687INJVBJ1Z4r9hd7He13LduC
	 Ru0H+dP0KZPRC96SLoNYlWvlgOi/xszfD/i1k8SK6o9WyJDSvxmYUNWkg8AZHbGH2E
	 2+aX8QR/JP4Lb/oFOr2uaIeKsjcUTZ6lwIdeE6Rnuy6Q/k2oeqfsud2OrF2ERWN0QM
	 TY5BQ9TO/ED1Q8E6E1djMPhhWcPH1n7Z1Ej6EDzexkK5qKUk1SSTzfXzNypuQkOKUd
	 zJdpXiGUCWglw==
Subject: Re: [PATCH net v2 9/9] gve: prevent XDP frame leak and corruption
 during DQO TX cleanup
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, thostet@google.com, nktgrg@google.com,
 eddiephillips@google.com, pkaligineedi@google.com, jeroendb@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 24 Sep 2026 10:46:53 +0000
Message-ID: <179024681365.2160803.18423750984465801177@kernel.org>
In-Reply-To: <20260922194533.631387-10-joshwash@google.com>
References: <20260922194533.631387-10-joshwash@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch still unmaps XSK pending packets as if the driver
  owned their DMA mapping, so it never closes the bug class its message…
- [Medium] Now that gve_handle_miss_completion() no longer crashes on XSK
  packets, those packets can reach the late-reinjection branch of…
- [Medium] The new XSK teardown handling in
  gve_tx_clean_pending_packets() never runs when XSK packets can…
- [Low] The commit message describes only XDP frames being mistaken for
  SKBs, but the patch also changes AF_XDP zero-copy (XSK) behaviour…
- [Low] The comments were not updated to match the rewritten cleanup
  code.

--

gve: prevent XDP frame leak and corruption during DQO TX cleanup

This commit changes gve_tx_clean_pending_packets(),
gve_handle_miss_completion() and remove_miss_completions() to switch on
pending_packet->type, so XDP frames are returned with xdp_return_frame()
instead of being handled as SKBs. It also marks XSK pending packets
complete during teardown. It moves the XSK reorder queue helpers earlier
in the file so the cleanup path can call gve_tx_process_xsk_completions().

> When tearing down a DQO TX ring or processing miss completions,
> pending packets were assumed to be SKBs. If an XDP frame was pending
> during cleanup or timeout, cur_state->skb was accessed on an xdpf
> union pointer or the XDP frame was leaked without calling
> xdp_return_frame().
>
> Refactor gve_tx_clean_pending_packets(), gve_handle_miss_completion(),
> and remove_miss_completions() to switch on pending_packet->type.
>
> Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")

[Severity: Low]
The commit message only talks about XDP frames, but the patch also
changes AF_XDP zero-copy (XSK) behaviour. Could the message describe that
as well?

Before this patch, gve_handle_miss_completion() did:

	*bytes += pending_packet->skb->len;

For XSK pending packets the skb/xdpf union is always NULL, because
gve_xsk_tx_dqo() never sets it. So a miss completion on an XSK packet
would be a NULL pointer dereference in NAPI context. The new XSK case
fixes that crash.

That code came from 2236836eab26 ("gve: implement DQO TX datapath for
AF_XDP zero-copy"), which added GVE_TX_PENDING_PACKET_DQO_XSK. Should
that commit get a Fixes: tag too?

The message also doesn't mention two other changes. At teardown,
gve_tx_clean_pending_packets() now marks XSK slots XSK_COMPLETE and tries
to report them through xsk_tx_completed(). And gve_xsk_reorder_queue_head(),
gve_xsk_reorder_queue_pop_dqo() and gve_tx_process_xsk_completions() have
been moved.

Both commits landed in the same development cycle, so this is mostly
about traceability.

> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 78f946ae72649..e8481b993beb0 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c

[ ... ]

> @@ -201,11 +244,30 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
>  		else
>  			gve_unmap_packet(tx->dev, cur_state);
>  
> -		if (cur_state->skb) {
> -			dev_consume_skb_any(cur_state->skb);
> -			cur_state->skb = NULL;
> +		switch (cur_state->type) {
> +		case GVE_TX_PENDING_PACKET_DQO_SKB:

[ ... ]

> +		case GVE_TX_PENDING_PACKET_DQO_XSK:
> +			cur_state->state = GVE_PACKET_STATE_XSK_COMPLETE;
> +			break;

[Severity: High]
The gve_unmap_packet() call above the switch still runs for every slot,
XSK slots included. Can this unmap a DMA address the driver doesn't own?

gve_unmap_packet() assumes the driver mapped the slot:

	/* SKB linear portion is guaranteed to be mapped */
	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);

For XSK, gve_xsk_tx_dqo() posts a pool-owned address and increments
num_bufs, but it never records dma[0]/len[0]:

	pkt->type = GVE_TX_PENDING_PACKET_DQO_XSK;
	pkt->num_bufs = 0;
	...
	addr = xsk_buff_raw_get_dma(pool, desc.addr);
	...
	++pkt->num_bufs;

The XSK case in gve_handle_packet_completion() only sets
GVE_PACKET_STATE_XSK_COMPLETE, and gve_free_pending_packet() doesn't
reset num_bufs. A completed XSK slot therefore keeps num_bufs == 1, along
with whatever dma[0] an earlier user of the slot left behind.

On the XDP TX queue, the same slot can first carry an XDP frame from
gve_xdp_xmit_one_dqo(). That fills dma[0] with a real mapping, which is
unmapped at completion. If the slot is then reused for XSK, a later
ifdown, reset, or XSK pool enable/disable (via gve_restart_rings())
reaches:

gve_queues_stop()
  gve_tx_stop_rings()
    gve_tx_stop_ring_dqo()
      gve_tx_clean_pending_packets()
        gve_unmap_packet()
          dma_unmap_single(dma[0])   <- already unmapped

Slots that were never used for anything else would instead unmap address
0 with length 0.

Under swiotlb or an IOMMU, could this release a bounce slot or IOVA that
now belongs to another mapping?

remove_miss_completions() has the same type-blind unmap right above its
new XSK case. Before this patch, an XSK miss completion crashed in
gve_handle_miss_completion(). Now the packet reaches
remove_miss_completions() after GVE_REINJECT_COMPL_TIMEOUT and hits the
stale unmap at runtime.

Would it be better to move the unmap into the SKB and XDP_FRAME cases,
the way gve_handle_packet_completion() already does?

> +		default:
> +			WARN_ON_ONCE(1);
> +			break;
>  		}
>  	}
> +
> +	if (tx->xsk_pool)
> +		gve_tx_process_xsk_completions(tx);
>  }

[Severity: Medium]
Can this drain ever run while XSK packets are pending?

gve_queues_stop() clears the XSK pool pointers before it stops the TX
rings:

gve_main.c:gve_queues_stop() {
	...
	gve_unreg_xdp_info(priv);

	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
	...
}

gve_unreg_xdp_info() calls gve_unreg_xsk_pool(), which does:

	priv->tx[gve_xdp_tx_queue_id(priv, qid)].xsk_pool = NULL;

So when gve_tx_stop_ring_dqo() calls gve_clean_tx_done_dqo() with a NULL
napi and then gve_tx_clean_pending_packets(), tx->xsk_pool is already
NULL and both drains are skipped. gve_tx_reset_ring_dqo() then zeroes
xsk_reorder_queue_head/tail and the reorder queue.

As a result, outstanding XSK descriptors are never passed to
xsk_tx_completed(). That includes descriptors the device completed during
the final gve_clean_tx_done_dqo() pass.

gve_queues_stop() is used by gve_close(), gve_restart_rings() and the RDA
XSK pool enable/disable paths. In those paths, AF_XDP sockets on other
queues stay bound. Won't their completion rings lose entries on every
stop/start that had TX in flight?

The remaining caller is the gve_queues_start() error path, which runs
before any XSK packets could be pending. So the new drain looks like it
can never run in practice.

[ ... ]

> @@ -1347,8 +1387,25 @@ static void gve_handle_miss_completion(struct gve_priv *priv,
>  			secs_to_jiffies(GVE_REINJECT_COMPL_TIMEOUT);
>  	add_to_list(tx, &tx->dqo_compl.miss_completions, pending_packet);
>  
> -	*bytes += pending_packet->skb->len;
> -	(*pkts)++;
> +	switch (pending_packet->type) {

[ ... ]

> +	case GVE_TX_PENDING_PACKET_DQO_XSK:
> +		break;

[Severity: Medium]
XSK packets now get past this point instead of crashing. Can they reach
the late reinjection branch of gve_handle_packet_completion(), which frees
the slot without checking its type?

After GVE_REINJECT_COMPL_TIMEOUT, remove_miss_completions() moves the XSK
packet to GVE_PACKET_STATE_TIMED_OUT_COMPL. Its completion tag stays in
tx->dqo.xsk_reorder_queue. If the reinjection completion then arrives
before GVE_DEALLOCATE_COMPL_TIMEOUT:

gve_handle_packet_completion() {
	...
		if (unlikely(pending_packet->state ==
			     GVE_PACKET_STATE_TIMED_OUT_COMPL)) {
			...
			remove_from_list(tx,
					 &tx->dqo_compl.timed_out_completions,
					 pending_packet);
			gve_free_pending_packet(tx, pending_packet);
			return;
		}
	...
}

The slot becomes GVE_PACKET_STATE_UNALLOCATED while the reorder queue
still points at it. gve_tx_process_xsk_completions() stops at the first
entry that isn't XSK_COMPLETE. Wouldn't every later XSK completion on this
queue then be held back?

This doesn't look like a double free, since gve_free_pending_packet() sets
the slot to UNALLOCATED. The queue only unblocks if that exact slot is
later reused for XSK and completes. Even then, a second reorder entry
points at the same slot, so one entry stays behind for good.

If the AF_XDP completion ring fills while the queue is blocked,
xsk_tx_peek_desc() stops handing out descriptors. TX on that queue could
then stall until the rings are restarted.

remove_timed_out_completions() already handles this case:

		if (pending_packet->type == GVE_TX_PENDING_PACKET_DQO_XSK)
			pending_packet->state = GVE_PACKET_STATE_XSK_COMPLETE;
		else
			gve_free_pending_packet(tx, pending_packet);

Should the late reinjection branch do the same?

> @@ -1377,9 +1434,26 @@ static void remove_miss_completions(struct gve_priv *priv,
>  		else
>  			gve_unmap_packet(tx->dev, pending_packet);
>  
> -		/* This indicates the packet was dropped. */
> -		dev_kfree_skb_any(pending_packet->skb);
> -		pending_packet->skb = NULL;
> +		switch (pending_packet->type) {
> +		case GVE_TX_PENDING_PACKET_DQO_SKB:
> +			if (pending_packet->skb) {
> +				/* This indicates the packet was dropped. */
> +				dev_kfree_skb_any(pending_packet->skb);
> +				pending_packet->skb = NULL;
> +			}
> +			break;
> +		case GVE_TX_PENDING_PACKET_DQO_XDP_FRAME:

[Severity: Low]
This isn't a bug, but the comments here no longer match the code. The
comment above the unmap in remove_miss_completions() still says:

		/* Unmap/free TX buffers and free skb but do not unallocate packet i.e.

The code now also returns XDP frames and skips XSK packets.

The "This indicates the packet was dropped" comment has also moved into
the SKB case only. The XDP_FRAME case is the same drop and also
increments tx->dropped_pkt.

Separately, the header comment above gve_tx_clean_pending_packets()
still names a function that doesn't exist:

/* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
 */

That name predates this patch. Since the function is being rewritten
here anyway, could it be fixed as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922194533.631387-1-joshwash%40google.com
