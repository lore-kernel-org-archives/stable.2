Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028479;
	b=oG+gt0TFhWiIaJCl4NnLUZKW+m6WewiSFMTAY0CPFp7t7CaQgqtrvwaPWjVG+QRXXyCB
	 ox71eT7hqCH6p6YbAty59ZDeU2NySdSDCX6XoHawVYr0+XnHwliuKLiDacvXBictFDbW3
	 7arWNvl9I7KfGDn7zMHf3wNeMQY2HHNC4xdarEIbD0n0xn+QObo35dXPZeu7S64btUGp4
	 5DPjLqkwbVTFSLVXqKW8jymIhjUMWtWl+hSELIpVyjWKuEbeiGA++5ESu7kY/uGAUcAfg
	 4WAuxVLe+lRQ+WOrZudjTS1usjk16nfWe7BIWJuoQ+Q7cgutG2eTadXlbbwBUQQKKCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4YP/4sMLmMrBNwv0rmr3CgPfxwdrbgn3B1FIYdO1TaM=;
	b=Fza+ncgp8ef5matLkVWV1nlQxrTb40N1cOEhlCgjShzuHw6lmC9F96whDT3c1qxXE3Xe
	 tyKV/b97MzWFCS+rdZq7KtRplIpQLbv6yDUzG6HSNHJungiIvNVYEjwsjeFW0V09cUXuh
	 07+xQUn093xqs7Lvg+rMoWA/rOgnBTBVuIeStEhndlvco8znoV+AmmIOschtX9lCaweoi
	 l4N8E5nb3Vu9vK1l8dKrd9l6uszVPGmKk9fMQbVA60kFs14tXS7lSkaN2Adntm4M6PfF5
	 jot3SCMpxp8odNe5KIl8oVPogZhgSyX8WcBCRkgIvRSHASCcykVsiYPFp7dybyST4Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C35Jq0pf;
	arc=none smtp.remote-ip=91.218.175.238
Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BC606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C35Jq0pf
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BD5GR4twj1Y0cxe10dqIpaa4/qJ/AH8RfmV9ehRX730=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793028476; v=1; x=1793633276;
 b=C35Jq0pfAi43X24zs7+pws0mYLmITR+OUzEveCg0XkZvazu8n4wJD73zrHK7x5S+fEpLQuLX
 P49c8d0YGrGpUtVW23hk8Og+UipwHF8cebaDl0rHVHYY/y46DZkmAf4UXIXMFQh48UVakZafxcK
 AZ370RiZGW/kNAJoqjyubAWo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b2b5afc969dd0a08;
	Mon, 26 Oct 2026 15:27:56 +0000
X-Mizu-Trace-ID: b2b5afc969dd0a08
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: alex@ghiti.fr,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: akpm@linux-foundation.org,
	zhangchunyan@iscas.ac.cn,
	rppt@kernel.org,
	kas@kernel.org,
	david@kernel.org,
	andrew+kernel@donnellan.id.au,
	rmclure@linux.ibm.com,
	debug@rivosinc.com,
	baolin.wang@linux.alibaba.com,
	usama.arif@linux.dev,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alexghiti@rivosinc.com,
	viro@zeniv.linux.org.uk,
	ajones@ventanamicro.com,
	arnd@arndb.de,
	axelrasmussen@google.com,
	brauner@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	jack@suse.cz,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	paul.walmsley@sifive.com,
	peterx@redhat.com,
	robh@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	yuanchu@google.com,
	stable@vger.kernel.org,
	pasha.tatashin@soleen.com,
	linux-mm@kvack.org,
	me@ziyao.cc
Subject: Re: [PATCH 1/1] riscv/mm: fix soft-dirty migration PMDs being treated as present
Date: Mon, 26 Oct 2026 23:27:45 +0800
Message-ID: <20261026152745.11239-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261004030312.90163-1-lance.yang@linux.dev>
References: <20261004030312.90163-1-lance.yang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Gently ping ... Hi RISC-V folks, any thoughts on the proposed fix?

