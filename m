Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE345039;
	Thu, 24 Sep 2026 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790225168; cv=none; b=V33b948MYER3KqPkTvz+VDe4LiwJp1lWzqVp4jrD6jiRtc1Y+n5fcl9zK/1UvtLsnQ01vl/FotfgzY4u5FDECkdeDgFUrfhmCpcxUrVxV3O/se+AiWA/uOodSrAyxeSoo105xudzEi5dARQtEpn/GQkdVKEd0IpukghaBA5Tmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790225168; c=relaxed/simple;
	bh=twJdAsaPAodbcF/MI4mhg53E/bpYg9gpDeHwjpTU600=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOKG/WFY7YrWLt6ltnJppnkuVS8VqNNpUF7rF8tiw1QV/NwA0FU2SxrOvi1JC9dHIGoamFdfe7Q7IBO6Zlow4CQK+2I6Wg49MpJmK8yyGhFIePsSVE9k9CO/XZcJ1mfmKmC3JdPExENvTQ6H52DUUVX7iHtTIr7cFbmu2Z/jPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZsnSmBfs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZsnSmBfs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20843143D;
	Wed, 23 Sep 2026 21:46:02 -0700 (PDT)
Received: from [10.164.19.30] (unknown [10.164.19.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3643F86C;
	Wed, 23 Sep 2026 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790225165; bh=twJdAsaPAodbcF/MI4mhg53E/bpYg9gpDeHwjpTU600=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZsnSmBfszOm6qzkEvFPgQjQ0kQZ5rsw/V9DHea66UnB7W7VSv5h9Ddq4TabOy99Wh
	 XMueywuU9wOiu50kH2brG1fCB0yg3HCNcInkPkgPSEf8VkYfVkp1Wa3Zv1icE/xGNZ
	 zE0kADTabnlTDAY+7Dmq3XLFBQ9ZCA3SmxNMKe9Y=
Message-ID: <27fbf794-6fbb-44e3-91e7-d2ae86aae9af@arm.com>
Date: Thu, 24 Sep 2026 10:15:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Fix the break-before-make flush range for
 erratum 2645198
To: Andrea Parri <parri.andrea@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260923143636.89480-1-parri.andrea@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260923143636.89480-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/09/26 8:06 pm, Andrea Parri wrote:
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

Thanks, such typos should be filtered out by LLMs nowadays : )

Reviewed-by: Dev Jain <dev.jain@arm.com>


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
>  	}
>  

