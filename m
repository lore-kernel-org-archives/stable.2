Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246C46A5FB;
	Tue, 21 Jul 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649817; cv=none; b=ES5a04GyCjpeuI4u+LMuhyVwCgxofYCOyNgW54YFkDKcGUcAHaJTLbw3wTDr8uhSfcnRWBRg+OwBqBb01HRvQFv+b7tOHn2DnxbZGIAPoU21g2DpC5dzkpxgWYnl/AREJ6s5CR7lMlCJ4t1DpB0jJ3o9guDrT19U46NvJr9YhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649817; c=relaxed/simple;
	bh=KMgTbTWKaG9NQREe1FHO+XIH9W2+K9G65O26h8QkCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olHlbeUEOO/8S/hFiff5uYHIOR5AAUb5d445h629gGXFWK3C+sEMmUeImAsytHQgviFCGgHsnvatnz+r5ck0+vSpDfbnaPEZ3ggNYEwFgMdwXm05kipzOpf8PLQmhH21AQvLG+zTJgovv330EFI3EAqJFeTX1E7IkQyqvDe7U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn23ge19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn23ge19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A751F00A3A;
	Tue, 21 Jul 2026 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649816;
	bh=knVnxubrgobf7tjT7gTlNb8boEHPM95Zv1y4aZWV32U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jn23ge19Sp3OHi7/dZ5LahFQ2JCeoBtEv5QSAz+Zr31WMELW/dB6pb68iQSU7uUUL
	 3EGBoLEuY65SGcVYSRSNIToLskuX48TAg3jhTLtmC1aBxKqsCVblMTrBtUB88+zGHf
	 49A49ho8xMivpVm0VSzNi0lwyomstB7RepOxWGU2lmDGr2p0/zaNj56FOYpYwnx0UN
	 pYR0+DWbMeSFjBI/Cu/GV2iY1c/m94ItYJn7OzSe93WW8qY8q4Gj/tUXeE3cLJSRLz
	 ipP7mZoGhOap+hcsFLP3Xo75YIbK+FUJhUSuKhGYuBjGLUWF8w9e7LxlklBucI+4Hc
	 q98CgVg0RG0GQ==
Date: Tue, 21 Jul 2026 17:03:32 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ila: reload IPv6 header after pskb_may_pull in
 checksum adjust
Message-ID: <20260721160242.GK19108@horms.kernel.org>
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

Reviewed-by: Simon Horman <horms@kernel.org>

