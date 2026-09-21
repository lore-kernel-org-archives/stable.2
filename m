Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277C3F927B;
	Mon, 21 Sep 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976822; cv=none; b=WBtWH/ZCIWjPxyAPWtijiQuiqHNpI3iZz8qZSBw/Bhb9rTAbGIKi1+Z0Ztrkg1k1Ii737nKOElscaR4WCqJuzzP5zoE9PfbOG9DUNfhFJ7U1IDmUu1R3bwVWTlP7zp0HiSRwW4MqmgFcrt8C+22OGNhIIKfbpqj11ILhm0rYEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976822; c=relaxed/simple;
	bh=VLUdS02NRRno6GLL+tr+sk9bKjuGY7lFkc5FZ9tEJq4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3I9F4J5f3oV4JMI686zGGEBpQat6Ml01P5SygdJolKq1bu9/NU4LEiSHDfFR9fhwVAoq//X//5iXPIvtVQkzNep4txhkLwxCZbli7J2aWNt2xXFdMVaQsAx5UuG0nuhLppdxg4UUmR2+wk32EujcG3QyWpOX3EKna6F/yu5cR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=P8ZkK8xM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="P8ZkK8xM"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8A25120728;
	Mon, 21 Sep 2026 09:46:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sB1aWwUjRQfB; Mon, 21 Sep 2026 09:46:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 055E120704;
	Mon, 21 Sep 2026 09:46:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 055E120704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789976812;
	bh=J22Zw0SkQCK/M+p7X5FLSZuVRrlKG7w+gt8YvGfV6+w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=P8ZkK8xMBnWrFkVbzWb1WU2mGkOP0wcnXbRJPMtT4+zggJL8naG6XDHI2XnY4knm3
	 4Q/PjPJ2RuL80ORr4VfsODmUxy71un9Oyv+7wPw2z6fMH7cwahnJjgOBmfYyiqpm5P
	 o7hm5foVM7sEWe0WWDfifJRSTuHwTcQXAE63ZbJyXCN8Htq1IrG9i1LF70873q3LJj
	 wU59XP3w5++LuYKYZQJlnB8baZs8gYRcU8uptEhqTpgLP8nQzDuXAP1hA/0w4UhF6j
	 n2Mn5evVEej91ag2teEzjVLzI6mlTvKoS3nBfgYNfPTvqavIDLY4VUCWuzplM9MFKd
	 jJ5zt1p307gYw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 21 Sep
 2026 09:46:51 +0200
Received: (nullmailer pid 1751865 invoked by uid 1000);
	Mon, 21 Sep 2026 07:46:50 -0000
Date: Mon, 21 Sep 2026 09:46:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: retry inexact policy lookup after node
 reinsertion
Message-ID: <arDg6mhqpIy1kPSc@secunet.com>
References: <20260903145735.468999-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903145735.468999-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Sep 03, 2026 at 10:57:34PM +0800, Chengfeng Ye wrote:
> An inexact policy lookup first records pointers to candidate hlist heads
> and then traverses the lists.  A concurrent policy insertion can merge
> inexact tree nodes between those operations:
> 
>   lookup                         policy insertion
>   ------                         ----------------
>   find inexact candidates
>     save obsolete hlist head
>                                  write_seqcount_begin(&bin->count)
>                                  merge inexact tree nodes
>                                    hlist_del_rcu(&policy->bydst)
>                                    reinsert policy->bydst in survivor
>                                  write_seqcount_end(&bin->count)
>   evaluate saved candidate list
>     miss the moved policy
> 
> The merge immediately reinserts the same hlist node into the surviving
> tree node.  RCU keeps the policy alive, but it does not provide a
> consistent view while its list node is moved.  A lookup that selected the
> obsolete list can observe it empty.  A lookup already traversing a moved
> policy can instead follow the next pointer rewritten by the reinsertion.
> Either case can return an incorrect IPsec policy result.
> 
> The per-bin sequence counter already brackets calls to
> xfrm_policy_inexact_insert_node(), including node merges.  The read side,
> however, currently validates the counter only while searching an
> individual rb-tree.  A successful search returns without validation, and
> the later candidate-list traversal is outside that read-side section.
> 
> Snapshot the per-bin sequence before discovering candidate heads and
> validate it after evaluating all candidate lists.   Retry the lookup if
> the inexact policy tree changes while it is being searched.
> 
> Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Applied, thanks a lot!
