Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422364;
	b=mr3b12JnbYhzfPwpcVtBgbIgg77b4BjNMdyXJ/NicuRJoVXlW1S5f+pjHBTD/Fx7vw7t
	 n94qUco7OxnOpGpSN5l6uu+WP0h9uhxT+C5QgvPndTdRmT0ivikO1qt9AQeua3Y6MrzCm
	 W7hsKpCchwgM/srSWqRUqxLwUCE3go95qZ013tDfucpk8+w/r8914VMvYm5dGNZ0NG4Wa
	 71D+hw9t+vKcH8M24gPqUyT42t8JTqkWP0UCkdjk2f354c7d862Repxmb9dkktBxzKgC2
	 K0hxB3vXqGC4an6KZHDCK0iErZvLXWJVN5snEVzeW42zYQjjxl3QGWMrEowfGeRrKbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422364;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LRAIfcX6+TdrX9n5/F+l2/1/bdd3k5f7+8neSB5hSIA=;
	b=5gudHbiMrqWPIUbfsBrpfn7sLJvPHAu0QwMOJRTyIZDNMK/a30HedoGV5keR5WdL5FpV
	 PXeMcVurY4erdJfuhz+HoFGAYNu8BWN7K6WCS/SIXiJWkW1vDjSk83PAZ13enUgVZ5bxM
	 Vw1VXjuUi5qN8YrAD5iapqfijyd7E43CI4956YFnSutAQMVD2Axii8en1i2nWaTDY6T4y
	 UoNdqSPQnLTU8D2tPKDzrS3qJvSinta81q3dx/Pt/A07CwjV4MJ23S3zXpEJxf5kQD4MK
	 9DfzdOY9BEtVRwE9a0CX9Is/LuHw4lFijqxKF47uEdatF78JvIXciU9iuUI5wk2OJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="ic+37J/+";
	arc=none smtp.remote-ip=91.218.175.111
Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160A606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C160A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ic+37J/+
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2gpjyCxlXHV0kojP2zZzDz+9fWvH7WUFDk0I4A7ZOo4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794422360; v=1; x=1795027160;
 b=ic+37J/+PMNglcZ4O6GYMCFRlVhoVoVzwDw1G1hNEFe33rP4lI7o2VPyrhiNLm7OMduH99Zc
 JujJ2y9jwJHfRxjzfA45Asz24HLAPqfsgPq6vzdGsKB3a2x/GZ926pdBgKMVm1VWvktKWv30q99
 kPA8m5W8zklVFd9Dd/y9VZOY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9920d73fa52f55d7;
	Wed, 11 Nov 2026 18:39:20 +0000
X-Mizu-Trace-ID: 9920d73fa52f55d7
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a hardware-poisoned subpage
Date: Wed, 11 Nov 2026 10:39:17 -0800
Message-ID: <20261111183917.1093166-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avRqaatdOUunxrcZ@gremlin>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 13:18:36 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> On Wed, Nov 11, 2026 at 03:38:29AM -0800, Usama Arif wrote:
> > do_swap_page() checks PageHWPoison() on the faulting page, but the
> > large-folio batching path then maps the rest of the folio without looking
> > at the other subpages. A poisoned subpage that is not the one being
> > faulted gets mapped anyway, and the fault that would have reported it
> > never happens.
> >
> > Skip batching for such a folio and let each page take its own fault,
> > where the existing check catches it.
> >
> > Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
> > memory_failure() sets PageHWPoison() on the subpage first and only sets
> > the folio flag much later, and the bail-outs in between - for example
> > get_hwpoison_page() losing a page lifecycle race - return with the
> > subpage marked and the folio flag never set.
> >
> > Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> >  mm/internal.h | 15 +++++++++++++++
> >  mm/memory.c   |  4 ++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index cd3675c044e0a..e61c02f4019b0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -28,6 +28,21 @@ struct folio_batch;
> >  int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> >  		void *buf, int len, unsigned int gup_flags);
> >
> > +/*
> > + * Check every page of the folio for HWPoison, rather than relying on the
> > + * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
> > + */
> > +static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
> > +{
> > +	long nr = folio_nr_pages(folio);
> > +	long i;
> > +
> > +	for (i = 0; i < nr; i++)
> > +		if (PageHWPoison(folio_page(folio, i)))
> > +			return true;
> > +	return false;
> > +}
> > +
> >  /* mm/workingset.c */
> >  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
> >  			    bool flush);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d477a4f986bc8..4b7d456332200 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
> >  			goto check_folio;
> >
> > +		/* Let a poisoned subpage take its own fault. */
> > +		if (folio_has_any_hwpoisoned_page(folio))
> > +			goto check_folio;
> > +

Hello Lorenzo,

Thanks for the reviews!

> 
> Hm, isn't scanning every single page in the folio potentially quite costly
> here?  I thought the point of batching was to improve performance overall?

Swapping in requires checking every subpage, so there would be a cost.
I guess trading it off for correctness :(

> 
> It seems broken to have stuff potentially interact with hwpoison but then
> to only set the folio-level flag much later?
> 

PG_has_hwpoisoned lives in the second page, so memory_failure() only
sets it once it holds a folio reference, otherwise it could race with a
THP split. If get_hwpoison_page() can't get a reference,
memory_failure() gives up with only the subpage marked. The comment
above folio_set_has_hwpoisoned() in memory_failure() says that is fine:

  Don't need care about the above error handling paths for
  get_hwpoison_page() since they handle either free page
  or unhandlable page.

But a large folio that is briefly off the LRU, e.g. isolated by
reclaim, takes those paths too and can still be mapped afterwards.

> Also why are we swapping out folios containing hwpoison pages? Shouldn't we
> migrate away from the hwpoison? :) (I'm not really familiar with the hw
> poison stuff)
> 
> 

The error hits a folio that is already in the swap
cache, e.g. while reclaim has it off the LRU to write it out, and
get_hwpoison_page() fails for any folio that is off the LRU. Normally
memory_failure() would split the folio and isolate the bad page (for
an uncorrected error there is nothing to migrate; that is soft
offline). Here it does neither, and the folio stays in the swap cache
with only the subpage marked.

While looking at this I also noticed that the fallback drops a freshly
read (not yet anon) folio from the swap cache and frees it with the
poisoned page in it. We should actually actually also check folio_test_anon()
before checking folio_has_any_hwpoisoned_page().

> >  		page_idx = idx;
> >  		address = folio_start;
> >  		ptep = folio_ptep;
> > --
> > 2.53.0-Meta
> >
> 
> --
> Cheers, Lorenzo
> 
