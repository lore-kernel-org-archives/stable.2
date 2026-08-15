Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A110F2
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761022; cv=none; b=O6iJw73lRhpOG8ydTR2MqEMmBC1MsEuy89jiJK+4H2zSjzvwCVgObS0g1fnlLe2Zv1Dqk7885BLqN+RUEonrpakhOqM7bZ3umuHGJpsSTvsIFWqqpSDS7/syhaLuascO047Bo8fIsSklmTeKp+JvOm0Nnd1AJSS5bftTv0B/h58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761022; c=relaxed/simple;
	bh=PBXo34IDXYYHmHTJUJ/98mxbZMKpc3arcAtYIiZRR5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czJZSvxOywlIDYkiAHdoWpdWHqwje1Px5c1KU33rkcvQ5Q0M4BCdrEYFVUO9I5tVBeW31cMdQT3xZoZowoV39o1DI3+pEFOevqxCCStlbVRGAMBYCnjWy3TKUBxVdYCETJHf6oMetqr8ejkS53sIwJnNTvuEnwsEbLVk5mpk5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw8/4cfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw8/4cfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ED91F00A3A;
	Sat, 15 Aug 2026 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761020;
	bh=GWcK3vw+ZfROYYiQInXv3ie3F3ZDOj52XGou2eB+SMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rw8/4cfbYZQnLkN1N22P3YGLbrtYoC/E1psktRJ9eBADL8AKHqY5Ez6zND84hLknL
	 /VLofjg9vMfoClUpUEPXlXUF15dJitpm0MEBagKWqQUjh1WYHHMATNJH0AdXrcNTEE
	 Lfj+Udc7oCaPzl8qBoGJ7NyMvYLtEI794ves53CDkQ5RpHE9xo6nVgbjVCtFzP0tp9
	 gOBG01qsPoqujg8ftj4UCFTEN/JSqbFS0rcq1KCNYo9unsMo3W9ZSFHcuTz930DxNC
	 SEjZj7VvIIZ2KaKBz7nPO8d4boHDW3dF1xMGdvcOgiPpK8mdgf95My6+ED9pmzprDn
	 JnJXfCYECe6+Q==
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
Subject: [PATCH 6.6.y 1/2] mm/pagewalk: split walk_page_range_novma() into kernel/user parts
Date: Fri, 14 Aug 2026 22:30:15 -0400
Message-ID: <20260815023016.1435522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081329-aftermost-jailer-f18d@gregkh>
References: <2026081329-aftermost-jailer-f18d@gregkh>
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
Stable-dep-of: 26444eb71465 ("mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/dma.c |  4 +--
 arch/riscv/mm/pageattr.c   |  8 ++---
 include/linux/pagewalk.h   |  7 ++--
 mm/internal.h              |  7 ++++
 mm/pagewalk.c              | 72 ++++++++++++++++++++++++++++++++++----
 mm/ptdump.c                |  3 +-
 6 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b3edbb33b621d..0b4c20cc76cb7 100644
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
index 271d01a5ba4da..a35edf662d7ea 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 			if (ret)
 				goto unlock;
 
-			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
+			ret = walk_kernel_page_table_range(lm_start, lm_end,
 						    &pageattr_ops, NULL, &masks);
 			if (ret)
 				goto unlock;
@@ -317,13 +317,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
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
@@ -335,7 +335,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	 */
 	flush_tlb_all();
 #else
-	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
+	ret =  walk_kernel_page_table_range(start, end, &pageattr_ops, NULL,
 				     &masks);
 
 	mmap_write_unlock(&init_mm);
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27cd1e59ccf77..49bf5308786f9 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -117,10 +117,9 @@ struct mm_walk {
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
index f773db493a99d..03cfd9f736597 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/tracepoint-defs.h>
 
@@ -1229,4 +1230,10 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/* pagewalk.c */
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
+			  unsigned long end, const struct mm_walk_ops *ops,
+			  pgd_t *pgd, void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index b7d7e4fcfad7a..20df9f6ccd482 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -527,8 +527,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 }
 
 /**
- * walk_page_range_novma - walk a range of pagetables not backed by a vma
- * @mm:		mm_struct representing the target process of page table walk
+ * walk_kernel_page_table_range - walk a range of kernel pagetables.
  * @start:	start address of the virtual address range
  * @end:	end address of the virtual address range
  * @ops:	operation to call during the walk
@@ -538,12 +537,59 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
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
+ */
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
  */
-int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
+int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
-			  pgd_t *pgd,
-			  void *private)
+			  pgd_t *pgd, void *private)
 {
 	struct mm_walk walk = {
 		.ops		= ops,
@@ -553,10 +599,22 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
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
index e46df2c24d858..616a54c0cc420 100644
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

