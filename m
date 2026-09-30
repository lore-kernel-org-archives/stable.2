Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265ED36DA14
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735655; cv=none; b=rbIaOYjWzQ+KYReZTAb2Hy+Z9uQRVWzT1N7O3bdYh5cxXniSzmrfWPyZc/2bW1orMMQ3203rbpO1cUe8+RcwoRmBTh2ujOtE2vumk4aZNzmBWSqGO11H79j55gcrwJ9Th5YkCl6jfqQ6LuJNF794gqhu/kxoTxqEmrAB23P+PVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735655; c=relaxed/simple;
	bh=rQ3wMtdgsAn/qrAIdv/v5sRKU/z8+nKzLC2pbf4+dDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Ug8Y/v5XTUsJMtN09AcMIsOtDbrGLrKwg8Fc7XxbDqn65rmTssU76Ebe/MySFvLc8JhiuVNg4491/+AhMNO4WrC7qZSbLAvNOJNCz7W0/t+M7JRi9+W6rjqlPdVS8w7bYAtSdNFD9XXinXH7Yzahc6yPCLcOtCXkqI+aXs0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL2l/EjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL2l/EjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3231F0089B;
	Wed, 30 Sep 2026 02:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735643;
	bh=Hoq8tkqKLSnyqrqYcoHBfvanCoz8gWdgh3UaJf2y65c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dL2l/EjWU2/As3W0EnRkMN2lJPUOyCtU5sGk+kbZ3eBC/PxInvJ06AtXugLUzLY2S
	 6eUefdYqi7ja7QC/OOhS8CyFKgmSevtIm6fnjRPbL0rrxggVch3gYsPIe8eNDruTP6
	 BgBN+Fl6Jr6mh0cRxdDQlK3yevXCPodvoZCFI9T+TjZhFBLish4FJ7w2HtMqTJRMIh
	 V8/bc/nnwfNoYSYVmZV0h04glz5p/U1vagv64hnkO2WQvXdsC/d8AkPFKKR2eqc1gO
	 e6n2er9z4B21GvKHyY3GItLxy5IwOuNmWd0Ch6EcqyXUsCAK5kmfFULHgn2vXHH3j7
	 zWqXhaylYFkLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Tue, 29 Sep 2026 22:34:00 -0400
Message-ID: <20260930023401.3420697-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023401.3420697-1-sashal@kernel.org>
References: <2026092948-agency-overhand-3fd1@gregkh>
 <20260930023401.3420697-1-sashal@kernel.org>
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

Stable backport preparation for b3723b596b548 ("mm/damon/core: fix
unconditionally skip last region"):

Rename all uses present in 6.12, including the core KUnit override and
tests.  Drop changes to address-unit/minimum-size context fields and the
four-argument damon_set_regions() calls, which do not exist in this tree.

Match the target's quota helper preimage by passing the fixed region size
as min_region_sz and incorporating the existing-function changes from
1745ccbd2907 ("mm/damon/core: do non-safe region walk on
kdamond_apply_schemes()").  The region walk must visit newly split tails
when the helper returns true for the already charged prefix.  Preserve
the existing target-validity check and leave the last-region fix to the
target commit.  No new functions or context fields are introduced.

[ sashal: Reduced backport -- upstream dfb1b0c9dc0d6 touches 7 file(s), this
  backport carries 4. Not backported here:
  mm/damon/lru_sort.c
  mm/damon/reclaim.c
  mm/damon/sysfs.c
  mm/damon/tests/vaddr-kunit.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h       |  2 +-
 mm/damon/core.c             | 64 +++++++++++++++++++------------------
 mm/damon/tests/core-kunit.h | 36 ++++++++++-----------
 mm/damon/vaddr.c            | 22 ++++++-------
 4 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4688a10eca89b..a634d47eaa8bc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -15,7 +15,7 @@
 #include <linux/random.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
-#define DAMON_MIN_REGION	PAGE_SIZE
+#define DAMON_MIN_REGION_SZ	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b3a28a857d075..53d479da2007e 100644
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
@@ -1092,8 +1092,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	return sz;
 }
@@ -1298,8 +1298,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * damos_skip_charged_region() - Check if the given region or starting part of
  * it is already charged for the DAMOS quota.
  * @t:	The target of the region.
- * @rp:	The pointer to the region.
+ * @r:	The region.
  * @s:	The scheme to be applied.
+ * @min_region_sz:	minimum region size.
  *
  * If a quota of a scheme has exceeded in a quota charge window, the scheme's
  * action would applied to only a part of the target access pattern fulfilling
@@ -1310,16 +1311,18 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow and saves the second
- * region in *rp and returns false, so that the caller can apply DAMON action
- * to the second one.
+ * area that not charged in the previous charge widnow, and return true.  The
+ * caller can see the second one on the next iteration of the region walk.
+ * Note that this means the caller should use damon_for_each_region() instead
+ * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
+ * the second region will just be ignored.
  *
- * Return: true if the region should be entirely skipped, false otherwise.
+ * Return: true if the region should be skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s)
+		struct damon_region *r, struct damos *s,
+		unsigned long min_region_sz)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
@@ -1339,15 +1342,14 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, DAMON_MIN_REGION);
+					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+				if (damon_sz_region(r) <= min_region_sz)
 					return true;
-				sz_to_skip = DAMON_MIN_REGION;
+				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
+			return true;
 		}
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
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
@@ -1514,7 +1516,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s))
+		if (damos_skip_charged_region(t, r, s, DAMON_MIN_REGION_SZ))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -1660,7 +1662,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 			esz = min(throughput * quota->ms, esz);
 		else
 			esz = throughput * quota->ms;
-		esz = max(DAMON_MIN_REGION, esz);
+		esz = max(DAMON_MIN_REGION_SZ, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -1727,7 +1729,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -1752,7 +1754,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
 
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
@@ -1891,13 +1893,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
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

