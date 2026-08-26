Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF213B71DB;
	Wed, 26 Aug 2026 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733713; cv=none; b=LCWCzBqJlzWVpuSgntUeKceGev1izaz4DMe19eXFaSEe5S5UZ0wzR2VOiiqFar/C8yjAjNb8nefJ6LPItrTS9r+e9lslqKoMcxdChKSMs7COn8P6BI+QXmOqJpZape8aCfHvnVC9VeMKMAIPuhKhg66HJuUyzt3vWfEsv6620jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733713; c=relaxed/simple;
	bh=kq0tX0yydquROrSB1iVAB6rQkiO06N2mj9/x9h3ED68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3EYyKXJnbiwsBRQeu4Iw6aqGSaV8dy8wUckrQ7DdI4IMBTmL91sch80ZCqmoT8yr66QIbUmK+u5axa5JmW3NLDOm8iDQbtb+jnmPD7p/tvWroD6+Q7flSZAZ9Ee/cl4mPUUH/AEp+AdF93xAwDQghjQqzyLIJRnOAPtApiMI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwreYk+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwreYk+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430DD1F000E9;
	Wed, 26 Aug 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787733711;
	bh=0cadP6y+fdngFsaWBuCdgbwmvj6CFlss1lrEwgi5LSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PwreYk+qO4hSUjg/NtTqnARvQ6Fuid0F33c+ai+MzQlenyUC7YvlQgXHgbmZB5J73
	 O8jhWPgA2wXNHXMW+PAEMtSN9cjjg5NotFLwl+R7AQEiQSXOk3BcaDJqIYMJ2d4kko
	 6yhr4ECsNuzLieja/nhINegjq7tVC2emQGiCJkHIUZN84ecYcexp/hk9FNjjBy5tiH
	 vouDPju3AcpUBB40BfYgUxBi2nJOm5Wwzimy4S+31SmcSL5aces53ERHJJzOQoJLcJ
	 VwS1AZ65H1JZ7/77O1ieDPPvJEyaVDZTw3+3YUyZEHjiiz0OlN8/uwYe7zuLBgVddb
	 BG/GJ2r0UNmaQ==
Date: Wed, 26 Aug 2026 09:41:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 3/3] mm: khugepaged: fix folio is used after
 folio_put/unlock()
Message-ID: <ao6mjpuVwfqXvTyH@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-4-vernon2gm@gmail.com>
 <ao6e9RxwQ-KC1Ikq@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao6e9RxwQ-KC1Ikq@gremlin>

On Wed, Aug 26, 2026 at 09:09:16AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 24, 2026 at 05:29:35PM +0800, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > On the rollback path, folio_put() has already dropped the last reference
> > of new_folio. On the success path, new_folio is already unlocked and can
> > be freed concurrently. The trace_mm_khugepaged_collapse_file() is left
> > with a dangling folio pointer.
> >
> > So using the folio_pfn() before dropping the reference, closing
> > use-after-free window.
> >
> > Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  include/trace/events/huge_memory.h | 6 +++---
> >  mm/khugepaged.c                    | 5 ++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index fa828967e1fb..5fb4d92cfd84 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -211,10 +211,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> >  );
> >
> >  TRACE_EVENT(mm_khugepaged_collapse_file,
> > -	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
> > +	TP_PROTO(struct mm_struct *mm, unsigned long new_pfn, pgoff_t index,
> >  			unsigned long addr, bool is_shmem, struct file *file,
> >  			int nr, int result),
> > -	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
> > +	TP_ARGS(mm, new_pfn, index, addr, is_shmem, file, nr, result),
> >  	TP_STRUCT__entry(
> >  		__field(struct mm_struct *, mm)
> >  		__field(unsigned long, hpfn)
> > @@ -228,7 +228,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
> >
> >  	TP_fast_assign(
> >  		__entry->mm = mm;
> > -		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
> > +		__entry->hpfn = new_pfn;
> >  		__entry->index = index;
> >  		__entry->addr = addr;
> >  		__entry->is_shmem = is_shmem;
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4e0fca5942dd..24347f1a94ae 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2254,6 +2254,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	struct address_space *mapping = file->f_mapping;
> >  	struct page *dst;
> >  	struct folio *folio, *tmp, *new_folio;
> > +	unsigned long new_pfn = -1;
>
> Nitty but:
>
> Could we use pfn_t? I don't love that we are inconsistent with that.

(As before disregard, I was somehow behind on the times + pre-morning-coffee
confused :)

>
> Also the general pattern for pfn names is pfn_xxx so pfn_new instead?

Also since we're using xxx_pfn elsewhere here new_pfn is fine.

Therefore, with David's suggestion applied:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> >  	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
> >  	LIST_HEAD(pagelist);
> >  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> > @@ -2633,6 +2634,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	retract_page_tables(mapping, start);
> >  	if (cc && !cc->is_khugepaged)
> >  		result = SCAN_PTE_MAPPED_HUGEPAGE;
> > +	new_pfn = folio_pfn(new_folio);
> >  	folio_unlock(new_folio);
> >
> >  	/*
> > @@ -2671,12 +2673,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	}
> >
> >  	new_folio->mapping = NULL;
> > +	new_pfn = folio_pfn(new_folio);
> >
> >  	folio_unlock(new_folio);
> >  	folio_put(new_folio);
> >  out:
> >  	VM_BUG_ON(!list_empty(&pagelist));
> > -	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
> > +	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
> >  	return result;
> >  }
> >
> > --
> > 2.53.0
> >
>
> --
> Cheers, Lorenzo

--
Cheers, Lorenzo
