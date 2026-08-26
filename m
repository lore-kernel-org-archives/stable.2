Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF3202F70
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712295; cv=none; b=GuhwV/wakuvD/caVCku64QWB1XYjQ5nul0NphJHAmnYtCzMeAH+D88Pnl1OTndIh6+X/UqB+DJcf0nmmkw17ELYBHhIpKTXN598JEFj+EokHHDsxuU0Ab01ycsy2o0rB7/qUrOWdmhAGxZNP6U8AW3E2Z+aRC6Pwiu7GewV+MLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712295; c=relaxed/simple;
	bh=1JWUaBF49CbL1v8enwBF0KoyvX2JrPm6z+oaUkUIvx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU3XRnYu1BoGKeEsQApfg+yvWbtWnCgGyMbB75FxyNV3/9skLCJCVDqKP8Z1oh2ZzAqECeAWFxG+1WBsmnC3BmKcpWIc4tg+jCw/rUf0iVxvXKCzZIrxkT6vjbkrnOBWhV9hQYR1nHfzqeilcqxhmjR1DxHVjWdwAmBOuar6c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBc1uKHd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBc1uKHd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6af66ca14so5869685ad.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787712292; x=1788317092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cA8BuFbVdWVsPxBHUcYsv9jfBYLl6xZCnqzfAhivzwc=;
        b=tBc1uKHdXm5P5vz39E+Z7EAyOisvhoDGESBumTBoq5NUUDJDAACWOb1RRDsoeYbJCl
         2uA0kOXoTR68mKM5FTaWSOoh0mg5liiy/CV4/UKWzCD6MYu/gE7/Qmk9W3qPnf+Ef0oo
         aYCqbEpuan6IzN/dInM2EXqXGnTtTBldIC8p+NerJQzL5nGUzhAdG0z6XgJtMZA9Wag6
         4dddqTUyPLQgwuB8JIXLWotiAy/GjGPKU0PjaKfnV14C/JBm+lnHW3xGWl0Ua6MDllBB
         EILEKXsIMlc3D2deRg8gOvdgk9rQ5r9gp+n0MheMNkDGNj0aPO6o8rs8Llsl8W5h+cM9
         GMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712292; x=1788317092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cA8BuFbVdWVsPxBHUcYsv9jfBYLl6xZCnqzfAhivzwc=;
        b=oW7RJ1dwwaEu4W4NLSGrGY4uE3oTt9ZWHJfEtdklH4X/hDoNlNqPbUzhAl1BpIPSTo
         UFsCcXYZ33dBXdz0x88B39o2nusRotNFpqSS7dRrfj1maiDw8bICpgHfYguJUaJbwasM
         UXmud9aYZRqBjIrcAJHiNMKhnSRN9uQOtjii3VEX5sWmT7OD5hNjm6fxdDj4gGPssrU0
         JDFMgSm1U7wo099OliJlIL2tnS/EXCZKfzjxVnFxEiRWIEZUYep6fuOkuHzi/Cri0S29
         AVfj22c0odoDqso7enrsvBto81jMY2DLDKsn5/Cb9o4xxE/Od0FeKNFbHyyEee/ViLUF
         UrRg==
X-Forwarded-Encrypted: i=1; AHgh+RplZnQpkLD+i3FropCLW86ckXwW1QT3+O4iASg92RblxPsoYPOPpWlr6/KFo+L/LNLr7zzbykk=@vger.kernel.org
X-Gm-Message-State: AFuF++nbpTAbVQeL+5Q+AvLetHsYsGrOYIWexr8e+fXTtg+mSkd7SdRf
	GxsIXrbhsuhH1FU6v9rof3SNDjeNoD+c+LYF5AsReIOF+eK1syU5psGM
X-Gm-Gg: AR+sD11OiLYtqBliGqksGFz1billxRsW2XB181f4PzUmRb4KwoeM8z3NnyHxJBJytRO
	ocebK6DCoJ8vwvKZnj0ECumaCTlgjEJkP0XBwLsIAmmhIF6eJ+6niOK8uTNm+L4sUE7coDGTs+u
	bEZbPyt/o1xhKGwzGaYxkyEoPyzkPWFjlLqk7dz9UOyhCL979ylRPoD7/ey06bxF2XwMO+cn0SR
	yg7ZemWaGqbdiW5PZ6tNeSgqEQBa8dcwLlCp8SgTdwggb4Wp2LWqUquMU2CEoOCFRoP3nFi8H4f
	MVj9e9NduWCfwTKskn6txQ7lDrcgI2LN+fv08F1sp1IHgDSMOovcBaDAb8g6dKgNyyXjY/RfSzP
	oipVlGTQvS56WLy9T3Z+arUgdYwz1eWx9fkh51TqGwtESZWAzDiVpB9fei9UZCFG7wILsyUIFZb
	/l+9MgkesyM0094M2vM3+PRiy5I2iZgtiZ2ib+Us0L4JNhu9mO4Mt0QouyTVtOTmaTiaYqBNwIw
	A8=
X-Received: by 2002:a17:903:120c:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d707aaad36mr41806225ad.8.1787712291979;
        Tue, 25 Aug 2026 19:44:51 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704ba5ca3sm3296535ad.41.2026.08.25.19.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 19:44:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:44:45 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>

On Mon, Aug 24, 2026 at 01:54:18PM +0200, David Hildenbrand (Arm) wrote:
> On 8/24/26 11:29, Vernon Yang wrote:
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
> > Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  include/trace/events/huge_memory.h | 6 +++---
> >  mm/khugepaged.c                    | 5 ++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
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
> > index 79effd3f3da4..00337405c0e0 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  	int present, swap;
> >  	int node = NUMA_NO_NODE;
> >  	enum scan_result result = SCAN_SUCCEED;
> > +	unsigned long pfn;
> >
> >  	present = 0;
> >  	swap = 0;
> > @@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  			continue;
> >  		}
> >
> > +		pfn = folio_pfn(folio);
> >  		if (is_pmd_order(folio_order(folio))) {
> >  			result = SCAN_PTE_MAPPED_HUGEPAGE;
> >  			/*
> > @@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  		}
> >  	}
> >
> > -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> > +	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
> > +				      file, present, swap, result);
> >  	return result;
> >  }
> >
>
> Shouldn't we just reset PFN to -1 at the beginning of the loop (and set it
> initially)?

When the `xas_for_each()` iteration to terminate and the folio operation
preceding is normal, but pfn will be incorrect.

If we just reset PFN to -1 at the __ending__ of the loop (and set it
initially), then the above situation won't occur. If so, I will do it in
the next version.

--
Cheers,
Vernon
