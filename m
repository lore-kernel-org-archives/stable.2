Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D523E325;
	Wed, 14 Oct 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007950; cv=none; b=B6PKT40x6cD2tHk8KNGuB5aCkW8KDVZ+pySgYwfDU0y9/tuAq2BnVGXwYPQni9naOv+N5c7j/A8R/O5K0AlKOLICLVI9w5w9cIw8WG358wP0w2E08YzQlzDHcH85+rnPISiKScu/Nr+TTG+x1RCQdlBAIpfFuIXtB5by+gv3Vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007950; c=relaxed/simple;
	bh=cgvDACsSx3OYlBdbu4Yz6RdZtVaqIsMBtdbBv/xIn1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiWrQD5Wt3Oql6hIN8xSLGA9dQjwEu/SJ9+CLFpIvu3fkoad0gY1WJVShqCaDfBFET8cH0CaLmxUcCIKymrdi0hiLcf7ls1h7s8yURR5tjmqSDzIWz3Xo1SDNSD9ok1cswlZHCrCNAuFnXnq4iyfPB0b9RWLTmhEl85mI9f+9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI3k8wat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI3k8wat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783001F000C4;
	Wed, 14 Oct 2026 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007948;
	bh=pS/KNOJaK0AZwKUD/L/8m7QFZRj2fsRj82r/sdiQEWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gI3k8watXRl1bgsoF8D1kj8tgMgDHOarxvHetnoYH3vI0a0KBskOZLcuAS91+xD0B
	 E4ZW0IQ8Bd5pKfJJJL/VqPddPGXYuf0RsygIrATZNrc7GcgqqJ89q8npEBK3Bgnjq5
	 qocBMFEnvxYN8UxyOiDANY2jZeaMr7UME3Cfnzp3CoXDrCZdy4nYWJBdzAAcATTQ04
	 nGXbey6Pv+WCMyJ6TeLRfHXci52/YskTmy/K3PjXF+JjZRDBstnvgJYgMROPeucEg5
	 P7mZoDepEwAGp25Ibt/jdJqzkKSe8bcxjg88eQqZRyGmC2UsregIRaUdHwILSQA/Mk
	 zE244BSgVZOtA==
Date: Wed, 14 Oct 2026 20:59:06 +0100
From: Harry Yoo <harry@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in
 kmem_cache_destroy()
Message-ID: <as_eaUXfCni0sofu@thinkstation>
References: <20261014150844.8536-1-kaloz@kernel.org>
 <as_MPz_gXzkuGqFq@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as_MPz_gXzkuGqFq@thinkstation>

On Wed, Oct 14, 2026 at 08:46:56PM +0100, Harry Yoo wrote:
> On Wed, Oct 14, 2026 at 05:08:43PM +0200, Imre Kaloz wrote:
> 
> Looks good to me,
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> 
> I guess it's late to queue this to slab/for-next-fixes.
> Let's queue this to slab/for-next for 7.4-rc1.

I can already see this won't be a straightforward backport as
the code has changed a lot over the history.

Let's try best to minimize divergence from the mainline commit,
and let's backport to older kernels only when it can be reproduced
fairly easily.

-- 
Cheers,
Harry / Hyeonggon
