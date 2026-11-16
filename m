Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848121;
	b=OyDsxsZoTKP12pcI0E+0SjrRdc7jqLa7tsH5jbydEtY50Vi+E5sODuEKHFhM0Hjzbh8i
	 JX40JdlYN56TRQItwvXYMC7UhcVENKIVjbLI46I2JqkeOrfsSDBy9sP/d8o7BjfnOl3Ln
	 8h259qzEDlcqS2LQiAmdOQnZ6knAMqfeLFlhIC19Cj76yO//RRBx1QE9hAx8hVmlMQqy1
	 CDAafZQlcXMcOdpcrsAv79h7MAyyKfjkdy24DTnmNapcVlYCuxov78ABgPRI1L4FfBW3s
	 ENA5OuDSkik1Kc+me4r3CLEpcveGs29mbPL0FHglFjojDkrfy33GAlZKKs7EJgkgHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848121;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MOX2IuvHhL6KYQ9Yw7AqZupB+f7laGqvjxs74L8EXG8=;
	b=ehAPu6R4IJQwAhBDMsoCrkxqdbtZwurzgi0FQOVA8gkv+lMdAkzZTLJkQevVo8zxJ46r
	 bfJrujZ7mFbvv6cITnWsPJOH6IAc22+or0ylLHCTCXCIeWrGDnx64aWLS7REiKJ6EjEXF
	 731DNsr5HG+Rr1jiMPwPw1u+UBsrwNNyCtrbdVeEqjimBgQsdeTXELY6+7vZxzRgjHLAP
	 z/G0nTgb98Xg6akOU8R5b3NxH/hjfrG1kvP4uWmBQnG2PHnw5MygdGrhRq+TXzB29hCnk
	 vJxbHGUJzzgaEYyi61k4vq0EM7zqkO1k7Xhzl4hYsC/qnSBi9djlD7fG3NYo4VZbfTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6GIz5y6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A5606A883;
	Mon, 16 Nov 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6GIz5y6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0771F000C4;
	Mon, 16 Nov 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848120;
	bh=MOX2IuvHhL6KYQ9Yw7AqZupB+f7laGqvjxs74L8EXG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6GIz5y63dt2rZbL7xip5OTicaJXloFWpGTULYFqkW9HNEePnEJsw/7ovDbpWiQDO
	 BechQm/psjOWB/RzQycF0bnACUr4SnQgyaJZGQnMMOsrmeys0qzHu7IzBstSYksORU
	 ZH0CAlw6byFvqDhSazJnACEhhLQyvMB0Dyqx9Us6iBvreHHS0U5Gto+9/Bwv2YjTmd
	 w9OJWt3ApH+4oPK8ln5XSFK1K9BUegykOibmGaHp5oIMR29n6LOwoRbwSkSoAdW2ot
	 7WZXWkPsMcpymkpe+jgN53EDt4FjWuL54O7Xer9UNnRsIhZJ92t2/wrqIB6sPr1zVC
	 Md5feKFAEJoYg==
Date: Mon, 16 Nov 2026 16:55:12 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
Message-ID: <avsz6Op6mfkF4y1x@gremlin>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
 <e13044a0-871b-4033-8a79-22cb9653b6b1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13044a0-871b-4033-8a79-22cb9653b6b1@kernel.org>

On Mon, Nov 16, 2026 at 05:01:52PM +0100, David Hildenbrand (Arm) wrote:
> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
> > A driver that implements both ->fault and ->huge_fault must anticipate
> > concurrent use of both.
> >
> > This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> > concurrent with faulting, as that only holds the mmap write lock and thus
> > does not exclude faulting threads stabilised by VMA lock.
> >
> > insert_pmd() and insert_pud() have issues with this as they both assume
> > that, if the page table entry being populated is not empty, it must a
> > present huge entry.
> >
> > This is problematic as if it is a write fault, it compares its PFN against
> > the one being inserted, warning if they differ, on the assumption that the
> > entry is a huge leaf.
> >
> > Since the entry may be a page table, this is invalid and can result in
> > spurious warnings.
> >
> > Equally, the entry might be non-present. Nothing can install such an entry
> > in the VMAs that reach this code today, but there is no reason to rely upon
> > that.
> >
> > Therefore only examine the PFN if the entry is both present and huge, and
> > otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
> > at the appropriate level.
> >
> > This is what already happens for a read fault, for which the existing entry
> > is not examined at all.
> >
> > Target the commit which introduced the first driver which both mixes fault
> > orders and passes the write flag for the fix (since this commit, both
> > drm_gem_shmem and panthor are prey to this issue).
> >
> > Reported-by: Eliav Farber <farbere@amazon.com>
> > Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
> > Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/huge_memory.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 0d589be136d2..da632c3e834b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> >  		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
> >  					  fop.pfn;
> >
> > +		/* We may have raced a fault which installed a page table. */
> > +		if (!pmd_present(*pmd) || !pmd_trans_huge(*pmd))
>
> Ok, we hold the PMD lock, so that cannot change concurrently.
>
> Given that we are in THP code, I wonder if we could just test for pmd_leaf()
> instead.
>
> Same below for PUDs.

That's what the original did, but as the commit message says I don't want
to rely on the entry not being a softleaf here, in case we do something
later that changes that.

It's future-proofing.

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
