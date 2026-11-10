Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322945;
	b=Vq2uPeh/L2d1gZFQK3Bu9jgo8c0M3mWQ/zSqeOAa0L8huqVYHqkAefoi6s2taBTa9Lgh
	 ON9qwUT3xBPwpXufI+l1N1oWPigvrlnXdvtn+6/rad1i/HwtC/wX5e7J1HnyufC9wSh7i
	 OnnoYlSd1GBoYk1GK3NtqshPTmVagi3nk/mGV+Z4hy8Gy4lRuOdJWkrrwlU+kavv6l5/K
	 4WstBqJ/0paar8h451F1V20+clf9l3t6d1zNbn7bc/iAadNSlGMGxLcClxMl7Lnr9GLoS
	 MwRiGOyxPPkAdmnsqHiu2qfO6SqyMKnEcEW2dehyjP5rAOJnQjdXkVasla4ZPIIBC4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6wfzhmFvH2WgKdDfLPSjTZHvmLnSaUsqNAKtOLW5Tic=;
	b=auf+PIt+xl6DnglkDwPDiR/AWVhD8G7I0TN8IpCQo/Xt1VE7OaBdE9copU8p62FTXKVO
	 MQGnOW6lwc4V97TRGkToMzhJyYGeg9rl4d7oeoIyj8yl1kaTJr3YDvFqaZeqc3/i4NoE8
	 QDxIt71mt2xG6Hcj8f7ZiGX+hT//oFUorn2eWHOhl8CQybuvs5vACq7eEC++gCH3WJjmB
	 cA2GuMMqaVqI3xfdYrg/Wt5JBjOVWhfx5FnoGRnlQHfxUPzXtiGvpdKaSmN41xBdb0oXR
	 oTnRKqOvRajKoRq6IJxCyWgl0t0b5Dsby1AiXW6JYNQgcaH3uvMnjDZGWn5eyBLrddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dmk1YNzS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08560A2613;
	Tue, 10 Nov 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dmk1YNzS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE211F0089F;
	Tue, 10 Nov 2026 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322944;
	bh=6wfzhmFvH2WgKdDfLPSjTZHvmLnSaUsqNAKtOLW5Tic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dmk1YNzSjHduNWsO8al9cecTz4YXl8TNi6tMk2K3GMtJuzgYM1NidmnDYrmdhtc0R
	 XfQ1rBwFqV0u6zrKxxfWrxG4xkbK2aSX832bR8ogPI15vt+LWXXGVjRTENHd6Bll8G
	 LvVHq9pVoCNOCkNdN6rKgdnTBMs9wDNIEAipic2dPQHpwxakQzMlCiKSsfbd7OWkB3
	 +/MeJl5Y61m3cvZnXg65J9tz/NzImT780osZc7yWwJrlbmeajvC+tZ29rgjWIjXKwR
	 SUSS/lHhk+7E+jes3/9j9aOUI9xNEFIZ0kwMSKPWdYPdzpfMfKOqCEOo7f4M+RX0z1
	 J7ckpIA7XcUpA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev
Subject: [PATCH 6.12.y v2] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Tue, 10 Nov 2026 07:02:16 -0800
Message-ID: <20261110150218.145605-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200803-failed-6.12-26ae50a0901a@kernel.org>
References: <20261109200803-failed-6.12-26ae50a0901a@kernel.org>
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
Changes from v1
- v1: https://lore.kernel.org/20261110022924.115699-1-sj@kernel.org
- Mark last_nr_regions as a private field to avoid kernel-doc warning.

 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 5 ++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4688a10eca89b..b05c626f6479a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -641,6 +641,12 @@ struct damon_ctx {
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
+/* private: */
+	/*
+	 * number of regions after last merge.  Read kdamond_split_regions()
+	 * for more details.
+	 */
+	unsigned long last_nr_regions;
 };
 
 static inline struct damon_region *damon_next_region(struct damon_region *r)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3142776e2e0ee..ec7f22ad33e1d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1932,7 +1932,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -1942,14 +1941,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		return;
 
 	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
+	if (ctx->last_nr_regions == nr_regions &&
 			nr_regions < ctx->attrs.max_nr_regions / 3)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
 		damon_split_regions_of(t, nr_subregions);
 
-	last_nr_regions = nr_regions;
+	ctx->last_nr_regions = nr_regions;
 }
 
 /*

base-commit: a100533c838bab5a555d92e082e38e092f2b4ea6
-- 
2.47.3
