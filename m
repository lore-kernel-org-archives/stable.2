Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E85366042;
	Tue,  1 Sep 2026 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246656; cv=none; b=noWYdIaxhXmkcHR2cFCs3xoR20FF3A6Ahd60uR+OxQ8unNDe0SaOReqJmb32Cy17ZIIV2M2reD8rn9V3P/rkpu876Xl+zMR/oJ7OrhMUGzsbfUlIxeteaWsWIiQUansMo3hOEwk9VVMxutlW96Jhrxa+6O/XlsUutm7ReR2ifkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246656; c=relaxed/simple;
	bh=N5JN30iIXs7hcClP3bNFzqexbBkyyYozyq3HG+2gkQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itGyjA5ERm9V4ItWl5dw8rB+VC7Q+cUFdOPCxtBxexScX7x/Ptn9RCcTmZWqkVEH7nB4ZuJI7i194LEahi5l0mp7bW6W7ehkwks7ONmHa0Zrm54U5Ux9Hs2KNYlBRkfXIxYaAEE1hT9xDCn2hF8w0odkF/V7CMBq9MnWXEOzmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDVT9GzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDVT9GzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B791F000E9;
	Tue,  1 Sep 2026 07:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788246655;
	bh=0SqZ2CRB1xQrZ6iMKbhesyoGFZLDo+2hk/T50dV72v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDVT9GzHbY/bzH314K5VEKlVdPD8boPyWzPzHaWW/Yr4AjyrLstXif3lyuMBId1cs
	 JB19rmqVqzozstZupCGEugybWAHxAaxzrQu5wE+lTRd9DdDlL3y0ao8JTe3MfJux5A
	 M0EUiyKgFgF7lakyk/lI3pI2Jcxl6hz898eMd4pGKEYFi1xK6jysV7UkuXvsXZrji5
	 yDma8W61OItMRQh2SylhqMC8fvDL8Lb+x8IErIoGczOLq3iFhoH6VDvjF9yPSG3yvi
	 685d2Si9/sBddEyyVGf5Woc3kKS/Oqn31cK5wVEWDuiW98jV/9kCTf3HKEcbWYy04S
	 av0cMBN6k2Z4Q==
Date: Tue, 1 Sep 2026 08:10:48 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>, 
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on
 collapse to avoid UAF
Message-ID: <apZ52DKlJIrpX6qq@gremlin>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>



On Tue, Sep 01, 2026 at 08:03:21AM +0200, Jiri Slaby wrote:
> On 01. 09. 26, 0:27, tip-bot2 for Lorenzo Stoakes (ARM) wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> >
> > Commit-ID:     be4f4ab413d15e2b44f6bcda3b607eb707a7712e
> > Gitweb:        https://git.kernel.org/tip/be4f4ab413d15e2b44f6bcda3b607eb707a7712e
> > Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > AuthorDate:    Thu, 13 Aug 2026 12:01:24 +03:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Mon, 31 Aug 2026 15:14:58 -07:00
>
> The committed patch to tip is bogus. It contains only the guard definition.

Dave - you've somehow applied this patch completely incorrectly to x86/urgent,
I'm not happy with this going to Linus in this form :/

Now the commit message and the actual patch are completely mismatched.

I'm not sure how tip resolves issues like these but is it possible to
replace this with the actual patch that was submitted please?

Thanks.

>
> > x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF
> >
> > x86 implements page attribute modification using its Change Page
> > Attributes (CPA) mechanism.
> >
> > This tracks properties of ranges such as cache mode through x86 page
> > attributes, and as part of that logic manipulates kernel page tables.
> >
> > Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> > fragmentation") ranges of kernel page table entries can be collapsed into
> > huge page table entries as part of this logic.
> >
> > As part of this collapse, it frees the page tables which the collapsed
> > entries previously pointed to, and it does so without any relevant locks
> > being held to preclude concurrent kernel page table walkers.
> >
> > The only way this code can be reached is if CPA_COLLAPSE is specified, and
> > this is only set in set_memory_rox() via:
> >
> > set_memory_rox()
> > -> change_page_attr_set_clr()
> > -> cpa_flush()
> > -> cpa_collapse_large_pages()
> >
> > Notable users of this are execmem and bpf when manipulating executable
> > mappings.
> >
> > However, this is problematic for ptdump as it walks ranges it does not own
> > and thus runs the risk of a use-after-free on page tables freed underneath
> > it.
> >
> > In addition, concurrent CPA collapse operations are possible which can also
> > cause races.
> >
> > Resolve the issue by acquiring the mmap write lock on init_mm across the
> > whole operation.
> >
> > It is safe to acquire a sleeping lock as all the callers invoke
> > set_memory_rox() from process context and in any case,
> > change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> > mutex, disallowing atomic context here.
> >
> > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Will Deacon <will@kernel.org>
> > Reviewed-by: David Carlier <devnexen@gmail.com>
> > Tested-by: Atish Patra <atishp@meta.com>
> > Tested-by: Nikunj A Dadhania <nikunj@amd.com>

It renders all of these tags completly incorrect too.

> > Cc:stable@vger.kernel.org
> > Link: https://patch.msgid.link/20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org
> > ---
> >   include/linux/mmap_lock.h | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index bec0eab..b8a13b8 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -630,6 +630,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> >   DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> >   	     mmap_read_lock(_T), mmap_read_unlock(_T))
> >   DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
> > +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> > +	     mmap_write_lock(_T), mmap_write_unlock(_T))

Yeah I meant obviously this isn't what the patch is.

> >   static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
> >   {
> >
>
> --
> js
> suse labs
>

--
Cheers, Lorenzo
