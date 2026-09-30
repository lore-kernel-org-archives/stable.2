Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCE3B2AA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726642; cv=none; b=X6Blju+AlY2eYBXcG9Rw5w1MJcPP8AQmwOTgCk7cL1srhx+wj6HSwvdYqlv55jRJQvNRp9nekjsT5//GuxcjuEz/Hv1xhf7uoDFK0gL3T1m1skwaq/D9SHb8nATL5L78Z2jJdR95K18XjUP3nm5hGIrYtVLJy0dtNg9/rASXM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726642; c=relaxed/simple;
	bh=r8SmFqylCNeXuYifl5gTaisDl3St17t+wdZObBRtiIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnF8HTlfiADvWDZxf4xtXrLmAagfSOMl+40yoaf5PbBCpS1auZqz8nZnc7vhCq1zP9MloFQMohh7nyZyHlTW70mvSnJKG1l2spnSxBiV43qsbiJjPic4BMOgTb8O712IqtRySCo+mgDYGjWqGKn4X9w2/4oF7DguTagOMV5f73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwxV6PHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwxV6PHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB91F0089A;
	Wed, 30 Sep 2026 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726640;
	bh=vjQZ+fmYFywDJ3dvP33iZd8mrrLqptdpNUnyAPLYBcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZwxV6PHD4X6Dy8+7OxSoxTfiGH87H7Xv1qtvfJ2Ht71eEZUYYEsTAFICiG5R2mzsF
	 sifzvrCE0DzzcV4kG3tUyEGAAIqWR1Uz+gdy7qTCDHwqnxOk4rbbGGzKa1pExJj4px
	 17LFJjxf11P70td51CCehcW2rbOjztVCPFfW1anlt55mS0H9BbSfEGwUdZ6XzKGCoe
	 lygFU6iX0CNp6QXjHULQRlQTUS8Op8bfUzeSWqgNmWdr0aZUFFH/7AihsXmplEHj7d
	 IcmfqAZ2igICap5i/hsy66YFclsOAPEcfJtpssGRn8I62wa1I5jPsLCSzwoLhbyhM+
	 Z17jGTiRxso2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] mm/damon: rename min_sz_region of damon_ctx to min_region_sz
Date: Tue, 29 Sep 2026 20:03:53 -0400
Message-ID: <20260930000354.2861391-4-sashal@kernel.org>
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

[ Upstream commit cc1db8dff8e751ec3ab352483de366b7f23aefe2 ]

'min_sz_region' field of 'struct damon_ctx' represents the minimum size of
each DAMON region for the context.  'struct damos_access_pattern' has a
field of the same name.  It confuses readers and makes 'grep' less optimal
for them.  Rename it to 'min_region_sz'.

Link: https://lkml.kernel.org/r/20260117175256.82826-9-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Stable adaptation for b3723b596b548c837a766aae3553c14a7b15af2b:

Keep the context minimum-region-size rename and update stable-only users
in range validation, context validation, and effective quota calculation.
The access-pattern min_sz_region field retains its original name.

Drop hunks for the extra minimum-size argument of
damon_set_region_biggest_system_ram_default(), which this stable tree
has not gained.  Retain the existing three-argument helper and callers,
and keep stat.c's separate monitoring-region setup unchanged.

Preserve stable's context-commit error handling, sysfs READ_ONCE()
snapshots, and the already-adapted direct-region quota helper and region
walk.  The target's last-region fix remains separate and applies cleanly.
No functions are added.

