Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024848;
	b=rKNNmv6/MOtaPpaQa2LOQ0WeLFev+S6dE0ly/kpIUU+B0cNyWQHKttMIeDtSn8hxXhSH
	 xCqmdJsaaqzqmq40StyrhwKtiblC9SsHUjoKGjTXX66dFMEXV7CetR06mfLT6lx/Xy5iW
	 L1gb9eodbQ3RA2C4xeK4xvpCOrjxqtkGM1QNXVqDxApeNtremadjb4SXoAujulrZLlNjW
	 6tfd+oziUnTwLg2VUe4iSsGhYE5xGS8S5I5vUMmwFHNE3w8HZxIRTQ9FVwc4oxNXOiyJX
	 GnPOQ9NdRmeMJadJylhgab/PGdPaRffT3m7W62caKnZbY9OsKHCD7VL5rGX6GBHbHrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6gmCDvdn2nsesgNhAh+epn0sztNU7HD2eJkAnfX6dkM=;
	b=sE8nHaHuViYVYe+hFVJg0INVk9dSqgyFt9KWfRry9PKqtnSljDH7gbFeZzUZpZ8AGDHF
	 Co+kTt9pTjyCz1r5aO7yXarRbKmKmUGr9B90X23ED53vGQoqEHEySOSMOyT1P29oPyfdp
	 1Wq8Q3SJQImoJ87hs1PI1aq7aW9bLiy6Re0t9J/eJBV+q/YAbNgUvZLS//0JuxMC4bCWw
	 g2NxenrhDtjKnu1UNSbKYQLwm6lnVRF4bqEPIek21P+w1C+lhUvIyXPilSxIolN1yYZ2D
	 4L0Xqeo633DnlWbFERXK/lcPz0SsDQGO9+GbAHbrZvoWIVu9YZ6VtUMaZUbkInu/5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IxP+N3i/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169B606A31A;
	Mon, 26 Oct 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxP+N3i/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B491F01825;
	Mon, 26 Oct 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024847;
	bh=6gmCDvdn2nsesgNhAh+epn0sztNU7HD2eJkAnfX6dkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IxP+N3i/n2LONGGX+afxhWlsWhOTpuuACZjEFunZuKXhHM/2qN4hqqU64faaUXtI2
	 b92CvQVadIqScamGEi3o9eCIrTfxGrFzZlCrrDKgiAtx3T5/tzM1rR5eMIeW2po5Pa
	 urKkl72EYR0eQoR0RdsG8tBvJ4Ol1kKz+lj5Dtmb6mncXA0dTNhWibCCxMDWCYHhEm
	 JjcPAXaw3eOLZGJ+tQaXLV+RTDRlHI3bdmuftngAJbZneOyCTJ7Qf7FQ5aTrFkvkd/
	 ctTKXd5FH7EQpXUMrcra1UQ+oWmBwBaVAaQqPbqfNg2IdzzJuTG8DG5krtiJ1R7e/r
	 RmLfgQDjpJKJg==
Date: Mon, 26 Oct 2026 14:27:16 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, xu.xin@linux.dev, 
	chengming.zhou@linux.dev, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jglisse@redhat.com, aarcange@redhat.com, 
	peterx@redhat.com, kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bobbypowers@gmail.com, bgeffon@google.com, dplotnikov@virtuozzo.com, 
	dgilbert@redhat.com, hughd@google.com, hannes@cmpxchg.org, kirill@shutemov.name, 
	cracauer@cons.org, mcfadden8@llnl.gov, gokhale2@llnl.gov, mgorman@suse.de, 
	mike.kravetz@oracle.com, rppt@linux.vnet.ibm.com, xemul@openvz.org, riel@redhat.com, 
	shli@fb.com, jthoughton@google.com, corbet@lwn.net, pbonzini@redhat.com, 
	seanjc@google.com, sj@kernel.org, ziy@nvidia.com, stable@vger.kernel.org, 
	samarth.colleges@gmail.com, med08elkadiri@gmail.com
Subject: Re: [PATCH] mm/ksm: fix userfaultfd protection during merge and
 unmerge
Message-ID: <at9d4XJUIM8SgBDs@gremlin>
References: <20261026130054.91461-1-lance.yang@linux.dev>
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
In-Reply-To: <20261026130054.91461-1-lance.yang@linux.dev>

