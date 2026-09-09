Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAD27A907;
	Wed,  9 Sep 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934331; cv=none; b=On6HMjmzNBympGTXMxBTZOPvYSni7oUEWb9LJiWSy3/VVakY5Jq4G83A3ag3JVhpKtKKiSACasVk1TSlsjdorWelI4vosv9MH6kceDL+fMlUhjt3px2R/FkPcyVJGc5ra7hMHy635YtQHHTL+nEfo2wEqqRXvAPNSzg8gGx2B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934331; c=relaxed/simple;
	bh=0VP3KfcN+PNaGYIMWd/+49cCnnjaDgoYPGFy7KbuJFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCUU8wdh00AQml3S281//5UunnCZ59+obLCsk8UxHdzj4XnTGvdKKYEddcwXZcCIsAHXkUvGFin/fsb0ohBHA0skuhHGvB/OcTY8OyiKiFb72PiJ6nc6xY/461K7ruR+qnG/5RJpifqUipJIRnZzcwZskWVqvd33Gw5UMD1sgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPM2O/Ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPM2O/Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B6B1F00A3A;
	Wed,  9 Sep 2026 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788934329;
	bh=JTNHGmJ0DTj2YzVE/g3B39CaUW+O9pAjBlY5zLYCgME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPM2O/IgkSuPMVaOrHVP1VoEsvB305RF8780d725ibG4WYs5XdgSUequiC6vnnp9E
	 lkwXtxZEv4qmhHV6iuXanupbwlFZ7QB+sYO4PCRQEirLAJvR96m3pqKaP2U8Um8h6Y
	 TjrHD7WxwlkJ77yhshQtz+TgnEbs+3leDYcjFW/9HHCrOWfUqw127OMY8Uyr0b2szg
	 xb7ZlldlcdaMGmqixZ/TNLo8S59WI+FJGEStXDAqoPxXFzSPV4jTV/ZQ7UueNiB41r
	 kaQ8dQX5vS9ZHpXxm4r362slmXl9/FqC1+PIQVpX7Zqa7q8D6kJg2rLBkarK6UCWgD
	 jHHpt1vKFwMeg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Tue,  8 Sep 2026 23:11:52 -0700
Message-ID: <20260909061152.278678-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090858-legislate-monogamy-2299@gregkh>
References: <2026090858-legislate-monogamy-2299@gregkh>
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
 mm/damon/vaddr.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 708f281c1b6b4..4aa89347d754d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -424,7 +424,6 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 }
 
 struct damon_young_walk_private {
-	unsigned long *page_sz;
 	bool young;
 };
 
@@ -453,10 +452,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 			goto huge_out;
 		if (pmd_young(*pmd) || !page_is_idle(page) ||
 					mmu_notifier_test_young(walk->mm,
-						addr)) {
-			*priv->page_sz = HPAGE_PMD_SIZE;
+						addr))
 			priv->young = true;
-		}
 		put_page(page);
 huge_out:
 		spin_unlock(ptl);
@@ -475,10 +472,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
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
@@ -505,10 +500,8 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	get_page(page);
 
 	if (pte_young(entry) || !page_is_idle(page) ||
-	    mmu_notifier_test_young(walk->mm, addr)) {
-		*priv->page_sz = huge_page_size(h);
+	    mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
-	}
 
 	put_page(page);
 
@@ -525,11 +518,9 @@ static const struct mm_walk_ops damon_young_ops = {
 	.hugetlb_entry = damon_young_hugetlb_entry,
 };
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
-		unsigned long *page_sz)
+static bool damon_va_young(struct mm_struct *mm, unsigned long addr)
 {
 	struct damon_young_walk_private arg = {
-		.page_sz = page_sz,
 		.young = false,
 	};
 
@@ -546,25 +537,13 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target)
+				struct damon_region *r)
 {
-	static unsigned long last_addr;
-	static unsigned long last_page_sz = PAGE_SIZE;
-	static bool last_accessed;
-
-	/* If the region is in the last checked page, reuse the result */
-	if (same_target && (ALIGN_DOWN(last_addr, last_page_sz) ==
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
-	last_addr = r->sampling_addr;
 }
 
 static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
@@ -573,17 +552,14 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
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

