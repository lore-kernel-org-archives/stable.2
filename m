Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098295;
	b=qkc/Bv5oi8vDGzeu/3KcVPElOFaA5CFmlJPpuXh0vTHxT74UAO+oLZUWe26EVPpuXPZn
	 wbjGBs3SZaAiHcNO9wXQHP3EjAaZLdrhp3B8owgXneCn9lPDZbpC6aC0Vss1kl0Bm3PDH
	 Z9mymAO3tmvunAKH+brTkDbA10vTgB/CFFWgSPifRFBh+GGa+8Uujh2wyq2unE1QxFUbt
	 aHhF8qXzj7MNRORFhIqn3YczS9BAjrifyaxTKGIM2IPhtWHQ3858xBfjoOsLyYPQoyZXv
	 xL4cZSiPO8mS4sTbUPAYtFlIjtxrpglFBSBynO6m0qxAIoXof7a9Q2VwovOS8B0oN7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yh04qxgrTE0t9Qiy350KcpsHv2F2CP3xlLrXbQ4gfzA=;
	b=Bx03l/FG7qwvlpSV9Z6mAYld5ZUJ6HGio4X6EZP55cV9+VzwEQKYqnuHKa2NhG4tCIsL
	 FR4qhFFYkrXDIfnAfogrdKb8o//TZAbehSmEhTg91oecRw4rgSzAU3bSyn7wgr+rmMbp9
	 P3xHcK0P3/4+03nArzuD6XClOyYO6/6YjhbmTAPPtI/Ok6fV05xuwyyjYsDjXRy5q7+ng
	 RMAhADRuRnBJZr7PaoHEOzxtzi7Op2BnPtX6jtdEvWqTiii0BDcIMrRu+OwUrEpst/mAr
	 uApU80qHw7C4p2vneNbjvPsoFf+6eDiMfKwQCNDLpKUdi64yKTGlIrXbLnGdlOKH9Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9s92eRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A4606A320;
	Thu, 19 Nov 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9s92eRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E1D1F000C5;
	Thu, 19 Nov 2026 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098295;
	bh=yh04qxgrTE0t9Qiy350KcpsHv2F2CP3xlLrXbQ4gfzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R9s92eRVO5KZjAlc1LnkaSV0Fh04CAjiJvc/nVRN4ystnHTnuZ5Oux6IA2R7aQwsp
	 tk+1qgVU0Ju6+QKo7RNnORInuvYaHCpjjx5rAfXUtXu5LY+sPcRU+ZMR0MNav1O/0w
	 MuKCiD5XyByr8Us88gspOmznkYFtNPaZrhX55hCjZZPmC0DH+MXFD9T/uqx2aVFDXL
	 iZqKjgPCeE+Y9lpXKUDP57Z0h/rBA4g3Y6uuGWl5regeiYHqtgDriEZXSuOfrOYyN7
	 6j+7WxKLWVhGa9sR7uJCCMhrqRRqJ6Cgm9T2IFwvajsFxm8ht2WFnjpTUb6sfDKHBq
	 AviYZY2QAtMjQ==
Date: Thu, 19 Nov 2026 14:24:48 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Qi Zheng <qi.zheng@linux.dev>, 
	Tal Zussman <tz2294@columbia.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/mprotect: don't skip uffd marker install when racing
 with PTE table reclaim
Message-ID: <av8EisTx8vlYID0b@gremlin>
References: <20261107-uffd_shmem_marker-v1-1-91fa2d653cfe@kernel.org>
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
In-Reply-To: <20261107-uffd_shmem_marker-v1-1-91fa2d653cfe@kernel.org>

On Sat, Nov 07, 2026 at 12:28:55AM +0100, David Hildenbrand (Arm) wrote:
> change_pmd_range() populates PTE tables before installing uffd-wp
> markers. An empty PTE table can be removed after change_pmd_prepare()
> returns but before the pmd_none() check.

