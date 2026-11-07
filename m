Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090131;
	b=1Kfc59bnc19+siOMtkqvRDoGqy6cR0GDMKR+q5b9H2PyXHOMpjW4L19cq6FNWrNj0aB0
	 Ftba3PvkOQfPeLw1Ms9CYrW3XKEzbvkNwCmXDaS/f8tdg4xDK9vvvYnDoqrbVoT7sDwny
	 lqc0A5aIVzC0DgZ6t+Pd9eAiCe4fyWofnkB2vWNOD53s450ozioIC4IWHcHD1n4jZzqoE
	 Pi7o5aFGMvgSiFc6X8KiobjGy+kefOQnQSnq+hhYPaHPAds+Gr2zhbS1j+HyliaOceI6F
	 IAvKHGDmfhoVrXpNWA47KRavzHse5B38GWxVvzOtOM1iyNRRycwkgoUyhTPZcESaRvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e8b2BxiNM2zDfbsfHX5lOdltBPseBRShaz9qPJkxXRw=;
	b=waZRMhA4gWFQz+7Ri8kwiudqVfizIf/IVm3sQGXVgat3tq9dYPQXvInHo2GbYAHIeeIk
	 wy6JBL4XNzPIi3O2XhbH7msA3r1J56lYyJ7NTVkIgrmwogqUt0G9VApNB+NENWcd5hA74
	 XRXiLrx1hWHWxlfXsAYRJZbckIIZOv1eIpSSCNnbjod10mG3UnR4zaJM97a0nCn/hlbXj
	 H+Z6lJmsUOUP+bSD8/zKnz1ESeeHcgLo0KziAv9+OSu1p7vrQQpU95Hqa+KhCVcetTS9y
	 kZ9TPRutqaeOQMuG6Yrp3l4F/8yb8v9cmSH0xbd5nN3vnN1xX2I6mKfHR7Lx8PaSAnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqsDAE7f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536C606A32E;
	Sat,  7 Nov 2026 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqsDAE7f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402281F008A3;
	Sat,  7 Nov 2026 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090131;
	bh=e8b2BxiNM2zDfbsfHX5lOdltBPseBRShaz9qPJkxXRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FqsDAE7f+a160tFFkgUqjUF6DTdHtN56zbOQZufBN6+E2VrZnKvqyakwl9OdCuNWf
	 7Kn9rtFQ3Ti9t+yZXjqVADYgS6eBXqRgznjBHQvKHWo+8KfF0SVVgx2SYhPCODCW/v
	 VzzW7/KzL8x/XBJ/ADaQXCrF94L7vHXFNArCz1KB01j6JW4NWbUcB2sQsKKRSXDmil
	 8MvXTzdjgpD0LvMZq2kRz8YezFtGlUOVpZU/ISC7ZaYWTDEk5Qjri1mer7zQfxVeDH
	 2y8B31pkpEt6hnDgwpYWZGdTa4tggab5HxuVd85yr7BJIfOLHC0g2NQ7LFp6HSRUj3
	 zMyGK3GoED4dg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.6.y 2/3] mm/damon/core: filter out damos address filter-split failed region
Date: Sat,  7 Nov 2026 14:22:00 -0800
Message-ID: <20261107222202.331476-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107222202.331476-1-sj@kernel.org>
References: <20261107222202.331476-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an address type DAMOS filter is configured, DAMOS tries to split the
region for the filter range, and apply DAMOS action to the filter-in
region.  The split operation (damon_split_region_at()) could fail from
allocation failure under extreme memory pressure.  In the case, DAMOS
action could be applied more or less than expected, ignoring the address
filter.

The issue only rarely happens under extreme memory pressure.  No crash or
leak happens.  Occasionally not applying the action to a few regions
shouldn't be a real problem.  But applying the action to a region that the
user has excluded via address filter could be a surprise depending on the
use case.  It is only theoretical.  No such real case is found yet.

Filter out the entire region if the split is failed.  Update
damos_filter_match() signature to receive the error from split.  Also
update kunit tests for the updated signature.

The issue was discovered [1] by sashiko.

Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org> # 6.6.x
(cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 ++++++-----
 mm/damon/core.c      | 13 +++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index dd91b0eea61ff..1988b7dd29e96 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -461,6 +461,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
 	if (!f)
@@ -482,25 +483,25 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 2;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = DAMON_MIN_REGION * 6;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 4;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
@@ -515,7 +516,7 @@ static void damos_test_filter_out(struct kunit *test)
 	/* region started in the range */
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9d4a78deaa06a..99e934a6d1ce9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -930,13 +930,14 @@ static void damos_update_stat(struct damos *s,
 }
 
 static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos_filter *filter)
+		struct damon_region *r, struct damos_filter *filter, int *err)
 {
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
 	unsigned long start, end;
 
+	*err = 0;
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
 		damon_for_each_target(ti, ctx) {
@@ -962,12 +963,13 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
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
 	default:
@@ -981,9 +983,12 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
+	bool matching;
+	int err;
 
 	damos_for_each_filter(filter, s) {
-		if (__damos_filter_out(ctx, t, r, filter))
+		matching = __damos_filter_out(ctx, t, r, filter, &err);
+		if (matching || err)
 			return true;
 	}
 	return false;
-- 
2.47.3
