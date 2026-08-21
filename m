Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5539890A
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300368; cv=none; b=GyQ88QkQPjb7yBfR2xpVXbOd24wjLOImTDTydOqoLw0tuDb7OD0FLOFMtdiNJKQnxjbqbk0MNhwzlcyZdi/Z2POogIMMeT9rnWgz8kJCk+2Gni6g2mx1UdHVA1Rrj33OakevPkUlYAw04z84dSFVtpU3tRvYwFFYVNku+0vU8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300368; c=relaxed/simple;
	bh=7IYOKQHnRf+eUCm70nBAatamYiIz53y0hAqBgYLgpPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqf0PVypkEAy6fzLcufff0fdrRkJULuqJyB1Z6pfPpFdPF/vIr6vGEoIoKYtTE8DZ08i9G+FcLdmBNGLP5iSv0s97MDEkGnr7nzrD7FngLBS+5x8+pFKHAio08cIHMVWUqku+9RBTT9PeehWxAc1H5t6JSFxB68ow6JRXIDGTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPIIL+IO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPIIL+IO"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caed617615so8385485ad.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787300367; x=1787905167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lhXuBcyJmXYpDqWCX/Ojyplzefto48/xHEW5jp//TXY=;
        b=mPIIL+IOnFBCoZaNNwAqg0hbOyO5RbY0LDJZXxvQENf5dh81OGr5o8F2/dUYkpx1Jy
         caNiKLZJyJUuVsuI8WtbbHLf0V1xLH27KBae4enbspiWZjQE2CufSDMghfna7JbYV82X
         y5GBBC//9BeD9MUTdZo6VU8nhhp6YKQE6WPMQMLfSqBHi9xFyIWIPK6S7PHjmNQRYJSw
         FjHXa1cCLqm+w+sOcaWVNLjE0NdGj8rRgWGxRa8udMfDVrPYz7h3qRsfV6NyiGgo3g7E
         iLrvfz77Lpq17rGngDSaoUPDtrbIe8sO4sEMJYN1FCMjWXiM3O3w7OdbmBOcZ3JOqhNU
         hHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787300367; x=1787905167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhXuBcyJmXYpDqWCX/Ojyplzefto48/xHEW5jp//TXY=;
        b=ERizW27QogkTbdxHLLLWpa5moJcUYwsKbtE3juqyj7RO75/WOI2eFbV6JN5Os52mFU
         RgGThsM2Z0XPAW/5EY8sY7B9/0EWUAGUIuvicY5cXDiQTkMIKCdyiEdTRJE4cMJBNuqL
         vNkIwt4mWdIGze20Is4Yqx1qV/pdyKlS+5d3pC1cgjksaEu5ERif12sRlmsKiQRaMkTR
         EHhewt00I4bksLjAtAraXB2bPdGuNnitzRxFRGIvJVpYKe7fqfIs4sRh9Rx2t3Ba7Jur
         bwtIuKRWpHnOpmY3120FnlX03qwiok3u2gcd+dywLt9J5nFPJhXKlw9oSJXR0knRfbkO
         TSRw==
X-Forwarded-Encrypted: i=1; AHgh+RpVmM1LTVDYsYL9jto7RFbTnxvhgkS/UwrlZsVVBqyj4xkG/YhUMRBEVrlZw5FwvvAfRAn7uBA=@vger.kernel.org
X-Gm-Message-State: AFuF++nZA6X6fPN1a155h8vCLdaY6ND8ghGaNqqSKofBcCpGvl+IWlTP
	l1XKH81OkA2Pyr3wyKGVzCzvSI1erJARcH+Y7PZdgeqLNEQO5xJJOoMJ
