Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C383330B32;
	Wed,  9 Sep 2026 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933547; cv=none; b=TAV0sXPobyZ30fOBvgd3kbFFPjFMBFXINw/Z6Vz6UyAnRx+XJyh9LManOm40XbLcNAyEu0FDoQtr5D/zEAIQfu9krsRgYQ9yQDZpbsOZSJLlvtjC2fcddGResufGVNfOPVXlYAwC2wfgx6XLHqNTdr3QqaQP1ybpXL9iv627kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933547; c=relaxed/simple;
	bh=YUVUEp206WDEqlY6ppGgGlJU16y5C+XT48cMlXenyb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu7UDj12HO1rgtcdkF0+HDz5OE87eJQASCUaiTLhktMcRLPIWtGlTkmW2mV7khNVAIriLOVSc2jZgLDWqsb/rvJoNbhCXXh7E5HOrETgHkcDnYGCk4Wzb7VLdtrgsyLfPA2bGGpE+DQgs0m81M0O74H2+4l7fW3leb6o63hSAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/frkGtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/frkGtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBB11F00A3D;
	Wed,  9 Sep 2026 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933545;
	bh=Epg7VvkQFn4idS3jDgNCme+/Oh0x5i324IkAs6cBC8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/frkGtP7zeTOWd39MZ5p0OwjH42hqg0zdTFxTJukmkjR3kBHW/HHc35Y+Oz4UNBN
	 /jmV6K0JYE7FPs04gwPK2ES1zSJfDlo3Ar2ubs9/ApcBRAu3FzhCOYXlIU49XpWT2+
	 zgtvTT+aZBZ8thn9xzojGHcRxIaQfQYCEdDPdv53inQwfBE7fGHF2QosjMv1N6SpIL
	 rhw7f+OKk+44eWHN4HXYC+o1HYYvm5+jwUxngYmZtvVyG4gzQY6SIqSoeqEFAVPesp
	 VWrnBkzVOoVchQSBl8ASEhMt9toaipwgAfI9UrnL0GJQccus+i9WlZvA+J12nNmWwU
	 DwymJA36OAsaA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Tue,  8 Sep 2026 22:58:57 -0700
Message-ID: <20260909055857.266952-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090858-excusable-alkaline-da79@gregkh>
References: <2026090858-excusable-alkaline-da79@gregkh>
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
index 4d7dc9f65f682..c74b3fd1d227a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -429,8 +429,6 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	/* size of the folio for the access checked virtual memory address */
-	unsigned long *folio_sz;
 	bool young;
 };
 
@@ -466,7 +464,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 					mmu_notifier_test_young(walk->mm,
 						addr))
 			priv->young = true;
-		*priv->folio_sz = HPAGE_PMD_SIZE;
 		folio_put(folio);
 huge_out:
 		spin_unlock(ptl);
@@ -488,7 +485,6 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 	if (pte_young(ptent) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = folio_size(folio);
 	folio_put(folio);
 out:
 	pte_unmap_unlock(pte, ptl);
@@ -517,7 +513,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	*priv->folio_sz = huge_page_size(h);
 
 	folio_put(folio);
 
@@ -535,11 +530,9 @@ static const struct mm_walk_ops damon_young_ops = {
 	.walk_lock = PGWALK_RDLOCK,
 };
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *folio_sz)
+static bool damon_va_young(struct mm_struct *mm, unsigned long addr)
 {
 	struct damon_young_walk_private arg = {
-		.folio_sz = folio_sz,
 		.young = false,
 	};
 
@@ -556,25 +549,13 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target)
+				struct damon_region *r)
 {
-	static unsigned long last_addr;
-	static unsigned long last_folio_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
-				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		if (last_accessed)
-			r->nr_accesses++;
-		return;
-	}
+	bool accessed;
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	if (last_accessed)
+	accessed = damon_va_young(mm, r->sampling_addr);
+	if (accessed)
 		r->nr_accesses++;
-
-	last_addr = r->sampling_addr;
 }
 
 static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
@@ -583,17 +564,14 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 	struct mm_struct *mm;
 	struct damon_region *r;
 	unsigned int max_nr_accesses = 0;
-	bool same_target;
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
 		if (!mm)
 			continue;
-		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target);
+			__damon_va_check_access(mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
-			same_target = true;
 		}
 		mmput(mm);
 	}
-- 
2.47.3

