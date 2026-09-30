Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927527727
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726645; cv=none; b=n5CFsvClpXcVrvAQlN5NHGBxJpqexyOD1EN8Y+bH6mroePTYxn99tbrR/sP4hmf0GbMdlJ05nGnBcyvL9PHEEbL0/Q4rXfdFUZaJH57sUfAF5UWyol3Te7GB7hoM98IqokkKn9HEU6+3HWb1FHhhM1uON6eLaGotOam58n7aJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726645; c=relaxed/simple;
	bh=nMwt6APwUvR1etAm3mGn9SY3Sxm9SQVfzWuJ59lwOC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op7nY/EUMX5OvntWn6L2yxNQ9eeic4fVr9zhgmQRM4pn/vNVHHbO1TmZdlM4jf68vATABz6VjFIVQpt+Dqt6Y2DpHdNFCESt+AHLs4fbjP1FHJ4Vizvy6y1fQBOuCCMSpP9eHjqodAlyqiNlg9DxhI4G3PMIzSXNT30itlF2LI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGWQPMvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGWQPMvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188D31F00893;
	Wed, 30 Sep 2026 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726643;
	bh=Y1PN+O+djsYy2h9q2S5gBwMLOvJS7rZBDEsTaF/Bo4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGWQPMvXVe+8yDQNFCPIlgzTU7/AuuNa1H8L0b7Khk4UbL3rIVHUpY76ALm0vanEf
	 8wGuNcAdjGrH4sG+0gvz7Lh/qaGsL3GXwck7UmniAkfyqhJCmhFA4eCjmt85hGWVsF
	 IHmlTLIAQHolCCK7MMWkmTGTLXjTJ7eUafErq1ENCu7BGGspeCYorE0ZDV0XvlMIC2
	 Sl4H3z7PsHM4eV8SUwDAjZP9VyC3xs8c52UcwQ+AIw4HUE8/TFPIpylOURaOCGFICy
	 u5iTMPLY9L2ezMVshu7ho44uRV3Xked/CfYD8hWB9Sz/QNllBnlw/BF4DKT6kYAzn5
	 wKQhOUugcRr/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Tue, 29 Sep 2026 20:04:00 -0400
Message-ID: <20260930000401.2861657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092900-prize-superglue-6d70@gregkh>
References: <2026092900-prize-superglue-6d70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit dfb1b0c9dc0d61e422905640e1e7334b3cf6f384 ]

The macro is for the default minimum size of each DAMON region.  There was
a case that a reader was confused if it is the minimum number of total
DAMON regions, which is set on damon_attrs->min_nr_regions.  Make the name
more explicit.

Link: https://lkml.kernel.org/r/20260117175256.82826-8-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Stable dependency adaptation for 90179da203ba:

Rename every use present in 6.12, including the core KUnit override and
filter tests.  Drop upstream hunks for address units, per-context region
alignment, and the newer damon_set_regions() signature, which are absent
from this tree.  Preserve the stable region-setting validation and error
handling.

Prepare the existing quota calculation for the unmodified target patch:
store the fixed minimum region size in damon_ctx, pass the context and
scheme to damos_set_effective_quota(), initialize esz to ULONG_MAX, and
use the upstream mult_frac() throughput calculation.  Keep the existing
minimum quota clamp for the target to fix.  No functions are added.

[ sashal: Reduced backport -- upstream dfb1b0c9dc0d6 touches 7 file(s), this
  backport carries 4. Not backported here:
  mm/damon/lru_sort.c
  mm/damon/reclaim.c
  mm/damon/sysfs.c
  mm/damon/tests/vaddr-kunit.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 90179da203ba ("mm/damon/core: allow esz to be set to zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h       |  4 ++-
 mm/damon/core.c             | 56 ++++++++++++++++++-------------------
 mm/damon/tests/core-kunit.h | 36 ++++++++++++------------
 mm/damon/vaddr.c            | 22 +++++++--------
 4 files changed, 60 insertions(+), 58 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4688a10eca89b..dda0357026edf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -15,7 +15,7 @@
 #include <linux/random.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
-#define DAMON_MIN_REGION	PAGE_SIZE
+#define DAMON_MIN_REGION_SZ	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -631,6 +631,8 @@ struct damon_ctx {
 	struct completion kdamond_started;
 	/* for scheme quotas prioritization */
 	unsigned long *regions_score_histogram;
+	/* minimum region size for time quotas, fixed on this stable branch */
+	unsigned long min_region_sz;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32737cc5f877b..c74a0cc9ea413 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -19,8 +19,8 @@
 #include <trace/events/damon.h>
 
 #ifdef CONFIG_DAMON_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 static DEFINE_MUTEX(damon_lock);
@@ -218,8 +218,8 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	for (i = 0; i < nr_ranges; i++) {
 		unsigned long start, end;
 
-		start = ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION);
-		end = ALIGN(ranges[i].end, DAMON_MIN_REGION);
+		start = ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION_SZ);
+		end = ALIGN(ranges[i].end, DAMON_MIN_REGION_SZ);
 		if (start >= end)
 			return -EINVAL;
 		if (i > 0 && last_end > start)
@@ -258,16 +258,16 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						DAMON_MIN_REGION),
-					ALIGN(range->end, DAMON_MIN_REGION));
+						DAMON_MIN_REGION_SZ),
+					ALIGN(range->end, DAMON_MIN_REGION_SZ));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-					DAMON_MIN_REGION);
-			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+					DAMON_MIN_REGION_SZ);
+			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION_SZ);
 
 			/* fill possible holes in the range */
 			err = damon_fill_regions_holes(first, last, t);
