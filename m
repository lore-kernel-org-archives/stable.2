Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A283B95F2;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683696; cv=none; b=P0cTOETZ7jKojZJd3wDRJHvT+amsUsXAsh8f0we42DS52cQ7+F1vXYM3b8WZTxy2QAHRd4ftzsii7D4PhOZ1qRP67/VJzVRyhFajxXzgYH8M1ZnVhZ3IViZ/fr+n9ycqUntJuj4V7sFaRLJG9D6qVhszKqdvmvTj4fi0wSUBk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683696; c=relaxed/simple;
	bh=n/t3/pdVXS0Jt0TAUkoYM31IalaCViDcV8Ahgd4JMJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxmbZNz0ojObvGal6Mw26Z2Yow3nUjGJ4BNe/FZDEWcNY/exINAkrGn8XabXoO9Tp5EWpgowAB7wUR0/qwtlL2DMceYzbq27yu6pQ6nD1kKmUHHA7pXwkaWQgt0Hu44WyF8ttsjYkGpcTbhWvCaOuKEvKjYH76q4XJOB++vGzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAh3iceE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAh3iceE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D91F00A3A;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683694;
	bh=qdss7KwiVKURhK0NoHx/6TLcyP6FekMODUWc+wtuLzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RAh3iceE+2/jLRIbPExiF4OEJXdK1pOSagWGRv2I22jnZuwEXyPdTVEoMGr9MedDV
	 HepS3fjZxFpRxcffJphSwDhqy2/m4O0B0I7mtMdwXSZAaUme/oCsB4GZiOYBLHrhQT
	 uoKkRg3WyJ4/SC4ErgiQ5AUKonTAE+1LDgeIobyGAGB6VvvPfUoP3h+UPCubvhWIZP
	 P9Fb71spOW/ehbld5FNPoBXyUVRqxBRYg8dalvE6umO6egz3WjrQtX39oJ6u2Cp4r0
	 aXw2fOKURDb+ZHGiNoy1KVZscF4PeLXuYAsjRaOlRJuAmVXbhcE7bahFHYTeLTjGm7
	 L0vL7r2qhp3nw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 4/6] samples/damon/mtier: handle damon_stop() failure
Date: Sun, 28 Jun 2026 14:54:43 -0700
Message-ID: <20260628215447.96166-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628215447.96166-1-sj@kernel.org>
References: <20260628215447.96166-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_mtier_stop() assumes its damon_stop() call will always
successfully stops the two DAMON contexts.  Hence it deallocates the two
DAMON contexts after the damon_stop() call.  However, if a given context
is already stopped, damon_stop() fails and returns an error while
letting the DAMON contexts that have not yet stopped keep running.  This
kind of unexpected early DAMON context stops could happen due to memory
allocation failures in kdamond_fn().  Because damon_sample_mtier_stop()
just deallocates all DAMON contexts with damon_target and damon_region
objects that are linked to the contexts, the execution of the unstopped
DAMON context (kdamond) ends up using the memory that freed
(use-after-free).  Fix the issue by separating the damon_stop() to be
invoked per context.

Note that DAMON_SYSFS also allows multiple DAMON contexts execution.
But, it calls damon_stop() for each context one by one.  Hence this
issue is only in mtier.

For the long term, it would be better to refactor damon_stop() to always
ensure stopping all contexts regardless of the failures in the middle.
Make this fix in the current way, though, to keep it simple and easy to
backport.  I will do the refactoring later.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260609014219.3013-1-sj@kernel.org

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 66b591f2180fa..faaaaa12e6206 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -199,7 +199,8 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 2);
+	damon_stop(ctxs, 1);
+	damon_stop(&ctxs[1], 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
