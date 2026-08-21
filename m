Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E8435A9E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300290; cv=none; b=KFf2ZV9XdrNBvbUbdbPS+gvuiDyud50fwsU5PyeutREoNjHI1Z+WP3VPuw9aDoy/R7GeF+Lx6foW+d/XxwQsquhtTqOiLk5X6fxPPJ2MrqpjhwLXakDJSDxNnYG/up7B5o4dM1k/2fCp6DoO7YXjeCveJkBOqy7PcBoI3810N/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300290; c=relaxed/simple;
	bh=ErHixVMf1QJ0BI24Tolbk4imNQdj7Yzy526L4m7830s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfAbkMqVrIobsY+pX2uMAvFoM+BYepl9Y0CuuMD/UDYvsBUJ9OtHVB2eDV0M4eEftB/aco3G59sBYpPcm5q3Fu199X17n2U9ljPWbATmk8yaH+gGs8f7q2Uk3MZ7KjFd0oyqsqW3fs070lgtGkl5b4GiyI8jenCe7syszCK3kIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdxYv0ZN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdxYv0ZN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84874b52eabso959549b3a.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300285; x=1787905085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ys3Uj8kuRyrhvynwdvoQqOQA8x+KEUQJRwi9cjOxd9c=;
        b=PdxYv0ZN3zck7VuK2dRyTzROChiSPV1g1+qQSJQfCdtKbHT0qUYhY81Y3ZTn2xp9gQ
         DbU5PMIEMin7Ji641C8px8gXE3kA6Q6WrlyUjfiHOPYz0o/wxvLSlbEI9nziR4qIDpbF
         y1qn9KVT6sfQ+F6uSERJ7A2x6QyonUeTR65E0fG66NSo7DLt3cbHi0kXrPfpGx2k4F/t
         V5+gfOMtKBIb37RRrCwka7p6iicY/LW4lDJLC88vGsp1HcKGlo3MdaCr1mWHsj1bcxBP
         vycvivQxgGiLo5YnMB6KrmUTmY/2r+OxQRt1UG3ofbDxjXsTJl9/kE1oPFurkq9xTjtI
         VbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300285; x=1787905085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ys3Uj8kuRyrhvynwdvoQqOQA8x+KEUQJRwi9cjOxd9c=;
        b=S5sikvGqNLctfDRm0TU0eHPyQCSTYIFTN9qh9MOITGKu6irkgnVA/tvclqgAHQYY88
         uu7lkIZoxyEcy8YDidP4iaDG5u+Hmc5NuoSGsBD1UW87LbOvARcdUu5E6rBla/PB7TBH
         vExAdMQ1C03/Blatd+wcaOHLgzZf2OTpkH6TmcUSzRUVhGkcAZxqqS9aic0FxQuKMr5p
         K5C0yW9lJVgyusT1fVCHpoQA2c7R4oxM/PhZB0VAtttasVSigA4hNADqaXEz8nd91c3T
         eiJjwRWYWf+4vnwbXcfVeI5Skz0rZ+DORe+eUk24qse6tTty27Qg1Z2X7mlngnwgNBn9
         xl3A==
X-Forwarded-Encrypted: i=1; AHgh+Rp0gcWp8NAHheA1sA5ecMOm/GkaCHx07u2DXIvOMcSq71/T4uLMgMohf3Tv6qMeTqPYugalVpY=@vger.kernel.org
X-Gm-Message-State: AFuF++lvHGrHGW73RPo6VeOhXscWVbccpQp36lmlDYSMrJTFvD+M6w9K
	VblkyWD2Zyn54RDxMxW8OS/MBAy1YpUAvi1NeI+9ApCccWIwhCF/Jo9H
X-Gm-Gg: AR+sD11y2jxPRPWn6WHKp2kmeUYrTDh0zNUBKmpI/vOIfWfwMoIWY1FxOxq0egujaS0
	Hfc2qdKLKE7aP33kOWdkeXm5YpLCNnnRAe9Nt/YOFFkwJIIwmF40NkY2js0vJSlmD25b7bgyAm5
	3k2gN0L1Dklo/Cc4R3lx6gzrnmSph/Gf8nw/caTmHxJIQa4VzM02t/n/HZ1I1UA3zr1ysZC5DjG
	icAGMIvcwrMxmbNmTKh1BlPihYH9GtOTorS0/Fm59aTdXILu7JeWEaLu+CBuN9zPEg3QjVc8bgR
	l9x5AnrZ8h/Sym2cnnxgeCbucoDayl8LfeBSKd1280OhElmQHH8gbmWiegyep/muyGIgzhmgdKN
	fPjZlhXbpxHJf2issb47KyJHpzFM39DDgzLU7zd34y7KthLez8NMjj1FfhGh+mS0rExQREmQHw4
	9xc66tpOU0birCGQIFhEwPShTief/3jdROXiMd1D4unGp6ennef/ii/gOSx96DfpH5zzvdFS6/h
	jo5mSLu5+np/V2e1FU=
