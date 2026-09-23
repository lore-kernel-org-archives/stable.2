Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE954788;
	Wed, 23 Sep 2026 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130260; cv=none; b=BWKrM1y7etKnQEulUICamIobvMkuKtatlpbzgCvvP+Z6X2T1GacA4rxQW8LB/f1nD5uKjI4x9QcWgBNjwL8iA26cDgTRmBne5oUSuxEuQ/9OBFUNUQ8/ldM+QgrSdxGV1ISGUHjWK99FUhQRUzehSrGTytsezdvlaPqSzHRaFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130260; c=relaxed/simple;
	bh=r4MIFdRHeTn138NWQHUELziQJqZiu7yst8in9riAkqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4oErTfrsRyubTEnAdp8/m25NCkCyEX9bMZiE0cyG4sTTRb2Kk3g1K0TaRFPjq+VxguitnzNCSwAasjK/RTPsvLtDn6B0XdJwbwGHwja0Gad34os7m8Zk+XOle02EXfjg16xYGRK+J4ERcSbkYStI2PZZr/le+ePkFpvOUM6tpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=qCXtDRN+; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="qCXtDRN+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=z79l7x4ubFqNKrcR/nl90khYYkFHcdHj/PnwWb+DoTY=; 
	b=qCXtDRN+mFseEqE9x/fpbUUFfgxYiDp4MBEr4oHfiHssu3UVhKRXl5eXh47xgFKOxSw8OkyZYrN
	NRFjLSJ84NvWB27YcZI/5uuyLT32KuwiIkZ/rqWiZRy2+zb0DmDG8BZu72J844/iHo8lFsP4gvwZy
	Bos+ccTAqyO0CjME9FoK7uuEtMLrlaICPgj0cCIXOCwx+z6lFESMmgcYTaQUQfaLf06M6c1wb/WTl
	DKQWYRYv5g0gsX5ckp3M2WsbVHSr0Kl1E/wncZf7fm0WkTWMILj7jS/AIDOLtYNhxgfVpuKOJTaTQ
	iPPE7uwrpscYYoPWizUmZjPYhgtHXgI/YCqg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1x9CeX-0000000GsM7-3XD2;
	Wed, 23 Sep 2026 10:24:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Sep 2026 12:24:09 +1000
Date: Wed, 23 Sep 2026 12:24:09 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net v2] xfrm: validate ihl in xfrm4_transport_output()
Message-ID: <arM4SS7k7aswJAOL@gondor.apana.org.au>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
 <20260923021640.38855-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923021640.38855-1-q.h.hack.winter@gmail.com>

On Wed, Sep 23, 2026 at 10:16:40AM +0800, Qihang wrote:
> xfrm4_transport_output() reads the IPv4 header length (ihl) from the
> packet and uses it for __skb_pull() and memmove() without validating it,
> so a frame with ihl * 4 larger than the linear header underflows skb->len
> to a huge value or trips BUG() in __skb_pull().
> 
> Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
> device) reach xfrm output without the header validation that
> ip_rcv_core() applies to received traffic.  The underflowed length then
> flows into esp_output() and the crypto scatterlist setup, where every
> length in the underflow window ends in a fatal fault (BUG_ON in
> __skb_to_sgvec()).  This is a deterministic local denial of service
> reachable by an unprivileged user through a user and network namespace.
> 
> Reject ihl < 5, matching ip_rcv_core(), so a complete IPv4 header is
> present.  Then use pskb_may_pull() to make the header linear: this
> rejects ihl > skb->len, linearizes a header that currently lives in
> fragments, and guarantees __skb_pull()'s precondition that the pull must
> not drive skb->len below skb->data_len, and it keeps the memmove() source
> in bounds.  ip_hdr() is re-read afterwards because pskb_may_pull() may
> reallocate the skb head.  xfrm6_transport_output() already bounds its
> header length through xfrm6_hdr_offset().
> 
> Fixes: b59f45d0b2878 ("[IPSEC] xfrm: Abstract out encapsulation modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---
>  net/xfrm/xfrm_output.c | 5 +++++
>  1 file changed, 5 insertions(+)

As I said when this first came up, our entire IPv4 stack
assumes that this is validated upon entry into the IP stack.

So taking a whack-a-mole approach inside the IPv4 stack is the
wrong thing to do.

Please fix those entry points into the stack instead by ensuring
that the IP header is valid.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
