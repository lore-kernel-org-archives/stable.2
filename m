Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F283C3449;
	Mon, 17 Aug 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955433; cv=none; b=h4M2r2/fVQEQoG4LlVnBotSxkJ7dhSQxqcoWgnF+sV0p5UcA/t8zD+yhfwSGDzJZyV3s83Kb5hxPSJzpFUod3eWpM4EvlIcz6P6yuqAY4DzM6jO99RbjVmJdKjUgWe5qr3u8QHPzCetidW8LUlBpCeFhUY9FF+KM6bWOankD7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955433; c=relaxed/simple;
	bh=NfRHayOFN3Vuh/9a5GrxESJAGCqJB49o0DHuC2dQ9lw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plHo/ghNDRj+Zv6TKcGthQODaAeVWVbYQ+R3WWvV4msAsuNjpriHJR8eTtaEjznerovk4PqFLmd0N9oWs0Ba8xLueWUdKTC1bY6d5VtRmmaBpeMzkCtQv47frui8KWKChMgg37KiGyVFh1kaY1+sqpcz2yPZq4My4PU6DD6im50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UvJA+LgK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UvJA+LgK"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B8599207C6;
	Mon, 17 Aug 2026 10:30:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vz63utZw1f8C; Mon, 17 Aug 2026 10:30:28 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 22F40207B0;
	Mon, 17 Aug 2026 10:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 22F40207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1786955428;
	bh=E2b1g+ZF2TubrokbYbJCsr5ihusL/h54HE05O2SRuCk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=UvJA+LgKKUe8UNzWes2NTzFq3xi/1Sopkt8XwD5GL1/ZqzYElbevpggA4Kk8/w/Lt
	 xZ8kf5G1rpzN7YrWFCTOOaN2K/IjSdOPX4pK9H4fYCcvI8I3uc7Po13eSnTYqdmc9N
	 B2cnM74S03W5X5OQGNjrMekAz91zyzy7jUz3vRTHpap7gdpiy3wjU55/9q5/rnIsUx
	 DPiSyMozohh+ciGWEoUvvvKhzf7cL6yWPXUdxIQvR6pNC/M1EB9RCyXj0h323mUQd7
	 sL8g3PNhU3G5eWIHa17cNm5dzepoQX7drZ/EBNV8mcmivFKfsDn6yr9nLVtL90O/iW
	 pb83ONfH0/+Og==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 17 Aug
 2026 10:30:27 +0200
Received: (nullmailer pid 2445479 invoked by uid 1000);
	Mon, 17 Aug 2026 08:30:26 -0000
Date: Mon, 17 Aug 2026 10:30:26 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Siwei Zhang <oss@fourdim.xyz>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Siwei Zhang <fourdizhang@tencent.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] xfrm: use hlist_del_init_rcu for state_cache
 and state_cache_input
Message-ID: <aoLGokLlBCkXd6uT@secunet.com>
References: <20260730114028.1077499-1-oss@fourdim.xyz>
 <20260730114028.1077499-2-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730114028.1077499-2-oss@fourdim.xyz>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 30, 2026 at 07:40:08PM +0800, Siwei Zhang wrote:
> From: Siwei Zhang <fourdizhang@tencent.com>
> 
> Commit 14acf9652e56 ("xfrm: defensively unhash xfrm_state lists in
> __xfrm_state_delete") converted bydst/bysrc/byseq/byspi from
> hlist_del_rcu() to hlist_del_init_rcu() so that a second
> __xfrm_state_delete() on the same object becomes a no-op rather than a
> write through LIST_POISON pprev. It missed state_cache and
> state_cache_input, which kept hlist_del_rcu():
> 
> - hlist_del_rcu() leaves pprev = LIST_POISON2 (non-NULL), so
>   hlist_unhashed() returns false.
> - hlist_del_init_rcu() leaves pprev = NULL, so hlist_unhashed()
>   returns true.
> 
> A second __xfrm_state_delete() therefore enters __hlist_del() on the
> already-deleted state_cache/state_cache_input nodes and does
> WRITE_ONCE(*pprev, next) through LIST_POISON2 — a write use-after-free
> once the slab is reused. The corruption can in turn cause a subsequent
> hlist_for_each_entry_rcu traversal to follow a dangling next pointer,
> producing the read use-after-free reported in xfrm_input_state_lookup().
> 
> Switch state_cache and state_cache_input to hlist_del_init_rcu() to
> match the other four lists, closing the write use-after-free and, with
> it, the read use-after-free it spawns.
> 
> Assisted-by: CodeBuddy:GLM-5.2
> Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
> Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siwei Zhang <fourdizhang@tencent.com>
> ---
>  net/xfrm/xfrm_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 36a4f6793ede..f494c1ac57a4 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -823,9 +823,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
>  		if (!hlist_unhashed(&x->byseq))
>  			hlist_del_init_rcu(&x->byseq);
>  		if (!hlist_unhashed(&x->state_cache))
> -			hlist_del_rcu(&x->state_cache);
> +			hlist_del_init_rcu(&x->state_cache);
>  		if (!hlist_unhashed(&x->state_cache_input))
> -			hlist_del_rcu(&x->state_cache_input);
> +			hlist_del_init_rcu(&x->state_cache_input);
>  
>  		if (!hlist_unhashed(&x->byspi))
>  			hlist_del_init_rcu(&x->byspi);

What is the difference between v1 and v2 of your patch?
Both look identical to me.
