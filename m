Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461041;
	b=XjC6DyYY7EdIU3nNvk4D0K/oRkw9AXFRiagpa/oXzYWY6pdoetNFLpD6eEddnTlCugbc
	 z8Q5J8RvXHrPpGN3cI0pPvwEf0Ileoa7+5AcBhubjJGxVRu6MDmgZOe0TWzfQrwXi2k90
	 3TlOEmbz6e/ZsfY2qH7MIDkLJVS1nyO9UDFbCP+ifkNOj/h8hC4ehWecoiO6XkE9l4zqe
	 Hl3pb937SDiOvJRdreIPplv6DHHv0GLu245MV5q4F41J/X/mgf3EH3coQnemSThXmF5h+
	 VWX2dIU8AUDoAobG4U4fdVyR9yUe9QlHXtE+7NjNjYeP2zlI70CiS9Ts7VgRHcUphiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461041;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7E3MYOWZmAqd5n44b4wTDqjDi7qvsZEFmKsEM+R1X9I=;
	b=y1xnsVZX2vonAolnBcCTfqTu/KScu/1bHf8xluIg2EVAwT0KAPOQwLb5l0xo3nBxagQF
	 Yh7fjM4qcRiGSr5mYWFfBwizVML3GHc5UkUN6Zm8djYdXheZdv1sRozFdT64wD9NkZeN9
	 mFA1qDkAEM8c5bJJ7AJl5aTFi2li41R8SuMOO8iGnz7m59XDxkVnx/tRVk/bRn25ZISvt
	 YsF3Wb/x9gzXRan+H75ZcLWPTo6OeoFStDKVrBI40lFnTRHm/n4NH+o8Fh1U/CmLLWY2K
	 MqSCUQatuZpRIcMGyNGFmqTC7aLhH4zLXz/kzwu0TidLn+zhLNcUwmBSkZVFb019Ssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYfJuhMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44001606A320;
	Tue, 20 Oct 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYfJuhMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7601F000C5;
	Tue, 20 Oct 2026 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461040;
	bh=7E3MYOWZmAqd5n44b4wTDqjDi7qvsZEFmKsEM+R1X9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nYfJuhMF7lVNH8K59PI8SOCo9JhPtzkfmugOIwk/OBLhEZHvcvQAaLetAKbXg+yJ7
	 KseQkgptJXdvJBZGupXNZ+EgKYiNZKWlnjIf8VxiU8xyCCHjTaEeArgkbZgXJuzJJT
	 rKJIidY2vQcPLic1qkRx7yRn0Oz3WeaKIg5jdXE0/3odb12gGsKi8GxM33B9XQQEc0
	 XVmhOgUmuTTf4TOrzg3OQX+4s8A7Tkw+RAt8cNuDxSwq8RaEvVcc2Iz1SVeJx9UbMs
	 7I2MhIodSKTkOvjs1Ctj+g7FxvDOrRhd8VGCgrjzhNDdxlPOr158DZci7RHdwoRLXO
	 E5Hqs+0/KGlLQ==
Date: Tue, 20 Oct 2026 09:30:34 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] riscv: mm: don't let GUP-fast follow entries without
 _PAGE_READ
Message-ID: <atbEOlTjwZ9nr7rG@xhacker>
References: <20261015-riscv-gup-read-fix-v1-1-8cf7f2504029@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-riscv-gup-read-fix-v1-1-8cf7f2504029@nvidia.com>

