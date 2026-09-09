Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32137C903;
	Wed,  9 Sep 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934068; cv=none; b=pDIA9S/bzS4pYIZKE8F0OobGyq+S+IOFu2bljiLsHOnNpbhqkFGzmNuXjeACjsTlv0VAYig4Ed5jPVOZJX6bjHHepVr4Gfpc4ZzXjxR5JRkbNDKOt2lVjHTN0ij8TFfsrQQnbO5u5HTerj+21ER7Zmdc1zRJho8Heizow+k6Uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934068; c=relaxed/simple;
	bh=JaqAVT8uiO+uUJmrwFi+DvTd3youR/rV7wQFMvfnpWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFdZ5w+7JiL1lrb5VMJAR/z/Utetk3RexaMY1KQ1HF5z1UEmVWJjoVnTletZVc9utcoEfOQIq0lOSPqvmeDMbDC2Z5i5u78C2LoX9UzoAmZO1XYR2G4DB2/r3qy/utR2OOZoCv4Fnr1hO/mibf3OewVloznvE8WsKeNdF9dpwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZAC1NBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZAC1NBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D41F00A3A;
	Wed,  9 Sep 2026 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788934063;
	bh=vISV3w6p3Ty1DjJ3WJ54PARHMW95Q4BJMOnSjVnq/XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZAC1NBvuryO5d6uCVwomv+5OjC8Hx+zpPmyhoRkSnA8k6yH/l+qxCrZuEBB/HcsE
	 PynqwHufR+AJ+wJN41PfP3PH8Cl/8DTnbCQq9Zi40a71cGy0rxnBoy1r0eTX6SatW3
	 ZRvsohCUsbugbAX+dMNn8u8ZP/af/wVsFnWOk1A+zz9SFpDe+kG1/sCJg9X7Ddzosq
	 K7M0hNTjEIaP6F7IhC9gdQtkEjbDTAOVgXz6ijSQ7q+/8AOO7GRh0JKGOXDsQeh3ha
	 86vR1450p9thOL3ryMq+s6TlVqpA28++vulN1BtkumWPnAJ7HTQtKdkQZ+M3cCz2XN
	 a/jN0Nk2wS3JQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Tue,  8 Sep 2026 23:07:36 -0700
Message-ID: <20260909060736.273661-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090859-trouble-fanatic-b990@gregkh>
References: <2026090859-trouble-fanatic-b990@gregkh>
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
 mm/damon/vaddr.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index dbb0f0fb2e598..bc0034b235d83 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -516,7 +516,6 @@ void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	unsigned long *page_sz;
 	bool young;
 };
 
@@ -545,10 +544,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (pmd_young(*pmd) || !page_is_idle(page) ||
 					mmu_notifier_test_young(walk->mm,
-						addr)) {
-			*priv->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+						addr))
 			priv->young = true;
-		}
 		put_page(page);
 huge_out:
 		spin_unlock(ptl);
@@ -567,10 +564,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (!page)
 		goto out;
 	if (pte_young(*pte) || !page_is_idle(page) ||
-			mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->page_sz = PAGE_SIZE;
+			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	}
 	put_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
@@ -581,11 +576,9 @@ static struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
 };
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *page_sz)
+static bool damon_va_young(struct mm_struct *mm, unsigned long addr)
 {
 	struct damon_young_walk_private arg = {
-		.page_sz = page_sz,
 		.young = false,
 	};
 
@@ -604,25 +597,11 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 static void damon_va_check_access(struct damon_ctx *ctx,
 			       struct mm_struct *mm, struct damon_region *r)
 {
-	static struct mm_struct *last_mm;
-	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
-		if (last_accessed)
-			r->nr_accesses++;
-		return;
-	}
+	bool accessed;
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_page_sz);
-	if (last_accessed)
+	accessed = damon_va_young(mm, r->sampling_addr);
+	if (accessed)
 		r->nr_accesses++;
-
-	last_mm = mm;
-	last_addr = r->sampling_addr;
 }
 
 unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
-- 
2.47.3

