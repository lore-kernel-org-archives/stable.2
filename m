Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168909;
	b=5HxMhZ0XKNRhZzrVwZKEAknpwkdlB8Lm5eG3m45LViBCWOEt4MZ0oEASJmj9XWADoI2t
	 7bKNN2Mi8jWfK52BUoi+TuBFpfFuvrWYhwFTS96rjDkJhxt+ScKrxmH8cTP6pVMQ7+eqS
	 yKpbYQLI1nMuBPBI+7I7PZ2qYwk2I3bxgrmqRs4uCEDvcHw9MCIrJJnvjB6WusuKzItKO
	 24h/RbA3Xr3Bq6bZtWwkRiMpoyaz7Pf8aEg5rsaGxyLlfsU+OBn5c4BBUjDfF/boxjk5Y
	 hLd5xGdTn/9Mh9mFSpeL19rnJQyqJpR+DabvI57/Fl5db10m4PorJ095BxiLQDZn/ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168909;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e8b2BxiNM2zDfbsfHX5lOdltBPseBRShaz9qPJkxXRw=;
	b=rguf0ZY4IoAl5S8AdvUS9CAOcxldPJlvokxFdh/QRP/uhYUfrxcbAnQ0iIEKxLiizQVQ
	 zNTELZu/s4xkwRsU2ZPmOH9Zz13kpCf77sO3rqznhVuORgM3UYxCJnot661oeUQNsmNRV
	 6fJI2VcfgDqTtb9v+y+LgZ+2hyNK+56e9sFsZkyb58DoBphPZ85eySaUwWJoIJ52DUTFa
	 296ama1qoJ3hBmOn+TUXbIBTBaVMYQpzt6knZ43M77qgBd5Isd4e2YllRGevISgM59lsG
	 wgRKVFASMeR8g69o+gIjvZRqlOjDYhYGtXvhKwnDYrF2KINmNwrb7n/kGLpEWJDcNEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VupSj50k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A8606A322;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VupSj50k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8CA1F008A3;
	Sun,  8 Nov 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168908;
	bh=e8b2BxiNM2zDfbsfHX5lOdltBPseBRShaz9qPJkxXRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VupSj50krcOI/QPET5RtqPM0krqDypQmTkx6pRkm0HkA8KP2sZ9E9tdnuSBoBhEAZ
	 L+k2As8MLvMhSOiw81m+bCd/p8oiD6187BWpSub9YaViomQQSvEQ7QDi2Maz+YkjYZ
	 LUgt2LbthyyHmH0UcTLyFiZtgm8TUXaYdq/e1eC0Lw8GSQyG7/u7W73obykvyFCxFs
	 FmgzCF/RBxggbaNi9NWjX7v0p4/WhDrMgz3r5ZHp6olDFRa6jJvf5WjbYf8tqljRCP
	 rs65bMSyWBVQyBXnV9Yf1Sm4/Az9aMZ0KHYjV19Ml7e47gChIeRSh8BYIfQU6pqyAZ
	 g4H3hNqAB+JfA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.6.y 2/3] mm/damon/core: filter out damos address filter-split failed region
Date: Sun,  8 Nov 2026 12:14:54 -0800
Message-ID: <20261108201456.116824-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108201456.116824-1-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
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
