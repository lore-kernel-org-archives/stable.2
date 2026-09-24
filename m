Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A35388371;
	Thu, 24 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242911; cv=none; b=p0K6FVlGilzWig5cX05hsRMR4I53rfvxJJbeEQmz44OP60OWZs9U9+FozITv0WPG3mgJ1TjGG1npINY1tDCdKFxPaEXYSWwF/ERvVXbwmZFAlFZu3J4qFFpN5kV3vL3g54ZDIL9tnvh+cXzQO8oHoZGvI6WtcLn9ET0aq8TVa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242911; c=relaxed/simple;
	bh=RBX4B4bKtfjbLqikSvS1byAkRrvTM9BBDT0jb8BgzKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaCHtDIfqc8fJqwOiWUyhnggQOmJMkovB2CuVDxdA3jd1UQA/dUQTCFS0v4V40WDVu2CRgobtp0qPV4+ufxUJFPjD/PR0eztKRZC4mHX4nN9y/DKG4Ivuovv2g5aYGyRYFHRiruCw3C7nFdy0rVd44sXvl/zVi7iF2PfZSSI3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cRYmoBMy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cRYmoBMy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A5E61477;
	Thu, 24 Sep 2026 02:41:43 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32AA63F86F;
	Thu, 24 Sep 2026 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790242907; bh=RBX4B4bKtfjbLqikSvS1byAkRrvTM9BBDT0jb8BgzKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRYmoBMyAkTJmv8S3EwwsWOkLlqls6hnd0e5KRQ3xi4AhCDyvf7ksNzxK1XErIUAy
	 nJ+ZLXa2SkGUcatOXoY7H2SyzYg20ub6vaRxldbJeBmIDvTaJ8EN9jpTjigsokFaaQ
	 O/tGl5ZYwqC6VW0UIe2V5Q6F5Mrr2BAelwR2HdD8=
Date: Thu, 24 Sep 2026 10:41:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dev Jain <dev.jain@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Fix the break-before-make flush range for
 erratum 2645198
Message-ID: <arTwVXOGRSI8MtAM@arm.com>
References: <20260923143636.89480-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923143636.89480-1-parri.andrea@gmail.com>

On Wed, Sep 23, 2026 at 04:36:32PM +0200, Andrea Parri wrote:
> modify_prot_start_ptes() performs the break-before-make TLB invalidation
> required by erratum 2645198 with __flush_tlb_range(), whose third
> argument is the end address of the range.  It passes nr * PAGE_SIZE
> instead of addr + nr * PAGE_SIZE, so __do_flush_tlb_range() computes the
> page count as (nr * PAGE_SIZE - addr) >> PAGE_SHIFT.
> 
> For addr > nr * PAGE_SIZE that subtraction underflows, the page count
> exceeds the batching limit and the flush degenerates to flush_tlb_mm(),
> so a single-page mprotect broadcasts an ASID-wide invalidation and a
> full-range mmu notifier call.
> 
> For addr <= nr * PAGE_SIZE only [addr, nr * PAGE_SIZE) is invalidated,
> and when the cleared batch starts below nr * PAGE_SIZE the tail is left
> in the TLB.  The workaround then no longer covers the whole batch, and
> for addr == nr * PAGE_SIZE the flush is empty.
> 
> On affected Cortex-A715 CPUs, this can corrupt ESR_ELx and FAR_ELx on the
> next instruction abort caused by a permission fault.
> 
> Pass addr + nr * PAGE_SIZE as the end address.
> 
> Fixes: 7efa1cd5f89b5 ("arm64: add batched versions of ptep_modify_prot_start/commit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 79d90226fd5dc..d4384131e10d8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -2295,7 +2295,7 @@ pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
>  		 * in cases where cpu is affected with errata #2645198.
>  		 */
>  		if (pte_accessible(vma->vm_mm, pte) && pte_user_exec(pte))
> -			__flush_tlb_range(vma, addr, nr * PAGE_SIZE,
> +			__flush_tlb_range(vma, addr, addr + nr * PAGE_SIZE,
>  					  PAGE_SIZE, 3, TLBF_NOWALKCACHE);

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
