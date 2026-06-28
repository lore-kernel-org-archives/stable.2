Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D63B5303;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683695; cv=none; b=lx8NkzgNLit5WtrPfCZRVvZl9iaFDauCK6kNJm3XMYII+bq78wUj87AwqZq0VXFcZ1UXZXZw1mczuisveGdou0nTTIT3Y+lQZ7tPlKCcVBqO6Py1Bw8Ip4wsTDLzL/H+cNnoKiA5iUJJTma2amkFiYEmDfY863FzR4Qr/ZHhUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683695; c=relaxed/simple;
	bh=vhA2Q/FA3xxi/IXebfb02djle8DTT/VrgFTaXDirz8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMS+zs7WAuhPxhTWI1RLlmJfAOEak1HAmXoeLfCQm6SyQmT6GIq5DrEbXTR42pwrtgo6tbK5DsHc6ZG9iEZ3NBxNkzKES3NJkE4leV6lJvKuZO30JH4t9QM7oeEr00yIvarHMQD8HtjjHEGs8NcCF7fe/zTYedfEqKt9+3HqMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZH0JUwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZH0JUwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1711F1F00A3F;
	Sun, 28 Jun 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782683694;
	bh=qfAQcGY5mXPLuWlFWNsr+GYvFhReWhn1bTVwZS99dfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZH0JUwelV8LBYd/Rg5FEJMin2KD2M0Y2kTQ2yp7ak5sYnqHB7TuUNVBQ01CGCp+9
	 fQQxMSG6SRtWjZL08fNgx0rBrSJXcHHcsA3ENWFmrZeCTd8W/0KfE2BO9s4DiMB1U0
	 sHRRml1Ajg3GDeOF22vT7cGHUQug2tSkXzECdd1M3sbf+HkzW/YVbu57aCVAHaiwQT
	 SLIWTTpVk2+1L4uJUmGWBjQpovQcz/e+Y+9KMfWqjwExUesG5JLgC6UKxwAWGBgTgR
	 tW1mycjVi6bbZOZwm5ZiuRWVJ3sWF6yLGf6/DTRa40+aSjrPtHzvctDM5OkLsiVRYl
	 VKxdK++8+x/Sw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 3/6] samples/damon/mtier: handle damon_start() failure
Date: Sun, 28 Jun 2026 14:54:42 -0700
Message-ID: <20260628215447.96166-4-sj@kernel.org>
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

damon_sample_mtier_start() callers assume it will clean up resources
when it fails.  And the function does the cleanup for context buildup
failures.  However, it is not doing the cleanup for damon_start()
failure.

As a result, when damon_start() fails, it could leak the memory for
DAMON context.  Also, if damon_start() fails for only the second
context, the first context will indefinitely run, and avoid starting
other DAMON contexts since it is running in the exclusive mode.  Stop
possibly started DAMON context and free the contexts in case of the
failure to fix the issues.

Note that the issue can reliably be reproduced because the module calls
damon_start() in the exclusive mode.  For example,

    $ sudo damo start
    $ echo Y | sudo tee /sys/module/damon_sample_mtier/parameters/enabled
    $ sudo cat /proc/allocinfo | grep damon_new_ctx

Because the first command is running another DAMON instance, the second
command fails the damon_start() call because the new DAMON instance
cannot exclusively run.  And without this fix, by repeating the second
and the third commands above, we can show the memory consumption is only
increasing due to the leaks.  It requires the sudo permission though.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index eb1143de8df17..66b591f2180fa 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -174,6 +174,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 static int damon_sample_mtier_start(void)
 {
 	struct damon_ctx *ctx;
+	int err;
 
 	ctx = damon_sample_mtier_build_ctx(true);
 	if (!ctx)
@@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
 		return -ENOMEM;
 	}
 	ctxs[1] = ctx;
-	return damon_start(ctxs, 2, true);
+	err = damon_start(ctxs, 2, true);
+	if (!err)
+		return 0;
+
+	if (damon_is_running(ctxs[0]))
+		damon_stop(ctxs, 1);
+	damon_destroy_ctx(ctxs[0]);
+	damon_destroy_ctx(ctxs[1]);
+	return err;
 }
 
 static void damon_sample_mtier_stop(void)
-- 
2.47.3
