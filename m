Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31544A412
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151376; cv=none; b=rC70fvyPVGvfVv4/aP9oTxo5FSGP29U3gskGMbHPAun6+2B6hLDljiXKltuNrCt6De+U0k1810SFyfMeNHMx9YVR6DsHCWRqhaff/h1j1Ktlz/0M57Sj7AlAtV8l0ZRMwWe6AuMCrtZB9VBt0jPdbnIRayAANiclR9H4n74dhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151376; c=relaxed/simple;
	bh=Z4GS+Rj9+9cjjFlBmN2koONv6Me0KH+Sgzhf8AxQP84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvouKy0yQxeFY+ydivwdmxSiGQAonOTJJc3kPUa2EdnOTfQA7pNMHZY1I0U/x8KLfc75GUHfOg3U79WzXJSx+iC5EJ4ZYLWlWaX7L+E3LfSNRytcpapzILp3C9fWnJDKnXj5olYZc9SxI5ArvHlzR11/ACvNOd3/osrsuUofsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEgcXUl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEgcXUl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D84F1F000E9;
	Wed, 19 Aug 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151367;
	bh=0oYdCRKiBRSRm5fxQYnejrNsw3E0znEh6B02bSvq7E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CEgcXUl4cA5tW78vu9GZhaayMhx7ElNymJF5T/dYmj4NnoM5eIykxbiM/QaPhuL4g
	 rS73snBoKhM2UWOjz5h8BizQmDvoIXI15dU6bUrLNL8+Wsi103Ymb0RuUZbATAgHHS
	 YOY5y0N+4UzJfc4r0MNrWAmhmpfhB+AlCkI0Nsotbx4rD0+CARBRqdbHOywaHAhaiK
	 S098TC592QBIxEdiez1WlL85+5qalJ38EzUI1YhQtfPGDYR9KkenSp/HHrOyJBNKlg
	 KubvHftqNddvMN5cTsbYyRxcy9qZqnI95KNC+8EsXQdW6IYJGw3My8Y5DUM3doSNHN
	 ILQrKL26DD6og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Barry Song <baohua@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jonas Bonn <jonas@southpole.se>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mm/pagewalk: split walk_page_range_novma() into kernel/user parts
Date: Wed, 19 Aug 2026 10:56:00 -0400
Message-ID: <20260819145602.3898518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081757-agreed-lagging-0a18@gregkh>
References: <2026081757-agreed-lagging-0a18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit 96d81e4766f9e88b66a0502b5a7f34a4c20ac754 ]

walk_page_range_novma() is rather confusing - it supports two modes, one
used often, the other used only for debugging.

The first mode is the common case of traversal of kernel page tables,
which is what nearly all callers use this for.

Secondly it provides an unusual debugging interface that allows for the
traversal of page tables in a userland range of memory even for that
memory which is not described by a VMA.

It is far from certain that such page tables should even exist, but
perhaps this is precisely why it is useful as a debugging mechanism.

As a result, this is utilised by ptdump only.  Historically, things were
reversed - ptdump was the only user, and other parts of the kernel evolved
to use the kernel page table walking here.

Since we have some complicated and confusing locking rules for the novma
case, it makes sense to separate the two usages into their own functions.

Doing this also provide self-documentation as to the intent of the caller
- are they doing something rather unusual or are they simply doing a
standard kernel page table walk?

We therefore establish two separate functions - walk_page_range_debug()
for this single usage, and walk_kernel_page_table_range() for general
kernel page table walking.

The walk_page_range_debug() function is currently used to traverse both
userland and kernel mappings, so we maintain this and in the case of
kernel mappings being traversed, we have walk_page_range_debug() invoke
walk_kernel_page_table_range() internally.

We additionally make walk_page_range_debug() internal to mm.

Link: https://lkml.kernel.org/r/20250605135104.90720-1-lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Barry Song <baohua@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 27c32e553834 ("mm/ptdump: always stabilise against page table freeing using init_mm")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/dma.c |  4 +--
 arch/riscv/mm/pageattr.c   |  8 ++---
 include/linux/pagewalk.h   |  7 ++--
 mm/internal.h              |  6 ++++
 mm/pagewalk.c              | 74 ++++++++++++++++++++++++++++++++++----
 mm/ptdump.c                |  3 +-
 6 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b3edbb33b621..0b4c20cc76cb 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -75,7 +75,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * them and setting the cache-inhibit bit.
 	 */
 	mmap_write_lock(&init_mm);
-	error = walk_page_range_novma(&init_mm, va, va + size,
+	error = walk_kernel_page_table_range(va, va + size,
 			&set_nocache_walk_ops, NULL, NULL);
 	mmap_write_unlock(&init_mm);
 
@@ -90,7 +90,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 
 	mmap_write_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
-	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
+	WARN_ON(walk_kernel_page_table_range(va, va + size,
 			&clear_nocache_walk_ops, NULL, NULL));
 	mmap_write_unlock(&init_mm);
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index d0557a4ab8f9..4bcdd2e2550a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -298,7 +298,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			if (ret)
 				goto unlock;
 
-			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+			ret = walk_kernel_page_table_range(lm_start, lm_end,
 						    &pageattr_ops, NULL, &masks);
 			if (ret)
 				goto unlock;
@@ -316,13 +316,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 		if (ret)
 			goto unlock;
 
-		ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+		ret = walk_kernel_page_table_range(lm_start, lm_end,
 					    &pageattr_ops, NULL, &masks);
 		if (ret)
 			goto unlock;
 	}
 
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_kernel_page_table_range(start, end, &pageattr_ops, NULL,
 				     &masks);
 
 unlock:
