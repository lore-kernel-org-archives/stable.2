Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFC2236F2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712432; cv=none; b=fuvderzdYBNXX01V9G2FKgI9lnL6O+8IcsL5gXZpWQuxqylUQkHWNjbYTEpoynwymoNGW8wEU+iNuIU5Z/hbmvoyTHHDZHF3H71wSc7xrqagVpTBdu2WAeC8KhRFH/1RFlSeoYHsFhI5pBSMrZlvLURQb0HvpKGQ5rymwJ8ww44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712432; c=relaxed/simple;
	bh=Y7OFSIE1C5x6wy9pAT/XVG0PnAxS+TAlPJRa4dX5TnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKiPjrLknBaMt3dy/8O4rZx7joj5voGGZ+qVT377SLaiWZZllMl28AaB8r+UwRxaacB3sKMDS1a1LFqMT6t6s7Zpio1LxIfMPCGtTFGNWi3nxLQOoRs4Juyx/ouGEfnGFS1nX8br06tKgFDzJZfJcLjeRw3kI9p8n1WK+IFocTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9pogLpE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9pogLpE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbeea240819so353723a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787712430; x=1788317230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXjvmi8viN65x79krJkouz9aQjeT14YyvTaCF6GTZNY=;
        b=L9pogLpE0LtsQMy5i56xEVmewsl2kGvKBUbDeYHON1NuzIw95hLx1ArvQdqr/CCCLo
         Uw+yc68t/ls7tJpT31tE38H3PODNhNxK4JcFvpvmQxeZ5lRq0ahrIQKse3cJbSfiM3Qw
         F3vxB/WoN0iS+9Nl3ofhgKQbGauo0KlKQ8cjcsXcYVXytU15Mo/6Gfy47jKhLlMu7fIa
         tx9+0nUamOHMSt1NMpQPkw/Hs1WKSVWTXWQ1KEMfmlWMSx/f/4UoYNc91V7H4QbbzKrk
         KLi4f1H9XANlhN7jfV3KgZeiWmEp/bodBdV4Y+GvZHELmRTObSdqbIIT4b2p8aQxlpq8
         Evow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712430; x=1788317230;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXjvmi8viN65x79krJkouz9aQjeT14YyvTaCF6GTZNY=;
        b=HltpbZr6G0Oq3aNQ+KcXU5p2moJqC0vbDHOAGyU3Skuur2RRVO/kI3SmXlkxmKgVqT
         gsFsSgnUo8FRNnkg2wnrwFONVaWwNxxnAVilhft9f57tVg+4/cGKMbDfqb+Dl+KtMi76
         2HiiN6vqWEL6fW5Ff5wGgI6KWHbqccFStQ3nJ4z2SND4B3FLkItlRMpdUEAnFO2lrHi5
         uq3xdq/+sEoGXDyZBuTMXYtLvT9rwv/J0Rbz+ICd4Q8CBXl+TWd3SOa940D2zCw5eyjy
         QrXgpQPQtpqztKtXiTpaDKvWoxmAFOVvY6ZZI/vAwkdgRuG3+YsRO7kPS2thEL2IlNk9
         EV3A==
X-Forwarded-Encrypted: i=1; AHgh+RqKLw058RW7ssWpOEPIjhSsSxCqTAioqTpOUvpQFfqOmFYXJWFadglCQQnGKb4nkRH4AHEKNFk=@vger.kernel.org
X-Gm-Message-State: AFuF++mB3b2tqb97r/M+cVyeumM5v9SOlIn2NIJqfmGxggXHcansDFS2
	FScp7zgUjoHm9c2F6qLnnNz7gMCagH2rKeNW6VRFx/kZD56TwwzS8Wca
X-Gm-Gg: AR+sD128i+xsntZzsA+RlTStlFzKWvk4S2QO3atX8PNdeNivUy9kOg+Zyl/6WoQNVut
	a45W1yyoRn/bDO6RwgrnDAj/Nf6J/pY05aej3XvJnxwb/E1DPm79+9q/VB6DSsmIhJpS2cFiCLN
	KXIaXQAxja7/QGpTzZzw9z56Avhv5FS7qXpAA/oYVG4h18J/GuKqDrcRbp2IT9CGrEDGrC6PRaP
	oI1cTYAJr+9oUVYBrci1hvZn8oJ2yn7Qj6uWeQ4SHo82AgxRIhLr3dMWorFvBawxNm8VEgf0Xw6
	JGTfIda6+5mfOrt6wTELdPYSqxqgqNq5YbI1RVfURpM43OWcobOA3RdHtXI65uVMScwp8Yd2PrT
	mCQH5EVqLNqxLrpp8s63jnjtsuMMx6/DBBINgbtwxh5MFzB3VSwv2HtovniWRB8Wry1lkGGDRuX
	NrOc8KhpTGr+8QhqP71obSwXEJDW9XRNJNdPL36aKw1CQjQqD/HP2/KHYZa6yIUbp8SdB++CIZa
	Gg=
X-Received: by 2002:a17:90b:4b04:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3966d5f900dmr7209602a91.8.1787712430105;
        Tue, 25 Aug 2026 19:47:10 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a573a1sm2053380a91.14.2026.08.25.19.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 19:47:09 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:47:03 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 3/3] mm: khugepaged: fix folio is used after
 folio_put/unlock()
Message-ID: <50049af3-ff42-4017-a535-aca124620087@gmail.com>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-4-vernon2gm@gmail.com>
 <8001afe8-84e4-43d4-971b-b23f72070339@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8001afe8-84e4-43d4-971b-b23f72070339@kernel.org>

On Mon, Aug 24, 2026 at 01:59:53PM +0200, David Hildenbrand (Arm) wrote:
> On 8/24/26 11:29, Vernon Yang wrote:
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
> >  	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
> >  	LIST_HEAD(pagelist);
> >  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> > @@ -2633,6 +2634,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
> >  	retract_page_tables(mapping, start);
> >  	if (cc && !cc->is_khugepaged)
> >  		result = SCAN_PTE_MAPPED_HUGEPAGE;
> > +	new_pfn = folio_pfn(new_folio);
>
> Why not set new_pfn once after successful alloc_charge_folio()?

LGTM, I'll do it in the next version. Thanks!

--
Cheers,
Vernon