On Sun, Oct 04, 2026 at 11:03:12AM +0800, Lance Yang wrote:
>RISC-V uses _PAGE_EXEC for swap soft-dirty tracking when
>CONFIG_MEM_SOFT_DIRTY is enabled and Svrsw60t59b is available. That's
>a problem for PMD migration entries, since pmd_present() also checks
>_PAGE_LEAF (R/W/X) to recognize THPs with _PAGE_PRESENT temporarily
>cleared during splitting.
>
>When a soft-dirty THP is migrated, set_pmd_migration_entry() preserves
>soft-dirty with pmd_swp_mksoft_dirty(), setting the X bit in the
>migration PMD. Even with _PAGE_PRESENT clear, we end up treating a
>migration PMD as a present THP! The fault handler skips
>pmd_migration_entry_wait(), and a write fault can end up in
>do_huge_pmd_wp_page(), where pmd_page() decodes the migration entry
>as a mapped PFN.
>
>Move the swap soft-dirty bit to bit 12 and start the swap offset at
>bit 13 when CONFIG_MEM_SOFT_DIRTY is enabled. This keeps R/W/X clear
>in migration PMDs and lets us keep the existing pmd_present() check
>for invalidated THPs. Leave the offset at bit 12 when soft-dirty
>tracking is disabled.
>
>Fixes: 2a3ebad4db63 ("riscv: mm: add soft-dirty page tracking support")
>Cc: stable@vger.kernel.org
>Signed-off-by: Lance Yang <lance.yang@linux.dev>
>---
>I found this while reviewing Usama's PMD-level swap entries series [1]
>and comparing the swap flag bits with the PMD presence checks across
>architectures.
>
>[1] https://lore.kernel.org/all/20261002095503.3585565-1-usama.arif@linux.dev/
>
> arch/riscv/include/asm/pgtable-bits.h |  6 +++---
> arch/riscv/include/asm/pgtable.h      | 10 ++++++----
> 2 files changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
>index d5a86b4df3ce6..d84b459e010c1 100644
>--- a/arch/riscv/include/asm/pgtable-bits.h
>+++ b/arch/riscv/include/asm/pgtable-bits.h
>@@ -27,12 +27,12 @@
> 	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
> 	 (1UL << 59) : 0)
> /*
>- * Bit 3 is always zero for swap entry computation, so we
>- * can borrow it for swap page soft-dirty tracking.
>+ * Bit 12 is reserved for swap soft-dirty tracking. The swap offset
>+ * starts at bit 13 when CONFIG_MEM_SOFT_DIRTY is enabled.
>  */
> #define _PAGE_SWP_SOFT_DIRTY						\
> 	((riscv_has_extension_unlikely(RISCV_ISA_EXT_SVRSW60T59B)) ?	\
>-	 _PAGE_EXEC : 0)
>+	 (1UL << 12) : 0)
> #else
> #define _PAGE_SOFT_DIRTY	0
> #define _PAGE_SWP_SOFT_DIRTY	0
>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>index b644db16bda94..acaf6d3b54d04 100644
>--- a/arch/riscv/include/asm/pgtable.h
>+++ b/arch/riscv/include/asm/pgtable.h
>@@ -1178,18 +1178,20 @@ static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
>  *
>  * Format of swap PTE:
>  *	bit            0:	_PAGE_PRESENT (zero)
>- *	bit       1 to 2:	(zero)
>- *	bit            3:	_PAGE_SWP_SOFT_DIRTY
>+ *	bit       1 to 3:	_PAGE_LEAF (zero)
>  *	bit            4:	_PAGE_SWP_UFFD
>  *	bit            5:	_PAGE_PROT_NONE (zero)
>  *	bit            6:	exclusive marker
>  *	bits      7 to 11:	swap type
>- *	bits 12 to XLEN-1:	swap offset
>+ *	bit           12:	_PAGE_SWP_SOFT_DIRTY (CONFIG_MEM_SOFT_DIRTY)
>+ *	bits 12/13 to XLEN-1:	swap offset (without/with CONFIG_MEM_SOFT_DIRTY)
>  */
> #define __SWP_TYPE_SHIFT	7
> #define __SWP_TYPE_BITS		5
> #define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
>-#define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
>+#define __SWP_OFFSET_SHIFT \
>+	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT + \
>+	 IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> 
> #define MAX_SWAPFILES_CHECK()	\
> 	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
>-- 
>2.49.0
>
>
