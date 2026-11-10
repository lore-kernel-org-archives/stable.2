Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323209;
	b=Kc2yUGz3DB3tvXlnRGQeJxakVKPbIvrptzSX8q233geMijB+LzR1ja+yGP/KhEf+3XhG
	 g6EcLTEXZOlu5BbnR2TegVnG5jhQVjwfmp3u0yltqZbijEo8UFX5nb7NeCplDf8Yjr9gS
	 +RFuREW1B7g/bcOzdugtilABYvQDGngVKc1v/mif9gRalelCSjYne0VOeM+Bht7T66zWC
	 SR7YFzCdjOR+795lrJ/Gz5qRLDituheDppaHP5vFmuK7BGLVyuJr8MOhsCEE5pTDResgl
	 INa11KoWDg/L0FI82BKDrKY5LVE2uPddaS2ybshphWGH6mvR/6ObeeSZfOGzWeWF+TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kIRVfGeCCRWO7PZqCq/tf3YtWuj1gXXmj43dMX+RuR4=;
	b=pgfWgy/zgqjZAuG9fmxLoC5iMxfR8f3zMIZUJXz35P0m0nsrwGCzaAL+a/D2Xfx/cowD
	 bTI+Xv5H3bgnFa77iYiaQtIja7O9dqG2ATuXKQo5ie5vy2o9XPC1cQ/qdtOsGDP2L2LCA
	 lipCQsC1K269Jz8mqgevsNFyUV4c6i8UTvROEmroSSXiW9A9UKO6uExjKE1NzkXh/MDRo
	 dd8RV6eVF/GMaaxPQ394bPLZhc7tBauvMyACbvkSrsg295snOC3gKM8l0J316fC+2LICL
	 XpvilUUv8emPYZLEZJDsnoAXiBJVVk/juRCVBRNnGQ8RuxIElaByLFRL2F8C5J6eF+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLOW5Wvt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012860A2607;
	Tue, 10 Nov 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLOW5Wvt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22A41F0089F;
	Tue, 10 Nov 2026 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323209;
	bh=kIRVfGeCCRWO7PZqCq/tf3YtWuj1gXXmj43dMX+RuR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLOW5Wvtp/kc7sExbnxmbCWJdZPpfRA2pu0XYkgQJ5qLknEu+BxkzNFYpUb5Cfp4x
	 dG0XwQ3QwF3QOZwpMgxahfW/T8kvndqZAOxfKTTYctsHOwc8ufkZEa02sFQyjX8cVY
	 6sbZ5NC80FIBmz4KyrCoqoVpLMQ8cTvyv7zsfaqmoiRXVGenYwyMfACyHaxkOCmzVE
	 VNhITf9NRaWaJ1N8ht6I0XsPj+GYndLaq/E/x4SpUnQPV0W0EuQjtEzuhzjwjGI3tm
	 DjH+I+bWjFZFCWCk3USt3J6pWGm/VEFutYXVRzGAMOAF03aVMNNJhYlZbTLqmORv3c
	 mtZhKApDGKURw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6.6.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Tue, 10 Nov 2026 07:06:41 -0800
Message-ID: <20261110150641.148941-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201220-failed-6.6-26ae50a0901a@kernel.org>
References: <20261109201220-failed-6.6-26ae50a0901a@kernel.org>
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
index 16d28a190dae0..8186f7c0f597f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -557,6 +557,12 @@ struct damon_ctx {
 
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
index c106219d33dd9..6635f23499c95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1328,7 +1328,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -1338,14 +1337,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
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
-- 
2.47.3

