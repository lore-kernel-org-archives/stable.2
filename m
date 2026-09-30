Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1E4FE2EC;
	Wed, 30 Sep 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781180; cv=none; b=uOO922oW6jFX/BvOQapmSehC0p4Z/Rr0rtBvSK6Vi3SKLTCtCHe4Bs9LCTvzdtJGgZGe4aEcpvSxuEsw+KI196lzwYfMIfhU80ZSAWOLu70eByShcGT1nbJFlrfJSCZuMwztBiX6OL2wRPDF5FDpNlFGNbBqdZibGUHnHSg2ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781180; c=relaxed/simple;
	bh=YJuLGulGzVJUqZUJVdqoO4YED1P8JBsWonh0v98PTQI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9MGZ6011mMpuIeBHkfHgIlowJBRoPcaZ1VVK0RPTlHXx2MR30qB/K2zZPspVJKe1kiHKVISf7Tfdw/GQPurOC38TLRAZ5pWHFT1c64YMuJl04ly2iggocbZLgAWN/jw+pYXzOUEBdZZxChMBC0NpiNhvuD3MEz4n3hhM0qT3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4CEAS2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4CEAS2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD51F00893;
	Wed, 30 Sep 2026 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781168;
	bh=cCqYgF7O13HbZYEuyT2OOUmn2knOMWRAAx9dC6/FytM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i4CEAS2fMXTxICZBtGvGFvDTdoYO2hnjLVHstCFvZZ0/MTPQRbv7DtV4JCcmbzeYN
	 PZ8KucJrxOfn4FDU33ziDI7r4pqltzBQq2ZKbQfgQStRW6DrKrvk23ldq7pO4KcHO6
	 oNJhd1UHyu9AsC+l5qYQsELowXG2s57wTW4M1cKwnOP+F8fMmaZLAJp14swomQ8Lgb
	 +grDYRX5QUWm/205NJdgfSFRdlVTMcTn8O+TLCYjgDJje1jrn18WhtA1OdKtc7gYBn
	 esKOAHVfY2EQKbcI/WKOESqi67lQ26h2d7q0ZcsHvZguHwoKB548VsD+uWSyBFidb9
	 MrfijyT1cwHZg==
Subject: Re: [PATCH net v3 2/2] net/sched: sch_cake: validate transport header
 offset in cake_overhead()
From: netdev-bot+sashiko@kernel.org
To: ndaugoing@gmail.com
Cc: toke@toke.dk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 30 Sep 2026 15:12:47 +0000
Message-ID: <179078116751.434549.16979345983406823825@kernel.org>
In-Reply-To: <20260927131009.24250-3-ndaugoing@gmail.com>
References: <20260927131009.24250-3-ndaugoing@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `if (unlikely(hdr_len < 0))` check in cake_overhead()
  only catches stale transport offsets that have gone negative.

Pre-existing issues:
- [High] The same negative transport offset stored in an unsigned hdr_len
  also exists in qdisc_pkt_len_segs_init() (net/core/dev.c).
- [Medium] In cake_overhead(), `last_len = skb->len - shinfo->gso_size *
  (segs - 1)` can wrap as a u32 after an egress or classifier BPF header…

--

net/sched: sch_cake: validate transport header offset in cake_overhead()

When the transport header was never set, cake_overhead() now falls back
to cake_calc_overhead(), as qdisc_pkt_len_segs_init() does. The patch
also changes hdr_len to int and uses the same fallback when the transport
offset is negative. A negative offset can happen after egress or
classifier header mangling, for example bpf_skb_adjust_room() in
BPF_ADJ_ROOM_MAC mode.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index b0d604a7052a9..45969c1b95fc9 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

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

[Severity: Medium]
Is a lower bound of 0 enough here? The same bpf_skb_net_hdr_pop()
mechanism can also leave a transport offset that is non-negative but
stale:

net/core/filter.c:bpf_skb_net_hdr_pop() {
    ...
		skb->mac_header += len;
		skb->network_header += len;
		if (trans_same)
			skb->transport_header = skb->network_header;
    ...
}

Take a BPF_ADJ_ROOM_MAC shrink where len_diff is not larger than the old
transport offset. The offset stays >= 0, but it points before the new
network header, into the moved MAC header.

GRE decap is one example. gre_build_header() calls
skb_reset_transport_header() at the GRE header, so the transport offset
is 14 + 20 = 34. An egress tc BPF program then does:

    bpf_skb_adjust_room(skb, -24, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_DECAP_L4_GRE |
                        BPF_F_ADJ_ROOM_DECAP_L3_IPV4);

bpf_skb_net_shrink() clears the GRE gso_type bits and
skb->encapsulation. In cake_overhead(), hdr_len then becomes
34 - 24 = 10. That is below skb_network_offset() (14), so this check does
not fire.

