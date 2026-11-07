Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087936;
	b=l8N/g8TOgdHa5kYxY3vrggtQF/3SZ1UVzR/KGAhGPnTMhm8u72Qs0SVg8GibNjDHtkKp
	 towNMuaZmeYbOGocK3boeMyR1vJk1Md055RhzmfekKuuU+ie+5kmCJKeTW3Fo1+u9lFic
	 bvAZzNcvU2rh1hTI/eoz+DmWRSpg15xGgeiKZEgoHnj7bUknk8l8oVlOzDPYOqFJNxP9B
	 vW9ULilFx42tuxt0/PQDG+TLUwWmaW/kf8sVpwc0z9HXXxyU9RI4vaETcPjcRpMXS52kL
	 msAKM3aPX2hCfpj9rMcK0J1ftRt/qP+1TvOWB5AvznL7cWNl0lp6iRfbQv5RYltLIcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nyCIxBA5mJ06vHi0FAU5PamOp23wz03gHLUhBxnc4Z0=;
	b=S1s78I+5ryqFue7Cz1uO0MWn7oPIq+Mw8s218GFt77ZfpnX3HY/FVKpQD7B25/hyUCRE
	 J1kn56to1iLOYcsH/gZAHNvYPDUK6vUWbXUdAZ4bY8TXz9rfUn2aUVoGAEsY0F5NoQIzl
	 qBw53c+jj0qfvAQZTz211KDZ0Bjl6fd5pRWnxPc2Mk8kBWxFkHqjQ9lLiQ5nUpXQ4jz/j
	 4W/I5aMDmq8m++RSZZ2tOYOUtlqu3NNd6GIR0srB+l6Ci0hwXrgvHYcUaXqsVMfYmM+EH
	 waG+VfQYWQxxMHVzZYlnfMOhm4zlBWHTooH8Priz53dr1/CN2gFuGyEYcBHmk9XdXAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Waouwtiq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76734606D80B;
	Sat,  7 Nov 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Waouwtiq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EEE1F008BC;
	Sat,  7 Nov 2026 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794087936;
	bh=nyCIxBA5mJ06vHi0FAU5PamOp23wz03gHLUhBxnc4Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaouwtiqMvq5L/CDViXEiAdw/ify/xGtuBEoGC+6GV4wH3ZjrEhVyp1IXJeFliMGU
	 oADm7fa9Oot61Dq9T/QSCq3mKpsEeEaxTptLJ4FJJuo9RWzKYTQudvMWhCdg+Ts/XP
	 NaLfACOcdoKZYCqxKqFrqY+V4vwguWrNLPoy4SS4JBNioPAA0iwlo3KCZvz8PtlXhW
	 gByffuXzLXe2qT94Gml5QrWNLmBGbLnvOxSpLM0vyox7R8YuErLavXqyZAJwedZ3pw
	 6c/xTnnkiTa0AVBSvybrKW8Eca8wfCnsgSL30JeU0fISFGFCFuuwVaaLfzpUcUoHj8
	 F5aPM7J1o6NTA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 4/5] mm/damon/core: filter out damos address filter-split failed region
Date: Sat,  7 Nov 2026 13:45:23 -0800
Message-ID: <20261107214525.304638-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107214525.304638-1-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
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
 mm/damon/core.c             | 13 +++++++++----
 mm/damon/tests/core-kunit.h | 11 ++++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 52f01a6508b66..046c07b86a6e7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1372,13 +1372,14 @@ static void damos_update_stat(struct damos *s,
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
@@ -1404,12 +1405,13 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -1423,9 +1425,12 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
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
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ff9f73579f7b3..6b7cd8149a0e2 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -527,6 +527,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
 	f->addr_range = (struct damon_addr_range){
@@ -537,25 +538,25 @@ static void damos_test_filter_out(struct kunit *test)
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
@@ -570,7 +571,7 @@ static void damos_test_filter_out(struct kunit *test)
 	/* region started in the range */
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
-- 
2.47.3
