Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AF394EB0;
	Sun, 18 Oct 2026 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792360988; cv=none; b=J//KTTMoO/IcR+cVA4wMdF2DwU45YhUB39YRwMz3K18+lCScU5L/uHwAAYa2+qgR0dM0bX84X4xwsQdU3VhJYEdiR+iXr/G/aw9knzJlewyo5UYcY+4f7x28Nkb7gXG8zVVOeHVZqUee/81+MNkuT8TTI7jbGwaxsN3WTkMdn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792360988; c=relaxed/simple;
	bh=twLiNJ2iWt/8LUbRgsm5ooLbyC12UPzg7TGB8ejiu0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QL29NoVwf89QEkFyRTJhrGjBTHgri8aiSiXE9+zK49JcUGR6Laq25YeVl+1o8OyX338QXF2BIfEVecJbRuYRZu8zDYr1MBgl2utP+DetST5lQIFU/pnz+Gxp5LGeQ4AbWINiadYKuJmGIgt438b0H/AmpueEX2W6X7LYPivhWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO1SlCH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO1SlCH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896111F000C4;
	Sun, 18 Oct 2026 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792360986;
	bh=9jIwRePGhGl7Lj5AtdjryQO+SfZ1sGL+oGdwGuNfa24=;
	h=From:To:Cc:Subject:Date;
	b=PO1SlCH62VrarZagP9eLCG2Zz/sSoHA25CDWscQESh9Jq62Iu5LnFfmDh8f54vvNM
	 mKQg9EFCHasXibgNzVZtonckwtoUm76FsgS4R8lUqAW+1Yu5885OHZ/Ulhm9/1MddY
	 E+TSJ0h1MKBmQDWb3fRQ/aOl4zyh+OLTmE4kcrujbQwUNf1YPVYTsJDhQkx2SpMg0Z
	 xMuiniBCwvhm4J6tqBlYGnUibF9HbliZsa29LOi5C4bFSXBHOsRdU79Aehhf3OEHUD
	 dNcAwF+k+V8jPs3aswqV3EmHp+yZzwyt70eQz9FBc25zdS8IWwf4lQelbi3HJkBYek
	 hbLnkEaLN5b8A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: filter out damos address filter-split failed region
Date: Sun, 18 Oct 2026 15:02:52 -0700
Message-ID: <20261018220253.158238-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an address type DAMOS filter is configured, DAMOS tries to split
the region for the filter range, and apply DAMOS action to the filter-in
region.  The split operation (damon_split_region_at()) could fail from
allocation failure under extreme memory pressure.  In the case, DAMOS
action could be applied more or less than expected, ignoring the address
filter.

The issue only rarely happens under extreme memory pressure.  No crash
or leak happens.  Occasionally not applying the action to a few regions
shouldn't be a real problem.  But applying the action to a region that
the user has excluded via address filter could be a surprise depending
on the use case.  It is only theoretical.  No such real case is found
yet.

Filter out the entire region if the split is failed.  Update
damos_filter_match() signature to receive the error from split.  Also
update kunit tests for the updated signature.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 15 ++++++++++++---
 mm/damon/tests/core-kunit.h | 11 ++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef89901..4d34587387456 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2551,13 +2551,14 @@ static void damos_update_stat(struct damos *s,
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter,
-		unsigned long min_region_sz)
+		unsigned long min_region_sz, int *err)
 {
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
 	unsigned long start, end, wsum;
 
+	*err = 0;
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
 		damon_for_each_target(ti, ctx) {
@@ -2588,7 +2589,9 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 			break;
 		}
 		/* start inside the range */
-		damon_split_region_at(t, r, end - r->ar.start);
+		*err = damon_split_region_at(t, r, end - r->ar.start);
+		if (*err)
+			return false;
 		matched = true;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
@@ -2607,10 +2610,16 @@ static bool damos_core_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
+	bool matching;
+	int err;
 
 	s->core_filters_allowed = false;
 	damos_for_each_core_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter, ctx->min_region_sz)) {
+		matching = damos_filter_match(ctx, t, r, filter,
+				ctx->min_region_sz, &err);
+		if (err)
+			return true;
+		if (matching) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3fbb4e4e36fac..43e2f950f8ff4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1783,6 +1783,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
@@ -1803,27 +1804,27 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = 1;
 	r->ar.end = 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = 6;
 	r->ar.end = 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = 1;
 	r->ar.end = 4;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
@@ -1839,7 +1840,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1));
+			damos_filter_match(NULL, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);

base-commit: dbff06b9dcfe3a45b66fcf20d0fec8c3e56f5624
-- 
2.47.3
