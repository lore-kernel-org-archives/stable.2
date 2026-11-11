Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403691;
	b=sLDPRrPwgqSUKZVYOOIdr7QUkmTPhAgZG3fwlRlI+USXz5eLNmjhf2XCR2YqmCJ3cuba
	 pOCJEjuCJ+SWcJMrz7Ewp+oVlkRucB0aK4yoeCCJJz98uD5M3DWCwMOBkZcMTsSIKEL4K
	 50C91RrZLtOu8FfokEwot3Glbhmo6bN95Ic8Fx6pOQ5exlcmfsZ247SDWOy8/AOqKbgUt
	 Q00aD8mdaheBCST5H3DUxGV+43xGSCnLqUmFQXaB5LtZE9KrGfMEx1x6HLnwHTupMOvuQ
	 9A4c1+bP80ot9IMm+JTxAXUrTRfC84p2JjcneCmkH/TfJL++9xTUuJ+03QSrOiZrF0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9yzvDp9V72dMlAIfM00c1rGjJ9jmhjSG6zJg+AYgebE=;
	b=wPSMFL7INOqKY/Bi4iImBwKgqxzK+MPsjb6uTPOKiwiZJkJp62Mg6xRJkAfFmmZKtfJ+
	 YQKAGJks0kJKwNQQnx8LQZE1mCMc9jHvPteMck3gygFcYaGPZTL1SCFUILE8APYU8DHIH
	 oQayBx3BvjNtOFxbD10frDHEjX7SpyDUNOQ1djLMJav/LACJ+e88yI1rWzU+zFSus0xxp
	 ghIUb0827uYbPmuLyRJ7O/Hud0ws4JtYOkM14qGhAYXX0GQBh9jBWr1lyVwdthqLeH+Cg
	 qzOLl9HXRqHwddrWqrWevktNOi4fRrtVcvlFBgbln7QusdNGr1CY2OBEKkMWaYfXtvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqMHcqWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03291606A321;
	Wed, 11 Nov 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqMHcqWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC7B1F00A05;
	Wed, 11 Nov 2026 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403690;
	bh=9yzvDp9V72dMlAIfM00c1rGjJ9jmhjSG6zJg+AYgebE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nqMHcqWNioXm2Og6tdRJrkWbKwC0ujOefOXYCjxvh+lkZt7of1xvfeQt+q+zjLgQU
	 BUyh1Sr8huHwHJuA1ivTE7cvYTdM+BgaI2OwUooGuWdAHky+HVMV3xKJViN+hvdkvF
	 pI3Bqzmra/TY1QWhDj4QwW4e+DtPnkldM+RbLq8OA5GJnYfJ2C4HPyw8lIiaKAqC9F
	 UE++pRPBavhCP4PL709OT8SVK1uHUyQn48DrdttkxZfWS9yluYKPztivIpKSF51b8K
	 KM4d9OvPM8RqXr5VPhokRc/U/EA/VHCCii1pyiGbT5ZQPYADURSLCyL7Yt6lLAanPk
	 EA77fMI7dyxFg==
Date: Wed, 11 Nov 2026 13:27:59 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: don't read young/dirty from a
 non-present PMD in smaps
Message-ID: <avRtKQUdo_oEqyow@gremlin>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-3-usama.arif@linux.dev>
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
In-Reply-To: <20261111113904.650722-3-usama.arif@linux.dev>

On Wed, Nov 11, 2026 at 03:38:30AM -0800, Usama Arif wrote:
> smaps_pmd_entry() passes pmd_young(*pmd) and pmd_dirty(*pmd) to
> smaps_account() for every PMD, including migration and device-private
> entries, where those bits hold part of the swap offset rather than
> accessed/dirty state. smaps_pte_entry() only reads them when the entry
> is present.

Could say something something softleaf here ;)

>
> On x86_64 the offset is stored inverted across bits 9-58, which overlap
> _PAGE_SAVED_DIRTY, so pmd_dirty() returns garbage: a clean 2MB
> device-private mapping is accounted as 2048 kB dirty, and lazyfree
> accounting is suppressed. pgtable_64.h also warns that the hardware can
> set the accessed and dirty bits on non-present entries by mistake.
>
> Only read the bits when the PMD is present.
>
> Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Damn, yikes. LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d1..c0d391186c2b8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1019,13 +1019,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool present = false;
> +	bool present = false, young = false, dirty = false;
>  	struct folio *folio;
>
>  	if (pmd_none(*pmd))
>  		return;
>  	if (pmd_present(*pmd)) {
>  		page = vm_normal_page_pmd(vma, addr, *pmd);
> +		young = pmd_young(*pmd);
> +		dirty = pmd_dirty(*pmd);
>  		present = true;
>  	} else if (unlikely(thp_migration_supported())) {
>  		const softleaf_t entry = softleaf_from_pmd(*pmd);
> @@ -1045,8 +1047,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	else
>  		mss->file_thp += HPAGE_PMD_SIZE;
>
> -	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
> -		      locked, present);
> +	smaps_account(mss, page, true, young, dirty, locked, present);
>  }
>  #else
>  static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> --
> 2.53.0-Meta
>

--
Cheers, Lorenzo
