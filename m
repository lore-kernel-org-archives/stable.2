Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016C2C11CF;
	Wed, 26 Aug 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733742; cv=none; b=GXJUsaVQ0Cy0tiTYJ5CqD84ZisS3DveGwhcDEJPBj9jnEl3/rBXz0DVOqKEMMRbWoGeFtcmpBdCzmlTOApwtTtKGrf57sRktrC67jCzv28P7Eu1gnSMEiVT9vVYslKIPP8r4O6K6mT0H0FJflTwA9olPTOXbBAHO2V10UjDJ49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733742; c=relaxed/simple;
	bh=4kWSJqKQyjzOhb8vsHEqRzkVm4RtvJV/Law/ijV41jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiPbBAbSZPVazP+M0UvuWYrPCe8kP4DKYLYkcm4KZtyz8j5IOfEAtSn2PZHG07p5fFpo2ivMGdO2UNUO+ncAgwCLQMR5/1bsVaCUjuqJ2wp80hYop9rjao2eKAV44ePrHZ5Gf1iaTYXBCcJlp+Nticy9+ki2aXQ+D9136hSUxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTlJ4Wu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTlJ4Wu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE4C1F000E9;
	Wed, 26 Aug 2026 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787733740;
	bh=B87NBdQTr/+4nNDjbBWebVkttjgeA/nXGSCmd12w5so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lTlJ4Wu+M95u14eDIEgbeePfnTOioVhPOq8hrYMLclOeCve2higYszBR5GdoE7/Vv
	 eL4fXmw9Z4Nd/Wbh8O27k3Pe8jBrbJyZtqcnlPKKKkrWuvcgC6UM/Qd+V3kARn9O68
	 nQPgbAYzl2OG2/HiXhjvlDAbtrHUuxyqQYo4T6nRr8LTprhsRYpz4kmK76FoWFdfOj
	 PJTD1/WhoAccxq7HElCVcPqSakTnr/Oza9Pg7pu62svNrVdj64QvPC0w0cKIyJ5rzH
	 vRlWMlGlvBvA5T8BTWIyFLEaCVjzfH31lmo19uxx/b1scTA0JoQxz5s92GgkvcOWo9
	 Pab0i7KlNOBUA==
Date: Wed, 26 Aug 2026 09:42:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <ao6m1BQOpl5edwrc@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-3-vernon2gm@gmail.com>
 <ao6f4773bhQb-CtQ@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao6f4773bhQb-CtQ@gremlin>

On Wed, Aug 26, 2026 at 09:12:52AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 24, 2026 at 05:29:34PM +0800, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > After the page table lock has dropped, the folio can be freed
> > concurrently. The trace_mm_khugepaged_scan_pmd() is left with
> > a dangling folio pointer.
> >
> > So using the folio_pfn() before dropping the page table lock,
> > closing use-after-free window.
> >
> > Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  include/trace/events/huge_memory.h | 6 +++---
> >  mm/khugepaged.c                    | 5 ++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index 7b526528f85b..fa828967e1fb 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -55,10 +55,10 @@ SCAN_STATUS
> >
> >  TRACE_EVENT(mm_khugepaged_scan_pmd,
> >
> > -	TP_PROTO(struct mm_struct *mm, struct folio *folio,
> > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
> >  		 int referenced, int none_or_zero, int status, int unmapped),
> >
> > -	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
> > +	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
> >
> >  	TP_STRUCT__entry(
> >  		__field(struct mm_struct *, mm)
> > @@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
> >
> >  	TP_fast_assign(
> >  		__entry->mm = mm;
> > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > +		__entry->pfn = pfn;
> >  		__entry->referenced = referenced;
> >  		__entry->none_or_zero = none_or_zero;
> >  		__entry->status = status;
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 00337405c0e0..4e0fca5942dd 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1618,6 +1618,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  	enum scan_result result = SCAN_FAIL;
> >  	struct page *page = NULL;
> >  	struct folio *folio = NULL;
> > +	unsigned long pfn = -1;
>
> pfn_t please.

Disregard :)

With David's suggestion applied:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> >  	unsigned long addr;
> >  	unsigned long enabled_orders;
> >  	spinlock_t *ptl;
> > @@ -1780,6 +1781,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  		result = SCAN_SUCCEED;
> >  	}
> >  out_unmap:
> > +	if (folio)
> > +		pfn = folio_pfn(folio);
>
> And +1 to David on ensuring this is reset to NULL appropriately.
>
> >  	pte_unmap_unlock(pte, ptl);
> >  	if (result == SCAN_SUCCEED) {
> >  		/* collapse_huge_page() expects the lock to be dropped before calling */
> > @@ -1790,7 +1793,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  		*lock_dropped = true;
> >  	}
> >  out:
> > -	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > +	trace_mm_khugepaged_scan_pmd(mm, pfn, referenced,
> >  				     none_or_zero, result, unmapped);
> >  	return result;
> >  }
> > --
> > 2.53.0
> >
>
> --
> Cheers, Lorenzo

--
Cheers, Lorenzo
