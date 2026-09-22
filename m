Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA35678C4;
	Tue, 22 Sep 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095510; cv=none; b=CFhRnrbXANpJu89aef8uNhZw45DGSUGJJPWLGgwZRp1exUqkqEqw/oh8oxdzl4/5fP5+BM9qdHAuuww+GpydVbT7ZLbXQdAn0q2vlIUaEoFXjNLXkOmcdlcpLOlzfr2XGvLjPcGatnD4yrV2qasSyKLlCB/YJgL913feDoEj68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095510; c=relaxed/simple;
	bh=7LY3pKcbXJffBE1vT5GmjHHjVJI36qcfBjegrbhpHBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXPkrmmjKVVCxuJ7WsfFgs91hlXFx+3ckqzCtem31wuJZ9p+0rHodltSDWxkRzZ29fzvCw0sXRo1e8v1Zx6XZKUCqyqMZGy4iVwDB7UgU3apjTCe152BQxUYZbI02fEE+F2picj7hn/pPC7uc6FTVnULB5hqx8mTeFCkFQY+hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDhZi0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDhZi0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125AF1F000FF;
	Tue, 22 Sep 2026 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095509;
	bh=kMdG76MeQldYLnCdGPtfwF3zaPMlZJI65YPqsh9aHeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKDhZi0e73h+nMW4g8pA7A9NUbYmjT02T7buH0UC9uXaYZrNO8Zr0PPC/SZI602aX
	 XwxgYZEOKWDRu83nzrVKc/exGZR4LZdIPb/RkR0oOsdzxezkAfu5fSLqH0DoipprD5
	 LTJbHmlmHh615fAE3i3BJAZDNodtmagudfF3gkkZ8b8RthU/SuIRAE+84Z4dU3isyX
	 y0ylSUjpU1c9tVmoTmrVAOhlTxpKPVcD8JsPmJR3/F5S0uuxxxL7GoKgXCqDUkHQU8
	 8gVFLt/wLDCGy6Cv+0PHMRmkkW6Go0Lby5jDKJ7o2i9Yse4qbE87NPZB+s9tgU5ItD
	 +5C0mo8nWChVw==
Date: Tue, 22 Sep 2026 19:45:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, akpm@linux-foundation.org,
	peterx@redhat.com, surenb@google.com, aarcange@redhat.com,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-ID: <arKwjZ67hJFBunSd@kernel.org>
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com>
 <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>
 <49208ed6-6c20-49a9-9c0d-0e1cffe1898f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49208ed6-6c20-49a9-9c0d-0e1cffe1898f@kernel.org>

(cc Kiryl)

On Tue, Sep 22, 2026 at 01:40:51PM +0200, David Hildenbrand (Arm) wrote:
> On 9/19/26 02:46, Donggeun Yoo wrote:
> > UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> > destination unchanged, so a uffd bit set on the source lands in a
> > destination VMA that was never registered for write protection.  It is
> > then permanent: the bit is dropped only by change_protection() under
> > MM_CP_UFFD_{WP,RWP}_RESOLVE, which uffd_wp_range(), mrwprotect_range()
> > and userfaultfd_clear_vma() issue only for a VMA registered in that
> > mode.  pagemap reports the page as uffd-tracked, and MADV_COLLAPSE
> > refuses the range while the bit is set, because collapse_scan_pmd() is
> > strict about uffd on swap entries.
> > 
> > move_present_ptes() and move_zeropage_pte() build the destination PTE
> > from dst_vma->vm_page_prot and arm RWP only when dst_vma asks for it, so
> > the destination's own registration decides the result.  move_swap_pte()
> > copies the source PTE instead and only ever sets the bit, never clears
> > it, so one UFFDIO_MOVE behaves differently depending on whether the page
> > happened to be resident.
> > 
> > Clear the uffd bit on the moved swap entry unless the destination is
> > RWP-registered, as copy_nonpresent_pte() does where it installs a PTE
> > into a destination that may not be armed.  A WP-registered destination
> > stops inheriting the bit as well, which is already what it gets when the
> > moved page is resident.
> > 
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> > ---
> >  mm/userfaultfd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 74f04c323c50..6495666c596b 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1452,6 +1452,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
> >  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> >  	if (userfaultfd_rwp(dst_vma))
> >  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> > +	else
> > +		orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> >  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
> >  	double_pt_unlock(dst_ptl, src_ptl);
> >  
> 
> In move_present_ptes() we don't run into that issue as we create a new PTE from
> scratch
> 
> 	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
> 
> 
> Staring at the
> 
> 	if (userfaultfd_rwp(dst_vma))
> 
> I do wonder why we don't have to take similar care about wp ... I'm sure the is
> a good reason.
> 
> Code change itself LGTM.
> 
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
