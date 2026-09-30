Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576EEED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726641; cv=none; b=MWezl7Lsc4W6vDEihi9Y8Y5i+AtST10GqTQ+KB0HxHUpyRPjGpKnhr0+FUzYJdmB7bU0AsOwJjQ9/2bJRJgjfgYHZ4kXt4LVk2ski2LgDG9Lif2p9M5XJko3ux4HQZP8ZhXgkiCErPOIP/8w0rkrWTZAePmB3oDma8H4WjI3lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726641; c=relaxed/simple;
	bh=MNu6b2iGOZcm9rRR5yrKx2OecLT4x/NWdAN1h6Du5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2n1WnWP9XHCo8RZ7IODuiduO9llq4jt4yJGpJKZYC7Bo73L+on2uCJdPtKJwHugbC5+xRja6iLGibGZ+N/AIbSGoH+mkAPvrA63oVi+psi9whLP1H29rlqWcV6zwyS9tIXtqFjQ0GcNGPpANOND8k/kaRfnvlmq8+pt4tPngKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwVzrt5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwVzrt5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4F1F00899;
	Wed, 30 Sep 2026 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726639;
	bh=ghK8G9nHlfYvlRj5FIZ3ODs/UMjPnA1y06u3KMyCsNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YwVzrt5WWwovK4AzR6VXFucgTyymH4B6LlDViQigeAz3SgoVtYA+ViCpyRv2QOtjn
	 o8k4g3Hgw6rLPnwd18cyPxAXusML+vIz7UeyP3MSsMOJGlvC/Qesf6EV1MPD2LzybC
	 yalJpln3ntH0Vi6YXp3HxOQun6UWEY7ubmJwg9zZw+Ikackf7jEdOGNGp3w9keMOMb
	 DMBCBmSqwmLm7Nmvz7N46mz7xteFtVd0643NCCK9kbZRrIKrVFIaXIckSf3afNpSBs
	 8HABkvQFT0Lx4yZvFNIMjvQFn1DuyLYF1ylmqOa0+mT8NmI/fJEBmKYRuyNo2XFf/U
	 nS9IWPiaEHOSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Tue, 29 Sep 2026 20:03:52 -0400
Message-ID: <20260930000354.2861391-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000354.2861391-1-sashal@kernel.org>
References: <2026092947-shush-encode-1e48@gregkh>
 <20260930000354.2861391-1-sashal@kernel.org>
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

Stable adaptation for b3723b596b548c837a766aae3553c14a7b15af2b:

Preserve the READ_ONCE() snapshots of ops_id and addr_unit in sysfs and
use ctx->addr_unit when calculating the minimum region size.  Complete
the macro rename for stable-only core, stat, and core KUnit references,
including the one-byte minimum used by the existing tests.

Prepare the existing quota helper for the target's upstream patch:
rename its minimum-size parameter as in cc1db8dff8e7, and adapt the
region-walk changes from 1745ccbd2907.  Use damon_for_each_region() so
newly split regions are visited, pass the region directly to the quota
helper, and skip the charged prefix after a split.  These changes keep
the helper and its caller consistent and let the target apply cleanly.
No functions are added; the target's last-region fix remains separate.

Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h        |  2 +-
 mm/damon/core.c              | 41 ++++++++++++++--------------
 mm/damon/lru_sort.c          |  2 +-
 mm/damon/reclaim.c           |  2 +-
 mm/damon/stat.c              |  2 +-
 mm/damon/sysfs.c             |  2 +-
 mm/damon/tests/core-kunit.h  | 52 ++++++++++++++++++------------------
 mm/damon/tests/vaddr-kunit.h |  2 +-
 mm/damon/vaddr.c             | 24 ++++++++---------
 9 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8630ce99d6ca9..4293c13641be3 100644
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
index 2d9c27b490683..bbae7c7a99c49 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -20,8 +20,8 @@
 #include <trace/events/damon.h>
 
 #ifdef CONFIG_DAMON_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 static DEFINE_MUTEX(damon_lock);
@@ -563,7 +563,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
-	ctx->min_sz_region = DAMON_MIN_REGION;
+	ctx->min_sz_region = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -1721,9 +1721,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * damos_skip_charged_region() - Check if the given region or starting part of
  * it is already charged for the DAMOS quota.
  * @t:	The target of the region.
- * @rp:	The pointer to the region.
+ * @r:	The region.
  * @s:	The scheme to be applied.
- * @min_sz_region:	minimum region size.
+ * @min_region_sz:	minimum region size.
  *
  * If a quota of a scheme has exceeded in a quota charge window, the scheme's
  * action would applied to only a part of the target access pattern fulfilling
@@ -1734,16 +1734,18 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * This function checks if a given region should be skipped or not for the
  * reason.  If only the starting part of the region has previously charged,
  * this function splits the region into two so that the second one covers the
