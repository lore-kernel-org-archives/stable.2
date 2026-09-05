Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF354119FD
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788609397; cv=none; b=u7W9kB8wJr+CznyCoajU9drJXwRXkHUtLq5LJcDIBRoR1PXcfE0EUeul0HfINwWVJw0BJnJ8g0bWyYNOOEwsoT7XSNQQTYlHxoXJfMxM8LloqjS+Q8nGovIBji95gU9pKm6R1R4Q1e4pvihqzwxfpybAnDxImmwCZ0rK7H7jn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788609397; c=relaxed/simple;
	bh=8mcQRH9DpvEFV5xCmyoihcjIaLv+JuO7xQLwMuUD7xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxqNWQ0OOEBfye1ZD8fegfpulBFz0CPUWyyAsvRmOOgVMz1P7fEpyATR+Ud4fFtVbDImRcAlnO50wE11a0d/pztgaYeCpFJNKuo10vhYoyyyKRAg6pPjYoPpL0Vld285AGBgeRLin31XUjNfp7fRLDqHQtSglaW1WcyXwshnmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwLwaZ/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwLwaZ/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9A11F00A3D;
	Sat,  5 Sep 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788609394;
	bh=+uUqgQsCTUBbf133UX5YoePLL3cwIdD5w2LDC1D9Bzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UwLwaZ/XpqfUIegQxH4g1WVtTN7WOoImfw/+OJcZASSONq4tbSdyfJ8csNs4Gu3Qu
	 QqoQ1834ozlB5tom+sUlIbPhoXG8x9RNYcIB9v6wiTT5UzcM4E2DAWWh61YRfbDpFM
	 irjFz0gNfVYXbc7lm0Q1k3C/5rbcwLSpnzCEpDfI=
Date: Sat, 5 Sep 2026 13:54:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18 038/552] mm/page_vma_mapped: use huge_ptep_get() for
 hugetlb
Message-ID: <2026090537-postnasal-flip-f547@gregkh>
References: <20260904045747.813364717@linuxfoundation.org>
 <20260904045748.693901462@linuxfoundation.org>
 <d61b56b5-d874-4e50-a83f-8714da4641e9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61b56b5-d874-4e50-a83f-8714da4641e9@gmail.com>

On Fri, Sep 04, 2026 at 11:19:06AM +0200, François Valenduc wrote:
> Le 4/09/26 à 06:53, Greg Kroah-Hartman a écrit :
> > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Dev Jain <dev.jain@arm.com>
> > 
> > commit e87df0d5d6962bde50f55f6d02b779daa394f894 upstream.
> > 
> > check_pte() is the final validation step in page_vma_mapped_walk().  It
> > reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
> > range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
> > entry.
> > 
> > On arches which provide their own huge_ptep_get() to dereference a huge
> > pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> > etc to misbehave.
> > 
> > It is not clear whether this has a trivially visible effect to userspace.
> > 
> > Use huge_ptep_get() to dereference a huge pte pointer.
> > 
> > Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
> > Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Reviewed-by: Muchun Song <muchun.song@linux.dev>
> > Cc: Alistair Popple <apopple@nvidia.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Byungchul Park <byungchul@sk.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Gregory Price <gourry@gourry.net>
> > Cc: Harry Yoo <harry@kernel.org>
> > Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> > Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
> > Cc: Kiryl Shutsemau <kas@kernel.org>
> > Cc: Lance Yang <lance.yang@linux.dev>
> > Cc: Liam R. Howlett <liam@infradead.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Mel Gorman <mel@csn.ul.ie>
> > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Cc: Rakie Kim <rakie.kim@sk.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   mm/page_vma_mapped.c |    8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -104,7 +104,13 @@ again:
> >   static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> >   {
> >   	unsigned long pfn;
> > -	pte_t ptent = ptep_get(pvmw->pte);
> > +	pte_t ptent;
> > +
> > +	if (is_vm_hugetlb_page(pvmw->vma))
> > +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> > +				      pvmw->pte);
> > +	else
> > +		ptent = ptep_get(pvmw->pte);
> >   	if (pvmw->flags & PVMW_MIGRATION) {
> >   		swp_entry_t entry;
> 
> This patch causes this build error:
> mm/page_vma_mapped.o
> mm/page_vma_mapped.c: In function 'check_pte':
> mm/page_vma_mapped.c:110:25: error: implicit declaration of function
> 'huge_ptep_get' [-Wimplicit-function-declaration]
>   110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm,
> pvmw->address,
>       |                         ^~~~~~~~~~~~~
> mm/page_vma_mapped.c:110:25: error: incompatible types when assigning to
> type 'pte_t' from type 'int'
> make[3]: *** [scripts/Makefile.build:287: mm/page_vma_mapped.o] Error 1
> make[2]: *** [scripts/Makefile.build:544: mm] Error 2
> make[1]: *** [/usr/src/linux-6.18/Makefile:2051: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> commit 70010ab9a9eb7aee65f42ddc20835806759b4336 ("mm/migrate: use
> huge_ptep_get() in remove_migration_pte()") gives the same kind error.
> 
> If I revert those 2 commits, compilation work fine.

Thanks, I should have this fixed up now in the queue.

greg k-h