X-Received: by 2002:a05:6a00:ba8d:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-851fa018939mr7767261b3a.13.1787300284873;
        Fri, 21 Aug 2026 01:18:04 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3362860sm2564222b3a.8.2026.08.21.01.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:18:04 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:17:55 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <aedcacce-4880-41b0-a4a6-d892465fff57@gmail.com>
References: <20260815051924.194810-1-vernon2gm@gmail.com>
 <20260815051924.194810-2-vernon2gm@gmail.com>
 <aoMs79VDCnYvA9S7@lucifer>
 <aoMzkN8EfFllT5zH@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMzkN8EfFllT5zH@lucifer>

On Mon, Aug 17, 2026 at 05:23:30PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 17, 2026 at 05:10:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Aug 15, 2026 at 01:19:22PM +0800, Vernon Yang wrote:
> > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > >
> > > When the swap entries found exceed max_ptes_swap, the loop is left via
> > > break with folio still holding the xarray value that encodes the swap
> > > entry, not valid folio pointer.
> > >
> > > That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> > > to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> > > plain pointer arithmetic, so the trace event merely prints bogus
> > > scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> > > dereferencing the tiny encoded integer and oopsing khugepaged whenever
> > > the trace event is enabled.
> >
> > Hmm I seem to recall that we were no longer spporting !VMEMMAP SPARSEMEM, but
> > maybe I was imagining that :)
>
> OK seems some museum piece architectures are causing us issues again, fun times
> (parisc and some mips).
>
> >
> > But this needs fixing in general anyway.
> >
> > >
> > > So when folio is the swap entry value, simply set pfn to -1, just like
> > > exhausted scan naturally.
> > >
> > > And the folio_put() has maybe dropped the last reference of folio. The
> > > trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
> > > so using the folio_pfn() before dropping the reference, closing
> > > use-after-free window.
> > >
> > > Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > > ---
> > >  include/trace/events/huge_memory.h |  6 +++---
> > >  mm/khugepaged.c                    | 14 +++++++++-----
> > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > > index 291fae364c62..d3572d4ef453 100644
> > > --- a/include/trace/events/huge_memory.h
> > > +++ b/include/trace/events/huge_memory.h
> > > @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> > >
> > >  TRACE_EVENT(mm_khugepaged_scan_file,
> > >
> > > -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
> > > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
> > >  		 int present, int swap, int result),
> > >
> > > -	TP_ARGS(mm, folio, file, present, swap, result),
> > > +	TP_ARGS(mm, pfn, file, present, swap, result),
> > >
> > >  	TP_STRUCT__entry(
> > >  		__field(struct mm_struct *, mm)
> > > @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> > >
> > >  	TP_fast_assign(
> > >  		__entry->mm = mm;
> > > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > > +		__entry->pfn = pfn;
> >
> > I wonder how easy it is for people to interpret that this is a PFN of something
> > only in the case of an early exit.
> >
> > It's a bit of a mess that we're exposing internal implementation details like
> > this, quite honestly.
> >
> > I hope there is no expectation of this being there indefinitely.
> >
> > >  		__assign_str(filename);
> > >  		__entry->present = present;
> > >  		__entry->swap = swap;
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 617bca76db49..e7830761d3a2 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > >  	int present, swap;
> > >  	int node = NUMA_NO_NODE;
> > >  	enum scan_result result = SCAN_SUCCEED;
> > > +	unsigned long pfn;
> >
> > See below I think we should drop it.
>
> OK we can't because of museum piece architectures that will actually deref the
> folio to get the PFN...
>
> I'd startr by initialising this to -1 then since I guess in theory it's possible
> xas_for_each() could just not do anything is it? (folio is being set to NULL so
> that suggests so).
>
> >
> > >
> > >  	present = 0;
> > >  	swap = 0;
> > > @@ -2720,27 +2721,23 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > >  			 * PMD-sized THP implies that we can only try
> > >  			 * retracting the PTE table.
> > >  			 */
> > > -			folio_put(folio);
>
> I still hate the idea of moving these outside of the loop, it's just asking for trouble.
>
> So I guess instead:
>
> 	xas_for_each(&xas, folio, start + HPAGE_PMD_NR - 1) {
> 		pfn = -1;
> 		...
> 		if (xa_is_value(folio)) {
> 			...
> 		}
> 		pfn = folio_pfn(folio);
> 		...
> 	}
> 	...
> 	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
>
> That way you avoid the horror or moving the folio put somewhere deeply
> unintuitive and inconsistent, and maintain pfn lifetime for some arches nobody
> uses.

Thank you for the reference solution. After studying the overall
process, I found that the above solution still has two issues:

- When `!folio_try_get(folio)` or `folio != xas_reload(&xas)`, if the
  next `xas_for_each()` iteration happens to terminate, pfn will be
  incorrect, which is inconsistent with previous versions.
- when the `xas_for_each()` iteration to terminate and the folio
  operation preceding is normal. but pfn will be incorrect, also same
  issue.

To keep it simple, I modified it as follows. Is this OK?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79effd3f3da4..00337405c0e0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned long pfn;

 	present = 0;
 	swap = 0;
@@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			continue;
 		}

+		pfn = folio_pfn(folio);
 		if (is_pmd_order(folio_order(folio))) {
 			result = SCAN_PTE_MAPPED_HUGEPAGE;
 			/*
@@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		}
 	}

-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
+				      file, present, swap, result);
 	return result;
 }

--
Cheers,
Vernon

>
> > >  			break;
> > >  		}
> > >
> > >  		node = folio_nid(folio);
> > >  		if (collapse_scan_abort(node, cc)) {
> > >  			result = SCAN_SCAN_ABORT;
> > > -			folio_put(folio);
> > >  			break;
> > >  		}
> > >  		cc->node_load[node]++;
> > >
> > >  		if (!folio_test_lru(folio)) {
> > >  			result = SCAN_PAGE_LRU;
> > > -			folio_put(folio);
> > >  			break;
> > >  		}
> > >
> > >  		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
> > >  			result = SCAN_PAGE_COUNT;
> > > -			folio_put(folio);
> > >  			break;
> > >  		}
> > >
> > > @@ -2759,7 +2756,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > >  			cond_resched_rcu();
> > >  		}
> > >  	}
> > > +	if (!folio || xa_is_value(folio)) {
> > > +		pfn = -1;
> > > +	} else {
> > > +		pfn = folio_pfn(folio);
> > > +		folio_put(folio);
> > > +	}
> >
> > Hmm kinda hate this you're now mixing clean up logic with some trace logic.
> >
> > You have to go check out xas_for_each() and see that xas_next_entry() sets folio
> > to NULL at the end for the normal case to know this is OK and then figure out
> > that this is just for the break cases.
> >
> > That's not intuitive in already not intuitive code.
> >
> > And this is a patch you're wanting to backport to fix a bug too... :)
> >
> > I think you should keep the folio_put()'s where they are for now and limit this
> > fix to the trace code please.
> >
> > I think you should drop the pfn var altogether and do this far more simply, see
> > below.
> >
> > >  	rcu_read_unlock();
> > > +
> >
> > Stray newline added, let's not do that for a backported fix please :)
> >
> > >  	if (result == SCAN_PTE_MAPPED_HUGEPAGE)
> > >  		cc->progress++;
> > >  	else
> > > @@ -2774,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> > >  		}
> > >  	}
> > >
> > > -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> > > +	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
> >
> > I mean maybe better to just reduce this to something like:
> >
> > 	/* folio is NULL unless exited early. */
> > 	trace_mm_khugepaged_scan_file(mm,
> > 			(!folio || xa_is_value(folio)) ? -1 : folio_pfn(folio),
> > 			file, present, swap, result);
> >
> > As the least invasive way of fixing the trace + limiting the contageon?
>
> Yeah as above this isn't right.
>
> >
> > >  	return result;
> > >  }
> > >
> > > --
> > > 2.53.0
> > >
> >
> > --
> > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo
>
