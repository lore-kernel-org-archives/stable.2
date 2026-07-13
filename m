Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50596437469;
	Mon, 13 Jul 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951128; cv=none; b=WPVvQg1txlUyt2U3l6vn9eFXbrbvqko6wakl/V0axcT6zZe2Jv6LW00CdG0iqfK4sDQMhjfrt1751jpmzBe/Cr5i85qPlMnfOt99lTWDm7u6vzPRDjy1fZ5ZGMSYNP7wD/5gUX54WNxbcyi6dpo9Blh7k1Xz2KpouHEOLxUaaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951128; c=relaxed/simple;
	bh=vZYyX+a12usp29MAJtKmwcAKj0175PGkEUqyahpcjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anhkqwa4RR3Qtp2sU3ubwjBVsOKs6WYA0Qlg+N+ru/Xdc9VbJHCX52JcM5nzR8OMj2prJKtAzWUd4j/vCjOQT5O48aYcpcRvIFLdoahy/M37jOs/WxjpiJNuoV40TEdb/ZWS/jMnKTo/gQ+oq6gcIJX5itn9a8lYiIghmr9w+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQhsi6oB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQhsi6oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F11F00A3F;
	Mon, 13 Jul 2026 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951127;
	bh=dZ7Hztpv9AG3ym6rD1iyRftJCr5BqjDTKMYF5vaHn/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQhsi6oB6Dqy2UhzZgl0R7wMwFYoC01nOavo2Gn4P+0kq0kD3Hm545yLLe0+Uqr9+
	 +YgeckSbvOCmw+JICQvQotz/sNpn3oMsz1QqQSCtrX3MUr4nqLFGA82HkQuhIg6iLl
	 zdC1W79HSej4vTNr4wI6ayYd886K+14GcnmxMxQmJBBHYK55SJ1laUK6bUiIDtrJjP
	 HAL8ysVALSqofM0x8r2eZmtB/JTUnV+A0ELxHYbOuLUwMWL6Oc7teoFydLg13VhiOX
	 STDoK6mftNt7g6Rvf/LlFXfMwuSZNbNbNfVVm/Y2pUnvc1poIMN62fESq3zzZl+Qzt
	 SCgZE6BrNge/A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 3/5] mm/damon/vaddr: drop last same folio access check optimization
Date: Mon, 13 Jul 2026 06:58:34 -0700
Message-ID: <20260713135838.32730-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713135838.32730-1-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optimization can race when multiple kdamonds are running.
Meanwhile, the impact of the optimization is quite doubtful.  Just
remove it.

The user impact of the issue should be quite trivial.  After all, the
race can happen only when the user intentionally setup DAMON in the way.
Even if it happens, it would be rare and only degrade the best-effort
monitoring results.  No critical consequences like kernel panic or
memory corruption happen.

The race possibility was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d10b8042adb5b..d487b7a4a1042 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -383,8 +383,6 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	/* size of the folio for the access checked virtual memory address */
-	unsigned long *folio_sz;
 	bool young;
 };
 
@@ -411,7 +409,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-		*priv->folio_sz = HPAGE_PMD_SIZE;
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -430,7 +427,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (pte_young(ptent) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = folio_size(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
@@ -458,7 +454,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = huge_page_size(h);
 
 	folio_put(folio);
 
@@ -470,11 +465,9 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_young_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *folio_sz)
+static bool damon_va_young(struct mm_struct *mm, unsigned long addr)
 {
 	struct damon_young_walk_private arg = {
-		.folio_sz = folio_sz,
 		.young = false,
 	};
 
@@ -494,28 +487,17 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target)
+				struct damon_region *r)
 {
-	static unsigned long last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
+	bool accessed;
 
 	if (!mm) {
 		damon_update_region_access_rate(r, false);
 		return;
 	}
 
-	/* If the region is in the last checked page, reuse the result */
-	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		damon_update_region_access_rate(r, last_accessed);
-		return;
-	}
-
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed);
-
-	last_addr = r->sampling_addr;
+	accessed = damon_va_young(mm, r->sampling_addr);
+	damon_update_region_access_rate(r, accessed);
 }
 
 static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
@@ -524,15 +506,12 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct mm_struct *mm;
 	struct damon_region *r;
 	unsigned int max_nr_accesses = 0;
-	bool same_target;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
-		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target);
+			__damon_va_check_access(mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
-			same_target = true;
 		}
 		if (mm)
 			mmput(mm);
-- 
2.47.3
