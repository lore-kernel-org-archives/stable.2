Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084035;
	b=TkbudcutpHZ2Nk8oE1rO5/mNT9ly/5OODu1Xl1MZREb7FuMhHmkN4e4acNFBpOnBe4gK
	 PDIggyAVhpljiwykzWQ7jT2xc6sNOrnses52LjuABKivgmwMKt/BthNlyYpYUmlUHv5+b
	 gtqWvrg/F8xMHaLN3t08YYv6b1ab1WNBPC7+8HqxWxVr7SkPxjFDpUWnw0cqCrXmyJRQq
	 BwczkIiuKuqKH43NYN07Q4vtNNG19TFKlZLxVsWKxhziWc6BIOhxosDiJlkAQEx1JnShe
	 W4yAy2JVw1Q62FY8OWiH9xA9PQ1oPTEuu/9CiVIJSmdRYEuf4K6jec1CUTg5l5ReYHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084035;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1sku4jQlnBcRIMqFedESvbaRrc5SL6icTS5wBsxd6EU=;
	b=CI+Vl//xupBGFYmOd0EwY0vQfnROb6tOoAXCdpSGL4kPuSRE1sekVyTDziXwK9esHcRZ
	 KLHHX84sBC3JyKOzulLv3YcIzawk0smFLDBKHl4Mwxd+jCrBUDX6awhTHhcoRddurpSF5
	 D7i+NPf7Zr85MX45/5HkalCDv22PbzksTsvGxQuZ2J21ZHazMxPyHFriblRj4LL1uRfUN
	 JLCEFdr3qOvg90+9SWokxO/kfLtYcS7bvr6AApx2jxGQhckyG1zvbf3ln8HUjRqUUFMbT
	 q5Ymt9ZqoHcUrApL9u6xZH/I0ftI9wFSAIvDZFZ0AG1Z5Ks3aXZ32OjiJrWZuplYRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyPWg3On;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9908606A31A;
	Tue, 27 Oct 2026 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyPWg3On
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88CE1F01825;
	Tue, 27 Oct 2026 06:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084034;
	bh=1sku4jQlnBcRIMqFedESvbaRrc5SL6icTS5wBsxd6EU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WyPWg3On0QRT8OiUwBxHInjJUavp8S2hKx/DVzMgRBRLY5mPbUCHxumDwEkxFo9f8
	 E66yB9NPsmCZ3SqsmJB6uqx62NX75Ed2bH2S4liYkWAH1mkeeUwN03+sY1MrsJ/nQG
	 Ftd1M6/ZwRXNPBRCbqQhTZmIIit8C/iNBjn2tJLSZdi8u77AasFj5DFBXT5d4lTLIv
	 wrpUyJIzX9MOBg1zudh8UsrjRTOrRKz+tIxUC4UHXwlxough3yaNKpTr/UjNzzjXlw
	 HzvkKCBXHMXUao5BoG9mwWyRmO23DBlLeU4JcMka/qaT7VnRAeumKEYXfz8LJDrbAr
	 kLlDq5JkJXRzg==
Subject: Re: [PATCH net v2] inet: frags: prevent acceptance of partially
 authenticated reassembly
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 27 Oct 2026 06:53:53 +0000
Message-ID: <179308403346.3134.12478574904380821742@kernel.org>
In-Reply-To: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] secpath_equal() (include/net/xfrm.h) treats two secpaths as
  equal only if they have the same len and the same xfrm_state pointer…
- [Low] The new secpath check in inet_frag_queue_insert()
  (net/ipv4/inet_fragment.c:446-447) runs before the overlap/duplicate…

--

inet: frags: prevent acceptance of partially authenticated reassembly

This patch adds secpath_equal(). It makes inet_frag_queue_insert() return
a new IPFRAG_MIXED_SECPATH code when an incoming fragment's secpath
differs from the secpath of the queue tail. The IPv4 and IPv6 reassembly
paths now count IPSTATS_MIB_REASM_OVERLAPS only for real overlaps.

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index a6d69aaa6cd2d..298ca9bb00835 100644
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
> +	if (sp1->len != sp2->len)
> +		return false;
> +	for (i = 0; i < sp1->len; i++)
> +		if (sp1->xvec[i] != sp2->xvec[i])
> +			return false;
> +	return true;
> +}

[Severity: Medium]
Is comparing xvec[] by xfrm_state pointer stricter than the final policy
check requires?

xfrm_state_ok() in net/xfrm/xfrm_policy.c matches a state against a
template. It does not require one particular SA:

	return	x->id.proto == tmpl->id.proto &&
		(x->id.spi == tmpl->id.spi || !tmpl->id.spi) &&
		(x->props.reqid == tmpl->reqid || !tmpl->reqid) &&
		x->props.mode == tmpl->mode &&
		...
		(if_id == 0 || if_id == x->if_id);

This means several distinct xfrm_state objects can each be valid for the
same flow. Before this patch, a datagram whose fragments were
decapsulated by different but policy-equivalent SAs would reassemble and
pass __xfrm_policy_check(). Would such a datagram now fail reassembly
with IPFRAG_MIXED_SECPATH?

This seems possible in these setups:

  - per-CPU SAs (struct xfrm_state::pcpu_num) on a sending gateway that
    forwards inner fragments without conntrack, where the first and later
    fragments are handled on different CPUs (for example, NIC RSS hashing
    on the UDP 4-tuple)
  - an outbound rekey between fragments of one datagram
  - duplicate CHILD_SAs that share the same reqid

In the per-CPU SA case, the drop could repeat for every fragmented
datagram.

The commit message also says:

    Reject a fragment when its secpath differs from the fragments already
    in the queue, and keep overlap statistics limited to actual overlaps.

The code seems to drop the whole queue, not only the one fragment. In
ip_frag_queue(), IPFRAG_MIXED_SECPATH falls through insert_error into
discard_qp. ip6_frag_queue() does the same with discard_fq:

discard_qp:
	inet_frag_kill(&qp->q, refs);
	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);

nf_ct_frag6_queue() goes to insert_error, which also calls
inet_frag_kill().

The patch is tagged for stable. Should the commit message say that the
whole datagram is discarded, and that legitimate IPsec traffic can now be
dropped this way? If the strict pointer comparison is a deliberate
security trade-off, could that be documented as well?

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
> +

[Severity: Low]
This check runs before the overlap and duplicate classification. The
RFC5722 comment further down in inet_frag_queue_insert() still says:

	 * Duplicates, however, should be ignored (i.e. skb dropped, but the
	 * queue/fragments kept for later reassembly).

Take an exact duplicate of a queued fragment that carries a different
secpath, or no secpath at all (for example, a plaintext copy of an inner
fragment that arrived through an ESP tunnel). It now gets
IPFRAG_MIXED_SECPATH instead of IPFRAG_DUP.

In nf_ct_frag6_queue(), that skips the duplicate branch:

	if (err) {
		if (err == IPFRAG_DUP) {
			/* No error for duplicates, pretend they got queued. */
			...
		}
		goto insert_error;
	}

ip_frag_queue() and ip6_frag_queue() treat it like an overlap. All three
paths end in inet_frag_kill(), so the queue is destroyed instead of the
duplicate being dropped quietly.

Should the comment say that a mixed secpath is fatal even for duplicates?
Or should the handling change to match the comment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023185118.2588450-2-Jeremy.Jean%40oss.cyber.gouv.fr
