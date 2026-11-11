Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434415;
	b=Lq9nx31ZUqRWtYqv2BX238y6TlUq15zBZaZe+fykQcsa19wX+uG/INmoCNTXDfA4TUwt
	 UJzmQaURXXhDUrHsyJZmidKw1HtLgDDl+sKZvyPQKJ0rr5fBSkOO/bG+HyNDqVKq7Np5Y
	 nxgwOgvCoIjIMKNfo4xJp6fBZNowwDRhWnaaSAfsFMGnkCZgobOTXApSbjmr/gcayJRCv
	 mHDIWZTdpk0U2SeKtKd6RYefiQnAZUjZlqZMko0wEvfxTPCbY78bNEt/H3InFwcfr4A1d
	 LEu0O8HJn6kZmMegfGyO97i4MjuWWmobXYX1dOLHPQa7aiAPtMGSwJKhwuVYDFGgR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434415;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Klp5K9ghajAt5QsaOTYOAUgTbWlX0z+ZRRZWnWqsMaw=;
	b=hU+MsLM8HfgRodhmMhkDN2QHkZVzmjLaDMU+aL982DrVbmO4gUgFuzutphiHG5V1kInn
	 EDV1iVfM7KMNsTL374JaW7P2WHrOfRWi05mWEjzLle5t8RlIJzL8xazx/5mqzqTVNkpqd
	 CsrzL6YUrju997xtvVbUnprug9ZGLuCdS42LmyG1FQ9SV/uvZGh4wsY/f3HoIXNhRpuFb
	 nWlg7oPPf7Gr+wOOR1Mt0dRf43PkC3uhzDWpYb8rhRbWWvgwGn8jeFZ5578PpQBw0KV7Y
	 utFkWsWxsmaJRfSpa+ta8evltP6ddj+GOX0SmpHO5TvwhPavSIutSabcPeMKx0cAQ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OukkQprC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A38606A8AF;
	Wed, 11 Nov 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OukkQprC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560B71F00A0C;
	Wed, 11 Nov 2026 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434414;
	bh=Klp5K9ghajAt5QsaOTYOAUgTbWlX0z+ZRRZWnWqsMaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OukkQprCZ8BTWe49RBUt3YgTJeQJMbZKVPQeEVjdZrT9CznBowYaEM56Y0XnPfSMH
	 ZMaS5pWq/tFHO7omypC1u7bOSQLrTYaz/WEFZLpLKdJ/v4Pwitnay1MgiS50XFz5od
	 ba5BtleXPHSIMh0nEMl0Fcp77XW/rZ6VsChAK/xB11cv1YDG2Lcjyo6H7zDuIwvPIf
	 Nhs7trqyi2rNwc1Sqjr4Ycr80XG7L/0NBr2dyeGO18KSR7lMyVk0IMq6Qk+3cedyAT
	 x6bEm3XlcZBnHhWI/Tt+TzOAAdD7V94aPECfgkHCGZuzOt8nDNQEUZpdD+tWbzYPu/
	 vFakotApI+kmQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 11 Nov 2026 22:59:59 +0100
Subject: [PATCH 1/3] mm/userfaultfd: fix PTE table overruns in UFFDIO_MOVE
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pte_table_clamped_end-v1-1-2dbe339c487a@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
In-Reply-To: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, 
 Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3966; i=david@kernel.org;
 h=from:subject:message-id; bh=RpUx0NpY9p/6F0IgQ+tlhR7lPz8pKjk2jjthdIXwa2k=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+PE15t2VBklWqZvTEmQ+EdnNohZnO6C+/b7rbatP3N
 xYXc45f7ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiFy8x/I++yXfxRKBCgr59
 Ulqubce2U1USkyIPSK06ZWm4ktts001GhhdiYrznr1mv26KnHbhBZR7HSuaDbeGaTw2N8zrsji9
 0ZgMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

With a folded PMD, pmd_addr_end() simply returns the supplied end.
move_present_ptes() can therefore walk past the source or destination
PTE table during UFFDIO_MOVE.

pmd_addr_end() is only intended for page table traversal, in patterns
like "next = pmd_addr_end(addr, end);". With folded PMDs, a higher level
has already clamped the range to the PTE table.

Folded PMDs are uncommon, but can occur even on arm64, for example
with 64K pages and a 42-bit virtual address space.

Extract the calculation from folio_pte_range() into
pte_table_clamped_end() and use it to clamp both ranges. This preserves
the wraparound handling from commit f681d4580d5c ("mm: fix address
wraparound when scanning large folio PTEs").

Fixes: 50944692052b ("userfaultfd: opportunistic TLB-flush batching for present pages in MOVE")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/pgtable.h | 24 ++++++++++++++++++++++++
 mm/memory.c             |  7 +------
 mm/userfaultfd.c        |  4 ++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b7..66d369870a740 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -12,6 +12,7 @@
 #ifdef CONFIG_MMU
 
 #include <linux/mm_types.h>
+#include <linux/minmax.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <asm-generic/pgtable_uffd.h>
@@ -1518,6 +1519,29 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 })
 #endif
 
+/**
+ * pte_table_clamped_end() - Limit a range to a single PTE table.
+ * @addr: Start address.
+ * @end: Exclusive end address.
+ *
+ * Only use pmd_addr_end() when traversing page tables, in a pattern like::
+ *
+ *     next = pmd_addr_end(addr, end);
+ *
+ * Higher levels already bound the range when PMDs are folded. Use this
+ * helper elsewhere to clamp the range regardless of PMD folding.
+ *
+ * Return: The exclusive end of the PTE table containing @addr, capped at @end.
+ */
+static inline unsigned long pte_table_clamped_end(unsigned long addr,
+		unsigned long end)
+{
+	const unsigned long pmd_end = (addr & PMD_MASK) + PMD_SIZE;
+
+	/* Compare inclusive ends to avoid wraparounds. */
+	return min(pmd_end - 1, end - 1) + 1;
+}
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee2..ee792a2c0ccea 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4959,13 +4959,8 @@ static void folio_pte_range(const struct folio *folio,
 {
 	/* Stay within the page table and VMA boundaries. */
 	const unsigned long pmd_start = addr & PMD_MASK;
-	const unsigned long pmd_end = pmd_start + PMD_SIZE;
 	const unsigned long lower = max(pmd_start, vma->vm_start);
-	/*
-	 * We cannot use pmd_addr_end(), as it does not clamp reliably. To
-	 * avoid wraparounds, compute using the inclusive end.
-	 */
-	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
+	const unsigned long upper = pte_table_clamped_end(addr, vma->vm_end);
 	const unsigned long offset = idx << PAGE_SHIFT;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 169f681f9849b..57650e6f040d1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1266,8 +1266,8 @@ static long move_present_ptes(struct mm_struct *mm,
 	unsigned long src_start = src_addr;
 	unsigned long src_end;
 
-	len = pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
-	src_end = pmd_addr_end(src_addr, src_addr + len);
+	len = pte_table_clamped_end(dst_addr, dst_addr + len) - dst_addr;
+	src_end = pte_table_clamped_end(src_addr, src_addr + len);
 	flush_cache_range(src_vma, src_addr, src_end);
 	double_pt_lock(dst_ptl, src_ptl);
 

-- 
2.43.0

