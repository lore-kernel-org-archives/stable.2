Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362769;
	b=WYXU6kPDTvmZ5hT8lYOjN8pmNbtu3wjC2ZU8AnDms6IVWD1TJXU3HKBCs4/RphKwcO6f
	 lySQiXYLXo+0ihwnwBkUoyP6f4Kwig6MGufZPjtNqcYKxM/sGMCoQqdsxrcvaoUHthGTM
	 Cd9gu5yO2tShOKET6Y2uFIts24keX4flLJrNd9H0KgAL/aiq03o+vIu23s7jUB0y3X6oB
	 wqX5oBz9Kt+/889XEvBMsakyKAtkmFJepnNSQEzZfjhg8btoH5TonzvZxf5YnRuxpQTLc
	 +swzHv/ZNjlCVzReHk8yeSDKEmAhc+bHFhcYrWqiYnnPfPRiYrMp/gBPACjouCmhQlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362769;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pEOu/AQvgU0OKb5AZqRCUfaOk8gDp8NvYhcCjCvB5JU=;
	b=KZ9NC3rWeWVxVZK756u/0h/nrPy/VgVXorNgdPTD6Hhh1CcPvm+Z+5nsMLNaS5MiEWZQ
	 VJYnZzIioaQO4WfqXPztNmL7QyekZtj1Tqfq0lBKYmEy3nqX83Q+bTXKdJII4jRfcH9RY
	 yF4I3+ckOje6H7YMEBCW2sJeJUHlbqfmwW0LkwUcd6HTfXM6icrlguXkABuZYTzTpxDtV
	 I8hNK/Fg0mJ86511W9jEHpMS/g1imafaez/ej3f2evH6cPxou3M5WPICiTkIpcRGAt4fz
	 aO1XsZwsyOh4632SOeERWjQXOsanRG78si0P9WuOEPSqu68ypcNEMHzuThOkv5brtPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1GRqgVU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC90606A31C;
	Fri, 30 Oct 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1GRqgVU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBC11F000C1;
	Fri, 30 Oct 2026 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362768;
	bh=pEOu/AQvgU0OKb5AZqRCUfaOk8gDp8NvYhcCjCvB5JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z1GRqgVU4WIj2ovDw33wHVQ50+wcmPd8/iVAG4of6NAt3Rr/AR7PDuT4d8fAQTMtU
	 wXSiDpUBRzGwYOqpuW+G8+Owc6KG88nWoM0t0B9s2tP9+OeTyS8Peqtp9md0yYQYvP
	 d7Q0dFsYSX/Wu1Gd0vyfD8cIc4sNL96m2fr8q7Tr6vc2TlNNvgMPQVwhPnAPZ2qgNy
	 9GdRSJFsFof5PtAPP8aa93iHTxTmUTpJT5ygcEksnW7AFb+PSD7rnPpu9om4ZLsKKj
	 bUNOC/W6HS4UoE600ZsgdUDzGm0y+xdV/sXbDBY2EmdQW1XOZ93Cn2O45iEB5tNixz
	 aN1QY4oHSWwlw==
Date: Fri, 30 Oct 2026 14:19:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct
 pages with PMDs
Message-ID: <auSLSIwUi2xNIYua@kernel.org>
References: <20261030115326.1005755-1-songmuchun@bytedance.com>
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
In-Reply-To: <20261030115326.1005755-1-songmuchun@bytedance.com>

On Fri, Oct 30, 2026 at 07:53:25PM +0800, Muchun Song wrote:
> PowerPC radix vmemmap population can reuse an existing PMD mapping for
> a device DAX range marked HVO-enabled. The reused mapping is ordinary:
> its tail struct pages are not remapped to the shared tail page.
> 
> Leaving the section marked HVO-enabled makes memmap_init_zone_device()
> treat the range as optimized and skip initializing real tail struct pages
> that remain in use. This first triggers a zone mismatch warning, then
> faults while initializing the pageblock flags:
> 
>   WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>   Call Trace:
>     memmap_init_zone_device+0x164/0x430
>     memremap_pages+0x43c/0x93c
>     devm_memremap_pages+0x3c/0xa4
>     dev_dax_probe+0x264/0x3d0
>     dax_bus_probe+0x140/0x1c8
> 
>   BUG: Kernel NULL pointer dereference on read at 0x00001400
>     __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>     memmap_init_zone_device+0x358/0x430
> 
> Without these diagnostics, the uninitialized metadata remains latent until
> userspace accesses the device DAX range and triggers a later panic.
> 
> Mark the section non-HVO when reusing a PMD mapping so its state matches
> the actual vmemmap layout and core ZONE_DEVICE code initializes all real
> struct pages.
> 
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so this patch cannot be applied directly to some older
> kernels. Older kernels instead need to pass the vmemmap bounds to a
> range-aware vmemmap_can_optimize() and reject optimization on PowerPC if
> a PMD leaf overlaps the range. This reuses the existing mapping normally
> and makes core ZONE_DEVICE code initialize all real tail entries.
> 
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> v2:
> - Rewrite the commit message.
> - Describe the range-aware vmemmap_can_optimize() fix for older kernels
> - Note that kernels through v7.3 require a different stable fix
>   (suggested by Ritesh Harjani)
> - Collect Tested-by from Pavithra Prakash
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 44868b62b14e..4f75f10ed68f 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>  			return -ENOMEM;
>  
>  		if (pmd_leaf(READ_ONCE(*pmd))) {
> -			/* existing huge mapping. Skip the range */
> +			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
> +			struct mem_section *ms = __pfn_to_section(addr_pfn);
> +
> +			/*
> +			 * Existing PMD mappings can cover the edges of a valid
> +			 * HVO populate range. They are ordinary vmemmap mappings,
> +			 * so the current section must not be treated as HVO-backed
> +			 * when its struct pages are initialized later.
> +			 */
> +			section_set_compound_order(ms, 0);
>  			next = pmd_addr_end(addr, end);
>  			continue;
>  		}
> 
> base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.
