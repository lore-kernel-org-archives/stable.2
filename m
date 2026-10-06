Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD23B058C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278032; cv=none; b=VhN4v2ahCiMPdIwS2zVovv8Fy06lG2cuu7oL0UqS+2OB8IfIcoWT8PC0s9pUM+ZoHICoFFA+QXrx5UhcM4fOhSem58lvnEqiyIiHXgdn25STH0aM2qbZhe8vENSOrv4Uuyikk1EIQSkbu6sfcnsgbO1/M4sTw384i2Ju4ovcHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278032; c=relaxed/simple;
	bh=Uzht/gnnalOdKMOxMXIuqX3WZTTWDv2ShAnEFEPyhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdDnKDJGQ6tCRIC1t2sCKA8MfzPrgAL35HQoFZp3MfUbOUOzXhUWYVIVoYU0PopfNYDfjd+QVrqA9wwEnCjUyEj6fvc0AKh95vCkfHTv/H1rGb22Wq4GJ0k2YGYKzv/r/uO+3I5HzFhE2pXTV8Vojj4smFEKQnV7YwasB6cxaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=MYzNnMS7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0MmQS2y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="MYzNnMS7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0MmQS2y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B34514000DA
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 05:13:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791278028; x=
	1791364428; bh=MbQD73+crd7vZ9QKN8oet3vSF/p7ePpJtz6mLHHA2fo=; b=M
	YzNnMS7ZN3wVSn2vEjszZQBWv/gqXaybvo1BuDsA24Dv1uYKul3eMDqRHrZ59TYg
	NtM50AO+2d+0tzTVAU8OZGJhydpPVoNghkJc6ctrvMtP9EcrTenBLFhsNRfnOg67
	RqkkUsqnJdYW8sHuIzL7LEnGDIoc2B1w6eHmwBTOuGI8Yrtx+KV8Ft3Inr3t2qFa
	cmQ0UPhjVoM9AtN09FGMYD/bskoWSGztPDBUg7ez1AI6PJ+n+vgaUitsJZ20jDnw
	Pe/caucJEeirWsGMsWpFyxJ8Pqluw2Sfqcnri6h6Ub3W+QEklscvlFznQdE+6CNJ
	vu9LN2nfJAerHb7zCSJSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791278028; x=1791364428; bh=MbQD73+crd7vZ9QKN8oet3vSF/p7ePpJtz6
	mLHHA2fo=; b=e0MmQS2yZZ9YatnShEldHczseY8u/Cl142cD7PJEap/5ee30t18
	cCTSQo64oi7NTKBxMWcwM/uwx6zKhYqpjpRQCbL+DS9qTZO8p++CpZm3pFdqy7z1
	m7kGmofudCFATpHNN69DDVYLq0DwBrc+S/Ie7OEPnHE8/LVSZEeFOcmcRUrHyU4V
	Ql2v7l4P5Xr/uAZoJizz0kUFpRNcHPnTQcb36QMhJJDFRnBKolVvdqNbUkQJ5oJF
	6oCn7XckLLuZovW8XclyLNFekxUGgiKqvb75kr1iavPEcP+HZAHk11IKxIALmO+L
	1cPbtmpZr+zsoHTgt6n1yYYbteAZ1PWanrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791278028; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:c+cXtAfd1wjM9/gvlD3O5qKk3rQ3pR75yzrb9DvAqbWXhp/
	m7it7EXZd8NiTUOI5aTLO49OVtaPs7vLzyHPc/TyVppfTRk79No4S7XSXNNcRfRr
	sdB5rD/ZTNXRp6wtXfRRvkC5iBCbjENolqT4qv3zQKICgwlcZYiC3arwHg4QcpzJ
	gvkammcM5uWDvteVL8B903YQQRRxSl6gBcaR2VOxA6CVmLAHXSFTCc/GQvJlVNfq
	LxUsj87pQV7zh38HBNCntDIZR4E8t3Po81WCXaipF9b7yUyqMFeTzyslBsJETqYR
	G1CSYBMkx5cfUSVXt6XLjh07kF/BX6/b3ixVKlw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3q1TEc8G3uI4UoP5ag6eEF2ixUYiG8Gk1JdkBHKwrdA=:Uzht/gnnalOdKMOxMXIuqX3WZTTWDv2ShAnEFEPyhKE=;