On Mon, Oct 26, 2026 at 09:00:54PM +0800, Lance Yang wrote:
> KSM loses userfaultfd protection when replace_page() builds a new PTE
> from vma->vm_page_prot. Dropping its uffd bit lets a subsequent write go
> through ordinary COW instead of userfaultfd write protection handling. For
> RWP, a merged page also becomes readable without faulting.

I feel we probably shouldn't have allowed an extension to UFFD while it's still
fundamentally a broken feature :))

Which is evidenced by the SLEW of AI bug reports, and human-reported bug
reports, and endless history of bug reports and it infecting the rest of mm,
etc. etc. /rant

>
> Keeping the uffd bit and restoring PAGE_NONE fixes merging, but we also
> have to handle unmerging. An existing KSM page can be protected with RWP
> before MADV_UNMERGEABLE, so unmerging already needs fixing independently
> of preserving RWP during merging.
>
> Unsharing replaces a shared page with a private one and should leave
> userfaultfd protection in place, as do_wp_page() already does for write
> protection. Currently, an unshare fault reaches do_uffd_rwp() before it
> can proceed to do_wp_page().
>
> - With synchronous RWP, handle_userfault() returns VM_FAULT_SIGBUS.
>   break_ksm() then reports success with a KSM page still merged.
>
> - With asynchronous RWP, protection is cleared before unsharing.
>
> Preserve the uffd bit when merging, and restore PAGE_NONE for RWP. Let
> FAULT_FLAG_UNSHARE skip RWP fault handling and keep PAGE_NONE on each
> private copy as well. Unsharing can then complete with RWP still armed
> for a subsequent access.
>
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Link: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
> Link: https://lore.kernel.org/all/20261020055518.36087-1-lance.yang@linux.dev/
> Cc: stable@vger.kernel.org
> Co-developed-by: Samarth Narang <samarth.colleges@gmail.com>
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Looks sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/ksm.c    |  8 +++++++-
>  mm/memory.c | 14 ++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 910a1307ac9f..d6f736a1aa2f 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -34,6 +34,7 @@
>  #include <linux/memory.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/swap.h>
> +#include <linux/userfaultfd_k.h>
>  #include <linux/ksm.h>
>  #include <linux/hashtable.h>
>  #include <linux/freezer.h>
> @@ -1463,9 +1464,14 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>  		dec_mm_counter(mm, MM_ANONPAGES);
>  	}
>
> -	/* Preserve soft-dirty when replacing the page. */
> +	/* Preserve soft-dirty and uffd protection when replacing the page. */
>  	if (pte_soft_dirty(orig_pte))
>  		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_uffd(orig_pte)) {
> +		newpte = pte_mkuffd(newpte);
> +		if (userfaultfd_rwp(vma))
> +			newpte = pte_modify(newpte, PAGE_NONE);

OK, so by definition, RWP pages are protnone, and this resets it correctly.

> +	}
>
>  	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
>  	/*
> diff --git a/mm/memory.c b/mm/memory.c
> index 6a93b7fa48b2..99439a7afa63 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4122,8 +4122,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		if (unlikely(unshare)) {
>  			if (pte_soft_dirty(vmf->orig_pte))
>  				entry = pte_mksoft_dirty(entry);
> -			if (pte_uffd(vmf->orig_pte))
> +			if (pte_uffd(vmf->orig_pte)) {
>  				entry = pte_mkuffd(entry);
> +				if (userfaultfd_rwp(vma))
> +					entry = pte_modify(entry, PAGE_NONE);
> +			}

Could this be abstracted? You're doing the same pattern here, which also exists
in copy_present_page() and presumably many other places.

But maybe that's one for a follow up?

>  		} else {
>  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		}
> @@ -6659,9 +6662,12 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
>  		 * NUMA hinting and must still fall through to do_numa_page().
>  		 */
> -		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
> -			return do_uffd_rwp(vmf);
> -		return do_numa_page(vmf);
> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte)) {
> +			if (!(vmf->flags & FAULT_FLAG_UNSHARE))
> +				return do_uffd_rwp(vmf);
> +		} else {
> +			return do_numa_page(vmf);
> +		}
>  	}
>
>  	spin_lock(vmf->ptl);
> --
> 2.49.0
>

--
Cheers, Lorenzo
