Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432082;
	b=an9mEe61NVaLtwS9nwXffj5cMcrZ8ZIYeOidk36t9PAnhXtLsu5TdlPwjkZD9h3Vkc/L
	 VaUq0uMHp/EEgwV8rSjYQ7UXa0ods9B4n1pAiDBMeUXp1QD9r8Hx2brLuMzB9980Pi5F4
	 UIVDsVpGYY4HhEsaqu96yi9XbGyxWy6uK+y7lr/oklRliwqt9pFSgYJv6uWFpT6PpAQ0j
	 Ad7K1M6k3TmHzkUqTrsK+ccTt+FfMOG9CTEa6vwbBxcl2IY1QcQjyKkHFh138Bkr+Ntr7
	 ujdoWpYGhggrsakXkaJJxYJ72/EgcExC4sH/JpnYO7sOStdTEMv4cRNZBsSWO1HmCyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432082;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fZt/m1qZOFnQ7k6UBO7/YYuaCKNiSvGS39stDMwfba0=;
	b=WBoIeOQiost0YK73VS8flKbBP6hko/bIm1gNrTOVQvxFQii1D9i5U+Mc2L1SRSFBTZae
	 FDUOPpPqh8E1v1VIy0AcqiiLBo8x60anLk6ewCo+XCW3TjaUVjE87FyylxaQV1fnZBmz0
	 OMlMmUhymEMiS2vPoczt6LqFM/CDsJPIdUimjIpB8pU2SsmKPBdSt6aVZE9uyJ97XI/YJ
	 CUjkJvh29pfsJdGBUNEzJPB7ffcjs3bRbNHEm0SVCUT8kSqggZtua3KM9Gm5fwaaVQ77l
	 MGLMlP7TaQHH17u6+CgoaeND9vFOm50I5pJWdtbbiFEys6frrRmNmAAjQQidN/k3FHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MetUfBMg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CC606A31C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MetUfBMg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD81F000C4;
	Mon, 19 Oct 2026 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792432081;
	bh=fZt/m1qZOFnQ7k6UBO7/YYuaCKNiSvGS39stDMwfba0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=MetUfBMgp31/l0J+U8dWqh/Vvkxaj1S4gi07reShhOTKQJDWgRgzYid8BUZXBw+OW
	 kqO1GJKHVThzqO8lemThhx+ImH5ZbEvaY2zo1O75JY0hmELQMD1ko05Mrz2o/bNuvV
	 TCNuw7xWawzUH/6mu7Y56y3qwV8Sgba/r489QAq71498cStpX+WifZK7c12c1Qb8jR
	 40KiuKgf9CJ2hnGff+sIRhvYpXxh5ed3d7j0Ke0Ck+XVtss7HEflxwKhMtyHv5dNGS
	 7WVhrLja6JG2DrZgCucRQTCmrwbApl1NUiikmnyyDaUPHuTkFcEJzb/ABUhfgb/ocn
	 aKBExsDdF7oIw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
Date: Mon, 19 Oct 2026 18:47:30 +0100
Message-ID: <20261019174730.284280-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026081337-cogwheel-winnings-b218@gregkh>
References: <2026081337-cogwheel-winnings-b218@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is a nasty race between ptdump and ioremap when attempting
to map a huge P4D, PUD or PMD entry:

* ptdump walks kernel page table ranges it doesn't own.

* When ioremap maps ranges it tries to promote existing ones to huge
  page tables in ioremap_try_huge_[p4d,pud,pmd]() at P4D, PUD and PMD
  level, freeing the lower page table in
  [p4d,pud,pmd]_free_[pud,pmd,pte]_page() when it succeeds.

Both of these things can happen at the same time and as a result ptdump
can access a freed page table, resulting in a use-after-free and memory
corruption.

This is possible because while ptdump_walk_pgd() holds both the mem
hotplug lock and the mmap write lock before invoking
walk_page_range_novma(), ioremap takes no relevant locks at all.

Fix this by holding the mmap read lock in ioremap_try_huge_*() when freeing
page tables.

The read lock is sufficient: ptdump is the only walker that must be
excluded and it holds the mmap write lock.  Other holders of the read lock
may run concurrently, but each exclusively owns the range it operates on
and cannot reach the page tables freed here.

We also hold the lock while assigning the huge page table entry, which
means page table walkers observe only the huge or non-huge page table
entry.

We use a trylock to prevent ptdump from blocking ioremap making forward
progress.  This is fine because it's an optimisation in any case, and thus
the ioremap can safely proceed regardless.

All other kernel page table walkers that touch vmalloc ranges either
exclusively own the memory walked or acquire the mmap lock, so this
correctly excludes those walkers.

The issue has existed as long as ptdump was available and vmap freed page
tables when promoting to a huge leaf entry, that is, since commit
b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
for huge ioremap, and commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc
mappings") for huge vmalloc.

Since the former is the earlier of the two we choose that for our Fixes
tag.

This patch is based on work by David Carlier (linked), with gratitude!

Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gmail.com/
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 26444eb71465c9934d9d418ef69c43f61185329b)
[ ljs - Applied to ioremap_try_huge_*() in mm/ioremap.c, open-coded missing
   stuff + other smaller changes. Updated commit msg to reflect. ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/ioremap.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..0f3087e4ea9e 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -85,6 +85,8 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 				unsigned long end, phys_addr_t phys_addr,
 				pgprot_t prot)
 {
+	int ret = 0;
+
 	if (!ioremap_pmd_enabled())
 		return 0;
 
@@ -97,10 +99,23 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
 		return 0;
 
-	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
+	if (!pmd_present(*pmd))
+		return pmd_set_huge(pmd, phys_addr, prot);
+
+	/*
+	 * Acquire the mmap read lock to exclude ptdump, which walks
+	 * kernel page tables it does not own under the mmap write lock.
+	 *
+	 * Concurrent read lock holders are safe: each exclusively owns
+	 * the range it operates on and cannot reach this page table.
+	 */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (pmd_free_pte_page(pmd, addr))
+		ret = pmd_set_huge(pmd, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return pmd_set_huge(pmd, phys_addr, prot);
+	return ret;
 }
 
 static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
@@ -131,6 +146,8 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 				unsigned long end, phys_addr_t phys_addr,
 				pgprot_t prot)
 {
+	int ret = 0;
+
 	if (!ioremap_pud_enabled())
 		return 0;
 
@@ -143,10 +160,17 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
-	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
+	if (!pud_present(*pud))
+		return pud_set_huge(pud, phys_addr, prot);
+
+	/* See comment in ioremap_try_huge_pmd(). */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (pud_free_pmd_page(pud, addr))
+		ret = pud_set_huge(pud, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return pud_set_huge(pud, phys_addr, prot);
+	return ret;
 }
 
 static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
@@ -177,6 +201,8 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 				unsigned long end, phys_addr_t phys_addr,
 				pgprot_t prot)
 {
+	int ret = 0;
+
 	if (!ioremap_p4d_enabled())
 		return 0;
 
@@ -189,10 +215,17 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
+	if (!p4d_present(*p4d))
+		return p4d_set_huge(p4d, phys_addr, prot);
+
+	/* See comment in ioremap_try_huge_pmd(). */
+	if (!mmap_read_trylock(&init_mm))
 		return 0;
+	if (p4d_free_pud_page(p4d, addr))
+		ret = p4d_set_huge(p4d, phys_addr, prot);
+	mmap_read_unlock(&init_mm);
 
-	return p4d_set_huge(p4d, phys_addr, prot);
+	return ret;
 }
 
 static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
-- 
2.56.0

