Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C2330D2A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577843; cv=none; b=WQo+dBo7CyW2Nlrdi8c36ZIHqEW22aN+nT+QOeSzOm+MvkiOj9FAb3Nv18+iS2Ow+W0pYOEVnA7gk3kHG3+rKfnvjxegdW3ukLpMJV/xZZp95u4bY3WoIGCbmBLu1InLwZpHgyrkwCEafmcG9tvEyimk7tjSfViAqB0Op1NAzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577843; c=relaxed/simple;
	bh=S6sTPTSALV5TVsWCXeAxXPZhY5YPkKcV0So5jf/Xvl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufDA5DLbCAmZ3BpHcStFA0ahs7m7zwy6RhKPELG+abiKRSF2hRUocZRBVnjq/73iMRK51CqFawU4d61r8QeYCBkEXIzXhTr0WSkWsQvmOM36B/AHX3W9XWvIbhX7l9ZlNxLxMeEtXEQSYoeexGRkdNcMEPSfwuwqfA/vGiQ47b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEaHrRGf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEaHrRGf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84861fc51f5so4822697b3a.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577841; x=1785182641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0B7Ue8sunnZ4lhynaJhVBIqW08g9nfoJaXMan4+HMrw=;
        b=sEaHrRGfT6Xf2Xo9APtBOma8lK2YOyEaUkrBU98PwiGaXaK+OkELDOxwveFYmXozfX
         hnITH854K8hGrVh96EuThTEOuH83IkqsXZjt4iP19xCyiVx3EKQNPV2Ob9ye8LhkG3/N
         W2FJ+dFF3OZngI68LzM4Gliec3CUoDmBiazEzd4w2jJOKTzymgIntZpBzUwfjDwNum1G
         L7UUFK/a5ReqUpDWr2l4X14zsI5/WJV+6hU1qfQ5HEhrlkwkt5rv6XIgDvK2DxWa37M9
         HlE7o+Tf4m12kb1aeAkCV2A0pIdN2S/6dRI/XQrSDqEq4d6RrGjAiPWH0boIcSK+g4M6
         fICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577841; x=1785182641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0B7Ue8sunnZ4lhynaJhVBIqW08g9nfoJaXMan4+HMrw=;
        b=PD9cxpb3XYApQ4TXAhONlMVzk/Pd4+aE8WmHyszlHVJXwsim/Ys9Hh89bxDJrsGklh
         cFP7EalhFxI9yIjxn7D/baWIufgYP9yrxeIxV4Cy8AQpZlLvYTdKg1IQzGO/yLdHJbMy
         ScT7eL+zskzd65xZ3eScLBcRvSF1A9+CqXktuGYm/LVMRdt2Al+t4hpMGxYOlYVLsmdb
         hZAjXWG4defD4FZX/BF9ewWdw/ErKHjFG6vSaESySs4q29pNWUY7ZBkd92D+6NQ0Q5rY
         Scz10pzt0uBcVsSy4ZHBOvaCbQj6artBVAAD+4wVk27+2L/rZW0njxHa66ehUsapV8u6
         nILg==
X-Forwarded-Encrypted: i=1; AHgh+RqqkJygchhIb5tXVy7hKkSulwfpeyGa9He1feDs8kWMDB2+PZoixMLbOyuV12mwqqbAINzlrpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7O4ySrn4zOb0GZhvkAjNgdnicoiaIcXSIaEBFRVCdXwPer0J
	zcDzzorDmYtU2s1Qg4QnTSwCfRj76LMr+N3jCsMM/UGvEfLc8bz/yRCE
X-Gm-Gg: AfdE7clOqmtvXjhfLZmcaJWmd+keGH/7nM5hnnTVw1+H5SE0XrqZTBaqZ9hNYP6l+96
	cGSDs0u++bXw7rOUQN2JyQcQ0Zp2187O70tdI6iRPFMAp6rMe6uZe2e7WjBoTMFRlQH18w943jW
	dCrAm6YFykyX0H8XLgHUN4K4wmZTJtczJGrcN1dP9KfgbW4LV+3OS9K0Za+nBnjDPGKjFSnAgXD
	+hJuh+ReU1uFNKsjN8ZsxWToKxLxKT36zgdkPDcHOjihBc5kZPxPPabMvX3S+pU6mmniuF/7Gfl
	QYNmrcT+W98Vx60sl1u+qt9HWF1l4STRFWY24bGPxQ1vPn+8940t+nsAqxroc1MllijvxnENJGD
	QEja13T8WmkyvhXlfByZSeLObnIsbApWxthPGf2qk1JtJqc4TedQ783z2kU5rMmZ61pLP707qcX
	C6fugaVBz4rd1u5N8mztm+I2vhBZFXkp/GTg==
X-Received: by 2002:a05:6a00:92aa:b0:848:3dae:66e2 with SMTP id d2e1a72fcca58-84c2933dfc2mr15708445b3a.26.1784577840929;
        Mon, 20 Jul 2026 13:04:00 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9af7esm5860115b3a.52.2026.07.20.13.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:04:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:03:57 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al5_Le9QlD4zlt25@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5-fDRStgU6gjk6@fedora>

On Mon, Jul 20, 2026 at 01:01:00PM -0700, Vishal Moola wrote:
> On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> > When splitting a large page in CPA in __split_large_page() we allocate a
> > PTE directly without going through the standard page table allocation
> > routines such as pte_alloc_one_kernel().
> > 
> > This means the page table constructor is never called nor is the page table
> > marked as a kernel page table.
> > 
> > The former results in the folio associated with the page table not being
> > marked as a page table (__pagetable_ctor() is never called thus neither is
> > __folio_set_pgtable()) nor are statistics updated to reflect
> > it (lruvec_stat_add_folio() is never called).
> > 
> > The latter issue of failing to mark the page table as a kernel page
> > table (ptdesc_set_kernel() is never called) is far more problematic.
> > 
> > Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > tables") kernel page table freeing has been batched and since the
> > subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> > for kernel address space") IOTLB cache entries for kernel page tables have
> > been invalidated upon being freed.
> > 
> > Since split page tables are freed without this invalidation, the IOTLB can
> > contain stale entries for them.
> > 
> > Resolve the issue by using the ordinary PTE allocation API at split time.
> > 
> > This results in these kernel page tables invoking a page table constructor,
> > and thus requires a page table destructor.
> > 
> > Since we cannot assume one is always present (early allocated direct map
> > page tables are not marked as such), we conditionally call
> > pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> > otherwise we free the page table via pagetable_free().
> > 
> > Regardless of which path is taken page tables marked as kernel page tables,
> > which now includes split page tables, take the correct route through
> > pagetable_free_kernel().
> > 
> > There is a user-visible side effect in that split page tables will appear
> > in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> > allocated after early boot), however this is a positive change.
> > 
> > This issue started being markedly problematic after commit
> > 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> > choose this as the Fixes target.
> > 
> > Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 301fb9e77d91..a67ca33b9dd1 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> >  
> >  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> >  		list_del(&ptdesc->pt_list);
> > -		pagetable_free(ptdesc);
> > +
> > +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> > +			pagetable_dtor_free(ptdesc);
> > +		else
> > +			pagetable_free(ptdesc);
> 
> Lets not introduce more folio-ptdesc crossovers, we're trying to get
> rid of them :)
> 
> I believe pagetable_dtor_free() should do what you're looking for on its
> own anyway.

Actually, looking at it closer, maybe not because of the conditional
portion? But that makes me think it might be better to just replace the
ptdesc_clear_kernel() with pagetable_dtor() in the free function...
