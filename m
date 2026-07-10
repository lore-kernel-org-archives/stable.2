Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171C3242B0;
	Fri, 10 Jul 2026 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680633; cv=none; b=cf66VwCIdnJPVBqwGijrwHIPhMKIdtsKRJgdp2Aj/zFo1n4ApzfcAbNr8Ml+uGr75nX7f2sBhBLquveBkHmvR0m5tZfQUAavFVtH367COtoUyjbWqyxRfd7Lur/o3kYtX3AuppcpjD1Tbw3r7Q558oJOaD/j31+XpaajgzsBM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680633; c=relaxed/simple;
	bh=pMaPtDJt0ShPbK+WGVtxo1vXVrnpLL6Uol/iznePM7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqJ6NaeeesSJx+7FD/4UTWsJichGpQQaTKRHtV+gYKF4qtNmrkfEQ6Osfg9Xa5G20kOdRnCzWF0DYKk3wxaom7nmERuPZ69lTzky+d5LjNLMp3/VDsMz2qARgCvCfFu5tDbNEvaMgMj25wlhNiq67ToZ/awSMkiUOmwyFS9uifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEwjQS/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEwjQS/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D7F1F000E9;
	Fri, 10 Jul 2026 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680631;
	bh=aRHoo+mgtB+E/3rZwAPhfiNBBrkoBFkoDllGXhiaJEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nEwjQS/VZOhUggte99drcvVPcMEQN9te5OG6eie9RrKCigSlYWF1MtJD9xfosdKRj
	 6f3oEbix/q3rRdqam/cKBHLSitJkMKx74m7vw086xz64HpmFkdRf8d1md72mJ4IvQI
	 VKCbPehC+lC2v/GQr5uhJmx6FU7q9DMHFxKRpdVsniJHkqZIJctUhH8NM39KnW3IFT
	 m6AAxTwIWfs82mecH2bNyIA4WOrsHCoNY96BvEtptShh0demCBL4JckCWyGd1SImjX
	 Kys90TLBrmIrKbr7/jmiP9IVrmd2iP9trQ2F41+Rzp/nAHM4YZoMESJ3rqrzUDGaAU
	 4yJcY/SLc77Zw==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Fri, 10 Jul 2026 11:49:18 +0100
Subject: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
In-Reply-To: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10155; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pMaPtDJt0ShPbK+WGVtxo1vXVrnpLL6Uol/iznePM7Q=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLICzqUrv5jM8jT78ork/V/eip3mOnc61eNPZ/Ctg8m3D
 Fb59Pmqd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiq00Y/oeLWb3pmqH+Vi36
 r/YaY4XvLkGiWqdm9oYYfvJ99an3iA3Df0/RoP3y92+uV52YoPtfya26v4VHqyzmzfayXy47fxy
 6xw0A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Currently there is a nasty race between ptdump and vmap when attempting to
map a huge P4D, PMD or PUD entry.

ptdump is invoked by arch code to walk kernel or EFI page tables, either to
output it for debugging purposes, or to assert that there are no
W+X (i.e. executable writable pages) exposed in these ranges.

The feature is enabled generally via CONFIG_PTDUMP (whose implementation is
in mm/ptdump.c), and expose a debugfs interface for it if
CONFIG_PTDUMP_DEBUGFS is defined.

If CONFIG_PTDUMP is enabled, then /sys/kernel/debug/check_wx_pages is
enabled which checks kernel ranges to perform the W+X check. If
CONFIG_DEBUG_WX is enabled, this is done on boot.

(Note that arm32 implements its own page table walker and uses
CONFIG_ARM_DEBUG_WX and CONFIG_ARM_PTDUMP_DEBUGFS for this.)

The EFI implementations vary by architecture, but are not relevant to the
bug, as the issue is when kernel page ranges are walked.

ptdump_walk_pgd() holds both the mem hotplug lock and the mmap write lock
before invoking walk_page_range_debug(), however this runs into an issue
with vmalloc ranges.

When vmap maps a P4D, PUD or a PMD sized range and encounters an existing
P4d/PUD/PMD entry pointing to a PUD/PMD/PTE page table, it invokes
vmap_try_huge_[p4d,pud,pmd]() to try to convert it to a huge page table
mapping if possible.

However, when it does this, it holds no meaningful locks against other
kernel page table walkers, invoking [p4d,pud,pmd]_free_[pud,pmd,pte]_page()
which calls pagetable_free() and pagetable_free_kernel() in
turn (pte_fragment_free() for powerpc).

This means that a use-after-free becomes possible if the ptdump page table
walker happens to be walking a PUD, PMD or PTE page table after it has been
freed.

Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
tables"), if CONFIG_ASYNC_KERNEL_PGTABLE_FREE is set,
pagetable_free_kernel() will batch the page table freeing operation,
otherwise it frees the page table directly.

While the KASAN report that syzbot highlighted indicated that the issue
arose in a workqueue introduced by this change, this is coincidental and
the commit did not alter the race which has existed for quite some time.

This patch resolves the issue by simply having
vmap_try_huge_[p4d,pud,pmd]() hold the mmap read lock on init_mm while
invoking [p4d,pud,pmd]_free_[pud,pmd,pte]_page() and
[p4d,pud,pmd]_set_huge().

This way, page table walkers either observe a newly promoted huge
P4D/PUD/PMD leaf entry or the prior PUD/PMD/PTE entry and never get passed
a dangling pointer, whether the page is freed asynchronously or not.

