Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870440;
	b=3QC90W5h7HArAjsurVT+VQ+4m9MbNVbQzD5Vg3Kc1JbL2s4iaN8g66kkyIzLR1JygPtP
	 JsDipp2ihPzGur0rVkzxMZt2rdAaoZ90M/okr+Idx9LYnrm+bWgsWhyTMxL8nCbsg5Wr3
	 Ur3lzK1yhZ58oIJ6X7F3rCvhgm8Kl/G6Mhg/Hoc3gnErFyynIcu8+vvujM66hRjnk4cxS
	 9Fr+wgCnuNG2fv+fBRfro4r+K3uEHId1HAT2aN2IaNt/yT2dmzArxzQVQI10oRcy9uZah
	 cYz9pnHX3JWU8cH2sO7QT3eQQVsZ9ZHGc7MBAWJ7kJXnXkPfjOTvP4Le1nyKgCkMQPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nr+YoPGEHm8Q3JHJ6w69GvnBfQfVrjXNL0RTKjfdlF8=;
	b=BRkbzCShStKC0pZCJSicua9twOhKRVmKiW2tSVAmOMjB/cdVn71nyihFXJgCrFzTJTAL
	 hUPBqgORO+Wk/8ZNjek//3YxsG9uBOjralFiXfH5muUKl8Iq/yP0PLTcqE5pSLaRAay4X
	 1DHVwPqXiXppAGeb0zk6/tlrX3S06rDBH/k7X8IPYLgLN+CdPLou6OneGVofIq+79cadI
	 FdwRL0Og8mzotcuFI8hiAkg7AV+Om1bduEkgxQwxzxxkUIOJIQ9OGvSkwH+EAVLgFFN7g
	 8jKJ33ivPM63lUUXkXY94vOcUZ8hF9SEI/FC4S+B4V1CEdxoNwlZUa23IWawl0c/ZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3YoQoQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB46606A320;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3YoQoQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FF41F031E0;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870439;
	bh=nr+YoPGEHm8Q3JHJ6w69GvnBfQfVrjXNL0RTKjfdlF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3YoQoQ4gmS+/Aqq6qA74DhONxs0aqE+nSetz3bItoE39Xl1wFZRg+MRMfRW3rpBb
	 yRt5bxQPXRDXxbcR0zI7yUXJjsloteIoXQ2FNPvzM1pt+RK6RmqW/8VXOHILg2HaIM
	 syO40anvzZUAdaatr65SVify8Cb5rrzEQTy+LOJS2hXPgbadfM3srNGegGRAg8rErW
	 wnIYaAIaO9krKJlUwlEzlmIYKjano43sBfeBrVOFakXc9mGahe7TZRrFQc/7OnZY64
	 LRMyv/TWpmRDN8fsKyhiCaqru1n/OrhQzwOZsHWsIe56Kq78osz9LwLfAAkP3P7Psg
	 J4sqJ+Ks9ucIg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/3] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Sat, 24 Oct 2026 12:33:48 -0700
Message-ID: <20261024193351.87130-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024193351.87130-1-sj@kernel.org>
References: <20261024193351.87130-1-sj@kernel.org>
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

Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
Cc: <stable@vger.kernel.org> # 5.15.x
Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a47f2
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core.c       | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 63050eb2206a0..cb6a50032a1eb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -958,6 +958,11 @@ struct damon_ctx {
 
 	/* @rnd_state:	Per-ctx PRNG state for damon_rand(). */
 	struct rnd_state rnd_state;
+	/*
+	 * number of regions after last merge.  Read kdamond_split_regions()
+	 * for more details.
+	 */
+	unsigned long last_nr_regions;
 };
 
 /* Get a random number in [@l, @r) using @ctx's lockless PRNG. */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index eb1fcdabc0075..09722257ce736 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3795,7 +3795,6 @@ static noinline_for_stack void kdamond_split_regions(struct damon_ctx *ctx)
 	struct damon_target *t;
 	unsigned long nr_regions = 0;
 	unsigned long max_nr_regions = ctx->attrs.max_nr_regions;
-	static unsigned long last_nr_regions;
 	int nr_subregions = 2;
 
 	damon_for_each_target(t, ctx)
@@ -3811,7 +3810,7 @@ static noinline_for_stack void kdamond_split_regions(struct damon_ctx *ctx)
 	}
 
 	/* Maybe the middle of the region has different access frequency */
-	if (last_nr_regions == nr_regions &&
+	if (ctx->last_nr_regions == nr_regions &&
 			nr_regions < max_nr_regions / 3)
 		nr_subregions = 3;
 
@@ -3820,7 +3819,7 @@ static noinline_for_stack void kdamond_split_regions(struct damon_ctx *ctx)
 				       ctx->min_region_sz);
 
 done:
-	last_nr_regions = nr_regions;
+	ctx->last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.47.3
