Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012B4E1414;
	Thu, 15 Oct 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055132; cv=none; b=RpaM0Cdxoyy1CsSZVJa6qo3eZk9AISlyrm9iL5SM4znP9JVnXUgs3R08ZfotEBC+ty3cMofui8mvUIw0UxOwd6RF9opuOQDymv64lDhPBeXYphUKcvIrokfoYOoQG8np/nQgewnl3FS711eQpcoBEt6yX8meVu2J+3Jcyz64EG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055132; c=relaxed/simple;
	bh=i3Iy2xLXR2x993pIXgHnMySyaQglTta+do5lmMI7ybk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJRTjHZkBVOUsq4CMXMI0nwtgxvfUTJC0bv0rdm9WuDCpFVs5V+Lh+NCNVl6HC4HiaXrrHNWORfdcbHev7eRobinEv6LfkPAtT+psLAkZbgxhq55YlDj0lHElMThPENERf9ItkM+3diejnqRrSmFsKLtFljaxJ+UVsJQmjJCaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjxGIpPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjxGIpPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B41F000C5;
	Thu, 15 Oct 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792055131;
	bh=i3Iy2xLXR2x993pIXgHnMySyaQglTta+do5lmMI7ybk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjxGIpPytUDCjf3oHieq1z2xj+WqtcBnVttFrOgOeGtnR4dXibxnqiymN9qUS4FVQ
	 UZcwaO9d5rTLZcjDX8/WxaJ0OPnfXjEwQbP4YTJaQISyEupwW2HCHUydxT2PUolM3T
	 E91G+9KoXO+i+UtEff3VNmqcGtiqf5oiA59PYznQqEJGTo45KIvOBSUpd59/jgc60N
	 cpudvdzDyKTz3G0wt6wK2dboL19osEtYvZbZMPQ2aLGuRfeyxxOft7bF+wspbZO6Zl
	 BasBxay/SBgmeCqOzjjzapcDi7ghmQlto+QvjvuIEvoKzBxtuCCsxhZZJjeG+SKwJT
	 8D2smjU76jMdQ==
Date: Thu, 15 Oct 2026 10:05:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
Message-ID: <atCUhtQ2v1WtNKwf@gremlin>
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
 <as99gyi-NUprRK6e@gremlin>
 <a5c6edb4-9e8d-47f1-a316-6627e518fa7a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c6edb4-9e8d-47f1-a316-6627e518fa7a@kernel.org>

On Wed, Oct 14, 2026 at 08:29:35PM +0200, David Hildenbrand (Arm) wrote:
> > Hmm really? Is it possible to do that without the hugetlb lock?
>
> Yes, we don't have to sync against PMD sharing if PMD sharing is impossible.

Ahhh I see.

> Will send that out for the next cycle.

Looks sane!

>
> > It'd be good in general if we could get rid of that lock as a whole :) but maybe
> > dreaming.
>
> Yeah :)

I will probably have to go and look at that more deeply for
mmap_prepare/scalable CoW reasons. I will wear goggles... :)

--
Cheers, Lorenzo
