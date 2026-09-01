Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766B4582DF;
	Tue,  1 Sep 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247263; cv=none; b=B4xD/rUpeXQ/IOVAf/fteWe3V6WhASDhHkm1ktTbAyYZgWKSmc9iG1k8UTYmQkUbD6xqEij7sGGSGdssRisOypLu613u6iaiqpIrs7w4Lwp2nY7UvZMf+QttMwOT7Gt1BAJlREq8UlY1ZDlvXuAgqj8tJvHzoyMp/HaSAMg83ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247263; c=relaxed/simple;
	bh=QVi5Z29odO8aCMhE41jy434rZJxB+EKgOCwHGGDdP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph7BUv226C8QcSPObr6kCf+7vvm0Bqkxxuy4Eq3h823/aiRXsR9pwQb8osE/Qqp87nYAuAOhxLDRkDXuVajOI50+X3AxuZ8rmd9xHPsJWherJV5qX3TTgcLt2y++erACr7MuKYE7w9gl6QcZaEKmSRL9+1weQ9spGVz2F2KUePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuRxpt3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuRxpt3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC021F000E9;
	Tue,  1 Sep 2026 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247261;
	bh=0F8/0aZYXOMLcGOV+5hsNUMjgV4FOpBKEncbAuq19HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iuRxpt3mnUwa5xv1ss6ybX7Q7HrL3frGaku71Pi05c1SNGDc7uaB2Vtg/TMEP+DQj
	 NYjH2LvzwY6fpBB4Yli7XvLpZE+kn701IHEO9T9OBPeu5coPofJuIwAiR4HQm4IW5Q
	 JKFe8mN7JjB16dc09rMEQrNCpGW9VQXnrsEsKLwytT5hKcZkGyHUE9IEWPypakksdd
	 /HL5KCITRww1fBYLt4WOZJN+Ki0+JxjyThlcss8G+UcgOI36P3TYiFcPhshnyHt2Vg
	 XBwqOWXwiyQ8ypgT5NB9v0a7C3YklgNlg+JNfVbWMg9+lILnWGPF4N40DtkxOndXZM
	 IlEexZfVZCi7Q==
Date: Tue, 1 Sep 2026 08:20:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Atish Patra <atishp@meta.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm read lock on
 attribute change to avoid UAF
Message-ID: <apZ8Uh7ej4a9WkIq@gremlin>
References: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
 <178821524648.3717435.13938325908577682845.tip-bot2@tip-bot2>
 <ea12e0a4-36b3-4c71-8930-72fc4eaf369f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea12e0a4-36b3-4c71-8930-72fc4eaf369f@kernel.org>

Dave - Again this patch has been modified vs. what was submitted and the commit
message, tags, etc. are now completely incorrect.

I'm not happy with this going to Linus as-is, is there a way for you to correct
these please?