- * area that not charged in the previous charge widnow and saves the second
- * region in *rp and returns false, so that the caller can apply DAMON action
- * to the second one.
+ * area that was not charged in the previous charge window, and returns true.
+ * The caller can see the second one on the next iteration of the region walk.
+ * Note that this means the caller should use damon_for_each_region() instead
+ * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
+ * the second region will just be ignored.
  *
- * Return: true if the region should be entirely skipped, false otherwise.
+ * Return: true if the region should be skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s, unsigned long min_sz_region)
+		struct damon_region *r, struct damos *s,
+		unsigned long min_region_sz)
 {
-	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
 
@@ -1763,15 +1765,14 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, min_sz_region);
+					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_sz_region)
+				if (damon_sz_region(r) <= min_region_sz)
 					return true;
-				sz_to_skip = min_sz_region;
+				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			r = damon_next_region(r);
-			*rp = r;
+			return true;
 		}
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
@@ -2030,7 +2031,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
+		if (damos_skip_charged_region(t, r, s, c->min_sz_region))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -2302,7 +2303,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 	unsigned long sample_interval = c->attrs.sample_interval ?
 		c->attrs.sample_interval : 1;
@@ -2328,7 +2329,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
 
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 
@@ -2924,7 +2925,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION);
+	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION_SZ);
 }
 
 /*
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9bf46627feeca..c45edb12d78f3 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,7 +203,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 48225eb435e1b..fc1aafed8e584 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -199,7 +199,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 57972096d4ebd..7b137e4ebd3bf 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -178,7 +178,7 @@ static int damon_stat_set_monitoring_region(struct damon_target *t,
 	addr_range.end = arg.res.end + 1;
 	if (addr_range.end <= addr_range.start)
 		return -EINVAL;
-	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION);
+	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION_SZ);
 }
 
 static struct damon_ctx *damon_stat_build_ctx(void)
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7f52470be36e3..12db38f275930 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1451,7 +1451,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
-				DAMON_MIN_REGION / ctx->addr_unit, 1);
+				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0ce6481319432..f1a1d21f5a8b0 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -300,7 +300,7 @@ static void damon_test_split_regions_of(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 	}
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
+	damon_split_regions_of(t, 2, DAMON_MIN_REGION_SZ);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
@@ -316,7 +316,7 @@ static void damon_test_split_regions_of(struct kunit *test)
 		kunit_skip(test, "second region alloc fail");
 	}
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
+	damon_split_regions_of(t, 4, DAMON_MIN_REGION_SZ);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 	damon_destroy_ctx(c);
@@ -398,7 +398,7 @@ static void damon_test_set_regions(struct kunit *test)
 
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
-	damon_set_regions(t, &range, 1, DAMON_MIN_REGION);
+	damon_set_regions(t, &range, 1, DAMON_MIN_REGION_SZ);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
 	damon_for_each_region(r, t) {
@@ -553,14 +553,14 @@ static void damos_test_filter_out(struct kunit *test)
 	if (!f)
 		kunit_skip(test, "filter alloc fail");
 	f->addr_range = (struct damon_addr_range){
-		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
+		.start = DAMON_MIN_REGION_SZ * 2, .end = DAMON_MIN_REGION_SZ * 6};
 
 	t = damon_new_target();
 	if (!t) {
 		damos_destroy_filter(f);
 		kunit_skip(test, "target alloc fail");
 	}
-	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	r = damon_new_region(DAMON_MIN_REGION_SZ * 3, DAMON_MIN_REGION_SZ * 5);
 	if (!r) {
 		damos_destroy_filter(f);
 		damon_free_target(t);
@@ -570,53 +570,53 @@ static void damos_test_filter_out(struct kunit *test)
 
 	/* region in the range */
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION_SZ));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 2;
+	r->ar.start = DAMON_MIN_REGION_SZ * 1;
+	r->ar.end = DAMON_MIN_REGION_SZ * 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION_SZ));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
-	r->ar.start = DAMON_MIN_REGION * 6;
-	r->ar.end = DAMON_MIN_REGION * 8;
+	r->ar.start = DAMON_MIN_REGION_SZ * 6;
+	r->ar.end = DAMON_MIN_REGION_SZ * 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION_SZ));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 4;
+	r->ar.start = DAMON_MIN_REGION_SZ * 1;
+	r->ar.end = DAMON_MIN_REGION_SZ * 4;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION_SZ));
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
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION_SZ));
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
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index e2c36d4d8789e..a1a867cb4eb3f 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -147,7 +147,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
 	if (damon_nr_regions(t) != nr_expected / 2)
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c49f494ec17cd..18882f03fb6e6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -19,8 +19,8 @@
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 /*
@@ -78,7 +78,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -161,12 +161,12 @@ static int __damon_va_three_regions(struct mm_struct *mm,
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
@@ -259,8 +259,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
@@ -299,7 +299,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 	}
 }
 
-- 
2.53.0

