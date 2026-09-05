Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221B33998
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628604; cv=none; b=TFP2VE5HnfUDSSQCWRd5uU9k5ovoVP77bl3ZIabQqt3jWd9n5i+prTKLwypr8lCprcb95TJDcWoXXifkgunrAZkH9C0wv3QK87WSd/SKrYOXrRdKfJsM9nU+gDvQSqK/4eK6KPxZcIqRbu07gvv7LIV5HQ7BvNn5Bt/2VgELlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628604; c=relaxed/simple;
	bh=8yAJbx1T6sE/ZYAL33lEBPOCdVcPH3qhVNibT72F2KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZbv8ErrNUdfunyMQoo2U4hMbdAzoqqSjpGVV2gi9iIE0E4fZfrFN6fb5ILmO3/K4Ik8lq1xOHEn+66gvopttw/j6cWf99VUvOucCBzehTFR1M8Eu3j38oFa+ZIDwmvIfLNGFqzzfzasg+TOZapkWfTvQYsZnFjh7QBMjNTyzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZALIKYrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZALIKYrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F11F00A3A;
	Sat,  5 Sep 2026 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788628601;
	bh=XziAjtkUIMlIFQGr8QPcpWFCE19/uuCdr3uoe3w3y2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZALIKYrTE7dAU4I3CS4iesnkxT4o8rjDef6451WBq8sLGLm7JjKg0Dl2E0ieeljcs
	 /RcEPkwfsroH/TsCoqzMKRhV3oGbdlKxhlbjC6kan9X/byWMcEGYr9MgrNqR1pZ4xP
	 zEwF+jWX2zzPlZhUCYpDIejq+uJz33vlTUw8TcE0=
Date: Sat, 5 Sep 2026 19:14:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18 038/552] mm/page_vma_mapped: use huge_ptep_get() for
 hugetlb
Message-ID: <2026090545-rush-uncrown-871f@gregkh>
References: <20260904045747.813364717@linuxfoundation.org>
 <20260904045748.693901462@linuxfoundation.org>
 <d61b56b5-d874-4e50-a83f-8714da4641e9@gmail.com>
 <2026090537-postnasal-flip-f547@gregkh>
 <e3626c4c-e717-4ce9-b7ba-b22f20ad80c8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3626c4c-e717-4ce9-b7ba-b22f20ad80c8@gmail.com>

On Sat, Sep 05, 2026 at 04:38:22PM +0200, François Valenduc wrote:
> Le 5/09/26 à 13:54, Greg Kroah-Hartman a écrit :
> > On Fri, Sep 04, 2026 at 11:19:06AM +0200, François Valenduc wrote:
> > > Le 4/09/26 à 06:53, Greg Kroah-Hartman a écrit :
> > > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Dev Jain <dev.jain@arm.com>
> > > > 
> > > > commit e87df0d5d6962bde50f55f6d02b779daa394f894 upstream.
> > > > 
> > > > check_pte() is the final validation step in page_vma_mapped_walk().  It
> > > > reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
> > > > range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
> > > > entry.
> > > > 
> > > > On arches which provide their own huge_ptep_get() to dereference a huge
> > > > pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> > > > etc to misbehave.
> > > > 
> > > > It is not clear whether this has a trivially visible effect to userspace.
> > > > 
> > > > Use huge_ptep_get() to dereference a huge pte pointer.
> > > > 
> > > > Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
> > > > Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> > > > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > > > Reviewed-by: Muchun Song <muchun.song@linux.dev>
> > > > Cc: Alistair Popple <apopple@nvidia.com>
> > > > Cc: Andi Kleen <ak@linux.intel.com>
> > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > Cc: Byungchul Park <byungchul@sk.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Dave Hansen <dave.hansen@intel.com>
> > > > Cc: Gregory Price <gourry@gourry.net>
> > > > Cc: Harry Yoo <harry@kernel.org>
> > > > Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > > > Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> > > > Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
> > > > Cc: Kiryl Shutsemau <kas@kernel.org>
> > > > Cc: Lance Yang <lance.yang@linux.dev>
> > > > Cc: Liam R. Howlett <liam@infradead.org>
> > > > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Mel Gorman <mel@csn.ul.ie>
> > > > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > > > Cc: Oscar Salvador <osalvador@suse.de>
> > > > Cc: Pedro Falcato <pfalcato@suse.de>
> > > > Cc: Rakie Kim <rakie.kim@sk.com>
> > > > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > > > Cc: Rik van Riel <riel@surriel.com>
> > > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Zi Yan <ziy@nvidia.com>
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >    mm/page_vma_mapped.c |    8 +++++++-
> > > >    1 file changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > --- a/mm/page_vma_mapped.c
> > > > +++ b/mm/page_vma_mapped.c
> > > > @@ -104,7 +104,13 @@ again:
> > > >    static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> > > >    {
> > > >    	unsigned long pfn;
> > > > -	pte_t ptent = ptep_get(pvmw->pte);
> > > > +	pte_t ptent;
> > > > +
> > > > +	if (is_vm_hugetlb_page(pvmw->vma))
> > > > +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> > > > +				      pvmw->pte);
> > > > +	else
> > > > +		ptent = ptep_get(pvmw->pte);
> > > >    	if (pvmw->flags & PVMW_MIGRATION) {
> > > >    		swp_entry_t entry;
> > > This patch causes this build error:
> > > mm/page_vma_mapped.o
> > > mm/page_vma_mapped.c: In function 'check_pte':
> > > mm/page_vma_mapped.c:110:25: error: implicit declaration of function
> > > 'huge_ptep_get' [-Wimplicit-function-declaration]
> > >    110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm,
> > > pvmw->address,
> > >        |                         ^~~~~~~~~~~~~
> > > mm/page_vma_mapped.c:110:25: error: incompatible types when assigning to
> > > type 'pte_t' from type 'int'
> > > make[3]: *** [scripts/Makefile.build:287: mm/page_vma_mapped.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:544: mm] Error 2
> > > make[1]: *** [/usr/src/linux-6.18/Makefile:2051: .] Error 2
> > > make: *** [Makefile:248: __sub-make] Error 2
> > > 
> > > commit 70010ab9a9eb7aee65f42ddc20835806759b4336 ("mm/migrate: use
> > > huge_ptep_get() in remove_migration_pte()") gives the same kind error.
> > > 
> > > If I revert those 2 commits, compilation work fine.
> > Thanks, I should have this fixed up now in the queue.
> > 
> > greg k-h
> 
> Indeed, it works correctly now.

Great, thanks for testing and letting us know.

greg k-h
