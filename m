Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B844FDE55;
	Wed, 30 Sep 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781173; cv=none; b=nEEvLyett9pP4O4uu6PaM9gM9mINONh1O5vBJIlUctH2DxUI5N+D7GbE9KDzG5z98G9R8wk0BOmOo3e58wgabLmVQCTBg2lL4txjnXobIEzY9nj9mjXplmIqyVkOISV+lO4/xmd9qYRs9QWHQRXVxqkDios/tZ8XOYxbSPSFjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781173; c=relaxed/simple;
	bh=n3nEcG8Xkpjf9XyaMwaGgC3wx6M3LnojIGWNk/zxd5A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0q+LYBLcH6w5rD+uGjg/uvDbtFjo1WjwhEiCWWkF7AHYT08qQOGYpJkupVydEwT4+jdoRTVM62nmWNwGH6hpwLZaJMj0S5gp7XDXrwOdEheuMoE/+dDR5jCrD723j+E+ZTBN+W9BjkiCt5PtGaqsn68Do0GbfixV3kZ0PDBp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbzfmZWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbzfmZWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9451F000FF;
	Wed, 30 Sep 2026 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781167;
	bh=RvDEi6ityygBQBBR7ccbCoh0xjOCMqbPQDqOFa9LS4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BbzfmZWTDGzNmQSevrMImht7PMQu8fEDeXRTyoS/uvkr7BmibZJ1mqKJ1VWm4CzaE
	 EYgm8P0kiSnhd5BQxE/dGzK9kielLKzHY9LnbpP45v+K9ui0aXT3f4lu8byzlqM5x5
	 t7rj5tmiuyjJRS4dSiS2TCsS44WlFeKIEbMCo+uAwwNVFhMST9XvafD9Rxilu4P0Wr
	 dyQCqrp9YXZaKB82MSgjrFC0ZJah0hY4jRGkiRViANRiiKjvkgB2uBS1DXKz87k1dG
	 u564OCgLrfe/CHyazhNIGOUarqmmK8bwlTuBUCVASkZuRLl4OaG9yMxYQUvo66qNLF
	 2U2dPMaMM/5Ug==
Subject: Re: [PATCH net v3 1/2] net/sched: sch_cake: fix shaper stall on segs
 == 0 in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: toke@toke.dk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 30 Sep 2026 15:12:46 +0000
Message-ID: <179078116605.434549.16229112833347396709@kernel.org>
In-Reply-To: <20260927131009.24250-2-ndaugoing@gmail.com>
References: <20260927131009.24250-2-ndaugoing@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets the mechanism and impact of the segs
  == 0 bug wrong.
- [Low] The commit message never says how an skb with qdisc_pkt_segs(skb)
  == 0 reaches the multi-segment arithmetic in cake_overhead().

Pre-existing issues:
- [Low] cake_overhead() says its header-length logic is "borrowed from
  qdisc_pkt_len_segs_init()", but it lacks that function's checks.

--

net/sched: sch_cake: fix shaper stall on segs == 0 in cake_overhead()

This patch changes the single-segment early return in cake_overhead() from
segs == 1 to segs <= 1. The goal is to stop skbs with a cached segment count
of 0 from reaching the multi-segment overhead arithmetic.

> Because segs is an unsigned 16-bit integer, (segs - 1) underflows to
> 65535 (and is promoted to 4294967295 in the 32-bit unsigned arithmetic
> above). This multiplies the per-segment overhead by UINT32_MAX, so
> cake_overhead() returns a length close to 4.29 GB.

[Severity: Medium]
Is this description of the arithmetic accurate? segs is a u16, but it is
promoted to int before the subtraction, so segs - 1 is -1 rather than 65535.

The last-segment term also wraps when segs == 0:

    last_len = skb->len - shinfo->gso_size * (segs - 1);

This gives skb->len + gso_size. Writing F() for cake_calc_overhead(), the
old return value reduces to:

    F(skb->len + gso_size) - F(gso_size + hdr_len)    (mod 2^32)

