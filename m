Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A8372071;
	Sun, 27 Sep 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790508569; cv=none; b=iFPAeMly6HkmocnEsElpx5Tw+XpwRFgUr3B8kdtVlgE5VZGlvKazdjjzAtoy7m8RHbF1oethj841p++E9h9gGRgNdhpPJYBUQ2I3fcyyTIInsmorH/Vgznx/Ln3TdnoDWDHszvmMheoeJ2FNPQQbQWVlSkSgYan3GPMVI9Syc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790508569; c=relaxed/simple;
	bh=iNmBS8dBBhKRwdyDOuCZO0FeByuqDC45/07qemMA3ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0pFNRaBeygyumSwsP/8n8yfE5hum1Unyrgyd47QsCQe89V72SCMmxVIMHtqxhsbKcoaTEk2ecsMrdYYXGIuXkkaADBsdvFqTkkwvDEG5gcwJd+akO4qSKFJonF0WFLyWzY92niHuNOGRCiDr2bGPWShsmDNIOnLRgwV57yItXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHNcRlX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHNcRlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E631A1F000FF;
	Sun, 27 Sep 2026 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790508568;
	bh=BxAJl3A0EJGIAvln0d1KMvzA8iHvvUFIG+/E9rSHl4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioHNcRlXsc2Dxf3Nou4r5qn/8wm6e6s08DUoBc6mbW0j8j9IZjyjyeSW9uYaPt6mW
	 ygl6dAUOsfVrt6tlD15ez/ZLMVsFfV3l0iOeWvAgSvoUZ6Yljc3WvP8WBR15XwOx94
	 mvwsaKKaC3/EK1ZX38QCLG9zswdDlFp5qTVDZt5ZMBLUIOQ8EqtXoMJu2h2G7/+uxK
	 9qm1Tb/dMZYMjCLsvEnwTLr5u00M11ShzLItUiMDfpxwUd2XkcJvnmEuPkJeU/arGc
	 IHaLUEq04Ok+md3JwXJ3NEKfOVguuwMiAp3rzP7v3vYbsLDarSzUgil/4eF717HMqs
	 JLTnKYLpvFyJQ==
Date: Sun, 27 Sep 2026 12:29:23 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: ndaugoing@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
	jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: sch_cake: prevent shaper corruption and
 stall in cake_overhead()
Message-ID: <20260927112923.GH13925@horms.kernel.org>
References: <20260922084124.36858-1-ndaugoing@gmail.com>
 <179033656561.2160803.10981674263912832826@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179033656561.2160803.10981674263912832826@kernel.org>

On Fri, Sep 25, 2026 at 11:42:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Single `Fixes: a41851bea7bf` tag plus `Cc: stable` for three
>   independent defects, none of which was introduced by the tagged commit.
> - [Low] The changelog justifies change 3 with "post-enqueue mangling
>   (such as BPF packet trimming via bpf_skb_net_shrink())", but that…
> 
> --
> 
> net/sched: sch_cake: prevent shaper corruption and stall in cake_overhead()
> 
> This changes cake_overhead() to bail out to cake_calc_overhead() for
> segs <= 1, to skip the multi-segment path when the transport header was
> never set, and to treat a negative header offset as a fallback case by
> making hdr_len signed. The stated goal is to avoid inflated lengths being
> charged to the CAKE shaper.
> 
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index dc93267029e70..45969c1b95fc9 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -1413,21 +1413,28 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
> >  static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
> >  {
> >  	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> > -	unsigned int hdr_len, last_len = 0;
> > +	unsigned int last_len = 0;
> >  	u32 off = skb_network_offset(skb);
> >  	u16 segs = qdisc_pkt_segs(skb);
> >  	u32 len = qdisc_pkt_len(skb);
> > +	int hdr_len;
> >  
> >  	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
> >  
> > -	if (segs == 1)
> > +	if (segs <= 1)
> >  		return cake_calc_overhead(q, len, off);
> >  
> >  	/* borrowed from qdisc_pkt_len_segs_init() */
> > -	if (!skb->encapsulation)
> > +	if (!skb->encapsulation) {
> > +		if (unlikely(!skb_transport_header_was_set(skb)))
> > +			return cake_calc_overhead(q, len, off);
> >  		hdr_len = skb_transport_offset(skb);
> > -	else
> > +	} else {
> >  		hdr_len = skb_inner_transport_offset(skb);
> > +	}
> 
> [Severity: Medium]
> Should the three changes here carry their own Fixes tags rather than a
> single Fixes: a41851bea7bf plus Cc: stable?
> 
> None of the three defects look like they were introduced by
> a41851bea7bf. git show a41851bea7bf only replaces
> 
> 	hdr_len = skb_transport_offset(skb);
> 
> with the encapsulation if/else, so it neither added the segs handling nor
> the missing sentinel check.
> 
> The segs early return that changes from segs == 1 to segs <= 1 came in
> with c5d34f4583ea88 ("net_sched: cake: use qdisc_pkt_segs()"). Before
> that commit cake_overhead() recomputed the count itself for dodgy GSO
> skbs:
> 
> 	segs = DIV_ROUND_UP(skb->len - hdr_len, shinfo->gso_size);
> 
> so a cached segs == 0 could not be observed in older trees.
> 
> The missing skb_transport_header_was_set() guard, on the other hand,
> dates back to a729b7f0bd5bf4, where the same
> hdr_len = skb_transport_offset(skb); had the identical ~0U sentinel
> behaviour.
> 
> With only the a41851bea7bf tag, doesn't the segs <= 1 hunk get applied to
> trees that never had the cached count, while the sentinel fix never
> reaches the trees between a729b7f0bd5bf4 and a41851bea7bf that are
> exposed to the ~66 KB per segment accounting the changelog describes?

The above analysis does seem to be correct.

> 
> Would splitting this into one logical fix per patch, each with its own
> Fixes tag, make the stable ranges match the defects?

And, yes, I think one fix per patch is the right approach.

> 
> > +
> > +	if (unlikely(hdr_len < 0))
> > +		return cake_calc_overhead(q, len, off);
> >  
> >  	/* + transport layer */
> >  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
> 
> [Severity: Low]
> The changelog justifies this guard with:
> 
>     If post-enqueue mangling (such as BPF packet trimming via
>     bpf_skb_net_shrink()) produces a negative offset, hdr_len wraps to
>     near UINT_MAX
> 
> Is that ordering possible? __dev_queue_xmit() calls
> 
> 	reason = qdisc_pkt_len_segs_init(skb);
> 
> near its top, and only afterwards runs sch_handle_egress() and
> __dev_xmit_skb() -> cake_enqueue() -> cake_overhead(), which is the only
> caller. So cake_overhead() runs during enqueue, not after it.
> 
> The two windows that do exist look like:
> 
>   - between qdisc_pkt_len_segs_init() and enqueue, i.e. tc/BPF egress in
>     sch_handle_egress()
>   - inside cake_enqueue() itself, since cake_classify() -> tcf_classify()
>     (act_bpf, act_pedit, act_mpls, act_vlan) runs before
>     get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb)
> 
> The underlying mechanism still holds: bpf_skb_adjust_room() with
> BPF_ADJ_ROOM_MAC ends up in bpf_skb_net_hdr_pop(), which adjusts only
> mac_header/network_header and leaves transport_header stale, so
> skb_transport_offset() becomes old_offset - len_diff and can go negative.
> 
> Could the changelog name that ordering and a concrete path instead of
> "post-enqueue mangling", given the patch is tagged Cc: stable?

FWIIW, I think this is less of a concern.

-- 
pw-bot: changes-requested