[ sashal: Reduced backport -- upstream cc1db8dff8e75 touches 6 file(s), this
  backport carries 5. Not backported here:
  mm/damon/stat.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h |  6 ++---
 mm/damon/core.c       | 62 +++++++++++++++++++++----------------------
 mm/damon/lru_sort.c   |  2 +-
 mm/damon/reclaim.c    |  2 +-
 mm/damon/sysfs.c      |  9 ++++---
 5 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4293c13641be3..dda9347d2674b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -749,7 +749,7 @@ struct damon_attrs {
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
- * @min_sz_region:		Minimum region size.
+ * @min_region_sz:	Minimum region size.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -799,7 +799,7 @@ struct damon_ctx {
 
 	struct damon_operations ops;
 	unsigned long addr_unit;
-	unsigned long min_sz_region;
+	unsigned long min_region_sz;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
@@ -888,7 +888,7 @@ static inline void damon_insert_region(struct damon_region *r,
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region);
+		unsigned int nr_ranges, unsigned long min_region_sz);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bbae7c7a99c49..3920ce7d07925 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -201,7 +201,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * @t:		the given target.
  * @ranges:	array of new monitoring target ranges.
  * @nr_ranges:	length of @ranges.
- * @min_sz_region:	minimum region size.
+ * @min_region_sz:	minimum region size.
  *
  * This function adds new regions to, or modify existing regions of a
  * monitoring target to fit in specific ranges.
@@ -209,7 +209,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * Return: 0 if success, or negative error code otherwise.
  */
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region)
+		unsigned int nr_ranges, unsigned long min_region_sz)
 {
 	struct damon_region *r, *next;
 	unsigned int i;
@@ -219,8 +219,8 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	for (i = 0; i < nr_ranges; i++) {
 		unsigned long start, end;
 
-		start = ALIGN_DOWN(ranges[i].start, min_sz_region);
-		end = ALIGN(ranges[i].end, min_sz_region);
+		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
+		end = ALIGN(ranges[i].end, min_region_sz);
 		if (start >= end)
 			return -EINVAL;
 		if (i > 0 && last_end > start)
@@ -259,16 +259,16 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						min_sz_region),
-					ALIGN(range->end, min_sz_region));
+						min_region_sz),
+					ALIGN(range->end, min_region_sz));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-					min_sz_region);
-			last->ar.end = ALIGN(range->end, min_sz_region);
+					min_region_sz);
+			last->ar.end = ALIGN(range->end, min_region_sz);
 
 			/* fill possible holes in the range */
 			err = damon_fill_regions_holes(first, last, t);
@@ -563,7 +563,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
-	ctx->min_sz_region = DAMON_MIN_REGION_SZ;
+	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -1147,7 +1147,7 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
  * If @src has no region, @dst keeps current regions.
  */
 static int damon_commit_target_regions(struct damon_target *dst,
-		struct damon_target *src, unsigned long src_min_sz_region)
+		struct damon_target *src, unsigned long src_min_region_sz)
 {
 	struct damon_region *src_region;
 	struct damon_addr_range *ranges;
@@ -1164,7 +1164,7 @@ static int damon_commit_target_regions(struct damon_target *dst,
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
-	err = damon_set_regions(dst, ranges, i, src_min_sz_region);
+	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
 	kfree(ranges);
 	return err;
 }
@@ -1172,11 +1172,11 @@ static int damon_commit_target_regions(struct damon_target *dst,
 static int damon_commit_target(
 		struct damon_target *dst, bool dst_has_pid,
 		struct damon_target *src, bool src_has_pid,
-		unsigned long src_min_sz_region)
+		unsigned long src_min_region_sz)
 {
 	int err;
 
-	err = damon_commit_target_regions(dst, src, src_min_sz_region);
+	err = damon_commit_target_regions(dst, src, src_min_region_sz);
 	if (err)
 		return err;
 	if (dst_has_pid)
@@ -1225,7 +1225,7 @@ static int damon_commit_targets(
 			err = damon_commit_target(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
-					src->min_sz_region);
+					src->min_region_sz);
 			if (err) {
 				failed = dst_target;
 				goto out;
@@ -1254,7 +1254,7 @@ static int damon_commit_targets(
 		}
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src),
-				src->min_sz_region);
+				src->min_region_sz);
 		if (err) {
 			damon_destroy_target(new_target, NULL);
 			goto out;
@@ -1286,7 +1286,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	int err;
 
 	dst->maybe_corrupted = true;
-	if (!is_power_of_2(src->min_sz_region))
+	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
 
 	err = damon_commit_schemes(dst, src);
@@ -1311,7 +1311,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	}
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
-	dst->min_sz_region = src->min_sz_region;
+	dst->min_region_sz = src->min_region_sz;
 
 	dst->maybe_corrupted = false;
 	return 0;
