Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277777;
	b=adfKlYQ5xwAPRhCIFh8TVgixPDbTi0Ma5XwWt/qlLdtqH0yAtWkPI96MtWBqOOg+iW2n
	 S3pwh5dSw6SKtqD2bms8tKCGxPsE+A+Le23U+WUVdzEmv7bnZD9rJDaxd3eBsfV9db/8B
	 rdEX64mNP2TcJaNZ1kWAXaacFQfafpKkVmaJcCbHF+9j2FuJl31FBG300k86UeP7IxemV
	 eFZjY+eSwrfd9HXiqgNksEvnYGrKvuGxa2eZpWLSu06eneUwre/tupFFyhFEG4KtO+So9
	 Pz8Y/i1cqgwitNLadE+27+koU/jaRM0jgJAU9q1R7FvT9i0OB8MdCH7Ef+0pOy+zkwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277777;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lYxPH1s3j7NymSUn5H4vCRp+bnEOR+4MdhHPZkbHfzI=;
	b=rpdn+zl8P1vqfpzr71ejwqfJ1HXYY/UyTuxndgC6C4d/6d77tUrWyzltl+ZH+4WLrk0Y
	 nfdm/nrGb6j1ETsmV/lSUtQKZ4W5Zb/2I+8CaqDaw6F2Q/H7ZuSEszv8esXblrxYJywfg
	 uB/CiuChXPfusQpeUn9j6YDbBtj0CPgf8NnOZQGTiN6u9LrSktTFmHD0//0bBcxMhkuWa
	 r8qT3KFG8d083pXLOah8/dTfPx4Ln2ny87Y8OJPJmYugbQ+MzCbcQ/mbOGDyzUa+37czE
	 TdYFGcMiMDxKCvhQXzhaFAQQ4hpGYx72J8ByK6WJVp2CP2tSTLT56sakXHSKlzufIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqLfRzLw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C024606A31C;
	Tue, 10 Nov 2026 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqLfRzLw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2CC1F0089F;
	Tue, 10 Nov 2026 02:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277777;
	bh=lYxPH1s3j7NymSUn5H4vCRp+bnEOR+4MdhHPZkbHfzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MqLfRzLwWeunB4gF4YprwOEGCBTuv5dyrpEBFlLh2Or5FjcxWYmwurKpefk+tT9jf
	 vbqt4BKKSP+1QQQZSwVcKqfRm0az5s6YNunX/giKqwgFkkdBeJEuWvUPLzapra1bO4
	 iETRRW5rgL7FpRTqlqOrr5pzRyLRLDsvsMnMpY4JbU1MoJ5/6mWHyCP9txyTtB+tfn
	 YFp31tQYcp+BRNdEBuZKu8DQETiyzk7p66K26JXhzrtjm+ottwAuCseGqILkIHEbQN
	 cXRFpfhfqhOIjrXdvJJv95wr72UALHh6WPNwx54CV33Yeyn/W7MoMKvOL99YDSO3bE
	 e5+Yw+RBij8mA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 6.12.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Mon,  9 Nov 2026 18:29:24 -0800
Message-ID: <20261110022924.115699-1-sj@kernel.org>
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
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4688a10eca89b..dfd0295104d37 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -641,6 +641,11 @@ struct damon_ctx {
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
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
-- 
2.47.3

