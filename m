Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629C1A680C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831343; cv=none; b=oJmORDogPYT60eJlVB6rDy0ujJeCNYqZNmYj/+cHZE05q5OUEKOFWhH0xb8shm9hZdV80cPKe4i+/BYz/KY/nf07cH3fRKqymvscZNuD1QOR2HhaWhFlnvPREuDLU1JlV5m1Nlu/UKN/wZmtBn3Lkc2uTnw8IonduJHv1WZWDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831343; c=relaxed/simple;
	bh=E43FrjA4l42t+5NpLnk2/0+94HCbH9n7qhxyUYC4Dqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uis/JfJKwAHDA3JSLxijcC3GRU3c/Li2ahuKTKLAYXtERn9IoCe1UbxJ6RNKBEZbp4/4DoU0G+DLi4MEJdVfAMp9/Y2G/Wlfj1wRFhVAUkU6FGPTed+bD3jeWWNOju70t6YyMbMm7ud07IFOTlKKnittL2fJohb2FTC9YP2yWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swfZ8pvN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swfZ8pvN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398e9698a70so3524646a91.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788831341; x=1789436141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+ILT61+yX00t8m/Wo8aU1Ak3a6FiC5+l5Al1tpUFdU=;
        b=swfZ8pvNrJKvyMj9mw/5IAJOrEK7y6Y02PHv9/pXTT18eMt1g/G+yBbZcBep65fdde
         f0lnKHcSi3deAwYrooxWD4+uP124v/Uk3F2oJQED9v/fZNyXtBn+s5pdpnrlSUF5fIPD
         xpFr812S3QeylwBQa1lbW/LORAQLMakOkKF48LpHoZ96HsFEwKoO+w3mfmb7S5mA/cWD
         RTnywL9t1P3DQzp2UWo0yjRw0SyWRaPBvVC7yAIOyShZLdpDMf9KWeNhhU2TkGAum1aw
         DGP57OnXAbP3LU2Z86mZQgRHrHoQe6NAUxuTapTF3RDyiSLiI6CFhxVg1X7sQeDqp+qX
         4B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788831341; x=1789436141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+ILT61+yX00t8m/Wo8aU1Ak3a6FiC5+l5Al1tpUFdU=;
        b=TDGRzz3xT8RPblcSQJyEqyE/Evp3bG6ama/pSUJmlzUIX7WXvypFLFnTyTea7PKqmd
         j9+TpbyagRCgA+7j/1X4xTMTUT2h69LMfdUOuWzpLEbV5uLxxgj2T82MkwOuLsWc2gf+
         v28eBonSPkLR7Wh7dFo90kiU01HEoYbz5jyy8s9BOP4NEZ9YiU237k0Y3yuVhZBX3+BT
         yvrFe7dzgbJiY5YM4FPeiEY3TAkjbKMsaKKSs02Gx44gz2/7RThW0XoeXOExxveH04t+
         JLimokrt2A31zOJsiI2NknyRFNK4ajk59sMvJFFbWZU0gdSdYIRYo+68kybO52O9Bo29
         phlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxPtCcB5Rdu/ZfVb7Vp5z7SrY3xCWfG16/TpZculrkfPpLPinSTPoKGiug2J2OJS/pm779oK0=@vger.kernel.org
X-Gm-Message-State: AFuF++l99CqsugEOAxVgHQytc3bh5Nqd4I7raiF/+nmNTrFXjPvSjdG9
	shwl4ACcZJ/HNVQrosOlplIwJByNmI/qdUQ4rkjzyBsKwZRe93j70eNO
X-Gm-Gg: AYBFou1ZYfUYiWD70Njsb3ujZOKG36iKf6tZaHlpyfW6b3Jb5ygeRmDGJ49haALc3J0
	GOPyXwR72TSDLpTKlP05H93tcAb4iI7R60yFBAPphxxYuMgfGFS55CcGg8/uO9q3pShLyWl0TAJ
	4rWprMb8xrhdNjIWg6kGuG2jJfCWWzupaBGN9LGum9vtVjf4/kIooiVir+ltcaVJe/kI4xZjU7z
	jtBETDzM5USiscdG4mvBShY5zTor0/ozgBEHbhgtm6RqdhHDta2Bsfoz5slDp5kaEcSeLP1jDWr
	Vv1B1DuIE3fN/nB+manRQfzeqrL05FPZEKrgizdwD4JpQXPg17AjL9ip/2whG1rTTXuirpQCR+L
	RASfN9nxQmT8iawQY12SjW4elit1OJphWYw4hZL9rb+/JiEg5gcAYRlBFM0MSYSRCpGyhX+QKm1
	avCoJwtb6LKdFZV8jepq5MKIHXPNi9OEX8nW1sSCNE+iBSxTK2MtGEubdDymGHtmIAJow54zscH
	4o=