These *** wp markers man :)

>
> That check then skips the range, allowing UFFDIO_WRITEPROTECT to report
> success without installing the required markers. Subsequent writes by
> userspace to these areas will not trigger uffd events.
>
> PTE table reclaim during MADV_DONTNEED and page table retraction during
> khugepaged can trigger this.
>
> Retry page-table allocation in that case. Simplify the code, getting
> rid of change_pmd_prepare() by routing all code through the "again" label.
>
> It's a small race though, so likely this is not very urgent.
>
> Fixes: fe2567eb5521 ("mm/shmem: allow uffd wr-protect none pte for file-backed mem")
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> I expect Andrew to pick this up.
> ---
>  mm/mprotect.c | 48 +++++++++++-------------------------------------
>  1 file changed, 11 insertions(+), 37 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index e18d4e12fc341..ef4e7188e24da 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -470,25 +470,8 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
>  }
>
>  /*
> - * Populate the pgtable underneath for whatever reason if requested.
> - * When {pte|pmd|...}_alloc() failed we treat it the same way as pgtable
> - * allocation failures during page faults by kicking OOM and returning
> - * error.
> - */
> -#define  change_pmd_prepare(vma, pmd, cp_flags)				\
> -	({								\
> -		long err = 0;						\
> -		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
> -			if (pte_alloc(vma->vm_mm, pmd))			\
> -				err = -ENOMEM;				\
> -		}							\
> -		err;							\
> -	})
> -

Oh lord... glad to see the back of this!

> -/*
> - * This is the general pud/p4d/pgd version of change_pmd_prepare(). We need to
> - * have separate change_pmd_prepare() because pte_alloc() returns 0 on success,
> - * while {pmd|pud|p4d}_alloc() returns the valid pointer on success.
> + * Populate the lower-level page table if marker installation requires it.
> + * Return -ENOMEM on allocation failure.
>   */
>  #define  change_prepare(vma, high, low, addr, cp_flags)			\
>  	  ({								\
> @@ -517,30 +500,21 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
>  again:
>  		next = pmd_addr_end(addr, end);
>
> -		ret = change_pmd_prepare(vma, pmd, cp_flags);
> -		if (ret) {
> -			pages = ret;
> -			break;
> -		}
> -
> -		if (pmd_none(*pmd))
> +		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {
> +			if (pte_alloc(vma->vm_mm, pmd)) {
> +				pages = -ENOMEM;
> +				break;
> +			}
> +		} else if (pmd_none(*pmd)) {
>  			goto next;
> +		}
>
>  		_pmd = pmdp_get_lockless(pmd);
>  		if (pmd_is_huge(_pmd)) {
>  			if ((next - addr != HPAGE_PMD_SIZE) ||
>  			    pgtable_split_needed(vma, cp_flags)) {
>  				__split_huge_pmd(vma, pmd, addr, false);
> -				/*
> -				 * For file-backed, the pmd could have been
> -				 * cleared; make sure pmd populated if
> -				 * necessary, then fall-through to pte level.
> -				 */
> -				ret = change_pmd_prepare(vma, pmd, cp_flags);
> -				if (ret) {
> -					pages = ret;
> -					break;
> -				}
> +				goto again;
>  			} else {
>  				ret = change_huge_pmd(tlb, vma, pmd,
>  						addr, newprot, cp_flags);
> @@ -554,7 +528,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
>  					goto next;
>  				}
>  			}
> -			/* fall through, the trans huge pmd just split */
> +			/* The PMD might have been split. */
>  		}
>
>  		ret = change_pte_range(tlb, vma, pmd, addr, next, newprot,
>
> ---
>
> base-commit: a3d27154a205f6b32000e7e2734b2a6a4d22c65b
>
> change-id: 20261107-uffd_shmem_marker-a0b9869d783c
>
> --
>
> Cheers,
>
> David
>

--
Cheers, Lorenzo
