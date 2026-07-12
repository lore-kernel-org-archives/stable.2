Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3036654C;
	Sun, 12 Jul 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875821; cv=none; b=bOzG1tWYqY9uFOIS/4QXZsi1OOoK7PrNX9Euxm5x5DXqqbWI3+rWAy3TsaWtxN3ML+natsZmZMRM4JidoyJlCWSaHKZR5n5iLqIZ1s5Wefu9OoHCNzoe46iYX6aMdlf3Hjg+6SP4d2rhimd+94yyZMVlstEewylwnc1renxmUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875821; c=relaxed/simple;
	bh=eShbpgLz2NbIysbCSJJgbBQ51wiA+Nyw8yXGHdcRa9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozWUKkYdNAUyoVryMg47q2W4B5o+WsGxx64OdXoEQlShgGtvDXMF3EBjGJrdykvlQyGq8K/LCHtbpb+X9q9YK2jsIWvpZRPHLmi6huR9VV7tw73ogRWoNEpqDHOc2pMWhRxlm8e9whog+8lL37YfcXMG1x98LJlxOCobCRrjI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3VaMGI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3VaMGI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A9E1F00A3F;
	Sun, 12 Jul 2026 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783875820;
	bh=Y5xW2GMWQ2fJulemhF10bJTV6JcOyhTF3brjsm/0yqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3VaMGI4TyeJ5+PzRVirqrge5WUaVVa53j+QN2P8SmdEFEg3xutS40c25/o97BgMc
	 kwp4o55qHO37t7Y/5bbHjb59fckHhRZOeMgJNz5lg/p4g0aLsNCACTXULm30U0Bs0z
	 WCITAbrq1ea8ZvsV3Jy8LmpHm6DLsgcJGcWnGF5aNiOC79Cy9DO/Da78+OW6lDmJtr
	 xhBqrgx4PXiwc+xDv+XVflDcf2xu0epXhNUJUP6FAWJxN/fOIdpanW9LyjcCr3IOL7
	 G8ZNRGVaZVvst5/xV0xuJr+iQ2vtHw+cHldCtB5jaK79QYutZydKFlnudYlwZzBQQ9
	 Uy7UtpgsLq1uw==
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
Subject: [RFC PATCH v1.1 3/5] mm/damon/vaddr: drop last same folio access check optimization
Date: Sun, 12 Jul 2026 10:03:25 -0700
Message-ID: <20260712170328.91144-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712170328.91144-1-sj@kernel.org>
References: <20260712170328.91144-1-sj@kernel.org>
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
 mm/damon/vaddr.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d10b8042adb5b..16fe210d2042a 100644
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
 
@@ -496,26 +489,15 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
 static void __damon_va_check_access(struct mm_struct *mm,
 				struct damon_region *r, bool same_target)
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
-- 
2.47.3
