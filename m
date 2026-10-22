Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681557;
	b=snNxIZ7rW7msNyF4bJ9CGY3JUoU0RDHEdTkGkXuEc5Uzqists+uyBmPUrlGZiOnNQRC3
	 PPVPbZ9uqSOb3BQVQeqN0VCaWnAcC2Qy1mmSuVyfpAV+JSzfLkkyDdiGLutZJ88CFn8Nb
	 otgOtO9WeDX0Hx852uGsP/eoPOD2YO/KDlY+7mH802fUQ8IBPRuUkng4qrqWgXGfnpuqc
	 IIg/f2AXwqoOjjIx/cclZXRbX89Z5eTECNTxyfkuqvDup60PR7yDFRm5jXBQyDU8sAABT
	 D4dzq7XL6fgZZ91AxQ8TUbSgTM11HPjcrMDrzemDyyK6+XolTbpT034P1EdGwAlk12Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681557;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HrKgZPRLerxUrII0oqrcm4Xvj2MVo+Q+vkum7aPMFP0=;
	b=YQG6eE4MQHdAdi3R5x8ee1Vl5WIsb7KB8Ls2gx7AKSIRy1R0o1hcOLqP1D9bzBWpXUey
	 j4h6Es7NEPGEotJ1rzXWdS1T7w411f8Oy6BTavuXnWEI7T1dCQFBAZSZP8d9ORxu4JqZ7
	 rmxEa0ZOQR5dAJeFLXX1HlqmFKZjFMH6CYkj70h+xaHralDrqdktntziwU6pEidbEaJUI
	 8V2/bG+ZKmCDjlwfehxGPevvAiM5CAUBGj2PxnzUnEOOnpqVCJyNdrOiUq00rVJCqrgYR
	 qxDJ2x55tN34xJZQ2/E0kFBWsendnwiw4ODLlfg0WS2WdEj5n7v84vTzDQ/L8Dlfw6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBoONAWd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D18606A334;
	Thu, 22 Oct 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBoONAWd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B56E1F01825;
	Thu, 22 Oct 2026 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792681556;
	bh=HrKgZPRLerxUrII0oqrcm4Xvj2MVo+Q+vkum7aPMFP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jBoONAWdiVDjkztEn+QvJxIfQwxPY2nv1ax6Tw+MeqGqS6XKEwpSvQaX8bqoQxXma
	 Pg/Ua0YU6xi/QnTmc4+DXgijDYJhHb8HRDYE2IW6sWCyNZasUpXwrXnF4G5NF33gqK
	 +ELC9kc8ByGwR5cFp6AXFKwTUtSqALpIFMM6THrG7ifEIasMrV7qUPOmNEYnqm3/JG
	 4lLF2viZNjaxXVeVUcQSrr+ywwwGBLlUqhH0fLM8+fSVFVtU6W3+6GEAg3/sNiPunT
	 nMLPyxx4KALgFfjffckUsMV4ZQD9uArt4qvlBrobHPSjpx+dHOXmBL1DuGmLQXx/p7
	 e0VTqysmQzvCw==
Subject:
 Re: [PATCH net v2] xfrm: esp: reset outer TCP GSO metadata on espintcp input
From: netdev-bot+sashiko@kernel.org
To: yangguoshuai@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 15:05:55 +0000
Message-ID: <179268155570.3135.6366960419287611684@kernel.org>
In-Reply-To: <20261020030450.7170-1-yangguoshuai@gmail.com>
References: <20261020030450.7170-1-yangguoshuai@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Problem: outer TCP GRO metadata can still break espintcp input
  when the outer GRO aggregate carries SKB_GSO_FRAGLIST.

--

xfrm: esp: reset outer TCP GSO metadata on espintcp input

On espintcp input, this patch clears stale outer TCP GSO metadata. It
calls skb_gso_reset() on the head skb and on each frag_list member at the
skip_cow label in esp_input() and esp6_input(). This is meant to stop the
decrypted inner packet from reaching skb_segment() with outer GSO state
and hitting BUG_ON(!list_skb->head_frag).

> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index e76db5817e78..012b59f69292 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -900,6 +900,14 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
>  	nfrags = err;
>  
>  skip_cow:
> +	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
> +		struct sk_buff *iter;
> +
> +		skb_gso_reset(skb);
> +		skb_walk_frags(skb, iter)
> +			skb_gso_reset(iter);
> +	}

[Severity: Medium]
Is this reset reached when the outer TCP GRO aggregate carries
SKB_GSO_FRAGLIST? It only runs after skb_cow_data() succeeds, and
skb_cow_data() can fail on that gso_type before we get here.

tcp4_gro_complete() sets this on fraglist GRO aggregates:

    skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;

tcp4_check_fraglist_gro() chooses fraglist GRO when it finds no socket in
the ingress device's netns. That happens when rx-gro-list is enabled and
the espintcp socket is in another netns reached through veth or a bridge.
veth passes the aggregate on intact, and TCP queues it unsegmented.

When an ESP record spans such an aggregate, __strp_recv() makes it a
frag_list child of the message head and keeps the FRAGLIST gso_type. This
happens in one of two ways:

- skb_unclone() on an appended clone that has its own frag_list
- moving an old head that has a frag_list under a newly allocated head

esp_input() then takes the skb_cow_data() path, and for that child:

net/core/skbuff.c:skb_cow_data() {
    ...
		if (copyflag ||
		    skb_cloned(skb1) ||
		    ntail ||
		    skb_shinfo(skb1)->nr_frags ||
		    skb_has_frag_list(skb1)) {
			...
			if (ntail == 0)
				skb2 = skb_copy(skb1, GFP_ATOMIC);
			...
			if (unlikely(skb2 == NULL))
				return -ENOMEM;
    ...
}

net/core/skbuff.c:skb_copy() {
    ...
	if (WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST))
		return NULL;
    ...
}

esp_input() then takes the goto out before skip_cow, so neither reset
runs. The result is a WARN_ON_ONCE() splat, which panics with
panic_on_warn. Each valid ESP-in-TCP record like this is also dropped.
All of this happens before ESP authentication, on data that the TCP peer
controls.

esp6_input() has the same ordering:

	nfrags = skb_cow_data(skb, 0, &trailer);
	if (nfrags < 0) {
		ret = -EINVAL;
		goto out;
	}

The commit message says that at skip_cow:

    the head skb and all frag_list members are guaranteed to be uncloned
    with private skb_shinfo.

In this case skb_cow_data() fails before skip_cow is reached.

The skb_copy() WARN_ON_ONCE() itself is older than this patch. This is
still the same stale outer TCP GRO metadata problem the patch sets out to
fix, and a reset placed after skb_cow_data() can't cover it. Should the
outer GSO state be handled before or inside the COW step instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020030450.7170-1-yangguoshuai%40gmail.com
