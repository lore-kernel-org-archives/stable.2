Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B800388385;
	Tue,  1 Sep 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252003; cv=none; b=hg6CRFicc7l95idCMbfWhv0LwRe77VlNW9mmN9SgsMXDvFTaPjbusCGR1B8Yyfj8Yb+hedq2CaNiah5IN8ZHpb3mwSQxtaaQ3wjJBD+DNK7EW427O9HXOMqBuzt1eTX0wnikWcGMGzJSZc1KBrgqOhV0e4nnkRCcYQxcSGhuqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252003; c=relaxed/simple;
	bh=f5+z/urWN18KpDb3NPBrCm05UiPH3MMNc7VsUg/Sv7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E31Mc8WpLwV5KAmqzFJlcBuf0X9XG4b8qW6CtuBmxmFcA2kOAjpGjVxL1mkoDoqRgwNc6kC6iDzKw2JQBmyd90Z/4HUaXSP70c+tbAfFWLc1WGA04syrKS8tie1rQ5PaV/WZOzJvm7IA1Jpk9KqV4vktDc1/JQInhy9uwHcNTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rLm4dJAY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rLm4dJAY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 11290201AA;
	Tue,  1 Sep 2026 10:39:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sC8SiCtWYc7Y; Tue,  1 Sep 2026 10:39:57 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6F21E20189;
	Tue,  1 Sep 2026 10:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6F21E20189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788251997;
	bh=QVhAnbOLAAflZPz0raZS/HocwXEYsGRuvIvb5hBKbVs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rLm4dJAY6CRlvls+u+2MVZPr0LPwXKMvfUyYkAeqtdn0muUTCa+m0NS9OY+fZGAGU
	 dSYHZHugvJYGhPFYtGEED4la7T7zm3KuaEhRksL6AjsWmwe+LX8zJBvvgCwWCdKSkc
	 xAGdxFSomuh3MhbnhaKwcRfpZ9XB/LSweVwfOY/hGmxnZUdrOBMw1pXmwry5S0K9hP
	 DeXUBKZbaY5sW8x1Pe8EfR5VgxEsjI1YldEdORAIpG+vRRC+Gh9y8tDdqgdXC4bI9H
	 +lDXRBJr4+kZU3hmfqo0SteZWmWh1DPjT7tBG8dIJ2EvvxR23qgwLP045HrVhCnj0F
	 SXaAsKHkKSAaw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 1 Sep
 2026 10:39:56 +0200
Received: (nullmailer pid 5844 invoked by uid 1000);
	Tue, 01 Sep 2026 08:39:55 -0000
Date: Tue, 1 Sep 2026 10:39:55 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Siwei Zhang <oss@fourdim.xyz>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Siwei Zhang <fourdizhang@tencent.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] xfrm: use hlist_del_init_rcu for state_cache
 and state_cache_input
Message-ID: <apaPW58bs4VcO__s@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
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

Patch applied, thanks a lot!
