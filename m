Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52933EAEC;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014884; cv=none; b=gLjzTXfGpXL9sVsQz3cpYGPWGvD5/XAfvHIwVuJXuL4L7WXY6wWWQSjFor46xMIQ9c/Rs61Pxvv3a/0VMv5smBnD82o3gfcHE5k4DwoYUSW9TbQacuEmV+bX9oCNBYUUtZq0rG+MOyWw8lP85feCI+zyTloNxyhQkrBZKJ/nkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014884; c=relaxed/simple;
	bh=WIPA9dIrzYtN3A/rdctB0jxSPzPrRiW6LEy6UQ6IhbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXT8K5lJwf8Sd7q3teBSnBorKGVQwHKybjBuRP0tAaFCgR1ryWfQ+1JfWpLcn6ztjNruKg0h82LRlYvmAPt3cZ4o/409d0LSnvpMAuesiVhXXlpJIYwX+PwMJc9d3MmVpRBBFMyzGhWGrR7DLWP8HHBsY7IEiyibu4K2JuJcuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giNvD8gV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giNvD8gV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA61F0089A;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014882;
	bh=EDkQJtDgOrU4lvsYg1EkfO75V/KL21F3Sc45rqb1ccE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=giNvD8gVjuvzGCjAIf2P/Qv3EPIvKclX/DYD1jhbQQ4qRtkbifMFmt0QLzYvkfH8w
	 PUPLjQID5cRmhsDOlx9994Ds2YA9yHj7AXWZNC5LZkxmw4wA9LOKy600yAsD35X3eH
	 deIMo4lxIwb1+s6NCsmj8H2kWu0QUiuj0oQcm3Snrxv8g+y5WW5d2I9Dug3gICX6r6
	 WXlLyNB9ASN2vBJ0m/pfhUj7hbZIO/CexQ4DDCJEhNLJqM6P+5Y1CALRA9qPdEGZ2l
	 hxRQfibAbvAEqc3hyqmCkyBAlrU76cV0sb4dYvqwR0xAbHzK9giYepg+3uZPpxVNl6
	 zUkt0/hQYcWNw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/2] samples/damon/mtier: handle damon_start() failure
Date: Tue,  9 Jun 2026 07:21:16 -0700
Message-ID: <20260609142119.68120-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609142119.68120-1-sj@kernel.org>
References: <20260609142119.68120-1-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
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
