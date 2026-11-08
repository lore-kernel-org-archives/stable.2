Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165751;
	b=L88lkFuZxkL5NTWzGES6JeaYOHzB00u3lFQgzdV/6SCt+Vr5L48IOLpGh5ZZ4NQYkqih
	 10PjIbR29WUL3icgZW6GQYj6XdA2YTpp330v4VHFUPvA4VYJ35Amo/kM+H8TyOAGS3+TP
	 cbgghuZz/Qn9e9czT3YzW/L2lDFemWcv4x+6QbNSTiTLMAN567oF/3gyXyTICrv1/IfP2
	 VjxGXGXEpqaQNGHwOWOYPlkTBpayuPbLrzvBX0QNM6bCoN/fgzb55jScCUAj1SDe+RvhI
	 rAPGe7R4RTQ3w+qKcmjMSgaugUc4ax5bvn2h33zlkxo13JijocC75Qje2IiODMPMCbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TIAVWRl5IyIEzSAGdy1Y9O94fKWUT6y4xqwWabU5n+M=;
	b=q/hKy//NgiKapki0BbuVzd2ybDcCKkcVpciYqTQw1jaV/frQixiIczmgXxqzv/8RMSum
	 Lx7wv64HTGTPvjCMWilIBzoXnJF6X3bNQ84uTbQXJnRx+y3wynFYm4cMgEQPhYf58ZEoG
	 XFeREObMPv5ey6lSmt294DcuPZBNXn90pSaXGSPQ2Dghn55e4Ry3PmDVDnXpE/Mh2gYFq
	 whrpbDcLMC6mOx15KbQCAMdj5780LUi+O/Bl4DBIIj/zwuFaXvDnQc8cm7HaR3/dEV0j2
	 rdKNiXs97Ky4gTGu7c0p5grTVNx3VMoFPNQZPGN+VmznixSF23rjhTN/UCm0MWP/b/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3o8jXzq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57168606D80C;
	Sun,  8 Nov 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3o8jXzq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062DE1F008A6;
	Sun,  8 Nov 2026 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165751;
	bh=TIAVWRl5IyIEzSAGdy1Y9O94fKWUT6y4xqwWabU5n+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3o8jXzqd/cfJkZdfMFZQcY+niEfkkDqeJ0S+h5xlX008yN5KWS2qxytiiJldHf8b
	 RcRjD8XcF0XYITrHgicxWUBHGO99HRofEhk3hwIt5mpvYTmxCShKVgUK1BFB/MdtBA
	 ayUPQryMjxoDDa1RCjF/lrqIi3oQHj3m+a4nKJ4vcv5796zJgqAN6kiSAnIkeIXo7F
	 M5HAu04+aaQ0t9GvkCq8SwX2pHrhMlUSSYiUKJ524kioaMVIN5nb4SiXKO7VljO7P/
	 fCXCuBZ6xr/YHEPYbS0F0Ct/6iNYVynXLeG+nKyG4IXI3xJoUTG3pKcTd9emZWZaMr
	 nAQU0DI/gtShQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.18.y 5/5] mm/damon/core: filter out damos address filter-split failed region
Date: Sun,  8 Nov 2026 11:22:20 -0800
Message-ID: <20261108192221.114362-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108192221.114362-1-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
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
 mm/damon/core.c             | 16 ++++++++++++----
 mm/damon/tests/core-kunit.h | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 00cd0e2a1e341..dc8608c3cae40 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1812,13 +1812,14 @@ static void damos_update_stat(struct damos *s,
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter,
-		unsigned long min_sz_region)
+		unsigned long min_sz_region, int *err)
 {
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
 	unsigned long start, end;
 
+	*err = 0;
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
 		damon_for_each_target(ti, ctx) {
@@ -1844,12 +1845,13 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
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
@@ -1863,10 +1865,16 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
+	bool matching;
+	int err;
 
 	s->core_filters_allowed = false;
 	damos_for_each_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
+		matching = damos_filter_match(ctx, t, r, filter,
+				ctx->min_sz_region, &err);
+		if (err)
+			return true;
+		if (matching) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0ce6481319432..814197da4f507 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -548,6 +548,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
@@ -570,28 +571,32 @@ static void damos_test_filter_out(struct kunit *test)
 
 	/* region in the range */
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION,
+				&err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION,
+				&err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = DAMON_MIN_REGION * 6;
 	r->ar.end = DAMON_MIN_REGION * 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION,
+				&err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 4;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION,
+				&err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
@@ -607,7 +612,8 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION,
+				&err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
-- 
2.47.3