X-Received: by 2002:a17:90b:33c1:b0:398:9bd1:3214 with SMTP id 98e67ed59e1d1-39b262dfa81mr36200845a91.21.1788831340752;
        Mon, 07 Sep 2026 18:35:40 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm23586291a91.15.2026.09.07.18.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 18:35:40 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:35:33 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v4 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <047c287f-bb00-4672-9ab8-3323cbae8f2e@gmail.com>
References: <20260828055926.346744-1-vernon2gm@gmail.com>
 <20260828055926.346744-2-vernon2gm@gmail.com>
 <53f3afde-b5a7-4c2e-b6b5-8c844d1b6c8e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f3afde-b5a7-4c2e-b6b5-8c844d1b6c8e@kernel.org>

On Mon, Sep 07, 2026 at 02:25:57PM +0200, David Hildenbrand (Arm) wrote:
> On 8/28/26 07:59, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > When the swap entries found exceed max_ptes_swap, the loop is left via
> > break with folio still holding the xarray value that encodes the swap
> > entry, not valid folio pointer.
> >
> > That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> > to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> > plain pointer arithmetic, so the trace event merely prints bogus
> > scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> > dereferencing the tiny encoded integer and oopsing khugepaged whenever
> > the trace event is enabled.
> >
> > So when folio is the swap entry value, simply set pfn to -1, just like
> > exhausted scan naturally.
> >
> > And the folio_put() has maybe dropped the last reference of folio. The
> > trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
> > so using the folio_pfn() before dropping the reference, closing
> > use-after-free window.
> >
> > About calling the respective trace_xxx() functions separately on success
> > and failure, refer to [1].
> >
> > [1] https://lore.kernel.org/linux-mm/ao6jVbVHLUmuY2UA@gremlin/
> >
> > Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  include/trace/events/huge_memory.h |  6 +++---
> >  mm/khugepaged.c                    | 11 ++++++++++-
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index 5a48c5406cce..7b526528f85b 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> >
> >  TRACE_EVENT(mm_khugepaged_scan_file,
> >
> > -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
> > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
> >  		 int present, int swap, int result),
> >
> > -	TP_ARGS(mm, folio, file, present, swap, result),
> > +	TP_ARGS(mm, pfn, file, present, swap, result),
> >
> >  	TP_STRUCT__entry(
> >  		__field(struct mm_struct *, mm)
> > @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
> >
> >  	TP_fast_assign(
> >  		__entry->mm = mm;
> > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > +		__entry->pfn = pfn;
> >  		__assign_str(filename);
> >  		__entry->present = present;
> >  		__entry->swap = swap;
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 75639298efc2..b597a3e68606 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  	int present, swap;
> >  	int node = NUMA_NO_NODE;
> >  	enum scan_result result = SCAN_SUCCEED;
> > +	unsigned long failed_pfn = -1;
> >
> >  	present = 0;
> >  	swap = 0;
> > @@ -2715,6 +2716,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >
> >  		if (is_pmd_order(folio_order(folio))) {
> >  			result = SCAN_PTE_MAPPED_HUGEPAGE;
> > +			failed_pfn = folio_pfn(folio);
> >  			/*
> >  			 * PMD-sized THP implies that we can only try
> >  			 * retracting the PTE table.
> > @@ -2726,6 +2728,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  		node = folio_nid(folio);
> >  		if (collapse_scan_abort(node, cc)) {
> >  			result = SCAN_SCAN_ABORT;
> > +			failed_pfn = folio_pfn(folio);
> >  			folio_put(folio);
> >  			break;
> >  		}
> > @@ -2733,12 +2736,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >
> >  		if (!folio_test_lru(folio)) {
> >  			result = SCAN_PAGE_LRU;
> > +			failed_pfn = folio_pfn(folio);
> >  			folio_put(folio);
> >  			break;
> >  		}
> >
> >  		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
> >  			result = SCAN_PAGE_COUNT;
> > +			failed_pfn = folio_pfn(folio);
> >  			folio_put(folio);
> >  			break;
> >  		}
> > @@ -2771,9 +2776,13 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  		} else {
> >  			result = collapse_file(mm, addr, file, start, cc);
> >  		}
> > +		trace_mm_khugepaged_scan_file(mm, -1, file, present, swap,
> > +					      SCAN_SUCCEED);
> > +	} else {
> > +		trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
> > +					      swap, result);
> >  	}
>
> Just curious (maybe Lorenzo suggested that?), why separate out the SCAN_SUCCEED
> stuff?

Yes, this is the approach Lorenzo[1] suggested in the previous version.

[1] https://lore.kernel.org/linux-mm/ao6jVbVHLUmuY2UA@gremlin/

> When result == SCAN_SUCCEED, failed_pfn == -1 no?

Your understanding is completely correct, and I explained at the time
that this was redundant.

> We set failed_pfn now only when setting result ...

If you prefer one trace_xxx(), please let me know, and I'd be happy to
send V5.

--
Cheers,
Vernon
