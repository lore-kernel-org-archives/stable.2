Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E29495510;
	Mon, 19 Oct 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417154; cv=none; b=ElOEqbYRFRpVVRWc8kKMGTngFNsjWPcxwUlqjNyB3JEb+88Xp59h0hza6/pCnkCbEqs/i2QrUZfez5XI4uDhpHNR7sbPmn2VFfnoRWHHrqTuJp7X4DOObivfSDA2Ooo0Jp9uCGYYc4kbo+PowXz3EgstZH5GLtA+kS99eILb1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417154; c=relaxed/simple;
	bh=uspzV/dJrz8pu2AAzfeE45CxyH97ulPh1CLm1+C3K30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQw6nV/iAi+G37TWJeCAD7TTrUKK5/DhVHPnUKX8vM0vW0hqj9smR9Eq8XIRT9ZYzRNC26yVPz6M569RVO58jgbqkO3HiZmDC77HCCLpNLhg3wbDCVp4CeGmmxZKhcHKzHERZVFccL4P2d9a/fyXIdeDeNxGERknUPprPkhczQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQl2eY5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQl2eY5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943531F000C4;
	Mon, 19 Oct 2026 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417152;
	bh=jFDkykTpCFq9YT8TT2xwNVz5rz5D5UYP/IyAQl0FhJU=;
	h=From:To:Cc:Subject:Date;
	b=WQl2eY5qduO/ycVgT9nFECZAtwHY8BcuxkWXEtGaMyZcoWRr10cgdIql5DB6VQJ6v
	 pf/pzsioytZw2BC2C7loqHvXe20yFpfuGsIPAR2FeoFY+OZUhY/LR5HbRVbdbEhgyx
	 fiesFcMNxTnouwP+oaTnTBYvdbcUEwiL6Jw9Ecm4XI0pHukfzFD26HNQyyYDFeb4SY
	 TbcA7KpnDDkrgKaOU9QDiXAKlhUt3AQt6ZSTFUou72vo5ASNrkArSXOnCFbpyVyeAB
	 5CRq8pVppS7nSk3Yzg9HDrStqoYiAvxGsoK8d7sIzSpri3gTMVZU6zQygsZ66eFVFH
	 Rc5bJ2UfIXKdw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2] mm/damon/core: filter out damos address filter-split failed region
Date: Mon, 19 Oct 2026 06:38:55 -0700
Message-ID: <20261019133856.86835-1-sj@kernel.org>
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
Changes from RFC
- RFC: https://lore.kernel.org/20261018220253.158238-1-sj@kernel.org
- Handle failure in another split operation in damos_filter_match().

 mm/damon/core.c             | 16 ++++++++++++----
 mm/damon/tests/core-kunit.h | 11 ++++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef89901..479169dc9ac75 100644
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
@@ -2583,12 +2584,13 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		}
 		/* start before the range and overlap */
 		if (r->ar.start < start) {
-			damon_split_region_at(t, r, start - r->ar.start);
+			*err = damon_split_region_at(t, r,
+					start - r->ar.start);
 			matched = false;
 			break;
 		}
 		/* start inside the range */
-		damon_split_region_at(t, r, end - r->ar.start);
+		*err = damon_split_region_at(t, r, end - r->ar.start);
 		matched = true;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
@@ -2607,10 +2609,16 @@ static bool damos_core_filter_out(struct damon_ctx *ctx, struct damon_target *t,
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

base-commit: 7e7e74286672b8e164e60aec0e94f05f62eb357e
-- 
2.47.3
