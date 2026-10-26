Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054725;
	b=t67MR8dahMiH61aCVMjRSdKJpo7BgZeLqEs44CGsx9b0nnerDfwV+oU2DdkZ6f8pk1Sg
	 2uvD8e/b7KDeQ4K+7qhzyN6fRx3zrJEUfe8ShzV8hNBVfA3AXgeEUw2ruCSJAToFgBdvI
	 PVHcpGodwnR5nLk2fS0XfDJFn6NI/yMX+j0yxD+1abjg61rmkNx2qrudk+0/49F0oUL+s
	 s9Qgj+W7+CU4Fyiu8wQQ8KT2lyZeNKPaLzvIKyjiJlWqUhf7CsL/1+h9LYP+TrHAl6ZNJ
	 AYmN7WCBpamJPoDEcxdBHNxGCBb+s9BuZyUE7YpTt/6R4+fQNYh0jfuxrv/g3xe7O6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054725;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d/Its1iiRQhvUeA0+stemr9eVBlS8UDliWgmRnQ6fg8=;
	b=EilitSI+Jxw9asVjO5/R3XYyK9FXOSv8dVrXE2tSIs0h0MIOPyl6RrIV3ZctzMGwqlNG
	 haw/O5Uthcc92O45QVH+iLJUsEYnom2jRVMMqS4A4QOi5Fo+tci0KnBGgs9f9taoVmotP
	 k0PgEBCNnHR7WBVHIzxaHTRgt0SB4QSj/3/v75GQjSElxpf/6/75WmKHcdNfn4DKWSYgL
	 z8cju6XTFn0Ymm17I7bptjleLQUd144B7kXd25dkgtNASszP6PqKy3ZplDZCcUnvhf2Rx
	 RKW+7ShFxSqvaFO1W6WNA54HqU7ySBUEGccakwkNHyFONmVojzhYeuIuCamOtSPH6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luT1sQdk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD7606A327;
	Mon, 26 Oct 2026 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luT1sQdk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2CF1F031E0;
	Mon, 26 Oct 2026 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793054724;
	bh=d/Its1iiRQhvUeA0+stemr9eVBlS8UDliWgmRnQ6fg8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=luT1sQdkBDa0hHwdiWLEVoVLBT3log5jGP4FV/CZkM/Obum2zLRRqO6FvxPNHRh9l
	 WSjC7bKahtm+glyKQoW6u1aOo5/HVc0qaYwWXPKjLNhYeVCJFTBTIZwsoiKGA5cwQN
	 mkCBqy3XLq0t5EqmRWUXK2g606+6hzalpZW51YZdV+QlempeReQknZC7VkpkRR583u
	 Vd7Gtt+79a3+l0YVFVwkajzUjDqQjZAnFmCuABrv+TYRKKRgVN0Pt4eajNYybM4eno
	 REsCJ78ETKpNrS3TqDMCQxYMG51RBnZVFBt3wTmFBUT34Fkd+dFBanprBewMdNElTt
	 tLML8UGcDzziw==
Subject: Re: [PATCH net] inet: frags: prevent acceptance of partially
 authenticated reassembly
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 26 Oct 2026 22:45:23 +0000
Message-ID: <179305472320.3134.6433883285308503818@kernel.org>
In-Reply-To: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix misses IPsec tunnel devices that strip the secpath (VTI,
  and xfrmi across netns), so partially authenticated reassembly can…
- [Medium] secpath_equal() (include/net/xfrm.h:1213-1218) requires every
  fragment to carry identical xfrm_state pointers and an identical…
- [Medium] secpath_equal() treats sp->verified_cnt as stable fragment
  metadata, but it can change after a fragment is queued.

--

inet: frags: prevent acceptance of partially authenticated reassembly

