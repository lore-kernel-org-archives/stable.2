Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A605189B84;
	Thu,  6 Aug 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026525; cv=none; b=PEOzO86bWmN0dlbcGIP82WAWMTyEZ4Q6V2FFRbOtrWOg4K+EeIKnc8xu4UNqNIVpK4MGnJdI6mzqNZSfNXK8qpmofvu7V9BOH9oiR/DV5gFIsQ2bQxHYpEv3Yf1aZxNAi3nlBqq9RI+YuYeJEgQ6gNF8byPOzccToku+Svso1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026525; c=relaxed/simple;
	bh=rHs3CnXSdKadQAcdHlqH65nSjRRXV+7m5+ob5XNp5H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k54W7P/zP34GUmaEB1TTDSGoTyQBbRUltivB3p/Xotktj8rj6evC6yYNq20O0fDB6PtycGcS3unKXFTn2wYDpBHoPkOhHHLI2fkDw1XTh0HqYLcqIp4oqrMsnStw+kgB0O0M86Lxg87KddQEHGt+x7wmG7NOK95i2kwRADe3uUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2CZHq/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2CZHq/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B71F00A3A;
	Thu,  6 Aug 2026 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026523;
	bh=WRALKTV1zKMhBFx0Dmp3LzI+O3yS0lLJanyooXmsjYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P2CZHq/WkTtMXOpcNiYIyEa8nU7OerOZT9LUJ/XDRMM5oEvQwPytKpSQFV0JGeHk0
	 Cyr6UVJZvPeWLm/GxOh5hM+1JXcMlHXNX0SY+H+Mw7Hm96z07lNyvmoCytOba2Rjsw
	 +wlwyoz1y8XQxUFpkIrqE436sCTMcMO1dZdoR+whb1yjjQZP3Rt3s7OvgUSu0duE51
	 4cPe6gGCG4YPZ2lAnklLhi9dn8iLH65esbMkvYnYwRz/CbbSjE1CwK/Obr2svtqVXX
	 ptV27F7DPPUNrSNzmYvaVgSc3GVahuL1SWqevaEZhhjvzx4YEubXffKgGU0lWqNa9Z
	 7+Ds2lZxDVZjg==
Date: Thu, 6 Aug 2026 15:28:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anSZpAjt84Pn7O_b@lucifer>
References: <20260805055544.1568534-1-clg@redhat.com>
 <0e52d0b4-064d-4602-8e7b-5744b05f24ea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e52d0b4-064d-4602-8e7b-5744b05f24ea@kernel.org>

On Thu, Aug 06, 2026 at 04:26:20PM +0200, David Hildenbrand (Arm) wrote:
> On 8/5/26 07:55, Cédric Le Goater wrote:
> > From: Cedric Le Goater <clg@redhat.com>
> >
> > The global THP sysfs policy (transparent_hugepage=never/madvise/always)
> > gates the huge fault dispatch path in __thp_vma_allowable_orders() for
> > all non-anonymous VMAs, including PFN-mapped device BARs (VM_PFNMAP).
> >
> > DAX VMAs already bypass this check via an early return:
> >
> > 	if (vma_is_dax(vma))
> > 		return in_pf ? orders : 0;
> >
> > But "special huge" VMAs -- identified by vma_is_special_huge() -- do not
> > get this early return, even though they share the same fundamental
> > property: they map physical addresses directly into page tables and
> > involve no memory allocation, no compaction, no splitting, and no
> > reclaim. The THP policy has no meaningful effect on them.
> >
> > This matters for VFIO PCI passthrough of large-BAR devices such as
> > NVIDIA H200 NVL GPUs (256 GB BAR each). The VFIO driver registers a
> > .huge_fault handler (vfio_pci_mmap_huge_fault) that dispatches to
> > vmf_insert_pfn_pmd/pud, and QEMU's vfio_region_mmap() aligns the BAR
> > mappings for huge page table entries. Both prerequisites are met, but
> > with THP=never or THP=madvise, __thp_vma_allowable_orders() returns 0
> > before reaching the "trust huge_fault handlers" code.
> >
> > The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
> > page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
> > with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
> > severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.
> >
> > Configurations that trigger this:
> >   - transparent_hugepage=never on the kernel command line
> >   - The tuned cpu-partitioning profile (inherits network-latency, which
> >     sets transparent_hugepages=never via sysfs)
> >   - transparent_hugepage=madvise (the RHEL default), since VFIO VMAs
> >     lack VM_HUGEPAGE and QEMU does not call madvise(MADV_HUGEPAGE) on
> >     BAR mmap regions
> >
> > Extend the existing DAX early return to also cover vma_is_special_huge()
> > VMAs. This is consistent with how vma_is_special_huge() is already
> > treated for supported_orders (grouped with DAX). The mm/Kconfig TODO
> > comment "Allow to be enabled without THP" also acknowledges this
> > coupling is wrong.
> >
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4
> > Signed-off-by: Cedric Le Goater <clg@redhat.com>
> > ---
> >  mm/huge_memory.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 58cabe6af33d031e48250e21db51506bc46c97b2..6dfef5500a054f09f9ece6df8bf7a0194624350f 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -139,8 +139,12 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
> >  		return 0;
> >
> > -	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> > -	if (vma_is_dax(vma))
> > +	/*
> > +	 * khugepaged doesn't collapse DAX or special huge VMAs, but page
> > +	 * fault is fine. These map physical addresses directly — the THP
> > +	 * policy is irrelevant for them.
>
> emdash in a code comment?
>
> Then I spot
>
> 	Assisted-by: Claude:claude-opus-4
>
> and really have to shake my head.

Ha, I missed that!

Well all the more reason for me to take over this patch... :)

At least the AI is acked here (appreciate that at least Cedric).

I think the _actual issue_ is valid at least. The huge pfn stuff did seem to
completely miss this aspect of things.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