X-ME-Sender: <xms:zLvEaqVNCUxN4ccW14K2KFK0QXb49TzWtFKDF2X0Q3dK_3wtar0Awg>
    <xme:zLvEao9zRkn-NMYh0yjfoAD29xzWXLWX5GSiXabJIt3o3C8UJEVvHM9Qg9LDpmAwo
    l3ibLGfyyBYHdjVTJNh3BlHf_naNTGXJX18e7MHyrO6S291WwAYPac>
X-ME-Received: <xmr:zLvEanqvOAI6cptylGAfXrbHpne4ZOfMbXDqHxPDhrfTykLquREzv-kMKB4>
X-ME-Proxy-Cause: dmFkZTGj5C67xIbzcGLTgoQok/07Sc/orEjUInqIagiNX5tzfNrUnfY1jc1lLJwh2gzo3d
    GB698lLckGkQyvrNDBFvobDZ3AKW7HlEJvdeuEuAlIxo1NdMYrrrtakWUQIQiEjBN1B6ri
    wKi6qEUiJkKlNVegjOAgd0kUGjoPwR2IgA2mVnAWW8VbDla5+6eFmaorfJUN0WOYRndIYz
    ROX+4JJqCmnVpPn32jhHBxpZJszOIgw5BxKJ/vniHlQHUTPspDkZn8zhQw0awtlwixI2g3
    ZQGvwVpHDDhkkyRNR5r0tSVt1oN1XUrc8PaZB0foWj2F5PK6JJDPxdNR/3G99Mnb2qvrMU
    c56mQJWj6ObswPBB90YvyTCtHf3ox7HVMuKz78cItUQKSFqXMvsOUzU1YutPwP6Vp0EtNg
    zvaHKJI42l7V9TJ0PtV+gPEm3VW6l5/XgGbg2LEQIqoNJRWGFRPjO6mVeUFvHnf0OZ+Y/f
    4U0nHEL2QJASnnhk7mRiDdptzT/IKVcoui7jBiKWondtSYcFEB2DTr9KCNiVa0Et8B7VNL
    CCwc12rO2qO9rgrLt9TDix40u9rQecSgc6cc+ZDifD2hr4+OZ8aP4oavNuhISU7/obNUNe
    ypS3e2WxOARZDzI/ev8A/xhnLBLFoVPsYk/rnhA+zd8K2PQGzyCNC4G75z+A
X-ME-Proxy: <xmx:zLvEakf-Avx6HemUgYgNU-z-6nJ1Dj7h71J20c7xNyFzfY5K1YmJmQ>
    <xmx:zLvEam8XoTo7jDk2JIPuEvKlekuwb2Wra6wbYoGndj0ziiLHy6V3Jw>
    <xmx:zLvEaubjvbvOevENtcRI8NnnvuQGwAnSNAYoy3j7xxCeaAi3M-bfsA>
    <xmx:zLvEah1DQVwbKNt_l8_s6Ds1zH6SXTER3iNUcEET-o_Lok2Q9bTT9w>
    <xmx:zLvEaphCg6igknTLamJgXfAoRArks9hx9dtkfEUFwPqBRd26TKKctBxG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 05:13:47 -0400 (EDT)
Date: Tue, 6 Oct 2026 10:13:46 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Harry Yoo <harry@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <asS6uQPZY_9r2uUG@thinkstation>
References: <20260929174553.175333-1-kirill@shutemov.name>
 <arv8J7ysrdazJmfY@thinkstation>
 <ar0NRMxps8UErXaQ@thinkstation>
 <ar0Xbs9mEu-vUHvc@cmpxchg.org>
 <ar5rOHWwc_iPJF6C@thinkstation>
 <20261006081050.GA234057@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006081050.GA234057@cmpxchg.org>

On Tue, Oct 06, 2026 at 10:10:50AM +0200, Johannes Weiner wrote:
> Without counter indication, I would prefer to keep the tighter
> guarantees. ISTR this mattered on some of my ext4 tests in the past
> with the buffer locking.

OK, v2 takes the priority floor and the COMPACT_SUCCESS retry limit
from the requested order, with the explicit promoted order folded in.

> >     Should defrag_mode treat MIGRATE_MOVABLE like ZONE_MOVABLE there and
> >     move the page out at pin time? Ideally we might want to move it back
> >     on unpin, but it can be done by compaction too.
> 
> Should it even be specific to defrag_mode? I suppose without it, the
> poisoning from fallbacks would dominate by a landslide under
> pressure. But these pins can mess with compactability long before
> becoming capacity-bound.

Agreed, a pinned page in a movable block hurts compaction regardless of
defrag_mode.

It can make longterm pinning more expensive, but it is the right place
to pay the cost.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