On Tue, Sep 01, 2026 at 08:05:07AM +0200, Jiri Slaby wrote:
> On 01. 09. 26, 0:27, tip-bot2 for Lorenzo Stoakes (ARM) wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> >
> > Commit-ID:     477cf5cd1f698053df7426b7b8d9339e85e00946
> > Gitweb:        https://git.kernel.org/tip/477cf5cd1f698053df7426b7b8d9339e85e00946
> > Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > AuthorDate:    Thu, 13 Aug 2026 12:01:25 +03:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Mon, 31 Aug 2026 15:15:42 -07:00
> >
> > x86/mm/pat: Acquire init_mm read lock on attribute change to avoid UAF
> >
> > A previous commit protected against races between ptdump and CPA collapse,
> > however one still exists between attribute changes and collapse as reported
> > by Denis V. Lunev (linked).
> >
> > When an attribute change arises, a lockless page table walker obtains a PTE
> > entry, which is later written to via set_pte_atomic():
> >
> > ...
> > -> change_page_attr_set_clr()
> > -> __change_page_attr_set_clr()
> > -> __change_page_attr()
> > 	-> _lookup_address_cpa()
> > 	-> lookup_address_in_pgd_attr()
> > 	-> [ lockless page table walker ]
> > -> set_pte_atomic()
> >
> > There is nothing preventing a concurrent CPA collapse which can free the
> > PTE that was retrieved here, resulting in a use-after-free.
> >
> > With the mmap write lock taken on init_mm over CPA collapse, resolve this
> > race by acquiring an mmap read lock on init_mm over
> > __change_page_attr_set_clr().
> >
> > This locks across the whole operation over which the walk and the PTE entry
> > write occurs, solving the race.
> >
> > It is safe to do this here, as no spinlocks are held upon entry to
> > __change_page_attr_set_clr().
> >
> > However, the lock must not be held over an allocation, as allocation can
> > trigger reclaim and shrinkers may call into CPA recursively, making
> > deadlocks possible (init_mm -> ... -> fs_reclaim -> init_mm).
> >
> > A page table is allocated when a huge page needs to be split:
> >
> > -> change_page_attr_set_clr()
> > -> __change_page_attr_set_clr()
> > -> __change_page_attr()
> > -> split_large_page()
> > [ pagetable_alloc() ]
> > -> __split_large_page()
> >
> > Avoid deadlocks by dropping the mmap lock across pagetable_alloc() in
> > split_large_page() and track whether this is needed by adding a new
> > 'init_mm_read_locked' flag to struct cpa_data.
> >
> > This is safe as __split_large_page() (called with locks re-established)
> > revalidates that the page table entry is the same as it was prior to the
> > locks being dropped and __change_page_attr() repeats the entire page table
> > walk whenever a split occurs, so concurrent split and collapse are
> > accounted for.
> >
> > Concurrent ptdump is also safe as the lock is only dropped over page table
> > allocation during which time the page table has not yet been modified.
> >
> > The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> > operates upon vmalloc ranges, and on x86 only within the module mapping
> > space.
> >
> > This is important, because some callers directly invoke
> > __change_page_attr_set_clr(), bypassing this lock. However, none of these
> > operate within the module mapping space.
> >
> > * cpa_process_alias() - a recursive helper called by
> >    __change_page_attr_set_clr().
> > * __set_memory_enc_pgtable() - operates on the direct mapping and (via
> >    __vmbus_establish_gpadl()) the vmalloc mapping space.
> > * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
> >    valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> > * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
> >
> > This work is based upon Denis V. Lunev's excellent analysis of the bug with
> > gratitude.
> >
> > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Tested-by: Atish Patra <atishp@meta.com>
> > Tested-by: Nikunj A Dadhania <nikunj@amd.com>
> > Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> > Cc:stable@vger.kernel.org
> > Link: https://patch.msgid.link/20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org
> > ---
> >   arch/x86/mm/pat/set_memory.c | 28 +++++++++++++++++++++++++---
> >   1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index c38faf3..cb5d6d6 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -22,6 +22,7 @@
> >   #include <linux/cc_platform.h>
> >   #include <linux/set_memory.h>
> >   #include <linux/memregion.h>
> > +#include <linux/cleanup.h>
> >   #include <asm/e820/api.h>
> >   #include <asm/processor.h>
> > @@ -49,7 +50,8 @@ struct cpa_data {
> >   	unsigned int	flags;
> >   	unsigned int	force_split		: 1,
> >   			force_static_prot	: 1,
> > -			force_flush_all		: 1;
> > +			force_flush_all		: 1,
> > +			init_mm_read_locked	: 1;
> >   	struct page	**pages;
> >   };
> > @@ -409,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
> >   static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
> > -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> >   {
> >   	unsigned long start, addr, end;
> >   	struct ptdesc *ptdesc, *tmp;
> > @@ -443,6 +445,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> >   	}
> >   }
> > +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > +{
> > +	/*
> > +	 * Take the mmap write lock on init_mm to:
> > +	 * - Avoid a use-after-free if raced by ptdump (which takes its own
> > +	 *   write lock on init_mm).
> > +	 * - Serialise concurrent CPA walkers.
> > +	 */
> > +	scoped_guard(mmap_write_lock, &init_mm)
> > +		__cpa_collapse_large_pages(cpa);
> > +}
> > +
>
> Ah, this belongs to the "Acquire init_mm *write* lock" counterpart. Not sure
> how you managed to split/combine these two 8-).

Yeah this is completely incorrect, now the commit message, tags, etc. are all
wrong.

>
> thanks,
> --
> js
> suse labs
>

--
Cheers, Lorenzo
