Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF349B212;
	Fri, 25 Sep 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336568; cv=none; b=n+4UhCff2sikdY8F0yYxRG7fIDpnSPqDgc4jrLuxZ/GxLO1CDzjEsNUufrnvNviiCaDA4MhcOGG88+/00h3i5FxPUgQC1/81gUk0ya+i8DoBQYwAoXxmepOFiM96tPHqDiT45P9ioLwuZwKkuS/kuC7qba2GrW0+1IY5eUeS74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336568; c=relaxed/simple;
	bh=5FN3ZXz/DRiHZgykmiItbh/ShtFikwDRXdwIYMEI3tI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7o2X6P/lVnnYT9FOsNhmobHsrWhdI1BahIP+JoX2lDNhfvK4roKiFze6cHkL37wCeD1USUf9y5MSvAXx1iF966iVcDX98uv3hQow+z6c4xV9wvBRKEA/YGaQn7USY0U2fBQqtvjLiRLXRbNRfe8ua/Pll1Qrc5sDxLPyR+gV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIRUCXAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIRUCXAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E01F00893;
	Fri, 25 Sep 2026 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336566;
	bh=Dkzgsqb0EASiZi+afnhB/CWendYTMD6ABVU+iO9chVc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HIRUCXAYZYs6AYm/AeT1GDbo3VCe6gZifURK9imA3noWwJ2ikRyHzfOdXl6EUPU6+
	 Aox8QApX8EQ1z0ulO0K0iiBaxdxCDEZiWVuULI2NCPNj8X+seIGR5zHANqdq3Q8wsp
	 gweSrjJIC0aBypS7sx049uGsaUb0kDmuHtivpGS62951TZA1E5zQxmcEKuHSdlNehQ
	 XHfXFwQY+XvMf1zfX5clliOI3oD3jm04F8kGV6UvBizqpn821bQjWm9ct/7j9bjjuf
	 LqYZRXq1pzUlPDtI/9MmYZGAVxuivNiRU6HrQAQuzxkp2fdGucEYClSfbDOXvj9m3J
	 VU8SUo/tRy3xw==
Subject: Re: [PATCH v2] net/sched: sch_cake: prevent shaper corruption and
 stall in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 11:42:45 +0000
Message-ID: <179033656561.2160803.10981674263912832826@kernel.org>
In-Reply-To: <20260922084124.36858-1-ndaugoing@gmail.com>
References: <20260922084124.36858-1-ndaugoing@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Single `Fixes: a41851bea7bf` tag plus `Cc: stable` for three
  independent defects, none of which was introduced by the tagged commit.
- [Low] The changelog justifies change 3 with "post-enqueue mangling
  (such as BPF packet trimming via bpf_skb_net_shrink())", but that…

--

net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()

This changes cake_overhead() to bail out to cake_calc_overhead() for
segs <= 1, to skip the multi-segment path when the transport header was
never set, and to treat a negative header offset as a fallback case by
making hdr_len signed. The stated goal is to avoid inflated lengths being
charged to the CAKE shaper.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..45969c1b95fc9 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1413,21 +1413,28 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
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
> -	if (segs == 1)
> +	if (segs <= 1)
>  		return cake_calc_overhead(q, len, off);
>  
>  	/* borrowed from qdisc_pkt_len_segs_init() */
> -	if (!skb->encapsulation)
> +	if (!skb->encapsulation) {
> +		if (unlikely(!skb_transport_header_was_set(skb)))
> +			return cake_calc_overhead(q, len, off);
>  		hdr_len = skb_transport_offset(skb);
> -	else
> +	} else {
>  		hdr_len = skb_inner_transport_offset(skb);
> +	}

[Severity: Medium]
Should the three changes here carry their own Fixes tags rather than a
single Fixes: a41851bea7bf plus Cc: stable?

None of the three defects look like they were introduced by
a41851bea7bf. git show a41851bea7bf only replaces

	hdr_len = skb_transport_offset(skb);

with the encapsulation if/else, so it neither added the segs handling nor
the missing sentinel check.

The segs early return that changes from segs == 1 to segs <= 1 came in
with c5d34f4583ea88 ("net_sched: cake: use qdisc_pkt_segs()"). Before
that commit cake_overhead() recomputed the count itself for dodgy GSO
skbs:

	segs = DIV_ROUND_UP(skb->len - hdr_len, shinfo->gso_size);

so a cached segs == 0 could not be observed in older trees.

The missing skb_transport_header_was_set() guard, on the other hand,
dates back to a729b7f0bd5bf4, where the same
hdr_len = skb_transport_offset(skb); had the identical ~0U sentinel
behaviour.

With only the a41851bea7bf tag, doesn't the segs <= 1 hunk get applied to
trees that never had the cached count, while the sentinel fix never
reaches the trees between a729b7f0bd5bf4 and a41851bea7bf that are
exposed to the ~66 KB per segment accounting the changelog describes?

Would splitting this into one logical fix per patch, each with its own
Fixes tag, make the stable ranges match the defects?

> +
> +	if (unlikely(hdr_len < 0))
> +		return cake_calc_overhead(q, len, off);
>  
>  	/* + transport layer */
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |

[Severity: Low]
The changelog justifies this guard with:

    If post-enqueue mangling (such as BPF packet trimming via
    bpf_skb_net_shrink()) produces a negative offset, hdr_len wraps to
    near UINT_MAX

Is that ordering possible? __dev_queue_xmit() calls

	reason = qdisc_pkt_len_segs_init(skb);

near its top, and only afterwards runs sch_handle_egress() and
__dev_xmit_skb() -> cake_enqueue() -> cake_overhead(), which is the only
caller. So cake_overhead() runs during enqueue, not after it.

The two windows that do exist look like:

  - between qdisc_pkt_len_segs_init() and enqueue, i.e. tc/BPF egress in
    sch_handle_egress()
  - inside cake_enqueue() itself, since cake_classify() -> tcf_classify()
    (act_bpf, act_pedit, act_mpls, act_vlan) runs before
    get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb)

The underlying mechanism still holds: bpf_skb_adjust_room() with
BPF_ADJ_ROOM_MAC ends up in bpf_skb_net_hdr_pop(), which adjusts only
mac_header/network_header and leaves transport_header stale, so
skb_transport_offset() becomes old_offset - len_diff and can go negative.

Could the changelog name that ordering and a concrete path instead of
"post-enqueue mangling", given the patch is tagged Cc: stable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922084124.36858-1-ndaugoing%40gmail.com
