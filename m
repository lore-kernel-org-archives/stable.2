Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2D41D23A;
	Mon,  5 Oct 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196656; cv=none; b=IzNNKd9yOpnHQeaQHwR1mkhYhCq2kB1lYEOlxL3gYGnQSwKgPAfDxy5JAZttmcIeX94j1VTs9YJzCyR6cV5caRb3rfjwOC98RCwIeRfUarIV51MKRiewNUcrGefZc9UASGRrQVXiPPJleslveP3HIJmOEVF8me/V0mBQswP0gnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196656; c=relaxed/simple;
	bh=RDylGjdxj83XUypNAqtDW03hXKOxfYH18mbcAQXXxcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7nqYEEO+7V+mM32p3nowK2UAKsoloZ9aLyEcjc/r6TP95r9ht0GYPvudzv3yyyaKLD9uQNy3Y+G4WgNrHyp+QTZNWW6+F/YxbKIDSyqftZW6PIGydaB048cKZwM1Fww1mpfuQ2Ho0mpUWHnoz6U2oP95/X3+EDOZlq8DhhoIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFzxhi2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFzxhi2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394661F000FF;
	Mon,  5 Oct 2026 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196654;
	bh=cByG7GqhBvWV2hjaYwUvk7XARELXPjKV24/eCyNbhZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UFzxhi2OKhI7lOTnQNuT5HIVGpaxAbS1fgEPpdjeuyurAwRR8AVghIocUlZW6JGwR
	 mnGCuSA4j3JWEpMfC4xPkdvyQAKVzSd/Jkj5tOT+vRbqFF0BcqFAj4HDAiqRyeXpgK
	 rVFOS1s6YKwWKEiM//Z2aU/vsloh6wNr8iUpImltVL/MxI0rmEfGjkQkyLO3tsVRvK
	 npu3l3PXt8mv0PZPj+ZEqOibABFIOqYktx455TvhuC6zXUmzbvs0vEi+sj+Xp5wBKR
	 9N8QlqbV6+nm2AsncAr4ROh3G1k2HdVRDF68iEod47EmNtXDGQTexWFteH0cOtkckq
	 LQ4dPVDY4yBrQ==
Message-ID: <fabd52b6-36a7-442e-9cfb-47a39e4ae3d6@kernel.org>
Date: Mon, 5 Oct 2026 12:37:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv/mm: fix soft-dirty migration PMDs being treated
 as present
To: Lance Yang <lance.yang@linux.dev>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
Cc: alex@ghiti.fr, akpm@linux-foundation.org, zhangchunyan@iscas.ac.cn,
 rppt@kernel.org, kas@kernel.org, andrew+kernel@donnellan.id.au,
 rmclure@linux.ibm.com, debug@rivosinc.com, baolin.wang@linux.alibaba.com,
 usama.arif@linux.dev, wangruikang@iscas.ac.cn, namcao@linutronix.de,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, viro@zeniv.linux.org.uk, ajones@ventanamicro.com,
 arnd@arndb.de, axelrasmussen@google.com, brauner@kernel.org,
 conor.dooley@microchip.com, conor@kernel.org, jack@suse.cz,
 liam@infradead.org, ljs@kernel.org, mhocko@suse.com,
 paul.walmsley@sifive.com, peterx@redhat.com, robh@kernel.org,
 surenb@google.com, vbabka@kernel.org, yuanchu@google.com,
 stable@vger.kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
 me@ziyao.cc
References: <20261004030312.90163-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261004030312.90163-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/26 05:03, Lance Yang wrote:
> RISC-V uses _PAGE_EXEC for swap soft-dirty tracking when
> CONFIG_MEM_SOFT_DIRTY is enabled and Svrsw60t59b is available. That's
> a problem for PMD migration entries, since pmd_present() also checks
> _PAGE_LEAF (R/W/X) to recognize THPs with _PAGE_PRESENT temporarily
> cleared during splitting.

I'm curious: why do we have to set leaf indications for non-present things? The
HW sure will ignore it, right?

Is this a sw problem? Who needs that?

> 
> When a soft-dirty THP is migrated, set_pmd_migration_entry() preserves
> soft-dirty with pmd_swp_mksoft_dirty(), setting the X bit in the
> migration PMD. Even with _PAGE_PRESENT clear, we end up treating a
> migration PMD as a present THP! The fault handler skips
> pmd_migration_entry_wait(), and a write fault can end up in
> do_huge_pmd_wp_page(), where pmd_page() decodes the migration entry
> as a mapped PFN.

That sounds bad.

> 
> Move the swap soft-dirty bit to bit 12 and start the swap offset at
> bit 13 when CONFIG_MEM_SOFT_DIRTY is enabled. This keeps R/W/X clear
> in migration PMDs and lets us keep the existing pmd_present() check
> for invalidated THPs. Leave the offset at bit 12 when soft-dirty
> tracking is disabled.

That reduces the effective swap size (and PFN we can store). Could that be a
problem?

> 
> Fixes: 2a3ebad4db63 ("riscv: mm: add soft-dirty page tracking support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> I found this while reviewing Usama's PMD-level swap entries series [1]
> and comparing the swap flag bits with the PMD presence checks across
> architectures.
> 
> [1] https://lore.kernel.org/all/20261002095503.3585565-1-usama.arif@linux.dev/
> 
>  arch/riscv/include/asm/pgtable-bits.h |  6 +++---
>  arch/riscv/include/asm/pgtable.h      | 10 ++++++----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index d5a86b4df3ce6..d84b459e010c1 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -27,12 +27,12 @@
>  	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
>  	 (1UL << 59) : 0)
>  /*
> - * Bit 3 is always zero for swap entry computation, so we
> - * can borrow it for swap page soft-dirty tracking.
> + * Bit 12 is reserved for swap soft-dirty tracking. The swap offset
> + * starts at bit 13 when CONFIG_MEM_SOFT_DIRTY is enabled.
>   */
>  #define _PAGE_SWP_SOFT_DIRTY						\
>  	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
> -	 _PAGE_EXEC : 0)
> +	 (1UL << 12) : 0)
>  #else
>  #define _PAGE_SOFT_DIRTY	0
>  #define _PAGE_SWP_SOFT_DIRTY	0
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index b644db16bda94..acaf6d3b54d04 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1178,18 +1178,20 @@ static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
>   *
>   * Format of swap PTE:
>   *	bit            0:	_PAGE_PRESENT (zero)
> - *	bit       1 to 2:	(zero)
> - *	bit            3:	_PAGE_SWP_SOFT_DIRTY
> + *	bit       1 to 3:	_PAGE_LEAF (zero)
>   *	bit            4:	_PAGE_SWP_UFFD
>   *	bit            5:	_PAGE_PROT_NONE (zero)
>   *	bit            6:	exclusive marker
>   *	bits      7 to 11:	swap type
> - *	bits 12 to XLEN-1:	swap offset
> + *	bit           12:	_PAGE_SWP_SOFT_DIRTY (CONFIG_MEM_SOFT_DIRTY)
> + *	bits 12/13 to XLEN-1:	swap offset (without/with CONFIG_MEM_SOFT_DIRTY)
>   */
>  #define __SWP_TYPE_SHIFT	7
>  #define __SWP_TYPE_BITS		5
>  #define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
> -#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
> +#define __SWP_OFFSET_SHIFT \
> +	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT + \
> +	 IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>  
>  #define MAX_SWAPFILES_CHECK()	\
>  	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)


-- 
Cheers,

David
