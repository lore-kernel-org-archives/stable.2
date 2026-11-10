Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323687;
	b=UJVGCZ3dv/2uhI4QcZfchVcEuyPUh2tqs5hjUdmIMQSwNaADWWi9KXdd6mVhWSgrqM1P
	 xdKEyiU6qg6Ho64ypoTWJG0yRzwWcwSQDP3TR83f04dgA/Oka3ExPGPzbSFq+9dInsBRH
	 03Xe/cs+J07QclefY2oMuqxYDKKcJTd6msd687t/Rr61PaVq5prCSxse/02NLYwe/A4iz
	 PTl/YRYKnyngyaedmHlLXYUqatWUaUtNo+P315mN0Mg8cSGv6+7ESPEoshVl/2pkaO3Zm
	 32kqcLidXG05PFH70JXAgG9r/zmkIuzcstt5FX7prFivwrhHkZmEBhDUy7paTYPgecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vn82MjYSYtkYLmWnHDECPWoElzLvrczLl9peO4FbbO0=;
	b=VV03kNURHMGrDBcnRrg5x7Du796yImbQyn137KrNAP+BGylw34jB18Q4h0i87cs3ZBUR
	 PpsD8mlC56caUwkNzIXrTLasaey5VP3u0MoavxMnSbdrFmE2zhL3Tj4ilBrvRw5NYi3IU
	 C2u5U06llUJHSP5YDDvkpAuXUk+K4CN/7Bn3KbLLv25jicMZRP3RNuJY9DrzsZznUH2qe
	 0Ye8OFHbMVL81A7JMPugCsa0aWbEPCkXhRXJxjhBjD+YIiD3KPQ8chOYNC2SRRyuxls3d
	 Uonw4qPYbiBHxILsMRY+FzEfj5jWQK2vJQElKudM7UGaiPk4a2v/wtm80+7MOpNfapQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsh5Lbbi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D9606A31C;
	Tue, 10 Nov 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsh5Lbbi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46551F0089F;
	Tue, 10 Nov 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323686;
	bh=vn82MjYSYtkYLmWnHDECPWoElzLvrczLl9peO4FbbO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsh5LbbirVx9yBpE2cPoqsWeMx3GzLo3/IV/tYT7X9P7Txl3nVK4kQWFXkuY5w50q
	 a29F0tsRV+NIisy5mHeKI6s2v7/j+WLsOaacZRpj8umQRYbuHHmqsChY1CCW3zlOlz
	 fj64/1uXOdZvbwRYxob/GlwBpmBWyO+mDZB9ehByMFJtKZTFKW8m5WLaJox05VdOym
	 tDPeoMNswj3t7ML4TizhJqWo7uL4NW7bE4eYbwO5kqZpGSO0pEtp+foKglznh2i1c7
	 qNtPI+CFigbOvFuZ3QUkdi117XMRT6jtX/ueQ8kPYgRX/BSAx3mdQiS9E+NgHNNFNk
	 ugErdUO5oGDvA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6.1.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Tue, 10 Nov 2026 07:14:38 -0800
Message-ID: <20261110151439.154208-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201705-failed-6.1-26ae50a0901a@kernel.org>
References: <20261109201705-failed-6.1-26ae50a0901a@kernel.org>
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
index 0387d86b56697..0b63617106416 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -465,6 +465,12 @@ struct damon_ctx {
 
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
index f0da5cb2b88a0..a1db159b18611 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1075,7 +1075,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 	unsigned int nr_regions = 0;
-	static unsigned int last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -1085,14 +1084,14 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
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

