Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504635F61E;
	Thu,  3 Sep 2026 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420782; cv=none; b=uxeLb9Cf7C2Gh9VZyBcM+Krb4rtSR6GVY09HmdqnLpw+gSC48eqSY+1drm7VpUiBwWyv+RT9dpkvwjEwjNBAinqu5fPaqMJi/D+KKmDO3Rgoor3XN/3LwVtBIzYDixGttpjbnC9iCIIE5FcN0FuUfk4oOjVlWWzFvPVL0mQwKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420782; c=relaxed/simple;
	bh=rxDXIMSCoBOkjZoCKGfH+vbM71Jqs/DjLA1NIsEcEiU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjG66+otacm7486tnzvrzXPdAZBqoe7WbgdIyk1l2RuOPEc3423ywaoyxRDGYcCamMqOhlVet6d9Z5MVeH+6CEwIvW+TU0B2Cx7MOg1IakDF659vvqvjmhZYoAroUmIcrX9476hOPn009NdLqjyeV9lGz3hHEfbxOdZtJGpDIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cB5i5pl8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cB5i5pl8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 39E30201C7;
	Thu,  3 Sep 2026 09:32:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5baW6b2ggut; Thu,  3 Sep 2026 09:32:55 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7FEC72058E;
	Thu,  3 Sep 2026 09:32:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7FEC72058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788420775;
	bh=VYA2mSun53SINAKSK+NMDIUfBNfT1MQXzK7ecPvuByc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=cB5i5pl8P15gvLgAIgIH6yek67OYdmBr/hLsOLiYlx8ahEFwLtKwMIvCKxLETEIew
	 hgVz4lsfHRwEA+q33vGySgH0vId4NiMVdnDQvW4+vjL32+burtq8JxgK7RAXqUmNF6
	 pI1eyhMo4DE9rfW9sIvvJXvVv7wEHW2Ymi3hgOXa6/ol0ygCTJrNkjXtcDXl80o/47
	 IIrecm5VJzODHkEBb3COY3j9rFQAWivRTSMXtFM8kh+uZlSAFEajiZ2pgJCASw+Ym0
	 Tc5EP1/FHmRwa2dxQYo+prm3+/AsBRsCw21JrjsR9g0laEXu823hSKBL4lyS+9jhIK
	 48IhYhP9OMT7A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 3 Sep
 2026 09:32:54 +0200
Received: (nullmailer pid 1406827 invoked by uid 1000);
	Thu, 03 Sep 2026 07:32:53 -0000
Date: Thu, 3 Sep 2026 09:32:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: retry inexact policy lookup after node
 reinsertion
Message-ID: <apkipe4r500gMfwx@secunet.com>
References: <20260824152057.216329-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824152057.216329-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net] xfrm: retry inexact policy lookup after node reinsertion ---
commit 55045c9b49d306c47b0ee8e568d224e0bca94a3c
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

xfrm: retry inexact policy lookup after node reinsertion

This adds a snapshot of the per-bin sequence counter around inexact
candidate discovery and evaluation in xfrm_policy_lookup_bytype(), and
retries the whole lookup if the counter changed.  The stated goal is to
reject lookups that overlap the bydst hlist hop done during node merge and
reinsertion.

No Link: tags are present in the commit header.

> During concurrent policy insertion and route lookup, KCSAN reported:
>
>   BUG: KCSAN: data-race in __xfrm_policy_link / xfrm_lookup_with_ifid
>   write to ... by task 92 on cpu 0:
>     __xfrm_policy_link
>     xfrm_policy_insert
>     xfrm_add_policy
>   read to ... by task 91 on cpu 1:
>     xfrm_lookup_with_ifid
>     xfrm_lookup_route
>     ip_route_output_flow

Discovered by: opus-5 � Missed by: sonnet-5, gpt-5-6-sol, sashiko-gemini � Confirmed by: gpt-5-6-sol
Can this KCSAN report come from the code the patch changes?

__xfrm_policy_link() in net/xfrm/xfrm_policy.c only does this:

	switch (dir) {
	case XFRM_POLICY_IN:
	case XFRM_POLICY_FWD:
	case XFRM_POLICY_OUT:
		pol->pos = xfrm_gen_pos(net);
		break;
	}

	list_add(&pol->walk.all, &net->xfrm.policy_all);
	WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[dir] + 1);
	xfrm_pol_hold(pol);

The only one of those locations that xfrm_lookup_with_ifid() touches is
policy_count, and it reads it marked:

	if (!if_id && ((dst_orig->flags & DST_NOXFRM) ||
		       !READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT])))
		goto nopol;

Documentation/dev-tools/kcsan.rst states that if all concurrent accesses to
a variable are properly marked, KCSAN will never trigger a watchpoint and
therefore never report the accesses.  Both sides here are marked, so how
was this pair reported?

The write side the changelog describes in prose is a different one: the
bydst hop in xfrm_policy_inexact_node_merge():

	hlist_for_each_entry(tmp, &v->hhead, bydst) {
		tmp->bydst_reinsert = true;
		hlist_del_rcu(&tmp->bydst);
	}

	xfrm_policy_inexact_list_reinsert(net, n, family);

That path is reached via xfrm_policy_inexact_insert_node(), not via
__xfrm_policy_link(), and it also uses only marked writes
(hlist_del_rcu(), hlist_add_head_rcu(), hlist_add_behind_rcu()) against a
reader using hlist_for_each_entry_rcu().  So that pair would not be
reported by KCSAN either, which suggests the hazard being fixed is a
logical list-hop ordering problem between correctly marked RCU accesses
rather than a data race.

Could the changelog be reworded to describe the ordering problem directly,
and either drop the KCSAN splat or replace it with a report that actually
corresponds to the accesses this patch guards?  With Cc: stable in place,
the quoted evidence is what backporters will use to judge the fix.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 932a313b9460a..5d4e863863dfe 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c

[ ... ]

> @@ -2191,12 +2192,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
>  		goto skip_inexact;
>
>  	bin = xfrm_policy_inexact_lookup_rcu(net, type, family, dir, if_id);
> -	if (!bin || !xfrm_policy_find_inexact_candidates(&cand, bin, saddr,
> -							 daddr))
> +	if (!bin)
> +		goto skip_inexact;
> +
> +	inexact_sequence = read_seqcount_begin(&bin->count);
> +	if (!xfrm_policy_find_inexact_candidates(&cand, bin, saddr, daddr))
>  		goto skip_inexact;
>
>  	pol = xfrm_policy_eval_candidates(&cand, ret, fl, type,
>  					  family, if_id);
> +	if (read_seqcount_retry(&bin->count, inexact_sequence))
> +		goto retry;
> +

Discovered by: opus-5 � Missed by: sonnet-5, gpt-5-6-sol, sashiko-gemini � Confirmed by: gpt-5-6-sol
Related to the above: this retry can only observe mutations that are
bracketed by write_seqcount_begin(&bin->count).  The chain updates done by
xfrm_policy_insert_list() and __xfrm_policy_unlink(), and the counter
update in __xfrm_policy_link() named in the quoted splat, do not run inside
any bin->count write section.

So even taken at face value, would this new read_seqcount_retry() have any
effect on the __xfrm_policy_link() versus xfrm_lookup_with_ifid() pair
quoted in the changelog?
