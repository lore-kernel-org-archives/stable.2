Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2746F4BB;
	Mon, 21 Sep 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000414; cv=none; b=XJSG89pVPnWoOn9eeTMVPk8sfU80/XX+3GNSNlLA6bcu98LZr+3hREcpIbybaR/YxEEYaQUvFGCRchVWRfQIM+gEl2m9zYvvMdIvkVk2Hv8a6qksIp27aZe/R4AD2OaPuTQB5Pc+5/T2ZCYVR10zM2HFxGqWBgP7hoZg6uSpzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000414; c=relaxed/simple;
	bh=FtKQKIebSLhQ1pvRZxKy2tSAVnHeMRVUgHf+F6/BDBg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vfx4dOdEhpum5GAJOnS6RPe2PUgXRu+yYZh4p2kXDcKWiD56akb5++ajJgYLllI3etTsNH1ossk+wQqDXMGRvj45ZcYdemJKa+F/kqTaWd+tlK9g+PIdGmXDBpx2dPJEdW9yBmEwPNvllVAqFBhwzHI8Q0zNNOv0sqK0YzfQe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1qlUZSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1qlUZSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB931F000FF;
	Mon, 21 Sep 2026 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000413;
	bh=rCx3Ged42YqopxfbC6N0eUsafreZfHrJEe1VG/QdqjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X1qlUZSLjxWN2hrPf5R5ngE1lq/MkbRU1UntXx/EWSrm+M7oDP4SrrW1zIenV7Lgy
	 AfipOE9qn06w3EspE8akL+/lVMgWiyAa/gVSW9qfEzPTO5nsmNxdMBqN2OlTHoRnpB
	 gKVAtxwcZ7BYHQYuKN85NiuGKWzVNlonjCZ79lCoH+eEWK6pqVHD8lgBsl6CWjIJqX
	 9eQ7r7qTlgO9q7c/Yhc9Rsw6OLfaL6TEyNROupDw2loFZCmMMlKpu8AGdneWKbMymL
	 rS57w5P9xjSh0yzw48Uwh6swOsLfzZpzw+7cW6z7lvHAPLnD1tnjKVfIKCKREw0xCj
	 v1T1qg55zwGlg==
Subject: Re: [PATCH 2/2] net/sched: sch_cake: check negative transport offset
 in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, toke@toke.dk, jhs@mojatatu.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 14:20:12 +0000
Message-ID: <179000041222.2160803.11108326722307773525@kernel.org>
In-Reply-To: <20260917122153.62722-3-ndaugoing@gmail.com>
References: <20260917122153.62722-3-ndaugoing@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message asserts a memory-safety bug that the cited code
  path cannot produce: "can lead to an out-of-bounds pointer (skb->data…
- [Medium] cake_overhead() (net/sched/sch_cake.c:1427-1434) copies the
  header-length computation from qdisc_pkt_len_segs_init() but imports…

Pre-existing issues:
- [High] cake_overhead() only special-cases `segs == 1`
  (net/sched/sch_cake.c:1424); `segs == 0` falls into the multi-segment…

--

net/sched: sch_cake: check negative transport offset in cake_overhead()

The patch changes hdr_len in cake_overhead() from unsigned int to int and
returns the plain cake_calc_overhead() result when the computed transport
offset is negative.  A couple of questions about the reasoning in the
changelog and about the completeness of the new guard.

Quoting from the changelog:

>     If an encapsulated or stripped packet has a negative transport offset,
>     hdr_len is converted to a huge positive integer near UINT_MAX. When
>     passed to skb_header_pointer(skb, hdr_len, ...), the signed offset argument
>     in skb_header_pointer() becomes negative, which can lead to an
>     out-of-bounds pointer (skb->data + negative_offset) and an OOB read.

[Severity: Medium]
Can this path really produce a read outside the allocation?

The offset ends up in __skb_header_pointer(), whose offset parameter is
already an int, so the unsigned conversion is undone:

include/linux/skbuff.h:__skb_header_pointer() {
	if (likely(hlen - offset >= len))
		return (void *)data + offset;
	...
}

The negative value comes from skb_transport_offset() /
skb_inner_transport_offset(), which are head-relative:

	return skb->head + skb->transport_header - skb->data;

So skb->data + hdr_len == skb->head + skb->transport_header, which is at
or after skb->head and still inside the skb head buffer.  The
skb_copy_bits() fallback reads from the same allocation.  Is the actual
pre-patch consequence garbage header-length accounting rather than an OOB
read?

Relatedly, could the changelog say how a negative offset reaches
cake_overhead() at all?  __dev_queue_xmit() already rejects such GSO skbs
before any ->enqueue() runs:

net/core/dev.c:__dev_queue_xmit() {
	reason = qdisc_pkt_len_segs_init(skb);
	if (unlikely(reason)) {
		dev_core_stats_tx_dropped_inc(dev);
		kfree_skb_reason(skb, reason);
		return -EINVAL;
	}
	...
}

