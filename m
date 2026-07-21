Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F242D746
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627150; cv=none; b=ETfz1tR6VeFxg+RAbiyPVk3CqbQoeEHruHZDwm/9HK8bhY0JwqjJnSZu/EWzXnOhaoJs4RdhvSZGbHJ9V24N4zWCrbTrNYcrcvs2+PSU7ausInhwxSr3ifrTX/xjFAdk7S/TXaFeWXFkvJ3PzKOItaWMUjZ0vw9DHvF9lzzZlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627150; c=relaxed/simple;
	bh=Sqx9Im1HASTcqkv7NqQM1Fv6UhjQ0/wjErEc7Em/n6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppSWTELVFtYiYMuimqMYl7gGWJGy5ieBMgjdjrmrRhCT8M2pm1lM3Qk4jAJz047ep5h6gzUMXPuwsp8DEyyO3C3VlcSZ3Nlga129f3Akt3ha4nXM+VgJpqhuAdgHObbYC0Vv6lcTbGGGqyoFjbQXwpkFi/IdFt+4Ta701LzMKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+0m8bsS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+0m8bsS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so138605775ad.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627147; x=1785231947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BlAqH8OpzhDNUGaMI/yhdZ5tSuc+jcqv1mstlCTQxyA=;
        b=L+0m8bsSyRxpMXcLbuoKbPLVxjuRKw/70gAeG1KZmwiD/T4UT1c8JP3LBY+LznBtV4
         xBdzu9P8sBGkn9doNX+k+6oVkORHxmONZ5Xa7dm/nFd7BDYpScXj7VNzJu7iFkdyDA7N
         xZ8QXKds1y94291FYQwMfA+/qcqHKMulaVF6cagrbmHCjgtZvOffKhe2sC3GJOyh1++f
         Ht7AkRzYLSZlXUInMZlUob5BWmudS5Tq7IO7YYiNQ6kPFCJzUwuETb7gveNZBJkk5heI
         pf16kWCgTycmSNjRXuukqHb48VmLfnPD1t7S9KpdgYZxiXfawhVwoISc71oFfodN6wGA
         si/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627147; x=1785231947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BlAqH8OpzhDNUGaMI/yhdZ5tSuc+jcqv1mstlCTQxyA=;
        b=IenWbgjwLURZ/24Hk02HfeTTCcvTAHkM1DPZVthhm6g3PblMa0warP9Fa0dAB9F+3Y
         6rcYbNYFitBY4xEZCrhhcMENulhQYVHLat0PWyXYKmm8To0dvRtB8hfxIEQIMIKJrcJT
         TWoqI2dB8j7htqxUky9eV3bDIcABAhpdRBfndbQAgYzAlzeC3PEhYGl1XGrby3Vynij+
         U5XYyKfBLhu2byHdE8IwGlnl3yD9ij/rQmfM6NVerWgfdoFDdylPXvNnbc9uOMzNLKye
         hCdExnfx6u+4tirmE91bL3D+Y5YCfJeqYrWeXp7EHHaygPjDniltRnvohLSnAVBLGGLy
         Eevw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5QXJsHgWcZO/gYt2pcRX0u8z73mbJQBBMr/s4s9YAUAenVLMPmPiZkwcqPmTu9gEGjseFHl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsY/aKQ6qpdMl5rrOgB39bR2nvypjOk0OL70jgIAmJ2dBjz4G
	7yn4QIY1f0wp+RpYctAV89HNK4r+i3NpRAlfc1NJKo7pSflhgy/bxI7O
X-Gm-Gg: AfdE7cl7h9XpqqZcl3cPUOBHpibb7ax5jh7V0/6Ci4yv9gBwjsI+n1t8SWfxq4Q+0db
	aVChGU2DYlW6L0qXX1Udk/MYNieKVhyihHalml5gJj5Dg7QO5R9EUOohxzOU18xLzoBvOv3o3Ix
	Bg55oLPc3N6tLwVhe06Ply/C5AMRl5PNPNZq9g9CS21dVzf/yCHHYjIrKnH+IZKO6C4qbE8UbUz
	spK7Nz7u61ln4SSzr0KDOD6Ske5JoAMnziLouGWOI4KsRaas7Z+8xjNsARnVl7EoBM4oQST/TCO
	Wp/hn7HVxlma6SQXXVJWwXWL26eAOyhuMJ4k+Uf/sepn/q475iFGCNbXpvdfdOBZJIK2wE9vnwD
	jhgb0WPG44fJJEpOsPqw/A2zfn7j0Zy69Kx6X/MSx2YsMnInO3MPyRoGiV/pnAfL3nDbRlp8ROo
	FgNmARi7MlZUJiaWZ/Zv3yZX7xcCq/dd3s3A==
