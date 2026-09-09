Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA837E5C0;
	Wed,  9 Sep 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933208; cv=none; b=Epg+nYpRVUPsd7tUq7FxgF/FTExx7aelNzxR75g0BN74I9Pt9Hpzkz56PlfP0IGckv95ffxuUZ5Tqs3H19gQqYcYUVLUw/Bcj70paKhtZ5zD2CKCJG9lP0loQo61Fszswe5/jVrszKnCMyv5J5AJ5n4NGTVfrjncBnJRp0ll7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933208; c=relaxed/simple;
	bh=qwP5ZNlX4B8IHP/LioYBERsrFKlMEeisgl6HE/JKSWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBF2Fu7OKsdPEARbjOvbU2rtYuc/6lb1dE77y2M172gNQ4sO5+mV/L18tmsC8aOS4rp8/gZVDY581BCdVpZxqor/lp6ml/9vL4NQhlEY7/9b5Do4Ls7+Vik7fAPExmrP4w7nd4vxC8/gO7sC9Y1OHu71hdncKWGzOrEoiSCsJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvMGjYdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvMGjYdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75401F00A3A;
	Wed,  9 Sep 2026 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933206;
	bh=X85vxEgaq7VjpbAhXrgy7gXEDusjwY4a/3yzhtIgPds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YvMGjYdceTa3MdWwfDpUS+9zbcw5amnl5dVMR7bSa05t9FynevCfoVZ6IaeTfnim2
	 6osFiD2VQvijo2NTIwKnj1LDKpMEc20YzUMubkdeI+bq9gYxdHQC0kkNohJeS4Uowj
	 GP7m7gDcCwLsYEPL+iyu03po372vcNuf+Ytq6X43hTnpyhqh9+C7X73npyYF6B4b2e
	 B6eLWB8OmUGWrrRC1HNRiHcNnVSU9dmjhmTk7+nYkwxUBxomgEX9fap9e+RDEISRpZ
	 LTNIGHrHBrYAbCxUxsq57rOehinn3PyHjBr1RDRf9ywbRSK2xZ4qV+NheeMUpN/4sg
	 tR/dWMQFyY1ig==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.2.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Tue,  8 Sep 2026 22:53:19 -0700
Message-ID: <20260909055319.263738-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090857-turtle-delirious-bcbc@gregkh>
References: <2026090857-turtle-delirious-bcbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optimization can race when multiple kdamonds are running.  Meanwhile,
the impact of the optimization is quite doubtful.  Just remove it.

The user impact of the issue should be quite trivial.  After all, the race
can happen only when the user intentionally setup DAMON in the way.  Even
if it happens, it would be rare and only degrade the best-effort
monitoring results.  No critical consequences like kernel panic or memory
corruption happen.

The race possibility was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 831846078caa14b7d00b2ccca8b8fe522afe3204)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2c1c1952c008d..404785128ffd7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -382,8 +382,6 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	/* size of the folio for the access checked virtual memory address */
-	unsigned long *folio_sz;
 	bool young;
 };
 
@@ -410,7 +408,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-		*priv->folio_sz = HPAGE_PMD_SIZE;
 huge_out:
 		spin_unlock(ptl);
 		return 0;
@@ -429,7 +426,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (pte_young(ptent) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = folio_size(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
@@ -457,7 +453,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = huge_page_size(h);
 
 	folio_put(folio);
 
@@ -469,11 +464,9 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
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
 
@@ -493,29 +486,18 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target,
+				struct damon_region *r,
 				struct damon_attrs *attrs)
 {
-	static unsigned long last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
+	bool accessed;
 
 	if (!mm) {
 		damon_update_region_access_rate(r, false, attrs);
 		return;
 	}
 
-	/* If the region is in the last checked page, reuse the result */
-	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		damon_update_region_access_rate(r, last_accessed, attrs);
-		return;
-	}
-
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed, attrs);
-
-	last_addr = r->sampling_addr;
+	accessed = damon_va_young(mm, r->sampling_addr);
+	damon_update_region_access_rate(r, accessed, attrs);
 }
 
 static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
@@ -524,16 +506,12 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct mm_struct *mm;
 	struct damon_region *r;
 	unsigned int max_nr_accesses = 0;
-	bool same_target;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
-		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target,
-					&ctx->attrs);
+			__damon_va_check_access(mm, r, &ctx->attrs);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
-			same_target = true;
 		}
 		if (mm)
 			mmput(mm);
-- 
2.47.3