X-Gm-Gg: AR+sD13o9CghK9rAPxAJGgncZKclE7uTPT3BmrUAJbhSYXJzXxXgOadiGLxVbqCBIuR
	Lh7LgXIKEsxrZ9e4laWU/ZtxrwBjyTHGzeRJB1neOJ2fLOB0k/hVfSfjSp3Pbk9V575XikR+thi
	eXKYhBf/7U2+yg7wv5Sewx1gGkpCYZtP/OKsCyNOZO3r0FNzvA1bGutzcvwznB62dYiU29E6CVo
	3lcjxEbQML/FGX1VwEjJzcqngIZ7Vbrx8Ym9Qe0IfkDUumSu62dsQwUrl0CAP7HHa2HpmUIwL/T
	SzmYe0j9e9Iq8rOUeLGpG/i+EejY1NVDZC3+7fSXoZXTBv/nbONMYvclsrfFqsDhRmi1QOKEIi/
	Sb8wlL7O8c7GzUPRO0qMoM+jiIvUkvR9svq60zotuaK7Me64HkWi9AUt9e5ZIjYes4NdD456NF6
	IFmdBzPxazbXG3IAAHCxCkaT2E61jBd32lS6BRCIffMklZlAMdRZJPoWt4kY/q/dEJkPGwTJRqg
	iM=
X-Received: by 2002:a17:903:354b:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2d64ade4a69mr92013265ad.2.1787300366663;
        Fri, 21 Aug 2026 01:19:26 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e15fsm16222015ad.45.2026.08.21.01.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:19:26 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:19:18 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <10f5d327-d86b-4971-9344-ce29f40f8955@gmail.com>
References: <aoMynfFI2XK2UXXN@lucifer>
 <aoM3BJE2mGmHZybs@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoM3BJE2mGmHZybs@lucifer>

On Mon, Aug 17, 2026 at 05:33:40PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 17, 2026 at 05:12:01PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Aug 15, 2026 at 01:19:23PM +0800, Vernon Yang wrote:
> > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > >
> > > After the page table lock has dropped, the folio can be freed
> > > concurrently. The trace_mm_khugepaged_scan_pmd() is left with
> > > a dangling folio pointer.
> > >
> > > So using the folio_pfn() before dropping the page table lock,
> > > closing use-after-free window.
> > >
> > > Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > > ---
> > >  include/trace/events/huge_memory.h | 6 +++---
> > >  mm/khugepaged.c                    | 4 +++-
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > > index d3572d4ef453..5dc71d292f47 100644
> > > --- a/include/trace/events/huge_memory.h
> > > +++ b/include/trace/events/huge_memory.h
> > > @@ -55,10 +55,10 @@ SCAN_STATUS
> > >
> > >  TRACE_EVENT(mm_khugepaged_scan_pmd,
> > >
> > > -	TP_PROTO(struct mm_struct *mm, struct folio *folio,
> > > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
> > >  		 int referenced, int none_or_zero, int status, int unmapped),
> > >
> > > -	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
> > > +	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
> > >
> > >  	TP_STRUCT__entry(
> > >  		__field(struct mm_struct *, mm)
> > > @@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
> > >
> > >  	TP_fast_assign(
> > >  		__entry->mm = mm;
> > > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > > +		__entry->pfn = pfn;
> > >  		__entry->referenced = referenced;
> > >  		__entry->none_or_zero = none_or_zero;
> > >  		__entry->status = status;
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index e7830761d3a2..7c8c48577408 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -1603,6 +1603,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> > >  	enum scan_result result = SCAN_FAIL;
> > >  	struct page *page = NULL;
> > >  	struct folio *folio = NULL;
> > > +	unsigned long pfn = -1;
> > >  	unsigned long addr;
> > >  	unsigned long enabled_orders;
> > >  	spinlock_t *ptl;
> > > @@ -1778,6 +1779,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> > >  		result = SCAN_SUCCEED;
> > >  	}
> > >  out_unmap:
> > > +	pfn = folio ? folio_pfn(folio) : -1;
>
> You already defaulted the value to -1, better as:
>
> 	if (folio)
> 		pfn = folio_pfn(folio);
>

LGTM, Thanks!

--
Cheers,
Vernon
