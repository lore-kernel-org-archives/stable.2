Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048444;
	b=2Bv9r4gJqrZOEb7f2Nj52uo9UbtVugyXijx7l4vXvYKr8PDLw6iT+hRx0/JsGMQ6WkCm
	 F5AkXxGov9Hp9deC6+UCQMcorY4CYLSLGTwkKvX3gPXuDfQ1biN4EZqUFRKtP1qgmboEI
	 Hz/4awe24Jh60aNGodwXVUQ4YJgL/AmtdCFn6eXZfSAlkjqk+p1jEKsA9P8yzlS9y0NPI
	 fptBlIh5z2cegDd2Fg6iVHyFBjeM7ZScRaK82Kr3waC866Cg7Eevdg1gTl3bDNhdjOM7u
	 TAbVPHa1F4WfNPVYRQ/s3FQsLpr1u/ik2gRd7C2A9ONz4R6w9DcssEdLcyLYqweKPfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hHnw1cv/UjGjCa+zKaIisP74Vne9c2bjY9aBJSqYpCQ=;
	b=hU7DCLXpcCHvc/11kfQED/ljTBYkU01d8MX5OGAFI43cCtuxBL/QPkyGPSHeHavQaNT1
	 aC1xfoNYrx6HT7ALs1QhE2gCfwQnxdJWMbMKEkrjdy22gwX+1ENYp2OkXGbtNzOxDDKjs
	 Mk80n3RqDyZkURjXLiylq2RXrZHqpWp+Vc/KdKw6JvFWiCfl5r3wbxss2+Qu2NStYyTtA
	 8mfa1zpWxXWspKCmZnUBzteLgLYugmBBUtZmVoln3WfSQ0L0yca3nw5LOk9/40Sef60OT
	 pDbEPEjVqFniZI5j2Jc30JiH50hZ6phKlUYCTXiMkqCp+mpkNFg8MjzTiqDVIA7izwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL7HW3P0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB681606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QL7HW3P0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC3F1F008A6;
	Sat,  7 Nov 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048443;
	bh=hHnw1cv/UjGjCa+zKaIisP74Vne9c2bjY9aBJSqYpCQ=;
	h=From:To:Cc:Subject:Date;
	b=QL7HW3P026naoL6Tp1K1W3K852G8PnV3+hxPrzpDFbRvXK8n/vSAeYlnHBMTWMrZs
	 +xHSt+hloNbVmj6KBlsIBjOIU1RplDBq32Cnz8xj+pyO/+0rAJdxkYjZ2ShLPqrTzZ
	 lxv3IhGEo2n8VDgovfA22vbN58u9lJS7flrleeXG0POYGEyMqNUHMNY2idcF93yCmV
	 i9s29ROkbj02JGm55ktbspBNjEEhN33Pjf8w0tPa0Ovaxd8ggyaJ4qEFlfkFH7r4AB
	 ZRoy7AM4G2pyFlhVl/uQDaFsGyQaa0YZJjnOM5fuyVNtL3rqYgVHJ/Qy+zdQpWEUp6
	 XWCUCuWABasXA==
From: Sasha Levin <sashal@kernel.org>
To: donggeunyoo.kernel@gmail.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	david@davidgow.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:21 -0500
Message-ID: <20261107054721-failed-6.1-1c3352282063@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c335228206392b96d327c6b49cea68cbb806d8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054721-failed-6.1-1c3352282063@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c335228206392b96d327c6b49cea68cbb806d8a Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 21 Sep 2026 08:24:42 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: test the size charged for a
 filter-trimmed region

damos_test_filter_out() checks that an address range filter splits a
region at the filter boundary, and stops there.  Nothing checks what
damos_apply_scheme() then charges to the quota and reports as tried.

damos_test_apply_scheme_filtered_sz() covers the two ways such a filter
trims a region: one that starts before the filter's range, and one that
starts inside it.

damos_test_apply_scheme_filter_sz_unchanged() and
damos_test_apply_scheme_quota_sz() cover the cases whose accounting must
not change: a region wholly inside a reject range, one wholly inside an
allow range, two filters trimming in a single call, a filter type that
never splits, no filter at all, a region the quota trims, and a quota
remainder too small for one region.

Link: https://lore.kernel.org/20260921152443.80132-3-sj@kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <david@davidgow.net>
Cc: <stable@vger.kernel.org>
---
 mm/damon/tests/core-kunit.h | 316 ++++++++++++++++++++++++++++++++++++
 1 file changed, 316 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ff0436c58441..df84d9cc7d204 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1706,6 +1706,319 @@ static void damos_test_filter_out(struct kunit *test)
 	damos_free_filter(f);
 }
 