@@ -334,7 +334,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	 */
 	flush_tlb_all();
 #else
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_kernel_page_table_range(start, end, &pageattr_ops, NULL,
 				     &masks);
 
 	mmap_write_unlock(&init_mm);
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 2f8f6cc980b4..5c44e205bc6e 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -95,10 +95,9 @@ struct mm_walk {
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
-int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
-			  unsigned long end, const struct mm_walk_ops *ops,
-			  pgd_t *pgd,
-			  void *private);
+int walk_kernel_page_table_range(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
diff --git a/mm/internal.h b/mm/internal.h
index 16a4a9aece30..dda3c9a46bf8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/tracepoint-defs.h>
 
@@ -895,4 +896,9 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+/* pagewalk.c */
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, const struct mm_walk_ops *ops,
+			  pgd_t *pgd, void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5295f6d1a4fa..2ce806bbd3da 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -4,6 +4,8 @@
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
 
+#include "internal.h"
+
 /*
  * We want to know the real level where a entry is located ignoring any
  * folding of levels which may be happening. For example if p4d is folded then
@@ -483,8 +485,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 }
 
 /**
- * walk_page_range_novma - walk a range of pagetables not backed by a vma
- * @mm:		mm_struct representing the target process of page table walk
+ * walk_kernel_page_table_range - walk a range of kernel pagetables.
  * @start:	start address of the virtual address range
  * @end:	end address of the virtual address range
  * @ops:	operation to call during the walk
@@ -494,12 +495,59 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * Similar to walk_page_range() but can walk any page tables even if they are
  * not backed by VMAs. Because 'unusual' entries may be walked this function
  * will also not lock the PTEs for the pte_entry() callback. This is useful for
- * walking the kernel pages tables or page tables for firmware.
+ * walking kernel pages tables or page tables for firmware.
+ *
+ * Note: Be careful to walk the kernel pages tables, the caller may be need to
+ * take other effective approaches (mmap lock may be insufficient) to prevent
+ * the intermediate kernel page tables belonging to the specified address range
+ * from being freed (e.g. memory hot-remove).
  */
-int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
+int walk_kernel_page_table_range(unsigned long start, unsigned long end,
+		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
+{
+	struct mm_struct *mm = &init_mm;
+	struct mm_walk walk = {
+		.ops		= ops,
+		.mm		= mm,
+		.pgd		= pgd,
+		.private	= private,
+		.no_vma		= true
+	};
+
+	if (start >= end)
+		return -EINVAL;
+
+	/*
+	 * Kernel intermediate page tables are usually not freed, so the mmap
+	 * read lock is sufficient. But there are some exceptions.
+	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
+	 * to prevent the intermediate kernel pages tables belonging to the
+	 * specified address range from being freed. The caller should take
+	 * other actions to prevent this race.
+	 */
+	mmap_assert_locked(mm);
+
+	return walk_pgd_range(start, end, &walk);
+}
+
+/**
+ * walk_page_range_debug - walk a range of pagetables not backed by a vma
+ * @mm:		mm_struct representing the target process of page table walk
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @pgd:	pgd to walk if different from mm->pgd
+ * @private:	private data for callbacks' usage
+ *
+ * Similar to walk_page_range() but can walk any page tables even if they are
+ * not backed by VMAs. Because 'unusual' entries may be walked this function
+ * will also not lock the PTEs for the pte_entry() callback.
+ *
+ * This is for debugging purposes ONLY.
+ */
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
-			  pgd_t *pgd,
-			  void *private)
+			  pgd_t *pgd, void *private)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
@@ -509,10 +557,22 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		.no_vma		= true
 	};
 
+	/* For convenience, we allow traversal of kernel mappings. */
+	if (mm == &init_mm)
+		return walk_kernel_page_table_range(start, end, ops,
+						    pgd, private);
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 
-	mmap_assert_write_locked(walk.mm);
+	/*
+	 * The mmap lock protects the page walker from changes to the page
+	 * tables during the walk.  However a read lock is insufficient to
+	 * protect those areas which don't have a VMA as munmap() detaches
+	 * the VMAs before downgrading to a read lock and actually tearing
+	 * down PTEs/page tables. In which case, the mmap write lock should
+	 * be held.
+	 */
+	mmap_assert_write_locked(mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 8e29b90d6bc3..0b8c9eb6aa29 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -3,6 +3,7 @@
 #include <linux/pagewalk.h>
 #include <linux/ptdump.h>
 #include <linux/kasan.h>
+#include "internal.h"
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
@@ -155,7 +156,7 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 	get_online_mems();
 	mmap_write_lock(mm);
 	while (range->start != range->end) {
-		walk_page_range_novma(mm, range->start, range->end,
+		walk_page_range_debug(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
-- 
2.53.0