On Thu, Oct 15, 2026 at 10:37:44PM -0400, Zi Yan wrote:
> riscv maps PROT_EXEC alone as PAGE_EXEC, which has
> _PAGE_EXEC but not _PAGE_READ, and a writable shadow stack entry is
> XWR = 010, which has _PAGE_WRITE but not _PAGE_READ. riscv uses the
> generic pte_access_permitted(), pmd_access_permitted() and
> pud_access_permitted(), which only check that the entry is present and,
> for a write, writable. So GUP-fast follows both kinds of entries:
> 
> - a read, e.g. from vmsplice() or an O_DIRECT write, can read an
>   execute-only page, which userspace cannot load from;
> - a write, e.g. from an O_DIRECT read, can modify a shadow stack page,
>   as pte_write() is true for it.
> 
> Slow GUP rejects both: check_vma_flags() fails a read from a VMA without
> VM_READ and a write to a VM_SHADOW_STACK VMA, unless FOLL_FORCE is set.
> 
> Fix it by requiring both _PAGE_PRESENT and _PAGE_READ in
> pte_access_permitted(), and using it for pmd_access_permitted() and
> pud_access_permitted() too.
> 
> Requiring _PAGE_PRESENT also stops GUP-fast from following a THP PMD
> invalidated by pmdp_invalidate(). x86, arm64, and powerpc do the same
> thing.
> 
> Fixes: 3f910b7a522e ("riscv: enable HAVE_FAST_GUP if MMU")
> Fixes: c68c2ef9d641 ("riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261015-anon_vma_uaf_fix-v1-0-7b977303b42b%40nvidia.com?part=2
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

> ---
> Sashiko found that the riscv pmd_access_permitted() added by the
> lazyfree THP discard rework [1] lets GUP-fast bypass execute-only
> protection. The generic helpers riscv uses today have the same gap, at
> the PTE level too, and the generic pmd_access_permitted() also lets
> GUP-fast follow an invalidated PMD. This patch makes GUP-fast require
> both _PAGE_PRESENT and _PAGE_READ. Requiring _PAGE_PRESENT stops it from
> following a PMD invalidated by pmdp_invalidate(), as x86, arm64, and
> powerpc already do and as the rework relies on.
> 
> While reviewing this patch, an LLM also found that riscv's
> pte_wrprotect() sets _PAGE_READ unconditionally, which turns an
> execute-only entry into a readable one [2], e.g. every execute-only

This issue can be fixed by Nickolai's patch:
https://lore.kernel.org/linux-riscv/20261017162229.796020-1-nickolai@csail.mit.edu/

> hugetlb mapping via make_huge_pte(). That needs a separate fix.
> 
> Link: https://lore.kernel.org/all/20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com/ [1]
> Link: https://elixir.bootlin.com/linux/v7.3-rc7/source/arch/riscv/include/asm/pgtable.h#L409 [2]
> ---
>  arch/riscv/include/asm/pgtable.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 40b1ed4f3ea89..f46b742d6dd93 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -372,6 +372,21 @@ static inline int pte_write(pte_t pte)
>  	return pte_val(pte) & _PAGE_WRITE;
>  }
>  
> +/*
> + * GUP-fast only follows entries that are present and have _PAGE_READ,
> + * and leaves the rest to slow GUP, which checks the VMA: an execute-only
> + * entry and a writable shadow stack entry (XWR = 010) lack _PAGE_READ, a
> + * PROT_NONE or invalidated entry lacks _PAGE_PRESENT. Any other writable
> + * entry is readable too.
> + */
> +#define pte_access_permitted pte_access_permitted
> +static inline bool pte_access_permitted(pte_t pte, bool write)
> +{
> +	const unsigned long need = _PAGE_PRESENT | _PAGE_READ;
> +
> +	return (pte_val(pte) & need) == need && (!write || pte_write(pte));
> +}
> +
>  static inline int pte_exec(pte_t pte)
>  {
>  	return pte_val(pte) & _PAGE_EXEC;
> @@ -820,12 +835,24 @@ static inline int pmd_write(pmd_t pmd)
>  	return pte_write(pmd_pte(pmd));
>  }
>  
> +#define pmd_access_permitted pmd_access_permitted
> +static inline bool pmd_access_permitted(pmd_t pmd, bool write)
> +{
> +	return pte_access_permitted(pmd_pte(pmd), write);
> +}
> +
>  #define pud_write pud_write
>  static inline int pud_write(pud_t pud)
>  {
>  	return pte_write(pud_pte(pud));
>  }
>  
> +#define pud_access_permitted pud_access_permitted
> +static inline bool pud_access_permitted(pud_t pud, bool write)
> +{
> +	return pte_access_permitted(pud_pte(pud), write);
> +}
> +
>  #define pmd_dirty pmd_dirty
>  static inline int pmd_dirty(pmd_t pmd)
>  {
> 
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261015-riscv-gup-read-fix-d657d67d350a
> 
> Best regards,
> --  
> Yan, Zi
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
