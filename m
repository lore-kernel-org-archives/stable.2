Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750745;
	b=Fez70vhzVqTKmIroEbObPR9XxjuyAUKOMQ+n4Oa70zPwQFyySyEM8KEd9s05I+QWCSQm
	 +sXbu5Zc3FdC6WtzSHWm56qY00dmjcp0bDYMt0sA4tbpE5VeGis3rNEwj/TYK/JhlYeep
	 TQo1NrR3sDNtAdl/o8mJpmOpBMQ037yFvOyWTcw8KXomE8nq+bndnYrl5h12hK3sNQq3Y
	 vFCrFNrcrdCDoKSm35YSvsCAerRylQCzkwFIDu+m9DB0SyZCWbRaYjPi8YCFqi2cvhTxS
	 X2UoziDZ4YJ+6qz2v6nt+EtVxho5A3/up3+4ofswMlmN3t+qJRc1RYu4Q2IxH2dcFmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750745;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xVoPvZV32EnV3nhq+nvsH8tkgnbU6lXXBkfpvhV3RiQ=;
	b=M/TIZKu87SSmREEeRWR9cFiMc3PzEqI2+C+vH7eDbREIRFr0hAgQpOkaG4N+Zw6yf4SQ
	 GZv38BvlAw4Nv0UTnP0d54XXWhmYEc5joV1isX/e/9xWHFF5W/knCxhABQOtd8PUXu9AL
	 MFYx1bYKTxZsMlHpiU4oyzp6sx4nlNxArzxcYrWNA7gbzoOiaYJAq4wUQiqlK4Ux56qb+
	 7oOMu/irtAvY4QGLZOjQMAWgqCLiDZAcB3T4SztISltzA4AGpSG4oKX2HkwFd7Wk57Ixa
	 eBTz34BsmL/WgEx9MWdbbeRAI2/phb5P/AbhtPUrDWYb9mBPdZ4QMBmt1cNRtAtoTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=H87Iowrz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C226606A31B;
	Fri, 23 Oct 2026 10:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C226606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=H87Iowrz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3502A1650;
	Fri, 23 Oct 2026 03:19:00 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AFBD3F7B4;
	Fri, 23 Oct 2026 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792750743; bh=cTejc6vMr58Bc8gk6KW2BncO0y2Cvz1clpAKwoF7/Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H87IowrzP0rj9C3cOW7Vzu9QCUMfiSLZ0/G+PHAGddRwpJrTeToyiptqu8vx7+3pH
	 w8RG+x0XddtHFphc6crHsU1gk8O6PWmj3qeZaN0M0Ly+45BVp2wb77l+7WxSJLLoTm
	 DUEPs9U6xhyWQsEoNRpuxhalPnHIewHnLwfzo0Zw=
Date: Fri, 23 Oct 2026 15:48:59 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Dave Hansen <dave.hansen@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 4/4] arm64/mm: fix destructor for unconstructed
 hotplug page tables
Message-ID: <4vrj226au2t5cyjsgqem7bami3tsgn57zcbw6cbedhkutknnh3@p4hngiltvm6j>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
 <20261023063428.3658761-5-songmuchun@bytedance.com>
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
In-Reply-To: <20261023063428.3658761-5-songmuchun@bytedance.com>

On Fri, Oct 23, 2026 at 02:34:28PM +0800, Muchun Song wrote:
> Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
> hot-removed page tables") made free_hotplug_pgtable_page()
> unconditionally run the page-table destructor. This matches page tables
> allocated by the arm64 mapping code, which runs the corresponding
> constructors.
> 
> However, arm64 also uses the generic sparse-vmemmap population code.
> Runtime intermediate page tables allocated by that code do not run a
> page-table constructor. Freeing one during memory hot-remove therefore
> runs a destructor without a matching constructor and corrupts
> NR_PAGETABLE accounting.
> 
> Free intermediate page-table pages through pagetable_free(). It runs the
> destructor only for constructor-backed pages and then releases the page
> through the page-table freeing path.
> 
> Fixes: c594b83457cc ("arm64: mm: call pagetable dtor when freeing hot-removed page tables")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v3:
> - Collect Acked-by from David Hildenbrand
> - Collect Reviewed-by from Kevin Brodsky
> 
> v2:
> - Free intermediate tables through pagetable_free() (suggested by David
>   Hildenbrand)
> - Update the commit message for the page-table freeing path
> ---
>  arch/arm64/mm/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 79d90226fd5d..4dce8fa227c3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1495,8 +1495,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
>  
>  static void free_hotplug_pgtable_page(struct page *page)
>  {
> -	pagetable_dtor(page_ptdesc(page));
> -	free_hotplug_page_range(page, PAGE_SIZE, NULL);
> +	pagetable_free(page_ptdesc(page));
>  }
>  
>  static bool pgtable_range_aligned(unsigned long start, unsigned long end,
> -- 
> 2.54.0
> 
