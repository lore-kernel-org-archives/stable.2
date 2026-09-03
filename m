Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB43939B0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460833; cv=none; b=Dj0kuoOW7DcAaZuDI4ul/i6ofJO9eLWbF4Bg6a9lwA06jXE/uglREYn/aVeAZMCKAe31gGyrrA3nKTo7WJPBN/ooEMGlPpgoPW8YhqG5dibS0pDyhj3e5Ack5yv4W/4wdP4d0FUnBTTsuQeth1yzjVCmY3c/607mLKEUWJCD7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460833; c=relaxed/simple;
	bh=A+37i3Vu30G2lzuJMlci8l2xlFHPWoMWlc6iWaldxks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tejl4J3FHiDFX5gDnTGLCdczii6CKblujVGJy7rg9zj0z/12E5yQ2Bq/k7utqYYt7XUJUTCzF2m2R/PMlO7uVLD9uKVwuJ7jRiYEbUJQ/2EidOCZuie8MKyeEOGmNvJMw59SpWjA1rdla8IHNYRA3hrDqlYq+Im4IKERaG3Lgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPT42ou5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPT42ou5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289741F00A3E;
	Thu,  3 Sep 2026 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460830;
	bh=uOoQHVkKDsh2zxJVZ6iVpkO5wmZv2oMoA4+xdCX4StM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPT42ou546owK3HazIAbWBFLXCOV5/SIlyU1IJqwLgwxgGHyJJwNcgHAMgSaC9/s6
	 7QiqB7ne3WrH2SJRNk0GFWjFJH5U533zvyviLnlxgvT5WMiHp43KLXYaXHDJwMguCp
	 eeYzJxfaGqEhu8hvHU1WGIzQGfvRU46BOhZCCHZWkCfcAn22mEW3uHxqkuSfUKlNMX
	 ke1SqkteOMzPNvfl+h7AyoaTPrpaDqYZ+IrP0SC8ilAvqUS1Qiilof/tVhluV9E1uS
	 GkQkkHxVBw2f6y0hBItxkXYs7XnRu3VFD2WRkASmHlUIhOrgl7elrsh8TtuHFbGxuQ
	 LeFHzllP1UU0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Xu <weixugc@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] mm/mglru: reset page lru tier bits when activating
Date: Thu,  3 Sep 2026 14:40:24 -0400
Message-ID: <20260903184027.1474890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-freezable-flatness-e858@gregkh>
References: <2026090303-freezable-flatness-e858@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Xu <weixugc@google.com>

[ Upstream commit f1001f3d3b6868998cab73d10fda1a5c99ddf963 ]

When a folio is activated, lru_gen_add_folio() moves the folio to the
youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
lru_gen_add_folio() doesn't reset the folio lru tier bits (LRU_REFS_MASK |
LRU_REFS_FLAGS).  This inconsistency can affect how pages are aged via
folio_mark_accessed() (e.g.  fd accesses), though no user visible impact
related to this has been detected yet.

Note that lru_gen_add_folio() cannot clear PG_workingset if the activation
is due to workingset refault, otherwise PSI accounting will be skipped.
So fix lru_gen_add_folio() to clear the lru tier bits other than
PG_workingset when activating a folio, and also clear all the lru tier
bits when a folio is activated via folio_activate() in
lru_gen_look_around().

Link: https://lkml.kernel.org/r/20241017181528.3358821-1-weixugc@google.com
Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Signed-off-by: Wei Xu <weixugc@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jan Alexander Steffens <heftig@archlinux.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7e698e326b2 ("mm/mglru: fix and remove redundant unevictable folio handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm_inline.h | 15 ++++++++++++++-
 include/linux/mmzone.h    |  2 ++
 mm/vmscan.c               |  8 ++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400e..622dfe2545d79 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -155,6 +155,11 @@ static inline int folio_lru_refs(struct folio *folio)
 	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + workingset;
 }
 
+static inline void folio_clear_lru_refs(struct folio *folio)
+{
+	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+}
+
 static inline int folio_lru_gen(struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags);
@@ -222,6 +227,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 {
 	unsigned long seq;
 	unsigned long flags;
+	unsigned long mask;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -257,7 +263,14 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	gen = lru_gen_from_seq(seq);
 	flags = (gen + 1UL) << LRU_GEN_PGOFF;
 	/* see the comment on MIN_NR_GENS about PG_active */
-	set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
+	mask = LRU_GEN_MASK;
+	/*
+	 * Don't clear PG_workingset here because it can affect PSI accounting
+	 * if the activation is due to workingset refault.
+	 */
+	if (folio_test_active(folio))
+		mask |= LRU_REFS_MASK | BIT(PG_referenced) | BIT(PG_active);
+	set_mask_bits(&folio->flags, mask, flags);
 
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f932c4350fcb..9d52485541529 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -403,6 +403,8 @@ enum {
 	NR_LRU_GEN_CAPS
 };
 
+#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
+
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 64)
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 20f4cb33d8e8a..e5cdf114c3ba5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2625,8 +2625,6 @@ static bool should_clear_pmd_young(void)
  *                          shorthand helpers
  ******************************************************************************/
 
-#define LRU_REFS_FLAGS	(BIT(PG_referenced) | BIT(PG_workingset))
-
 #define DEFINE_MAX_SEQ(lruvec)						\
 	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq)
 
@@ -4157,8 +4155,10 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		old_gen = folio_lru_gen(folio);
 		if (old_gen < 0)
 			folio_set_referenced(folio);
-		else if (old_gen != new_gen)
+		else if (old_gen != new_gen) {
+			folio_clear_lru_refs(folio);
 			folio_activate(folio);
+		}
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -4400,7 +4400,7 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 
 	/* see the comment on MAX_NR_TIERS */
 	if (!folio_test_referenced(folio))
-		set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+		folio_clear_lru_refs(folio);
 
 	/* for shrink_folio_list() */
 	folio_clear_reclaim(folio);
-- 
2.53.0