This patch adds secpath_equal(). It makes inet_frag_queue_insert() reject
a fragment whose secpath differs from the queue tail, so a reassembled
skb cannot carry a secpath that covers only part of its payload. It also
limits the REASM_OVERLAPS counter to actual overlaps.

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a6d69aaa6cd2d..493faac0faa45 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1201,6 +1201,23 @@ secpath_reset(struct sk_buff *skb)
>  #endif
>  }
>  
> +static inline bool
> +secpath_equal(const struct sk_buff *skb1, const struct sk_buff *skb2)
> +{
> +	const struct sec_path *sp1 = skb_sec_path(skb1);
> +	const struct sec_path *sp2 = skb_sec_path(skb2);
> +	int i;
> +
> +	if (!sp1 || !sp2)
> +		return sp1 == sp2;
> +	if (sp1->len != sp2->len || sp1->verified_cnt != sp2->verified_cnt)

[Severity: Medium]
Is verified_cnt stable enough to compare here?

Clones share the skb_ext allocation, because __skb_ext_copy() only bumps
ext->refcnt. __xfrm_policy_check() gets sp through skb_sec_path() with no
copy-on-write and writes the shared field in place, without q->lock:

net/xfrm/xfrm_policy.c:__xfrm_policy_check() {
    ...
	sp->verified_cnt = k;
    ...
}

One way to hit this is an IPsec gateway that forwards tunnel-mode
decapsulated inner fragments, with an AF_PACKET fanout socket using
PACKET_FANOUT_FLAG_DEFRAG on the receiving device:

packet_rcv_fanout()
  ip_check_defrag()
    skb_share_check()   <- clone of fragment 1 queued, verified_cnt == 0
    ip_defrag()

The original fragment 1 then continues through:

ip_forward()
  xfrm4_policy_check(NULL, XFRM_POLICY_FWD, skb)
    __xfrm_policy_check()   <- shared sp->verified_cnt = k

Fragment 2 then arrives with verified_cnt == 0. Wouldn't secpath_equal()
return false here, so that ip_frag_queue() kills the IP_DEFRAG_AF_PACKET
queue and the AF_PACKET consumer never gets these datagrams?

tc mirred (tcf_mirred_to_dev()->skb_clone()) looks like another way to
end up with a shared secpath across skbs that are processed independently.

On different CPUs, this also looks like a data race between the unlocked
write in __xfrm_policy_check() and this read under q->lock.

> +		return false;
> +	for (i = 0; i < sp1->len; i++)
> +		if (sp1->xvec[i] != sp2->xvec[i])
> +			return false;

[Severity: Medium]
Can this reject legitimate datagrams whose fragments were protected by
different SAs that each satisfy the policy?

Two cases where xvec[i] could differ between fragments of one datagram:

  - per-CPU SAs (pcpu_num / XFRMA_SA_PCPU) on the sending gateway, where
    the fragments of a forwarded datagram are steered to different CPUs.
    For example, UDP 4-tuple RSS can hash the port-bearing first fragment
    differently from the rest.

  - a datagram whose fragments straddle a make-before-break rekey.

Before this patch these datagrams were reassembled and passed the final
policy check.

The commit message says "Reject a fragment when its secpath differs".
However, IPFRAG_MIXED_SECPATH falls through to the same path as an
overlap in ip_frag_queue():

	err = -EINVAL;
discard_qp:
	inet_frag_kill(&qp->q, refs);
	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);

It does the same through discard_fq in ip6_frag_queue() and insert_error
in nf_ct_frag6_queue(). So the whole queue is thrown away, not just one
fragment.

Should the commit message mention the whole-queue discard, and the
tightening of matching to SA identity?

The drop is also counted only as IPSTATS_MIB_REASMFAILS, with the default
drop reason. Would a dedicated counter or drop reason make this easier to
diagnose?

> +	return true;
> +}
> +

[ ... ]

> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index b286ee429da8f..c18da91c1f031 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c

[ ... ]

> @@ -441,6 +442,10 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
>  {
>  	struct sk_buff *last = q->fragments_tail;
>  
> +	/* The reassembled skb keeps the first fragment's secpath. */
> +	if (last && !secpath_equal(last, skb))
> +		return IPFRAG_MIXED_SECPATH;

[Severity: High]
Does this cover IPsec tunnel devices that strip the secpath before
reassembly, such as VTI, or xfrmi across netns?

vti_rcv_cb() in net/ipv4/ip_vti.c runs xfrm_policy_check() on each
decapsulated inner fragment and then does:

	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(skb->dev)));
	skb->dev = dev;

vti6_rcv_cb() in net/ipv6/ip6_vti.c does the same.

skb_scrub_packet() always calls skb_ext_reset(), whatever the value of
xnet, and that drops SKB_EXT_SEC_PATH. Inner fragments authenticated by
the VTI tunnel therefore reach reassembly with a NULL secpath. A spoofed
plaintext fragment that arrives on the underlay interface also has a NULL
secpath.

Without a VRF, ip_defrag() gets the same vif from
l3mdev_master_ifindex_rcu(dev) for both kinds of fragment, so they go
into the same queue. secpath_equal() then returns true for NULL == NULL:

	if (!sp1 || !sp2)
		return sp1 == sp2;

ip_frag_reasm() and ip6_frag_reasm() then set skb->dev to the device of
the last fragment to arrive. If that device is vti0, could
attacker-supplied bytes be treated as tunnel-authenticated by
interface-based checks? Examples are rp_filter when conntrack defrags at
PREROUTING, or INPUT rules using -i vti0 after local-deliver defrag.

The subject and commit message say this prevents "acceptance of
partially authenticated reassembly" for "IPsec tunnel traffic". Should
the commit message say that VTI and xfrmi across netns are not covered?
Alternatively, should fragment provenance be tracked beyond the secpath,
for example by recording VTI/xfrm decapsulation or by comparing the input
device or tunnel?

> +
>  	/* An IP fragment is never a GSO packet, but an untrusted source

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023074515.2347924-2-Jeremy.Jean%40oss.cyber.gouv.fr
