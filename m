Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B3366541;
	Thu,  1 Oct 2026 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828797; cv=none; b=I1PJWDHfrD4EW8gfLPXZFV6klCGDJHApOTcO8ZUPydOZOzYgtW//mZG2KLUjzMeRr6kFauGgNhwUVc9UFl+wG0YafcAu33PMlPN7eEvV3hqtXr/4IzNIsUkBZ078LwbFCfNNudxLT07zFc1xC4VwIgriz44qTNOXg0BCybsBwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828797; c=relaxed/simple;
	bh=HCtHMn3sP0zmtH7BCqMfztyo2pkSkoESg26yLA/LcyI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkrWwYsXnNsJYEPj4cuZsTSCFA4jzg7ixikUt8MP2/z7r6dVfmOtkGoSIJcRZZjXD+BjPH9pGTqRNTzz1b2HrnQm0T9Tk+mL+x8/rHyuyNaKSvRaG8IRkFdvUpOwL3g0Wq9AfEJ6B/mDV6Q1QbKoxUZKRVm36zp8sPFO92DAGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC8wgXa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC8wgXa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC6D1F00898;
	Thu,  1 Oct 2026 04:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790828795;
	bh=UV95aU7paKdEgSXgO/aM9gvLom7AApvSRNV4BUsbQVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MC8wgXa/k3cpKParEU0z+W1jDI7/3zel8MWerEEDTLOSD9osOtv+BS0Y89kwjnzTB
	 zIUfdEhQPI7pfdf66qBIrkKKl6pCGMgr2uvR7MYoOhKDibRKsYVKeAKIMYV09VVeC3
	 R8pqAuT+Uwv8+uHS0bKSCfblRB1i8YdfXu1cFhAurlDRitx4MmfxT2uBafSCGQzbgD
	 KfUN56dWQSXEKpv8jXHQVCnyDHw/R9rPaplf+xfjHwqb2evElGiFSyy0aCQrqMWeFi
	 bFOZ5owpkxHeQUNR0ZfMy5qTwzs65Mpu0QhtKzhN4tBqpQwjCEFZfQ588wjXDY4HsH
	 CRoEJpdgWrijQ==
Subject: Re: [PATCH net v4 2/2] net/sched: sch_cake: validate transport header
 offset in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: toke@toke.dk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 01 Oct 2026 04:26:34 +0000
Message-ID: <179082879490.434549.12719144237659185288@kernel.org>
In-Reply-To: <20260928132452.59996-3-ndaugoing@gmail.com>
References: <20260928132452.59996-3-ndaugoing@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete.

Pre-existing issues:
- [Low] [Baseline: discarded as pre-existing, low] This problem wasn't
  introduced by this patch, but the cake_overhead() block commented…

--

net/sched: sch_cake: validate transport header offset in cake_overhead()

This patch makes cake_overhead() fall back to the plain
cake_calc_overhead() path in two cases: when the transport header was
never set on a non-encapsulated skb, and when the computed transport
offset is negative. hdr_len changes from unsigned int to int so the
negative case can be detected, and all fallback paths now go through a
single err label.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index b0d604a7052a..f8deb8083f16 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1413,21 +1413,28 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
>  static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
>  {

[ ... ]

>  	/* borrowed from qdisc_pkt_len_segs_init() */
> -	if (!skb->encapsulation)
> +	if (!skb->encapsulation) {
> +		if (unlikely(!skb_transport_header_was_set(skb)))
> +			goto err;
>  		hdr_len = skb_transport_offset(skb);
> -	else
> +	} else {
>  		hdr_len = skb_inner_transport_offset(skb);
> +	}
> +
> +	if (unlikely(hdr_len < 0))
> +		goto err;

[Severity: High]
Does this fully remove the ~66 KB per-segment charge the commit message
describes? Two paths still seem to reach it.

First, the encapsulated branch has no check for the unset sentinel.
bpf_skb_net_grow() is reached through bpf_skb_adjust_room() with
BPF_F_ADJ_ROOM_ENCAP_L3_*. It copies transport_header into
inner_transport_header without checking whether it was set:

net/core/filter.c:bpf_skb_net_grow() {
    ...
		inner_trans = skb->transport_header;
    ...
		skb->inner_transport_header = inner_trans;
    ...
}

It also sets skb->encapsulation = 1.

qdisc_pkt_len_segs_init() stores pkt_segs before its !was_set early
return:

	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;
	...
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;

So a GSO skb with an unset transport header keeps pkt_segs > 1. A tc
egress program in sch_handle_egress(), or act_bpf run from
cake_classify(), can then encapsulate that skb.

cake_overhead() then takes the else branch and computes
hdr_len = 0xFFFF - (skb->data - skb->head). That value is large and
positive, so the hdr_len < 0 test does not catch it.

Second, both the TCP and UDP branches ignore a NULL return from
skb_header_pointer() and keep the offset:

		th = skb_header_pointer(skb, hdr_len,
					sizeof(_tcphdr), &_tcphdr);
		if (likely(th))
			hdr_len += __tcp_hdrlen(th);
	...
	len = shinfo->gso_size + hdr_len;

The unreadable hdr_len goes into len, which is then multiplied by
(segs - 1). In cake_enqueue() the result becomes
get_cobalt_cb(skb)->adjusted_len. That pushes the shaper clock far ahead,
stalls dequeue, and corrupts max_netlen/max_adjlen.

qdisc_pkt_len_segs_init() returns SKB_DROP_REASON_SKB_BAD_GSO whenever
pskb_may_pull() of the transport header fails, which covers both cases.

Would adding goto err when skb_header_pointer() returns NULL, or checking
hdr_len against skb->len, cover the remaining cases on top of the new
checks?

>  
>  	/* + transport layer */
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
block labelled "borrowed from qdisc_pkt_len_segs_init()" differs from its
source.

It adds __tcp_hdrlen(th) without the tlen check that
qdisc_pkt_len_segs_init() does:

		tlen = __tcp_hdrlen(th);
		if (tlen < sizeof(*th))
			return SKB_DROP_REASON_SKB_BAD_GSO;

It also adds sizeof(struct udphdr) in a bare else for every non-TCP GSO
type:

	} else {
		struct udphdr _udphdr;

		if (skb_header_pointer(skb, hdr_len,
				       sizeof(_udphdr), &_udphdr))
			hdr_len += sizeof(struct udphdr);
	}

The reference only does this for SKB_GSO_UDP_L4. As a result, SCTP, ESP
or GRE GSO traffic is charged 8 extra bytes per segment. A garbage doff
after header mangling can cause an error of up to about 60 bytes per
segment.

Should this block also apply the SKB_GSO_UDP_L4 and tlen checks that
qdisc_pkt_len_segs_init() uses?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928132452.59996-1-ndaugoing%40gmail.com