@@ -1345,8 +1345,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < ctx->min_sz_region)
-		sz = ctx->min_sz_region;
+	if (sz < ctx->min_region_sz)
+		sz = ctx->min_region_sz;
 
 	return sz;
 }
@@ -1404,7 +1404,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int err = 0;
 
 	for (i = 0; i < nr_ctxs; i++) {
-		if (!is_power_of_2(ctxs[i]->min_sz_region))
+		if (!is_power_of_2(ctxs[i]->min_region_sz))
 			return -EINVAL;
 	}
 
@@ -1794,7 +1794,7 @@ static void damos_update_stat(struct damos *s,
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter,
-		unsigned long min_sz_region)
+		unsigned long min_region_sz)
 {
 	bool matched = false;
 	struct damon_target *ti;
@@ -1811,8 +1811,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, min_sz_region);
-		end = ALIGN_DOWN(filter->addr_range.end, min_sz_region);
+		start = ALIGN_DOWN(filter->addr_range.start, min_region_sz);
+		end = ALIGN_DOWN(filter->addr_range.end, min_region_sz);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1848,7 +1848,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 
 	s->core_filters_allowed = false;
 	damos_for_each_core_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
+		if (damos_filter_match(ctx, t, r, filter, ctx->min_region_sz)) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
@@ -1983,7 +1983,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					c->min_sz_region);
+					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -2031,7 +2031,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, r, s, c->min_sz_region))
+		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -2214,7 +2214,7 @@ static void damos_set_effective_quota(struct damos_quota *quota,
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_sz_region, esz);
+		esz = max(ctx->min_region_sz, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
@@ -2464,7 +2464,7 @@ static void damon_split_region_at(struct damon_target *t,
 
 /* Split every region in the given target into 'nr_subs' regions */
 static void damon_split_regions_of(struct damon_target *t, int nr_subs,
-				  unsigned long min_sz_region)
+				  unsigned long min_region_sz)
 {
 	struct damon_region *r, *next;
 	unsigned long sz_region, sz_sub = 0;
@@ -2474,13 +2474,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * min_sz_region; i++) {
+				sz_region > 2 * min_region_sz; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, min_sz_region);
+					sz_region / 10, min_region_sz);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
@@ -2520,7 +2520,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
-		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
+		damon_split_regions_of(t, nr_subregions, ctx->min_region_sz);
 
 	last_nr_regions = nr_regions;
 }
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index c45edb12d78f3..3475c22e338a5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,7 +203,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
+	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index fc1aafed8e584..8e916fc255665 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -199,7 +199,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
+	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 12db38f275930..66410c8fbe24f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1345,7 +1345,7 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions,
-		unsigned long min_sz_region)
+		unsigned long min_region_sz)
 {
 	struct damon_addr_range *ranges = kmalloc_array(sysfs_regions->nr,
 			sizeof(*ranges), GFP_KERNEL | __GFP_NOWARN);
@@ -1367,7 +1367,7 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		if (ranges[i - 1].end > ranges[i].start)
 			goto out;
 	}
-	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_sz_region);
+	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_region_sz);
 out:
 	kfree(ranges);
 	return err;
@@ -1388,7 +1388,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			/* caller will destroy targets */
 			return -EINVAL;
 	}
-	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
+	return damon_sysfs_set_regions(t, sys_target->regions,
+			ctx->min_region_sz);
 }
 
 static int damon_sysfs_add_targets(struct damon_ctx *ctx,
@@ -1450,7 +1451,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (ops_id == DAMON_OPS_PADDR)
-		ctx->min_sz_region = max(
+		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
-- 
2.53.0

