Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E7411660;
	Wed, 10 Jun 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099758; cv=none; b=QWDq86Gk3E8Go/9XXcTu4Qt/IoLXWOxGUtExxZIRUhx8d9EnAQjitaATrPCRF1xfz1ErMly16vH11FFzi6Qs2HAasRcfmX3BOC45JkIV67ClqwxsF7lYGHfQoPAzYDQbUsF0Tb4hG7iHrBmp0fkw5wLeAze+2F/6a1djFUe3dLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099758; c=relaxed/simple;
	bh=WIPA9dIrzYtN3A/rdctB0jxSPzPrRiW6LEy6UQ6IhbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmYJU9s3jwiFu8sAKXjuBnUv3ia9SnTLWSsp3b4WGkXMNbyk8mtnZJANuvGzq/Zf0MNcSiDpiRDUW+rXaE7z1BJJwEi6xlHV/ooflHVqyGdOHq97ruSSdGgYaW+Xlu3BrgUquG4PSJxqoW0ivAM3rGaW8MZEWUmVZm8RdJhmeD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPVLlWoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPVLlWoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91571F0089B;
	Wed, 10 Jun 2026 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099757;
	bh=EDkQJtDgOrU4lvsYg1EkfO75V/KL21F3Sc45rqb1ccE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPVLlWoMdhohPnY2v2+M7X6aLOAAsBM9xFiem1FcE4JHi9F2tf53jfedOXUm0YzLc
	 bbY0ex9oDuo/TvD3AHsSh7BU6nDffsSNQaXxy6Y7bvY9tbBP6htsK2O5CYFpZfwLV1
	 LUf7FWxCoX0ooxbiSOVKBP1qO2EKpWYM8Ffek591OILu9TzjVG8m6R732T3pmzqkRW
	 v/IUDl2WubbkFnAlC9EzgEUwmZlD6bU/9NDb7B+EhLElma6Mg98pZLN22W4k1ulRuT
	 bA/10CXmBuw0m5AWt0J+Mh3nf879D5JWrQ+SbUtL6VocODO1gPTs3TqLydeZ3/UM5P
	 WlHPVSNU9/A7Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 3/6] samples/damon/mtier: handle damon_start() failure
Date: Wed, 10 Jun 2026 06:55:41 -0700
Message-ID: <20260610135546.64943-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
References: <20260610135546.64943-1-sj@kernel.org>
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
