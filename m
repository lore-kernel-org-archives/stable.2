Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492139C013
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577667; cv=none; b=tNYnZ4H0eQaWs+2AHy9qQlJZKLXE708fMRxbEM0rm5SGpqLl1VX6Dx4e6Um520rPOhwv8f5NpjeQi8yB+Ap66otcRC1NeM0FqGV7mqLCUmbtRaYcyBjRgzeY0cOIY6uKPhWAP2UE5z30vDsMd33PgCZA/QIfYx8IJQBBjYZQdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577667; c=relaxed/simple;
	bh=fh9vsor5ESw9tLp2QbVw66m9no3crF0ZgJPINwiuibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaWZIVJRmuSD3fJqOGc32SkFBN1Q9GCvvVp+f9UbZRyJ6o9xqelJZj3TV5Q5WVGcWx3DtHlSn1KUT03gaTEJwYCh+JN66cgUJ7tEikghl5g96OZJEn30iS8SdKFkdtsDtlDXl3ku0XBTtnycrz2IGf8z+MiDS73xMpCB5OIOY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNGx2EFx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNGx2EFx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caf228a910so83083365ad.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577664; x=1785182464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHyzRN69SIvrGhU2BxqAEaCwqvk6nXUkdLyvQIyO8KI=;
        b=fNGx2EFx5VYsI6m9bznuyz7JMhaK/Au0F5/obxysK7ICslrtdkC44k5C1k3E+B/ylS
         MwQc/BTnhJftBzU6NLIGD3obrLUQq3PjhLVayYMRlqCbYvL87YRb8WRGAQ4UHKN9TcOf
         GddUrVsZa+DMJFG0xGsDiJ3U+9x+cQs5wA+KIjySAaTUWZXmqyed0zC5DbNWnEt2tjAR
         n6EG0zXj5Svs7rTm8H8Rlf7zwO83h1qSxdCd2vnP6C6C4sgORf2FJwmQrPV2QmyPgSg2
         zSHbW42cYZjFbWPNVE+T5X77IajV843s+C12VFHvnm3PUwIDlHtuHMlUh8c3zhMT/WCd
         1Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577664; x=1785182464;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHyzRN69SIvrGhU2BxqAEaCwqvk6nXUkdLyvQIyO8KI=;
        b=Q9XmgV8IwlCov5JVzHRMHRfOsPJhLHQqYlY745ms0PL1gDfJr6yVlspGZ3fegRvftH
         ajpMtKdIP6nUUKGWcLKO3c9ZfWL8AM8lzHVUwblHUYjRw8PCQLUNze+HwlUXA49i/Ivy
         jTZnb086UW+0Vo29o/iBBzJZGFWpw/G7o1OsCeyd3Mig3HtaN2OPccIp2v7vEXPa2+km
         DbkaLxPA+JtnYaF4cxVQiREAgw/fB5yDuA9vXAIaa58W2YepUrFUUMY4oDp05Jnh21wz
         9fkmwbxyjIYbgyAhuEKo9GvALMjwQ4mxhnTHwfDsJEznRSfqnTgtQX8tZ7oJy0ZLYWYN
         aiuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBSm8cVwUcEN7+isE54vXmTx9kveJrp8myraRcfsl4kpnR27/R0jAuLo8NHokel31zCZ93FtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwamX1sI8Htc09ls9Z5XvjirQ9R1UBg1M1zOhHYn29GilUSI7A9
	73vkngbAQYO3VAJgOjEC/OeSWC6emWaK6tOq8tq4LNHpZ0wiG+QWj98+
X-Gm-Gg: AR+sD13E/+fxOPggjZq+YaIYbk9ep3UFvdjHcLEe4CVtV/EnuGFCi0HNb+Ghqu7+Cqj
	f3dMZ6Y60lhaLVbPbe/bpgzYusCJ/q0hopTDhhlBiU8suDB/7I6uVrabGtUh7Fv5GEc71/jEKKO
	2kx4406xUW9GXOnhWb9lBdcffqOgkXTZ30XYouJ15IBuyvJ4A56VL1O/vbkXvubmKiB4xVlENfn
	t71dekF3GyYIzgnNlAnHagVpNRviElPMGN759dmFVhn0tcqvWBN4POKY1VVLn0RbbCUoXnqyzZR
	u696TeRn662qgGkOVa/LyT8G9jhGcK1OhvdQJKRRofGF2yswr4pf0Om2A+dfFg2io+y0GpnQaKr
	NA71mbgN1aqrY32mEebI37TfprHj0N0nzO45An+uaXu/Qoty5gsFXhwF4uyMTmfAUZuULKfSGYK
	YTnuiXwWgSTan2nSd6xQqr2GZ02P95o+IT/g==
X-Received: by 2002:a17:902:eccb:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2cf3496204fmr169889025ad.24.1784577664139;
        Mon, 20 Jul 2026 13:01:04 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476f70esm61611825ad.77.2026.07.20.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:01:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:01:00 -0700
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
Message-ID: <al5-fDRStgU6gjk6@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>

On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> When splitting a large page in CPA in __split_large_page() we allocate a
> PTE directly without going through the standard page table allocation
> routines such as pte_alloc_one_kernel().
> 
> This means the page table constructor is never called nor is the page table
> marked as a kernel page table.
> 
> The former results in the folio associated with the page table not being
> marked as a page table (__pagetable_ctor() is never called thus neither is
> __folio_set_pgtable()) nor are statistics updated to reflect
> it (lruvec_stat_add_folio() is never called).
> 
> The latter issue of failing to mark the page table as a kernel page
> table (ptdesc_set_kernel() is never called) is far more problematic.
> 
> Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> tables") kernel page table freeing has been batched and since the
> subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> for kernel address space") IOTLB cache entries for kernel page tables have
> been invalidated upon being freed.
> 
> Since split page tables are freed without this invalidation, the IOTLB can
> contain stale entries for them.
> 
> Resolve the issue by using the ordinary PTE allocation API at split time.
> 
> This results in these kernel page tables invoking a page table constructor,
> and thus requires a page table destructor.
> 
> Since we cannot assume one is always present (early allocated direct map
> page tables are not marked as such), we conditionally call
> pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> otherwise we free the page table via pagetable_free().
> 
> Regardless of which path is taken page tables marked as kernel page tables,
> which now includes split page tables, take the correct route through
> pagetable_free_kernel().
> 
> There is a user-visible side effect in that split page tables will appear
> in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> allocated after early boot), however this is a positive change.
> 
> This issue started being markedly problematic after commit
> 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> choose this as the Fixes target.
> 
> Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 301fb9e77d91..a67ca33b9dd1 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  
>  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>  		list_del(&ptdesc->pt_list);
> -		pagetable_free(ptdesc);
> +
> +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> +			pagetable_dtor_free(ptdesc);
> +		else
> +			pagetable_free(ptdesc);

Lets not introduce more folio-ptdesc crossovers, we're trying to get
rid of them :)

I believe pagetable_dtor_free() should do what you're looking for on its
own anyway.
