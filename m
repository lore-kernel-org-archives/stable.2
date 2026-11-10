Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273142;
	b=nF2G7f7iMtEohtCiPyPrEq/UHNoBYfn25j3343zoHMsvqXuOZGRe+l8ai1VNiiRItxCg
	 YsRXNbOMLxsJdgMmO9N4TtatJikFgfKU/zlJfh1CAss3yBDH4QCldZrUNPLu+gJouuDdI
	 xw/v2dkupD/qjzBOd6lBWS+gZiCbZ6ooFJ44Bzz4XTfoWxwA2wTDsi7aNLwkUc9WyDJG7
	 cUlXc4iu9A79DDzNfLp65oSmMtB/OtNF7K5+pw5cw3ishN2tk8Zhyrn59qO/Es9tiWTfF
	 xyYHpcXTvYlmClsq0ye1d8o/L+ISKsyl/gc8WjqKPScZOfNTmow6WgLOQNTr8gDVe/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rLLugWsE69/MbYb6k94YlAIHUboqHo9t4jbgzqPyiSY=;
	b=H+yWwxjZy+DUMyg2WjaIus7M4fQZVILmXhDmmnPjHScwox/soZZL0Hx5KEHv1N+yTfYm
	 QgDIGLp5NTrnhYfhlRmTL+IfG7QsKICNu33dEmP5Cu3bNwBTI6HwQYoNihWvWLkPiOHOv
	 5ChmuqeZNGGTCjjJBGmY/190CkHmRsAjEz4kTN7fXUQzM2SEnYRTUGx2gH7VITUVGmLBs
	 +GnBiY/a2yJhl5F8Nz9VNGY23YLf6px8cYkaR7fNeW8I2SvxBaoVM/LIFjJfXTlUkIfle
	 VbIXd9uclZqXx4Zu39Na4xb7JiH5fri5oLjcwMAzqddyhNkBLLVoMrlLMqmO7oDhDIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBJcZo3I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20952606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBJcZo3I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD11F0089F;
	Tue, 10 Nov 2026 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273142;
	bh=rLLugWsE69/MbYb6k94YlAIHUboqHo9t4jbgzqPyiSY=;
	h=From:To:Cc:Subject:Date;
	b=QBJcZo3IQ9T52Mrq38SIOW9dw0c+VaZV4tgZF3wX9QsBogPVTzS2YR3qzWB+GiPNy
	 ARD8UTuG9AiaDx/WD8PtkwFd1rRkd8SbR+GwfAgKZEouGcIz3Ugp4mvErdf4DdqpKX
	 GE5WOkrsaCFbQwIytkMtBt7KkKfYES++R/50albCZA0208+Q9F8yoAziQ0pGtxMjnv
	 dPAqUA4qv8zNpEyUJwFjYcpG1i/BnRKbLo1486lh4KKlOvzyekfGy4m5IHiS5n8ixS
	 3Nt4MAd2vlBZEMMgwvwBta0jV0f10bzqDP0POGCdoLT27ca+Yu4ftpx+pDYTmeDA1N
	 xawRsnvAr4mYg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	sieberf@amazon.com,
	sjpark@amazon.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: move static variable last_nr_regions to damon_ctx" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:20 -0500
Message-ID: <20261109201220-failed-6.6-26ae50a0901a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 26ae50a0901a44f7d50053f87dc38abd9f9a269c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201220-failed-6.6-26ae50a0901a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 26ae50a0901a44f7d50053f87dc38abd9f9a269c Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Sun, 25 Oct 2026 09:48:05 -0700
Subject: [PATCH] mm/damon/core: move static variable last_nr_regions to
 damon_ctx

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
2.53.0




