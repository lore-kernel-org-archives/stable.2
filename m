Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323977;
	b=l4osYR+GaYK8hP8rMOqo4wKvqfEx2s6vE0uTWWkNcyl0Y+0p0+Jv3QES3CyHwgqhxBRt
	 WT0fr/44v25QxKLDbYqFu9VxK8jE7GyxrxcD8+qgGiwHSauqAxGxb2PGlhR7zafXwtedw
	 jQCyoXrJnWJ6e2ehWoOcVZwjNoJZ24eRd87iVAHGeVWfZ51KvjrXnGZucJBcVaDcaiGv6
	 Kka0nKjxU+x0Kq0ffsU5ZuMl6EWV8xGlMpOYPw9dj9YI1tGWfNlqOT/Yc9RL5KtbEKT9u
	 B41B8OfqveF9+NMeXNrxILli090LMEPN+7PxQBjXw913jN+DAFI4V4VHwD17Ob4qQFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PCAWNzL1cvfVcJ1evLQxJn+oYYrJ86Z4hoDytTewJdc=;
	b=Qdvq99EguzH5+ky1ASI0QZ5NmThpMbeXoJe/ToTe0LASACaXJBhDzTUsQcpK7TfzmSar
	 gmPmvgBmZDRWvvsf5Jhb3ncJlaLY56PS5BJfFLh2bpi7SanjhOpRZRrtA7txO4NfBiiN6
	 luNQqdcvTmJr7G76tANlNE9S/0ltKIs+Oq5pS1iyVsZmZnRLXHz2tZYuocbuW3w6lk/MT
	 JhIobqSAIuAonhN8+x6s/EyjRBcpAVGcI4OSWj+L0NLzEHMTrIjgv4yTVm4oS1pztay6T
	 Sd4OCT3YoJ47h8KFIzOp6R7cHcO4yb9ta1qWRmDsJYnX8xPVjV4OHwUV2yr9l3Y663A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PokqkXyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1B606A320;
	Tue, 10 Nov 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PokqkXyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278E1F0089F;
	Tue, 10 Nov 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323976;
	bh=PCAWNzL1cvfVcJ1evLQxJn+oYYrJ86Z4hoDytTewJdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PokqkXyE276PTXpE8nAJDY4Jc6TYyfM5lEA2F8gcVbpGkNCsZ+yzOWeNIdARlUhDM
	 rvw9a1dw0qeGJRN3SaNEVXIQr3CcbT17gGeJtq6JvKxKD5rumexJKSetUQ0BihYcJ+
	 TiBmQG9JMt+DhnRS4KK0BVCkODx5y6BI3LH2ZXRiVsIWbCoPvWUXzTNdAjBGTpGnd7
	 M4W8i4Rbcw7NvnA5yprNxjmtw9j4HgSafG1do8Jq8pwqvbtINlQ9+LNo68ZEbwnn+e
	 ZxHd8JltWWZ2s3iOjGOCwRqglraCiyw5dNzMpkG+SYwvwj8YmcLe6qOsAhQfSOMsPW
	 ctgPF7vQn+Dyw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 5.15.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Tue, 10 Nov 2026 07:19:27 -0800
Message-ID: <20261110151927.158140-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202159-failed-5.15-26ae50a0901a@kernel.org>
References: <20261109202159-failed-5.15-26ae50a0901a@kernel.org>
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

kdamond_split_regions() uses a static variable last_nr_regions, to infer
if the region boundaries are too stable.  If it looks too stable, it
does a more aggressive region split because it might be a fake stability
coming from non-aggressive split.  Because the variable is static, the
inference can be racy and wrong when multiple kdamonds are running in
parallel.

The user impact is not critical.  No crash, no leak.  DAMON's
best-effort monitoring accuracy can be degraded when multiple kdamonds
are used in parallel and the workload has certain access patterns. Still
it is a bug that is better to fix.

Move the variable into the damon_ctx struct to fix the problem.

Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a47f2
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: <stable@vger.kernel.org> # 5.15.x
(cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 5 ++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d68b67b8d458d..bc0cdd67e2473 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -203,6 +203,12 @@ struct damon_ctx {
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 	struct list_head adaptive_targets;
+/* private: */
+	/*
+	 * number of regions after last merge.  Read kdamond_split_regions()
+	 * for more details.
+	 */
+	unsigned long last_nr_regions;
 };
 
 #define damon_next_region(r) \
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a50ced2efc0f..1ce0438328b94 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -603,7 +603,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -613,14 +612,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		return;
 
 	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
+	if (ctx->last_nr_regions == nr_regions &&
 			nr_regions < ctx->max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(ctx, t, nr_subregions);
 
-	last_nr_regions = nr_regions;
+	ctx->last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.47.3