All other kernel page table walkers that touch vmalloc ranges either
exclusively own the memory walked or acquire the mmap lock, so this
correctly excludes those walkers.

We acquire the mmap read lock as a trylock, as this is an optimisation that
is permitted not to succeed, a race is very unlikely, and doing so
eliminates latency sleeping on the lock would have otherwise caused.

We also define a guard class for mmap_read_trylock() so we can use
cleanup.h to make the scope handling cleaner in the implementation.

One wrinkle here is commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
ptdump"), which addresses the issue for arm64 only by explicitly acquiring
the mmap read lock on kernel page table freeing should a concurrent ptdump
be in progress.

This is problematic as vmap may acquire the mmap read lock prior to ptdump
attempting to acquire an mmap write lock, leading to a deadlock when the
mmap read lock is slept upon on page table freeing due to rwsem
anti-starvation.

We work around this by predicating the mmap lock being taken on
!CONFIG_ARM64 for the time being.

With this patch applied, a follow up will partially revert commit
fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump") and at that stage
remove the arm64 ifdeffery.

We also update walk_page_range_debug() to assert the mmap write lock
unconditionally and update the comment here to reflect this change.

The issue has existed as long as ptdump was available and vmap freed page
tables when promoting to a huge leaf entry, that is, since commit
b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table") for
huge ioremap, and commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc
mappings") for huge vmalloc.

Since the former is the earlier of the two we choose that for our Fixes
tag.

This patch is based on work by David Carlier (linked), with gratitude!

Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Cc: <stable@vger.kernel.org>
Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gmail.com/
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mmap_lock.h |  1 +
 mm/pagewalk.c             | 22 +++++++++++----------
 mm/vmalloc.c              | 50 ++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 04b8f61ece5d..6b5c2390cc30 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -621,6 +621,7 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 
 DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
 	     mmap_read_lock(_T), mmap_read_unlock(_T))
+DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3ae2586ff45b..bbcfd68d0907 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -678,6 +678,8 @@ int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end
  * will also not lock the PTEs for the pte_entry() callback.
  *
  * This is for debugging purposes ONLY.
+ *
+ * The mmap write lock must be held.
  */
 int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
@@ -691,6 +693,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 		.no_vma		= true
 	};
 
+	/*
+	 * When walking userland page tables, an mmap write lock must be held to
+	 * account for munmap() downgrading to an mmap read lock when tearing
+	 * down page tables.
+	 *
+	 * When walking kernel page tables, an mmap write lock must also be held
+	 * to account for page table freeing on vmap huge page mapping.
+	 */
+	mmap_assert_write_locked(mm);
+
 	/* For convenience, we allow traversal of kernel mappings. */
 	if (mm == &init_mm)
 		return walk_kernel_page_table_range(start, end, ops,
@@ -700,16 +712,6 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 	if (!check_ops_safe(ops))
 		return -EINVAL;
 
-	/*
-	 * The mmap lock protects the page walker from changes to the page
-	 * tables during the walk.  However a read lock is insufficient to
-	 * protect those areas which don't have a VMA as munmap() detaches
-	 * the VMAs before downgrading to a read lock and actually tearing
-	 * down PTEs/page tables. In which case, the mmap write lock should
-	 * be held.
-	 */
-	mmap_assert_write_locked(mm);
-
 	return walk_pgd_range(start, end, &walk);
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1afca3568b9b..9d0f1fdd6af3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -43,6 +43,7 @@
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 #include <linux/page_owner.h>
+#include <linux/cleanup.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmalloc.h>
@@ -158,10 +159,25 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
 		return 0;
 
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
-		return 0;
+	if (!pmd_present(*pmd))
+		return pmd_set_huge(pmd, phys_addr, prot);
 
-	return pmd_set_huge(pmd, phys_addr, prot);
+	/*
+	 * Kernel page table walkers either walk ranges they own exclusively
+	 * using the mmap lock for mutual exclusion, or hold the mmap write lock
+	 * on init_mm (ptdump being the motivating case).
+	 *
+	 * Therefore, acquire the mmap read lock to prevent use-after-free when
+	 * freeing page tables.
+	 */
+#ifndef CONFIG_ARM64
+	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
+#endif
+	{
+		if (!pmd_free_pte_page(pmd, addr))
+			return 0;
+		return pmd_set_huge(pmd, phys_addr, prot);
+	}
 }
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
@@ -210,10 +226,18 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
-		return 0;
+	if (!pud_present(*pud))
+		return pud_set_huge(pud, phys_addr, prot);
 
-	return pud_set_huge(pud, phys_addr, prot);
+	/* See comment in vmap_try_huge_pmd(). */
+#ifndef CONFIG_ARM64
+	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
+#endif
+	{
+		if (!pud_free_pmd_page(pud, addr))
+			return 0;
+		return pud_set_huge(pud, phys_addr, prot);
+	}
 }
 
 static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
@@ -262,10 +286,18 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
-		return 0;
+	if (!p4d_present(*p4d))
+		return p4d_set_huge(p4d, phys_addr, prot);
 
-	return p4d_set_huge(p4d, phys_addr, prot);
+	/* See comment in vmap_try_huge_pmd(). */
+#ifndef CONFIG_ARM64
+	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
+#endif
+	{
+		if (!p4d_free_pud_page(p4d, addr))
+			return 0;
+		return p4d_set_huge(p4d, phys_addr, prot);
+	}
 }
 
 static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,

-- 
2.55.0

