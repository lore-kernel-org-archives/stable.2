Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849718;
	b=qSa/Usb9pGxUc4aU4O4+cQYL11rEk8+TSFOVZSecizWDD7Lao1hOkXQ/swdhXMPQvrms
	 E0iQMfbf3yFf4EI8ufhPxI0KVT9qzp2krtRz+Tpt8dydhsofrbx4GFEBzFfelQIKwTQW1
	 Tz2c/PDfCn2oJMtwjSgiZeDSBCIxDFSt9+d/lIsKWRqI/TIsUmwAXrazxcqyUZ2pvYuiC
	 N/BHhxG1qf9niJZkMoCne3D2Cnn8houyp2r7S/JeG3DH5b1efgh89tO8yizTPr0GdBb/r
	 Z4c1zQbKWH7XMO8dB9j0cqz9nxthRWJf9i+zFykruX2qyV1ycoIAIS8eOevIIpCbkVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fVsGbQYRHAeRgv/EQToJrUh3lGrfBZ4ksTLjRrhgvYU=;
	b=XBk0uhzxL5jh8AJYTYQybOPErW9qCLfZ1vZ4Ornbj1HqzyKFuZbWjoF5DtgM6AnFv67i
	 7IINOdHjNvhkFtXC8Psuw8UWnYFyuu1Seviey/qqKwJawdbVvAelbxicRmkLHBlLhEaTk
	 vnLBNKJkMykvmDuFW0zZcoBPxO3sQt3D74JcJL2b/A92e3OJdB0PkYMh6eG+u6YslCZRb
	 RPSkTTE1sw9ibI91d4/k3W9cUlfEH8jgo1QJcLX6amc2qDEFrPx2R7JRsRWFsmTIdzGs7
	 xRjJs6rfkn6BTiMmEWIBrNB6YSOFqI/mn71blJgbcewWPS5AjVVg+8UESs3CHDynM+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0M2J+UM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465D606A33D;
	Mon, 16 Nov 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0M2J+UM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC131F000C9;
	Mon, 16 Nov 2026 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849718;
	bh=fVsGbQYRHAeRgv/EQToJrUh3lGrfBZ4ksTLjRrhgvYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0M2J+UM+J2X+m27UF/uGbLb5uGD5sVmGzVUXG8X7hI3x9Ukwm0nej1IfIbe+q+q9
	 4reI26TAGmspDfN1J/V4c7ZyHcnC6GigZMvmkQK1n5UiMB53RWR4vw8YCPo2RwRLt4
	 Jg3gUQAj4ldsw67y/c6ttu5ojccsDuWESHtxyftNAlad9Vu+fhiINNCwb01QivffAQ
	 JePUkTfZFHNdDVnAF3Yl14pC7gq3lYTqHNrr/VXu3l+7OKKRsJPGvhyDKiDcpf7mxo
	 bdEitk8xYizikjKUBgfGfwp2FWl2Y7EUh/LuegQWHpNecE4wmLbQLywq3Kr8eXGo3+
	 GS+kXaLTtMJjQ==
Date: Mon, 16 Nov 2026 17:21:49 +0000
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
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races a
 huge fault
Message-ID: <avs6WWOurjIN-trm@gremlin>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
 <998b00e3-bde9-450c-b50b-069e65d00c49@kernel.org>
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
In-Reply-To: <998b00e3-bde9-450c-b50b-069e65d00c49@kernel.org>

On Mon, Nov 16, 2026 at 04:59:35PM +0100, David Hildenbrand (Arm) wrote:
> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
> > From: Eliav Farber <farbere@amazon.com>
> >
> > A driver that implements both ->fault and ->huge_fault must anticipate
> > concurrent use of both.
> >
> > This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> > concurrent with faulting, as that only holds the mmap write lock and thus
> > does not exclude faulting threads stabilised by VMA lock.
> >
> > This is not currently safely handled by insert_pfn(), however, which
> > obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> > as an allocation failure, returning VM_FAULT_OOM.
> >
> > The issue is that get_locked_pte() also returns NULL if the PMD entry is
> > not a page table which can happen if a concurrent huge fault installs a
> > huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> > empty and insert_pfn() being invoked.
> >
> > This can result in VM_FAULT_OOM being reported incorrectly.
> >
> > Address this by proactively checking whether a page table allocation
> > actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
> > we were raced instead.
> >
> > The same assumption is made in insert_page(), however only DAX implements
> > ->huge_fault and can reach it, and it serialises faults of different orders
> > with its own mapping entry lock, so it does not require a change.
> >
> > Target the commit introducing the first driver able to do this.
> >
> > Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> > Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > Signed-off-by: Eliav Farber <farbere@amazon.com>
> > [ ljs: rewrote commit message, trimmed comment ]
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/memory.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e03110906aa8..cff39eccfd42 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2866,10 +2866,17 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> >  	struct mm_struct *mm = vma->vm_mm;
> >  	pte_t *pte, entry;
> >  	spinlock_t *ptl;
> > +	pmd_t *pmd;
> >
> > -	pte = get_locked_pte(mm, addr, &ptl);
> > -	if (!pte)
> > +	pmd = walk_to_pmd(mm, addr);
> > +	if (!pmd)
> >  		return VM_FAULT_OOM;
> > +	if (pte_alloc(mm, pmd))
> > +		return VM_FAULT_OOM;
> > +	/* We may have raced a huge fault, if so let the fault be retried. */
> > +	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> > +	if (!pte)
> > +		return VM_FAULT_NOPAGE;
>
> Same question, what if we would stumble over a PUD entry, how would we handle
> that today? I'd assume we'd also want to return VM_FAULT_NOPAGE instead of
> VM_FAULT_OOM.

It can't for similar reasons.

Actually changing this would require changing walk_to_pmd() a fair bit so it can
distinguish a failure to allocate from that, and I'm not sure it's worth doing
that at this point, better as follow-up?

>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