+static unsigned long damos_test_apply_scheme_stub(struct damon_ctx *c,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *s, unsigned long *sz_filter_passed)
+{
+	return 0;
+}
+
+static void damos_test_apply_scheme_filtered_sz(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = 0,
+		.max_sz_region = ULONG_MAX,
+		.min_nr_accesses = 0,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+	unsigned long min_sz = DAMON_MIN_REGION_SZ;
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {};
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damos_filter *f;
+	struct damos *s;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+	c->ops.apply_scheme = damos_test_apply_scheme_stub;
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(c, s);
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(c, t);
+
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
+	if (!f) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "filter alloc fail");
+	}
+	f->addr_range = (struct damon_addr_range){
+		.start = 2 * min_sz,
+		.end = 8 * min_sz
+	};
+	damos_add_filter(s, f);
+	damos_set_filters_default_reject(s);
+
+	/* reject filter, region starting before the range */
+	r = damon_new_region(0, 4 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 2 * min_sz);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 2 * min_sz);
+
+	if (damon_nr_regions(t) != 2)
+		goto out;
+	damon_destroy_region(damon_next_region(r), t);
+	damon_destroy_region(r, t);
+	s->stat = (struct damos_stat){};
+
+	/* allow filter, region starting inside the range */
+	f->allow = true;
+	damos_set_filters_default_reject(s);
+	r = damon_new_region(2 * min_sz, 10 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 8 * min_sz);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 6 * min_sz);
+
+out:
+	damon_destroy_ctx(c);
+}
+
+static void damos_test_apply_scheme_filter_sz_unchanged(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = 0,
+		.max_sz_region = ULONG_MAX,
+		.min_nr_accesses = 0,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+	unsigned long min_sz = DAMON_MIN_REGION_SZ;
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {};
+	struct damos_filter *f, *f2;
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damos *s;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+	c->ops.apply_scheme = damos_test_apply_scheme_stub;
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(c, s);
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(c, t);
+
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
+	if (!f) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "filter alloc fail");
+	}
+	f->addr_range = (struct damon_addr_range){
+		.start = 2 * min_sz, .end = 8 * min_sz};
+	damos_add_filter(s, f);
+	damos_set_filters_default_reject(s);
+
+	/* wholly inside a reject range: not counted at all */
+	r = damon_new_region(4 * min_sz, 6 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, s->stat.nr_tried, 0);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 0);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* wholly inside an allow range: counted whole, not split */
+	f->allow = true;
+	damos_set_filters_default_reject(s);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 2 * min_sz);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* two filters, each trimming: the size left after both is counted */
+	damon_destroy_region(r, t);
+	s->stat = (struct damos_stat){};
+	f->allow = false;
+	f->addr_range = (struct damon_addr_range){
+		.start = 4 * min_sz, .end = 12 * min_sz};
+	f2 = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
+	if (!f2) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "filter alloc fail");
+	}
+	f2->addr_range = (struct damon_addr_range){
+		.start = 2 * min_sz, .end = 3 * min_sz};
+	damos_add_filter(s, f2);
+	damos_set_filters_default_reject(s);
+
+	r = damon_new_region(0, 8 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 2 * min_sz);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 2 * min_sz);
+
+	/* a core filter that never splits: counted whole */
+	damos_destroy_filter(f2);
+	damos_destroy_filter(f);
+	f = damos_new_filter(DAMOS_FILTER_TYPE_TARGET, true, true);
+	if (!f) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "filter alloc fail");
+	}
+	f->target_idx = 0;
+	damos_add_filter(s, f);
+	damos_set_filters_default_reject(s);
+	s->stat = (struct damos_stat){};
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 2 * min_sz);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 2 * min_sz);
+
+	damon_destroy_ctx(c);
+}
+
+static void damos_test_apply_scheme_quota_sz(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {
+		.min_sz_region = 0,
+		.max_sz_region = ULONG_MAX,
+		.min_nr_accesses = 0,
+		.max_nr_accesses = UINT_MAX,
+		.min_age_region = 0,
+		.max_age_region = UINT_MAX,
+	};
+	unsigned long min_sz = DAMON_MIN_REGION_SZ;
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {};
+	struct damon_region *r, *next;
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damos *s;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(c, s);
+	damos_set_filters_default_reject(s);
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(c, t);
+
+	/* no apply_scheme operation: the whole region is counted */
+	r = damon_new_region(0, 4 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 4 * min_sz);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* no filter and no quota: the whole region is counted */
+	c->ops.apply_scheme = damos_test_apply_scheme_stub;
+	s->stat = (struct damos_stat){};
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 4 * min_sz);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* the quota trims the region: the trimmed size is counted */
+	damon_for_each_region_safe(r, next, t)
+		damon_destroy_region(r, t);
+	s->stat = (struct damos_stat){};
+	s->quota.esz = 2 * min_sz;
+	s->quota.charged_sz = 0;
+
+	r = damon_new_region(0, 8 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 2 * min_sz);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 2 * min_sz);
+
+	/* quota remainder below one region: tried, but nothing counted */
+	damon_for_each_region_safe(r, next, t)
+		damon_destroy_region(r, t);
+	s->stat = (struct damos_stat){};
+	s->quota.esz = 1;
+	s->quota.charged_sz = 0;
+
+	r = damon_new_region(0, 4 * min_sz);
+	if (!r) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+
+	damos_apply_scheme(c, t, r, s);
+	KUNIT_EXPECT_EQ(test, s->stat.nr_tried, 1);
+	KUNIT_EXPECT_EQ(test, s->stat.sz_tried, 0);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 4 * min_sz);
+
+	damon_destroy_ctx(c);
+}
+
 static void damon_test_feed_loop_next_input(struct kunit *test)
 {
 	unsigned long last_input = 900000, current_score = 200;
@@ -1959,6 +2272,9 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
+	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
+	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),
+	KUNIT_CASE(damos_test_apply_scheme_quota_sz),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
-- 
2.53.0




