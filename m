Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14060EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726639; cv=none; b=KaK5UtjKr2x4cqy4cnztK5x94+WezKYdiSkhEai13AoESu5sij2kwbYs694OkXFMcasqYzuAj6Jbb+sn4Hmu1cHtX/QgPqrNdxgERJCl+/dadh5l/mIp6GYyCrOPvGjBYI00v2DED4vKMZIwP4YW+6qZ4Nl+LPdlwmnZfeHT6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726639; c=relaxed/simple;
	bh=wFCe4qCELYOWlexUs1MfEx+/RX2k+KIJjm6PnvG7dcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liZ6+gW+crP8KbLN3cWi0b4vyOmGzxcXFzsQ9eujyD+TXuLpLipxmGFhz59Zu2djFiUgcQOlj11GdHPBlHQD7OzEhMywdXYwQJ9OdnXeBXsqYzlLdIq15t9IfaDJpnGupGV1Z0FjbeUgb4vEvHmrDIdtY1kHlAzNQo/uJtOo524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTBAhE3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTBAhE3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1513D1F000FF;
	Wed, 30 Sep 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726638;
	bh=9DYve23voyygavJUCfr/aHHDLtyityMbiLdqYqubl8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTBAhE3R5kBLu5cwg9jWf0Z3P/3bkV2/dddmZZIHiC8yasJqeRnoe+QBSzNhRgFOj
	 HaiuueozgAnk5W+qTMUvT5tYSDs2R7fo4ugFAYSpD7qC/PslUMkPx5XEV5m2qdTxnP
	 FVyNOv52PJZBQUA8beeIzz/E4Y9w62nHijl8KJl/H9GYWySkrsTkXALHAlg8kBzQYh
	 EY6rqy7FbTXETXF/Fmdvxj5QUhZguNYmTtjxFigxn3RP/y5G8f6pvCTIDLJ4plDui9
	 9+gr2Wgd2wJMj9Pdq/1Tj3MPcerkIqAXZiGsCODE1ooogotEpGsut8VQgD8Stpit6c
	 KNaq8sFI7r43Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] mm/damon: rename damos core filter helpers to have word core
Date: Tue, 29 Sep 2026 20:03:50 -0400
Message-ID: <20260930000354.2861391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092947-shush-encode-1e48@gregkh>
References: <2026092947-shush-encode-1e48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 8b02baf37311754518dfe78073583db03fbb0c07 ]

Patch series "mm/damon: misc cleanups".

Yet another batch of misc cleanups and refactoring for DAMON code, tests,
and documents.

First two patches (1and 2) rename DAMOS core filters related code for
readability.

Three following patches (3-5) refactor page table walk callback functions
in DAMON, as suggested by Hugh and David, and I promised.

Next two patches (6 and 7) refactor DAMON core layer kunit test and sysfs
interface selftest to be simple and deduplicated.

Final two patches (8 and 9) fix up sphinx and grammatical errors on
documents.

This patch (of 9):

DAMOS filters handled by the core layer are called core filters, while
those handled by the ops layer are called ops filters.  They share the
same type but are managed in different places since core filters are
evaluated before the ops filters.  They also have different helper
functions that depend on their managed places.

The helper functions for ops filters have '_ops_' keyword on their name,
so it is easy to know they are for ops filters.  Meanwhile, the helper
functions for core filters are not having the 'core' keyword on their
name.  This makes it easy to be mistakenly used for ops filters.  Actually
there was such a bug.

To avoid future mistakes from similar confusions, rename DAMOS core
filters helper functions to have a keyword 'core' on their names.

Link: https://lkml.kernel.org/r/20251112154114.66053-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20251112154114.66053-2-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .clang-format         |  4 ++--
 include/linux/damon.h |  4 ++--
 mm/damon/core.c       | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.clang-format b/.clang-format
index f371a13b4d192..748efbe791ade 100644
--- a/.clang-format
+++ b/.clang-format
@@ -140,8 +140,8 @@ ForEachMacros:
   - 'damon_for_each_scheme_safe'
   - 'damon_for_each_target'
   - 'damon_for_each_target_safe'
-  - 'damos_for_each_filter'
-  - 'damos_for_each_filter_safe'
+  - 'damos_for_each_core_filter'
+  - 'damos_for_each_core_filter_safe'
   - 'damos_for_each_ops_filter'
   - 'damos_for_each_ops_filter_safe'
   - 'damos_for_each_quota_goal'
diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb4dd13984d39..8630ce99d6ca9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -858,10 +858,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damos_for_each_quota_goal_safe(goal, next, quota) \
 	list_for_each_entry_safe(goal, next, &(quota)->goals, list)
 
-#define damos_for_each_filter(f, scheme) \
+#define damos_for_each_core_filter(f, scheme) \
 	list_for_each_entry(f, &(scheme)->filters, list)
 
-#define damos_for_each_filter_safe(f, next, scheme) \
+#define damos_for_each_core_filter_safe(f, next, scheme) \
 	list_for_each_entry_safe(f, next, &(scheme)->filters, list)
 
 #define damos_for_each_ops_filter(f, scheme) \
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6fa02025d2af1..da57c6dd93310 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -463,7 +463,7 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_quota_goal_safe(g, g_next, &s->quota)
 		damos_destroy_quota_goal(g);
 
-	damos_for_each_filter_safe(f, next, s)
+	damos_for_each_core_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
 	damos_for_each_ops_filter_safe(f, next, s)
@@ -871,12 +871,12 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	return 0;
 }
 
-static struct damos_filter *damos_nth_filter(int n, struct damos *s)
+static struct damos_filter *damos_nth_core_filter(int n, struct damos *s)
 {
 	struct damos_filter *filter;
 	int i = 0;
 
-	damos_for_each_filter(filter, s) {
+	damos_for_each_core_filter(filter, s) {
 		if (i++ == n)
 			return filter;
 	}
@@ -930,15 +930,15 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
 	int i = 0, j = 0;
 
-	damos_for_each_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+	damos_for_each_core_filter_safe(dst_filter, next, dst) {
+		src_filter = damos_nth_core_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
 			damos_destroy_filter(dst_filter);
 	}
 
-	damos_for_each_filter_safe(src_filter, next, src) {
+	damos_for_each_core_filter_safe(src_filter, next, src) {
 		if (j++ < i)
 			continue;
 
@@ -1846,7 +1846,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	struct damos_filter *filter;
 
 	s->core_filters_allowed = false;
-	damos_for_each_filter(filter, s) {
+	damos_for_each_core_filter(filter, s) {
 		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
-- 
2.53.0

