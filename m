Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E6221F20;
	Mon, 28 Sep 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598736; cv=none; b=tIdPVRBhRqN8JxFEsGaAyg7RVkTdyHdayV2nyTBpJjvxbccbXwSF8+r5FgEifQbkwSBJPd+nGsF0Bw3UCr2zrcLBufPrUKOK1tNj+ohIxLiLTilQXWkzGtwVAahkRvH0BkIpC7H95hBqfu5SPNF/Nl/gVt3CcCItdIVnOq3lXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598736; c=relaxed/simple;
	bh=Tr3NHHtcAtKS8gIq4c341pfjY04YYQSmxpxy8OIuoic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WwKeSdnOInVH5HIDP5wq4UpniSUb2UiG9Bp7LLbeH8ba8bl5gViOz5GMP4TcrwjSiuhnlXcFO4n4lENYrpBnPSZJnb/LcfgO5slhGJP92bTQacoACYeWIiEnW9shl7XnyX0HNhZOq4iAFhMVFXAZl0uAeNjbKD3+StaBmwYy6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Yuchao Zhang <ndaugoing@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: sch_cake: validate transport
 header offset in cake_overhead()
In-Reply-To: <20260927131009.24250-3-ndaugoing@gmail.com>
References: <20260927131009.24250-1-ndaugoing@gmail.com>
 <20260927131009.24250-3-ndaugoing@gmail.com>
Date: Mon, 28 Sep 2026 14:32:10 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874if9lfp1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yuchao Zhang <ndaugoing@gmail.com> writes:

> In cake_overhead(), the header length up to the transport layer is
> computed using logic borrowed from qdisc_pkt_len_segs_init():
>
> 	/* borrowed from qdisc_pkt_len_segs_init() */
> 	if (!skb->encapsulation)
> 		hdr_len = skb_transport_offset(skb);
> 	else
> 		hdr_len = skb_inner_transport_offset(skb);
>
> However, cake_overhead() does not validate the computed offset:
>
> 1. When the transport header was never set, skb->transport_header holds
>    the sentinel value ~0U. skb_transport_offset() returns ~65535.
>    skb_header_pointer() subsequently fails, leaving hdr_len as ~65535,
>    charging ~66 KB per segment to the shaper.
>    Mirror qdisc_pkt_len_segs_init() by returning cake_calc_overhead()
>    when unlikely(!skb_transport_header_was_set(skb)).
>
> 2. While qdisc_pkt_len_segs_init() runs at the start of __dev_queue_xmit(),
>    packet headers may be adjusted before cake_overhead() is reached:
>    - in sch_handle_egress() via tc/BPF egress filters;
>    - inside cake_enqueue() via cake_classify() -> tcf_classify() (e.g.
>      act_bpf, act_pedit, act_mpls, act_vlan).
>    For example, bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC) invokes
>    bpf_skb_net_hdr_pop(), which pulls skb->data forward and re-syncs
>    transport_header only when it aliased network_header, i.e. when no
>    transport header had been parsed. If a transport header had been
>    parsed, its offset is left where it was while skb->data moves forward,
>    so skb_transport_offset() becomes old_offset - len and can turn
>    negative. Since hdr_len was declared as unsigned int, a negative offset
>    wraps around to near UINT_MAX, corrupting header length accounting.
>
> Declare hdr_len as int and fall back to cake_calc_overhead(q, len, off) if
> unlikely(hdr_len < 0).
>
> Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the rate shaper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
> v3:
>  - Split from v2 into a standalone patch with its own Fixes: tag
>    (a729b7f0bd5b) per Simon Horman and Sashiko review.
>  - Clarify header mangling ordering (sch_handle_egress() and cake_classify()
>    before cake_overhead()) rather than inaccurate "post-enqueue mangling"
>    wording per Sashiko review.
>  - Link to v2: https://lore.kernel.org/netdev/20260922084124.36858-1-ndaugoing@gmail.com/
>  - Link to v1: https://lore.kernel.org/netdev/20260917122153.62722-1-ndaugoing@gmail.com/
>
>  net/sched/sch_cake.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index b0d604a7052a..45969c1b95fc 100644
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
> @@ -1424,10 +1425,16 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
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
> +
> +	if (unlikely(hdr_len < 0))
> +		return cake_calc_overhead(q, len, off);

We now have three identical calls to cake_calc_overhead() in the same
function; let's put these into an 'err' label at the end of the
function, and turn the early returns into 'goto err' statements.

-Toke