X-Received: by 2002:a05:6a20:e292:b0:3bf:63af:859 with SMTP id adf61e73a8af0-3c3ad973443mr18673082637.45.1784627147515;
        Tue, 21 Jul 2026 02:45:47 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm49625478eec.14.2026.07.21.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:45:46 -0700 (PDT)
Date: Tue, 21 Jul 2026 02:45:43 -0700
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
Message-ID: <al8_xx_99BjAUn5A@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al8hE_ded6qyWiDv@lucifer>

On Tue, Jul 21, 2026 at 08:43:51AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Jul 20, 2026 at 01:03:57PM -0700, Vishal Moola wrote:
> > On Mon, Jul 20, 2026 at 01:01:00PM -0700, Vishal Moola wrote:
> > > On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > When splitting a large page in CPA in __split_large_page() we allocate a
> > > > PTE directly without going through the standard page table allocation
> > > > routines such as pte_alloc_one_kernel().
> > > >
> > > > This means the page table constructor is never called nor is the page table
> > > > marked as a kernel page table.
> > > >
> > > > The former results in the folio associated with the page table not being
> > > > marked as a page table (__pagetable_ctor() is never called thus neither is
> > > > __folio_set_pgtable()) nor are statistics updated to reflect
> > > > it (lruvec_stat_add_folio() is never called).
> > > >
> > > > The latter issue of failing to mark the page table as a kernel page
> > > > table (ptdesc_set_kernel() is never called) is far more problematic.
> > > >
> > > > Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > > > tables") kernel page table freeing has been batched and since the
> > > > subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> > > > for kernel address space") IOTLB cache entries for kernel page tables have
> > > > been invalidated upon being freed.
> > > >
> > > > Since split page tables are freed without this invalidation, the IOTLB can
> > > > contain stale entries for them.
> > > >
> > > > Resolve the issue by using the ordinary PTE allocation API at split time.
> > > >
> > > > This results in these kernel page tables invoking a page table constructor,
> > > > and thus requires a page table destructor.
> > > >
> > > > Since we cannot assume one is always present (early allocated direct map
> > > > page tables are not marked as such), we conditionally call
> > > > pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> > > > otherwise we free the page table via pagetable_free().
> > > >
> > > > Regardless of which path is taken page tables marked as kernel page tables,
> > > > which now includes split page tables, take the correct route through
> > > > pagetable_free_kernel().
> > > >
> > > > There is a user-visible side effect in that split page tables will appear
> > > > in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> > > > allocated after early boot), however this is a positive change.
> > > >
> > > > This issue started being markedly problematic after commit
> > > > 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> > > > choose this as the Fixes target.
> > > >
> > > > Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > > ---
> > > >  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
> > > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > index 301fb9e77d91..a67ca33b9dd1 100644
> > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> > > >
> > > >  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > > >  		list_del(&ptdesc->pt_list);
> > > > -		pagetable_free(ptdesc);
> > > > +
> > > > +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> > > > +			pagetable_dtor_free(ptdesc);
> > > > +		else
> > > > +			pagetable_free(ptdesc);
> > >
> > > Lets not introduce more folio-ptdesc crossovers, we're trying to get
> > > rid of them :)
> > >
> > > I believe pagetable_dtor_free() should do what you're looking for on its
> > > own anyway.
> >
> > Actually, looking at it closer, maybe not because of the conditional
> > portion? But that makes me think it might be better to just replace the
> > ptdesc_clear_kernel() with pagetable_dtor() in the free function...
> 
> Well some kernel page tables are still allocated without ctor (early allocated
> direct map for isntance), and if you did pagetable_dtor_free() it
> unconditionally calls pagetable_dtor().
> 
> The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> assigned for kernel page table, and if PG_table never set clearing it is a noop)
> but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> nr_page_table_pages.

Gotcha, thanks for the explanation :)

> It sucks, but until everything is updated to call the ctor we have to do it this
> way :>)

Yeah that makes sense. Although I'd rather see the condition as:
if(PageTable(ptdesc_page(...)))

We really shouldn't be calling ptdesc_folio() anywhere anymore.