@@ -521,6 +521,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
+
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
 
@@ -1092,8 +1094,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	return sz;
 }
@@ -1339,11 +1341,11 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, DAMON_MIN_REGION);
+					r->ar.start, DAMON_MIN_REGION_SZ);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+				if (damon_sz_region(r) <= DAMON_MIN_REGION_SZ)
 					return true;
-				sz_to_skip = DAMON_MIN_REGION;
+				sz_to_skip = DAMON_MIN_REGION_SZ;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
@@ -1383,8 +1385,8 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
-		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION_SZ);
+		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION_SZ);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1464,7 +1466,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					DAMON_MIN_REGION);
+					DAMON_MIN_REGION_SZ);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -1631,10 +1633,11 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 /*
  * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
-static void damos_set_effective_quota(struct damos_quota *quota)
+static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 {
+	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
-	unsigned long esz;
+	unsigned long esz = ULONG_MAX;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -1652,15 +1655,12 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (quota->ms) {
 		if (quota->total_charged_ns)
-			throughput = quota->total_charged_sz * 1000000 /
-				quota->total_charged_ns;
+			throughput = mult_frac(quota->total_charged_sz,
+					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (!list_empty(&quota->goals))
-			esz = min(throughput * quota->ms, esz);
-		else
-			esz = throughput * quota->ms;
-		esz = max(DAMON_MIN_REGION, esz);
+		esz = min(throughput * quota->ms, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -1693,7 +1693,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		quota->total_charged_sz += quota->charged_sz;
 		quota->charged_from = jiffies;
 		quota->charged_sz = 0;
-		damos_set_effective_quota(quota);
+		damos_set_effective_quota(c, s);
 	}
 
 	if (!c->ops.get_scheme_score)
@@ -1888,13 +1888,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * DAMON_MIN_REGION; i++) {
+				sz_region > 2 * DAMON_MIN_REGION_SZ; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, DAMON_MIN_REGION);
+					sz_region / 10, DAMON_MIN_REGION_SZ);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ff9f73579f7b3..a97a4326a227e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -530,10 +530,10 @@ static void damos_test_filter_out(struct kunit *test)
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
 	f->addr_range = (struct damon_addr_range){
-		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
+		.start = DAMON_MIN_REGION_SZ * 2, .end = DAMON_MIN_REGION_SZ * 6};
 
 	t = damon_new_target();
-	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	r = damon_new_region(DAMON_MIN_REGION_SZ * 3, DAMON_MIN_REGION_SZ * 5);
 	damon_add_region(r, t);
 
 	/* region in the range */
@@ -541,45 +541,45 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 2;
+	r->ar.start = DAMON_MIN_REGION_SZ * 1;
+	r->ar.end = DAMON_MIN_REGION_SZ * 2;
 	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
-	r->ar.start = DAMON_MIN_REGION * 6;
-	r->ar.end = DAMON_MIN_REGION * 8;
+	r->ar.start = DAMON_MIN_REGION_SZ * 6;
+	r->ar.end = DAMON_MIN_REGION_SZ * 8;
 	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 4;
+	r->ar.start = DAMON_MIN_REGION_SZ * 1;
+	r->ar.end = DAMON_MIN_REGION_SZ * 4;
 	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
 	/* filter should have split the region */
-	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
-	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION_SZ * 1);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION_SZ * 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	if (damon_nr_regions(t) != 2)
 		goto out;
 	r2 = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
-	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION_SZ * 2);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION_SZ * 4);
 	damon_destroy_region(r2, t);
 
 	/* region started in the range */
-	r->ar.start = DAMON_MIN_REGION * 2;
-	r->ar.end = DAMON_MIN_REGION * 8;
+	r->ar.start = DAMON_MIN_REGION_SZ * 2;
+	r->ar.end = DAMON_MIN_REGION_SZ * 8;
 	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
 	/* filter should have split the region */
-	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
-	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION_SZ * 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION_SZ * 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	if (damon_nr_regions(t) != 2)
 		goto out;
 	r2 = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
-	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION_SZ * 6);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION_SZ * 8);
 	damon_destroy_region(r2, t);
 
 out:
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 089ee23e07de7..b423ce9da392d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -18,8 +18,8 @@
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 /*
@@ -74,7 +74,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -157,12 +157,12 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 		swap(first_gap, second_gap);
 
 	/* Store the result */
-	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION);
-	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION);
-	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION);
-	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION);
+	regions[0].start = ALIGN(start, DAMON_MIN_REGION_SZ);
+	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION_SZ);
+	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION_SZ);
+	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION_SZ);
+	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION_SZ);
+	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION_SZ);
 
 	return 0;
 }
@@ -255,8 +255,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
-- 
2.53.0