which leaves header mangling done after that point (nf_hook_egress(),
sch_handle_egress(), e.g. bpf_skb_adjust_room() ->
bpf_skb_net_shrink()) as the remaining route.  With Fixes: and
Cc: stable on the patch, spelling out the reachable trigger would help
backporters decide whether this is a memory-safety fix or accounting
hardening.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..ce9e85f9571e6 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1413,10 +1413,11 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
>  static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
>  {
>  	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> -	unsigned int hdr_len, last_len = 0;
> +	unsigned int last_len = 0;
>  	u32 off = skb_network_offset(skb);
>  	u16 segs = qdisc_pkt_segs(skb);
>  	u32 len = qdisc_pkt_len(skb);
> +	int hdr_len;
>  
>  	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
>  
> @@ -1429,6 +1430,9 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
>  	else
>  		hdr_len = skb_inner_transport_offset(skb);
>  
> +	if (unlikely(hdr_len < 0))
> +		return cake_calc_overhead(q, len, off);
> +

[Severity: Medium]
Should the companion guard from qdisc_pkt_len_segs_init() be imported as
well?  That function has two tests, not one:

net/core/dev.c:qdisc_pkt_len_segs_init() {
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
		hdr_len = skb_transport_offset(skb);
	} else {
		hdr_len = skb_inner_transport_offset(skb);
	}
	if (unlikely(hdr_len < 0))
		return SKB_DROP_REASON_SKB_BAD_GSO;
	...
}

When the transport header was never set it holds the sentinel installed by
__finalize_skb_around():

	skb->transport_header = (typeof(skb->transport_header))~0U;

so skb_transport_offset() returns 65535 - (skb->data - skb->head), a large
positive number that the new hdr_len < 0 test does not catch.
skb_header_pointer() then returns NULL for that offset, hdr_len stays at
roughly 65471, and cake_overhead() computes len = shinfo->gso_size +
hdr_len (about 66 KB) for each of segs - 1 segments.

That value is stored by cake_enqueue():

	get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);

and later charged in cake_advance_shaper():

	u32 len = get_cobalt_cb(skb)->adjusted_len;
	...
		u64 tin_dur = (len * b->tin_rate_ns) >> b->tin_rate_shft;

so one GSO skb can be charged many times its real size, and the u16
max_netlen/max_adjlen statistics are truncated.  On CONFIG_DEBUG_NET=y
skb_transport_header() also has a DEBUG_NET_WARN_ON_ONCE() for the unset
case.

Is the sentinel state reachable at enqueue?  qdisc_pkt_len_segs_init()
returns SKB_NOT_DROPPED_YET for it rather than dropping, after having
already stored pkt_segs, and the rx path only papers it over when
CONFIG_DEBUG_NET is unset:

net/core/dev.c:__netif_receive_skb_core() {
#if !defined(CONFIG_DEBUG_NET)
	/* We plan to no longer reset the transport header here. */
	if (!skb_transport_header_was_set(skb))
		skb_reset_transport_header(skb);
#endif
	...
}

Producers of that state include gro_cells_receive(), which calls
skb_unset_transport_header(skb), and the non-NEEDS_CSUM
else if (gso_type) branch of __virtio_net_hdr_to_skb(), which sets
gso_size without touching the transport header.  On a CONFIG_DEBUG_NET=n
kernel the rx-path reset above closes the route that could be verified,
so this may be limited to debug kernels.

[Severity: High]
This is a pre-existing issue and not something this patch introduces, but
while adding a guard here, would a segs <= 1 test be worth folding in?
cake_overhead() only special-cases one segment:

	if (segs == 1)
		return cake_calc_overhead(q, len, off);

With segs == 0, execution falls into the multi-segment arithmetic where
segs - 1 is the int -1:

	last_len = skb->len - shinfo->gso_size * (segs - 1);

	return (cake_calc_overhead(q, len, off) * (segs - 1) +
		cake_calc_overhead(q, last_len, off));

Does the u32 multiplication by -1 wrap to roughly 4.29e9 here, with
last_len becoming skb->len + gso_size?  That value reaches
cake_advance_shaper() through get_cobalt_cb(skb)->adjusted_len:

		u64 tin_dur = (len * b->tin_rate_ns) >> b->tin_rate_shft;
	...
		q->time_next_packet = ktime_add_ns(q->time_next_packet, global_dur);

which would push time_next_packet far into the future and stall dequeue
for the whole qdisc.

qdisc_pkt_segs() returns qdisc_skb_cb(skb)->pkt_segs verbatim, and
qdisc_pkt_len_segs_init() stores it before any fixup:

	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;

gso_segs == 0 is a legitimate DODGY state, for example:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
			shinfo->gso_type |= SKB_GSO_DODGY;
			shinfo->gso_segs = 0;
	...
}

and the DODGY recomputation at the end of qdisc_pkt_len_segs_init() is
skipped by the unset-transport-header early return without dropping the
skb.  Note that the same virtio branch that sets gso_segs = 0 is also the
one that never sets the transport header, so both preconditions can arrive
together; as above, the CONFIG_DEBUG_NET=n rx-path reset closes the route
that could be verified, so reachability on non-debug kernels is not
established.

>  	/* + transport layer */
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
>  						SKB_GSO_TCPV6))) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917122153.62722-1-ndaugoing%40gmail.com