skb_header_pointer(skb, 10, sizeof(_tcphdr), ...) then reads Ethernet
and IPv4 bytes. doff comes from the IPv4 TTL byte (TTL 64 gives 16
bytes), so each segment is charged 26 bytes of headers instead of 54.

A plain IPv4/TCP GSO skb shrunk by 30 in MAC mode behaves the same way
(34 - 30 = 4).

Would a check such as hdr_len < (int)off catch this case too?

[Severity: High]
This isn't a bug introduced by this patch, but does qdisc_pkt_len_segs_init()
in net/core/dev.c have the same negative offset problem? There it would
lead to a wild pointer dereference.

The commit message says:

    While qdisc_pkt_len_segs_init() runs at the start of __dev_queue_xmit(),
    packet headers may be adjusted before cake_overhead() is reached

This suggests the core helper only ever sees skbs that have not been
mangled. However, an egress tc BPF program can call bpf_skb_adjust_room()
with a negative len_diff in BPF_ADJ_ROOM_MAC mode and then return
bpf_redirect():

skb_do_redirect()
  __bpf_redirect_common()
    __bpf_tx_skb()
      dev_queue_xmit()
        __dev_queue_xmit()
          qdisc_pkt_len_segs_init()

This runs qdisc_pkt_len_segs_init() a second time on the mangled skb,
and nothing resets the transport header in between. The tc ingress path,
for example after an ingress redirect, is another entry point.

Two examples of the resulting offset:

- A plain Ethernet/IPv4/TCP GSO skb shrunk by 40 has a transport offset
  of 34 - 40 = -6.
- A VXLAN decap with BPF_F_ADJ_ROOM_DECAP_L4_UDP gives 34 - 50 = -16.
  This decap also clears skb->encapsulation.

In qdisc_pkt_len_segs_init(), hdr_len is still unsigned int:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
	unsigned int hdr_len, tlen;
    ...
		hdr_len = skb_transport_offset(skb);
    ...
		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;

		th = (const struct tcphdr *)(skb->data + hdr_len);
		tlen = __tcp_hdrlen(th);
    ...
}

With hdr_len = 0xFFFFFFFA, hdr_len + sizeof(struct tcphdr) is the size_t
value 0x10000000E. pskb_may_pull() takes an unsigned int len, so the
value is truncated to 14 and the check passes.

On 64-bit, skb->data + hdr_len then points about 4 GB past skb->data,
and __tcp_hdrlen() dereferences it. Can this oops, or read arbitrary
memory that then drives the drop and segment count decisions?

In cake_overhead(), the int offset argument of skb_header_pointer()
limits the damage, but the core helper has no such protection. The
dereference came in with commit 7fb4c19670110f ("net: pull headers in
qdisc_pkt_len_segs_init()"). Reaching it requires a privileged
(CAP_BPF/CAP_NET_ADMIN) tc BPF program.

>  
>  	/* + transport layer */
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |

[Severity: Medium]
This is a pre-existing issue, but can last_len wrap further down in
cake_overhead() after the same kind of egress or classifier BPF shrink?

net/sched/sch_cake.c:cake_overhead() {
    ...
	u16 segs = qdisc_pkt_segs(skb);
    ...
	len = shinfo->gso_size + hdr_len;
	last_len = skb->len - shinfo->gso_size * (segs - 1);
    ...
}

segs comes from qdisc_skb_cb(skb)->pkt_segs. That value is set in
__dev_queue_xmit() before sch_handle_egress() or cake_classify() run.
bpf_skb_net_shrink() then enlarges gso_size without refreshing pkt_segs:

net/core/filter.c:bpf_skb_net_shrink() {
    ...
		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
			skb_increase_gso_size(shinfo, len_diff);
    ...
		shinfo->gso_type |= SKB_GSO_DODGY;
		shinfo->gso_segs = 0;
    ...
}

As a result, last_len = old_last_len - len_diff * segs, which wraps when
len_diff * segs is larger than old_last_len.

For example, take IPv4 with 20 bytes of options, gso_size 1000,
skb->len 60075 and 61 cached segments. Removing the options in NET mode
gives 60055 - 1020 * 60 = -1145.

cake_enqueue() stores the result in get_cobalt_cb(skb)->adjusted_len.
Inside cake_calc_overhead() this causes three problems:

- A truncated garbage value is stored in the u16 max_netlen stat.
- The (s32) cast clamps the last segment's charge to rate_mpu.
- segs - 1 segments are charged at the enlarged gso_size, using the
  stale segment count.

The new hdr_len checks don't cover this case.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927131009.24250-1-ndaugoing%40gmail.com
