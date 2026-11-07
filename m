Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049493;
	b=rihDT1abQdYEynuxppSaJQ6ruBKNYtblMR731bwaROBEx9wXpkekAn/jA4z6KZ74nbXx
	 EEKqkzrMrTUQebN+VVwqJ0+LbWJoMY0oH9Ey5m2VhPaFfi/MBGXcE9lpSPhk7VpJvGjdO
	 PDPsbWK7YXlU5Hp2Zrk4IOrHATOaamFI6B6SBt0XdozGOKOzb1lZwypY8GMQ9UsLaN5p0
	 ZdY8tGWh10ItiKnvSx9EBsjmY0oiyglCGfX5yxuEbXzKTJtOL2d/H1D1Wu0JRRWvidMTN
	 TwprapAPfg45t66bYiH006ZGBVu5PPb4g/p6d2Mzb1giRCRsYT4KBIqwV5ra7JeCJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3qFaBmEa9AD6aaRvnTHXE8arSVX6M5wYTNrb1uu+4og=;
	b=4CMaAGNt8mhmALDykz4t1QAVJMb7h7SBO07fAYpiA7wJVS0w0jEq+8IMyAiA1ckjgO/9
	 POQFyiwWdWSdekF1No5iLUEFZ8yFDMaJmlitkKhiEW2oahR5sV/zj5AeW0RIB1m/R1RXW
	 tcjz4NKWAv8VQLpECO/r/KtCahfP6TqtigOJJtLWw+pAVovOuQV4d/QVu/260Qf/m+lZW
	 8TeKOfpVcOX7cIqzQhFzpuWS0KTxbdB5CE2NDXRn9vPXLlp33lXceIFobvP5TRc5oVYeK
	 dBfFVa4D8bYRleL5wTFwOLyE/UK877HL5ViuxT9byBXHWP1Q4UIel/DKp3jr0ewBWSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfnW0Vde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfnW0Vde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4671F0089F;
	Sat,  7 Nov 2026 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049492;
	bh=3qFaBmEa9AD6aaRvnTHXE8arSVX6M5wYTNrb1uu+4og=;
	h=From:To:Cc:Subject:Date;
	b=FfnW0VdebxaXkIhheDYLCdnX6tsSlmjJrT10rShQnVSzGbiOAUEvJS4JOu5h410At
	 3IVFovDGUI2dZv2LbuTA+iOtI4Mp/vgcaVJLSwrJsekl5hBCTTWVfTJfwoDxyz0zFQ
	 4cyc03anXS5p2N3uTOsiGkrHsH7rlcEKkfOJp39jdPUN2cqE3IjFo1LknNY9XP4mNE
	 5ba7HK0octvYmfqzhhMMTkGvUvCndn8m5MMJwn9dLbikBc2t5CS7oRMksb6HvAllZf
	 fp7cxA4ei529EI6XjsBv8YVYKCyDPGja76L990G08YrXCqUF6y4cFSc9LgW+qOHnnR
	 w6lcTEW5vjj5A==
From: Sasha Levin <sashal@kernel.org>
To: donggeunyoo.kernel@gmail.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	david@davidgow.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:50 -0500
Message-ID: <20261107060450-failed-5.15-1c3352282063@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c335228206392b96d327c6b49cea68cbb806d8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060450-failed-5.15-1c3352282063@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