F() never decreases as its argument grows. So when hdr_len <= skb->len,
wouldn't the old code charge roughly skb->len - hdr_len rather than
something close to 4.29 GB?

The large wrap seems to need hdr_len > skb->len. At this SHA that looks
possible only when the transport header is unset. In that case
qdisc_pkt_len_segs_init() returns early and leaves pkt_segs == gso_segs:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
    ...
}

cake_overhead() then computes hdr_len from the unset transport offset,
which is around 0xFFFF. The next patch in the series, "net/sched: sch_cake:
validate transport header offset in cake_overhead()", targets that same
condition.

The 4.29 GB figure is used to justify Cc: stable. Could the commit message
describe the arithmetic correctly and state the condition needed for the
stall?

> Commit c5d34f4583ea ("net_sched: cake: use qdisc_pkt_segs()") switched
> cake to retrieve the cached segmentation count via qdisc_pkt_segs(skb)
> instead of calculating it locally for dodgy GSO packets. If an skb with
> segs == 0 reaches cake_overhead(), it skips the segs == 1 early return
> and enters the multi-segment arithmetic:

[Severity: Low]
How does an skb with qdisc_pkt_segs(skb) == 0 get here? For every
SKB_GSO_DODGY skb that has a transport header, qdisc_pkt_len_segs_init()
already recomputes pkt_segs, and it drops the skb when payload <= 0:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
	if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
		int payload = skb->len - hdr_len;

		/* Malicious packet. */
		if (payload <= 0)
			return SKB_DROP_REASON_SKB_BAD_GSO;
		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
		shinfo->gso_segs = gso_segs;
		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
	}
    ...
}

pkt_segs == 0 seems to survive in only two cases:

  - the early return for a non-encapsulated GSO skb with no transport
    header set
  - a non-DODGY GSO skb whose gso_segs was left at 0

The in-tree virtio_net_hdr producers set DODGY. On af_packet they also set
a transport header.

In the second case, with a valid transport header, the new early return
charges F(qdisc_pkt_len()), which is F(skb->len - hdr_len). That is about
what the old wrapped path charged.

Could the commit message name the producer or path that leads here? That
would let the reproducer and the "tens of seconds" stall be checked, and
would help stable maintainers judge exposure.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..b0d604a7052a9 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1420,7 +1420,7 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
>  
>  	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
>  
> -	if (segs == 1)
> +	if (segs <= 1)
>  		return cake_calc_overhead(q, len, off);
>  
>  	/* borrowed from qdisc_pkt_len_segs_init() */

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The code
after this comment in cake_overhead() lacks several of the checks in
qdisc_pkt_len_segs_init():

net/sched/sch_cake.c:cake_overhead() {
    ...
	/* borrowed from qdisc_pkt_len_segs_init() */
	if (!skb->encapsulation)
		hdr_len = skb_transport_offset(skb);
	else
		hdr_len = skb_inner_transport_offset(skb);
    ...
}

Compared with qdisc_pkt_len_segs_init(), it is missing:

  - a skb_transport_header_was_set() guard
  - a check that __tcp_hdrlen(th) >= sizeof(struct tcphdr)
  - a pskb_may_pull() of the full header

It also adds sizeof(struct udphdr) for every non-TCP GSO type, not just
SKB_GSO_UDP_L4.

Of these, only the missing transport header guard can cause a large
overcharge. With an unset header, hdr_len is around 64 KiB, and each
segment is charged tens of KB when segs >= 2. The follow-up patch
"net/sched: sch_cake: validate transport header offset in cake_overhead()"
adds that guard and a hdr_len < 0 check.

After the full series, is the remaining difference from the core helper
intended? What is left is small misaccounting: the TCP header length term is
bounded at 60 bytes, and the extra UDP header is 8 bytes. This code dates
back to a729b7f0bd5b.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927131009.24250-1-ndaugoing%40gmail.com
