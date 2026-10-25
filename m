Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946901;
	b=zB7BVuCHIzmw0KOpHiZ7tUQAtYkkxOGmWMZUm9JT4+gyQ7f7a1pUsuwULQ2FhRxhMdkm
	 92+UjVsJYdT8EqNLGH63DKYO5pxDTs33RTrFmBpE0iM7jUxZ0pbSZth66CSjFJQzLwS0N
	 cCkjKD5VYZsCIqPMfhkYfC8/1sUEVNQ9BuLkAgk+9ZM04GV8KdISGGB/Nfw2PgCtOW2zH
	 HwWOS6D481iYlInQpaDxuEaUYfEs8hPzNA72e/EZotkurL0mj/Gywr6fD1q7np1KQ37ZU
	 n2hKk8AexEb8MGqg3+CdEBXpg0c0SUb7dc5c5EPXXLe0DH5oWkko9Qw9i0wYaqwLC+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nr+YoPGEHm8Q3JHJ6w69GvnBfQfVrjXNL0RTKjfdlF8=;
	b=d2xHp+1VGHDxLznQb7Vflz2Bo1u7Ujb/eINNva/c2IxJJ+jh88kcH9dpaUYZWU4txlis
	 /QF8pC5espvFAiWhQuRyk0nu0O67q8yvZCOf+rBTTZTUX3AJFFlkiSmZwtO145JPepwp8
	 /z5lx196yBxptlLppWbKlUwn/HgAUTwlGVrOVl9vQ49lDA31CcfMzDUFizNsDkZJZ/Q1L
	 wCAyhreDCPioK/MfpK4O7XGiTDDhVeQZzWA3FAB9LiTw/v2PnqcrjLjuphFuQu6x5oftv
	 VWQvCFUM3Gmq9V8S7Fb+qu2ugk4wy81Tch8M4qB+1GzocdH5HmVt+6m1+URrk/wGsKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij1vhXas;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFE606A325;
	Sun, 25 Oct 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij1vhXas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A31F031E0;
	Sun, 25 Oct 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792946901;
	bh=nr+YoPGEHm8Q3JHJ6w69GvnBfQfVrjXNL0RTKjfdlF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ij1vhXasNxw5M3NroJhpbMcVS7tHPfS6CrxKjKAo4XXYhO7PkpF2dmMn0QDbVWBZ7
	 uHUszc3RYcsfQtZGco6SJ9gr93j9Ca4ktIDU9y5OeRyQQUWlVJ3uTTuKWFbMsejqsW
	 XWIbH72CDPWzKvy9woIo4kb1zxavklgubYljz/VvJ0ckxOuNnl2+UFNFBzMQtreqpK
	 kqStRonGrVO1PDERbzM4cLLs2jsKnHNl77X4gW6zXYO7CPlEUs+2HJnIrqp2svKG7Q
	 F3DAULHZlQguqaqijUKSh4cZVFtpUl0v2eDVKlyvmMBn6OH9hb80dEFKeijKiIWyyx
	 VKJSly+gW2KGA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Sun, 25 Oct 2026 09:48:05 -0700
Message-ID: <20261025164808.152048-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025164808.152048-1-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
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
