Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849039;
	b=J1YxsrG4zSfHDnDLe+/4CuIr4Py586pcI3MYf192g19gWhN6oSfBAWkR8AGdyGUameex
	 gEhWA7zJz6rIKZ0VUAjtlL/5Q73qh+h14Qb5vRI58AikDWYTyBXz04N+I/DrLctthrctE
	 qHdczrL1EoOt6NNfTdD2YlSY7mrZ+qJnVLq47CQxgFF5i+g7M0oLhm1re0dM8mgFfhxRT
	 ERca35f/jhcoTRVdBtluJkCanWnLambRB7J03TsG/kV5c2I02n9VeonvZ6FHaJst2K0Qj
	 qYxwXzsqEV9y7jMd2HnKq1qN0+Zi90GAUeCbaV70VAI7/5gtq84tJqkuBCBXEFyuppA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849039;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tbHsekUSMb7nu0RIE/MWB5d+upWpW4eGrN8+h/t43/A=;
	b=b/YgV1PiZ0SyTnhxnP47F4+BABgBy5yDluthGPsUXvTksJt1u8MC1DwX4SDkmOJLQkox
	 KldBPekBU8cpn+BntxSBJzZWCVFfXLCiP0QziRXENKU2sNsKvEJe/G0pUHqIwpBJSeaQy
	 pMtIyN8zZJSmvLiX7Xw4RGYKat+PUXkxsPUJqO4NIEDO4YuWzvWCg74wIdj3NCFAFO0Yw
	 X0op1bAYX0yA11Mum761aYlD4f6Gkio4E/bUKSkC2vQpbxDJQnBeI4P7jCwkxiz8VldQm
	 sdMVZ2k/6LVGi8gvSfkv/Qc2hyKFGJIbBJnsNAhU7ZRVnN+6guF6FIW12CIPbMQTUVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooFZpzeq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC691606A33D;
	Mon, 16 Nov 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooFZpzeq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B8C1F000C4;
	Mon, 16 Nov 2026 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849039;
	bh=tbHsekUSMb7nu0RIE/MWB5d+upWpW4eGrN8+h/t43/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ooFZpzeqTPFuyP7Lh15EzI5bg9INBkCaKSSB/Wn0ybABoCZOdwGmkd4AWhLRWChoS
	 o7czW1XViUOfgC5gEd/vymO+F8VD50VxRYJOgFJQy9ICLGhFxoRZpdRIpi6ZpvQr05
	 fnZbT7fZfg4/ICiky6eLv0i5apWEUf4USsayEPrUhjfpDnLXZdPvUlzx4UIEHFACVd
	 KUhYexqFCsA9zVXZbqV8R432S7E/l+lw/ot1ce2rTthHGn3HfbTl/8wnseBBvNA0On
	 0y0yW0dcxaBc+UJ5qrSthAvIaAZgPZ0wCBPcLN0twIduD1KfTFeiY4XEsiq8G8SYRs
	 M4raFmCI52cng==
Date: Mon, 16 Nov 2026 17:10:29 +0000
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
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
Message-ID: <avs1rOJQ1gV33z8w@gremlin>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
 <dccf94b3-b901-4311-a233-488c87195dc5@kernel.org>
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
In-Reply-To: <dccf94b3-b901-4311-a233-488c87195dc5@kernel.org>

On Mon, Nov 16, 2026 at 04:56:25PM +0100, David Hildenbrand (Arm) wrote:
> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
> > From: Eliav Farber <farbere@amazon.com>
> >
> > walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> > so without holding the PMD lock, so the assertion is only valid if nothing
> > can concurrently install a huge PMD entry in the range.
> >
> > This is not the case for a VMA whose driver implements both ->fault and
> > ->huge_fault and which invokes vmf_insert_pfn() from the former.
> >
> > The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
> > takes the mmap write lock and faults taken under the VMA lock are
> > unaffected by this.
> >
> > This can result in two concurrent threads faulting the same thing
> > disagreeing as to whether to attempt a huge fault and thus ->fault and
> > ->huge_fault running at the same time and triggering this assertion.
> >
> > So just remove the assert.
> >
> > Target the commit which introduced the first driver able to do this for the
> > fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> > them using its own mapping entry lock.
> >
> > Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
> > Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eliav Farber <farbere@amazon.com>
> > [ ljs: rewrote commit message ]
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/memory.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 3a20d64fd276..e03110906aa8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2384,7 +2384,6 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
> >  	if (!pmd)
> >  		return NULL;
> >
> > -	VM_BUG_ON(pmd_trans_huge(*pmd));
> >  	return pmd;
> >  }
> >
> >
>
> Could this also stumble over a huge PUD somehow? Should we just prepare it for
> any leaves and bail out if we find some?

No, walk_to_pmd() can only come from the order-0 path right now and
__handle_mm_fault() makes sure that can't happen in the fault path:

	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
	if (!vmf.pmd)
		return VM_FAULT_OOM;

	/* Huge pud page fault raced with pmd_alloc? */
	if (pud_trans_unstable(vmf.pud))
		goto retry_pud;

So by the time any ->fault path runs, the PUD is stable.

We don't have to worry about the mmap paths as at that point nothing has
faulted in and it's all fresh.

So it's all safe as things stand.

But could update for future-proofing like:

	/* PUD leaf might have been installed. */
	if (pud_trans_unstable(pud))
		return NULL;

?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
