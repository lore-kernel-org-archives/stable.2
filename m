Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896026C385;
	Tue,  9 Jun 2026 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966487; cv=none; b=VvMEc/7h+22RZPQFGCoK6xvPvXorZEbL/6BkqFmeL+1+/osi71RnUQrN3MxYQhqQtgl27wSQc4jZns6sUAJGeir4Iwn9NT7F2IoxdJiHJHenRHg3DfQVF3J3Bi7Qm7oIX3o2axmeITNo2eq005Ilwfonm1MvxX3md8p+8VFwFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966487; c=relaxed/simple;
	bh=hN6m26Pt43YVNp2YWw3p5RNmTMEKADud6+2L5WFh1zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olWIPe/xaCBiZ/ly2E51FEmfNtvdn3JdbDYjtfrLX9hR77TuKfNAlrAJdXPusRh/nzcCexH4NAnqOPwmk06HXF9PQ+N67rycud95qHxUyHiQlECuZtQjuHL73XWiEzQcS7kvqHoApMvAx0WPVRF/AkNIts/SoiEmhqmGwfI8jqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0IlKExM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0IlKExM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E71F00899;
	Tue,  9 Jun 2026 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966485;
	bh=Jo6v5LwZ9ZiVMHZVW1HuuvAQB6tY4B2I58Ij6xQSkaM=;
	h=From:To:Cc:Subject:Date;
	b=T0IlKExMhP67Am9Ab1dPAxhi38p2Vua+v4TKu3QPQfHGzA8IHzar1Y5jk2fDSmNtM
	 PvUclIhidEI+NxyHipSY/tYmzKtQGSKF+tzkba2pJiMUuS3eMGgXUmOoOEft3SbcnC
	 6PohtZry+ysT3rdCbEkCM6yrvWoQmnBcgnDaqV5zAyLjuiROanwrZ0mQqVQRtY5aEt
	 lohzX6dcvd4nS63QrGw5NSGpNxRIaAhy71vASE2ytg2dzMY4R7wze4bPcmN9B7HvYV
	 Ibvym0crZS2p+N8yfedo7ztg1rafTOGRRWI03QRSu+hrODc96ovoRj0PttrXOcM26M
	 SarjuB4DjXbyQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] samples/damon/mtier: handle damon_start() failure
Date: Mon,  8 Jun 2026 17:54:41 -0700
Message-ID: <20260609005443.2122-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

base-commit: 947b8ee1c1735e548454493da9999a2647621bb0
-- 
2.47.3
