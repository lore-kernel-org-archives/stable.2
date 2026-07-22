Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC3411680;
	Wed, 22 Jul 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705200; cv=none; b=PBA907cSdtKVzbGn8gO2wRhHKHukzq+pFwjRqJPhLrg7r/+AetBLHzOkZ3CjTSP+Lh2wM2NXgxa10GfXuzylTsTg6vYzfbuLULPKcl2fPxskcZ9cPlwCL7ICB8VBjCKxY39ALWJYyjXfOOzTdcinR18NHFY/nvyzXmunHlNMf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705200; c=relaxed/simple;
	bh=nS08Db4ygIwrWH35zcLToVpc1tp28K3xkr1dKKu4ck8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0wKPmM9+O+kEEaIJXQWpmyFr8BvTkF8Y6chUsMAVE2XmHTh950e8iYvZha21b9Z7UxVzaY6/Y4entJksA80yxCyQ7ikoYoepr/K9TKmXfbikkevGXUh+J+HBA4wT3sAF4n8G7SuvY7HyDQRGvFTUd7NLmSjKCEq3yzhLWyEOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfCBcRBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfCBcRBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB71F1F000E9;
	Wed, 22 Jul 2026 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705197;
	bh=VzyKHWjERwTvD1OHvcQlnR4eADX0z86Q4wbCmhs/mN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfCBcRBU+GJW7kweZdSV0NfViJj28rjlBpR6AhMD3B+tk4ViHCFLZwDLtSbcx71fP
	 ouwJD8f3gpzyhGJe5h8/kPvMdwBAWSWPPnD4vhBGiZ4hFEMHaJoV/yCiJm0K2BX0JN
	 i5dA2nJvCCMiucVyKFKSe+7L0PUaXh4T/HnLbpXpdk0R+7y/VxmGV4LvmVOgJBzUod
	 OFXzheCnF1PetrDEpxzNauGJiEV0Q9nA9RbXgKeEF7jD4SVufxcwBCIMpWO/BQ35GN
	 5o0AbZVqkMOqX3YCMFhOxej3m0QnfdPaR642NqQ7UnTzn7iYUNMe9HQO5pWnwUvvL0
	 p0mWfLJJJEftA==
Date: Wed, 22 Jul 2026 09:26:33 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Antoine Tenart <atenart@kernel.org>, 
	Simon Horman <horms@kernel.org>, Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ila: reload IPv6 header after pskb_may_pull in
 checksum adjust
Message-ID: <amBwgPWFb8UIxssF@kwain>
References: <20260714114903.3763420-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114903.3763420-1-michael.bommarito@gmail.com>

On Tue, Jul 14, 2026 at 07:49:03AM -0400, Michael Bommarito wrote:
> ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
> pskb_may_pull(). On a non-linear skb whose transport header sits in a page
> fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
> and free the old skb head, leaving ip6h dangling; the following
> get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
> uses ip6h (and the iaddr derived from it) again after the csum-adjust
> call and additionally writes the new locator through that pointer.
> 
> Impact: a remote IPv6 packet routed through a configured ILA
> csum-adjust-transport route or receive-side mapping triggers a
> slab-use-after-free in ila_update_ipv6_locator() (KASAN). The route or
> mapping requires CAP_NET_ADMIN to configure, but trigger packets are
> unauthenticated once it exists.
> 
> Reload ip6h after each pskb_may_pull() in ila_csum_adjust_transport()
> before the csum-diff read. In ila_update_ipv6_locator() only the
> ILA_CSUM_ADJUST_TRANSPORT case pulls the skb, so reload ip6h and iaddr in
> that case alone before the destination-address write; the neutral-map
> modes never pull and keep their cached pointers.
> 
> Fixes: 33f11d16142b ("ila: Create net/ipv6/ila directory")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!
Antoine

> ---
> v2: In ila_update_ipv6_locator() reload ip6h/iaddr only in the
>     ILA_CSUM_ADJUST_TRANSPORT case instead of unconditionally, per
>     Antoine Tenart's review; the neutral-map modes never pull the skb,
>     so their cached pointers remain valid.
> v1: https://lore.kernel.org/netdev/20260711150648.2915106-1-michael.bommarito@gmail.com/
> 
> Evidence: a KUnit case on UML+KASAN drives ila_update_ipv6_locator()
> with a non-linear skb whose transport header sits in a fragment, so the
> pskb_may_pull() in ila_csum_adjust_transport() reallocates the head.
> Stock: BUG: KASAN: slab-use-after-free in ila_update_ipv6_locator, Read of
> size 4 (the stale ip6h/iaddr). Patched: both the valid-linear control and
> the fragmented case pass, KASAN-clean. Built clean, no new warnings.
> 
> 
>  net/ipv6/ila/ila_common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
> index e71571455c8a0..b78179bfc4c72 100644
> --- a/net/ipv6/ila/ila_common.c
> +++ b/net/ipv6/ila/ila_common.c
> @@ -85,6 +85,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  			struct tcphdr *th = (struct tcphdr *)
>  					(skb_network_header(skb) + nhoff);
>  
> +			ip6h = ipv6_hdr(skb);
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&th->check, skb,
>  							diff, true, true);
> @@ -96,6 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  					(skb_network_header(skb) + nhoff);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> +				ip6h = ipv6_hdr(skb);
>  				diff = get_csum_diff(ip6h, p);
>  				inet_proto_csum_replace_by_diff(&uh->check, skb,
>  								diff, true, true);
> @@ -110,6 +112,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  			struct icmp6hdr *ih = (struct icmp6hdr *)
>  					(skb_network_header(skb) + nhoff);
>  
> +			ip6h = ipv6_hdr(skb);
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
>  							diff, true, true);
> @@ -127,6 +130,15 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
>  	switch (p->csum_mode) {
>  	case ILA_CSUM_ADJUST_TRANSPORT:
>  		ila_csum_adjust_transport(skb, p);
> +		/*
> +		 * ila_csum_adjust_transport() calls pskb_may_pull(), which can
> +		 * reallocate the skb head and leave ip6h (and the iaddr derived
> +		 * from it) dangling; reload both before the write below.  The
> +		 * other csum modes do not pull, so their cached pointers stay
> +		 * valid.
> +		 */
> +		ip6h = ipv6_hdr(skb);
> +		iaddr = ila_a2i(&ip6h->daddr);
>  		break;
>  	case ILA_CSUM_NEUTRAL_MAP:
>  		if (sir2ila) {
> -- 
> 2.53.0
> 
