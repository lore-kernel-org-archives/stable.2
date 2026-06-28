Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD93B9D9A;
	Sun, 28 Jun 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683697; cv=none; b=Lmm7ZQXilzjqRpMGqDpdYzY9ZlwFIFVQiulqfgZCbEvePEXuDjb1YvnZ6Ft3PePehQ1coNxmo5+B6S+R3hiNZh90T6qUeQDglsRyWzQ8HV3OXKO3DzS0LU8TeTQNHulLvy5q/z2HZYZTPU/lKnlthvupPSctP0tz3RYtao+SWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683697; c=relaxed/simple;
	bh=6KCSQ2mPzGgYufB/BsVCnu11VDp4U8+Kq9xRKYkHodI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO0mYcQUf189lPKnekXbb6qG5j25rRvqsPLbI6IB+NJzc3yDFUUDpeUw/Y9MDZR4DLeSoUqoFuaGaIPCFgJ60+SEkW97rxvCcg2Cv+Cc5kkjy4amZPEjJU5NzsCL/DwKL3nl1B7QXmrjg4VuaIOs1qoxKqUgFsFi9oKPzb2u2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLV6cNV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLV6cNV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A940B1F00A3E;
	Sun, 28 Jun 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683696;
	bh=QZMAogVOdZfNtue3KEudF8E70M7L/5Zd6Peu2NziwDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLV6cNV3PqVhZlA2ArqlsSIoIOaJEWXbp6XNOQjnn8ybH4Te9MoId4aGWQAGLclWm
	 kNifkfr7OzbK+ydxLCDIy8AzIdP0CyHr8E2Au+fmlhSfa4O4maqqTzqYdu+7nIxs9V
	 OQzYMkCTkrhxbKDeN0AqI7iOsBI2k4hMZZRja0V1z0QKCGAB0m+zxEJ1mXfLtUR1bU
	 LaXgzM5/mSJ1uGt+KHjLdOAHdZdNIvWQROva5Rm4yOJ2q8WargXzZ1clwSFQX8o9qz
	 jfziukBNS8IKawoc4iar0Ry7cPDervjB36dMt1vG0PDVxTqHU1yquneKGtV/pc4DAv
	 gZj2YA39Tp80w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 6/6] samples/damon/prcl: stop and free damon ctx when damon_call() fails
Date: Sun, 28 Jun 2026 14:54:45 -0700
Message-ID: <20260628215447.96166-7-sj@kernel.org>
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

damon_sample_prcl_start() calls damon_call() right after damon_start()
is succeeded.  The kdamond that has started by the damon_start() could
be terminated by itself before or in the middle of the damon_call()
execution. There could be multiple reasons for such a stop including
monitoring target process termination and kdamond_fn() internal memory
allocation failures.  In the case, damon_call() will fail and return an
error without cleaning up the DAMON context object.  The
damon_sample_prcl_start() caller assumes it would clean up the object,
though.  When the user requests to start DAMON again,
damon_sample_prcl_start() is called again, allocates a new DAMON context
object and overwrites the pointer for the previous object.  As a result,
the previous context object is leaked.

Safely stop the kdamond and deallocate the context object when the
failure is returned.  Note that the kdamond should be stopped first,
because damon_call() failure means not complete termination of the
kdamond but only the fact that the termination process has started.

The user impact shouldn't be that significant because the race is not
easy to happen, and only up to one DAMON context object can be leaked
per race.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260610035214.4850-1-sj@kernel.org

Fixes: a6c33f1054e3 ("samples/damon/prcl: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/prcl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 0db2598946911..edeae145c4a8a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -112,7 +112,12 @@ static int damon_sample_prcl_start(void)
 	}
 
 	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	err = damon_call(ctx, &repeat_call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
 }
 
 static void damon_sample_prcl_stop(void)
-- 
2.47.3
