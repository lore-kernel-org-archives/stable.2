Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB80329C54;
	Tue,  9 Jun 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014884; cv=none; b=VdpxJkEdoUIw8sfQEP1sU+BJosU3y7NPnUljLLrcSgHEF9FVvZrDLJco999BYZ31IZRi0pwk/NiRgKjjMRSKr42jLcOf8H7+qthD/hI+zorQtVSDTojAZ6W2NEBCthN/o0pUxoGsaNZbYSOYfkrPiB0NWIBeVRFRHkvEpGNSR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014884; c=relaxed/simple;
	bh=enbigSKfZhHs55sFswY1ofWl2WsfR5xtqPL9/la+0Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZEjhGqgu8aPCOIEjx/aijKriDXytSb09OhXCohlqtO3xT69iH7ZBU+DbWVEfx8gzubLG2clan2xB3ie2br2fINPPKuD5AlX8NbtDYGKCTre2/N4CHT1kyO2ao+zkY/4MgIxtPDwLqTnELD/igCebiGBueEe0omIU/KUgNU72Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBYBOWtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBYBOWtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C0C1F0089D;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014882;
	bh=wvTmgzWVeo+cgK/5Fasuy9LNL6Vq1lM40f7iFKommVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBYBOWtNu/9rQ/xS6E0Bw2JnAvyTScw1/GnV+s5gpa21kSaJ5OgEOXYiBRekApavu
	 0Z+vAyNSAatnCKVudQPt//H/Wewnad9lZvbZp22exymEo+BS7h8wRx9eCBB2OB+7v7
	 dLnhKOANWGhxGTbWLcO2MZdu/jdp/s2gYVedTw0qqhV7Tz2n6MVxZPSl1DF3mqiNf8
	 LAvVA/sUOP8PYD0LTy0dhWVVqpvhGg0a7cHs1wuRMBQFucoL9G1cbydrMrZSmqAqUX
	 ZK30IofnXwoemrHCcWtANjWbnIg7Kk7tWLzBFys7O+8j97A1HPH2uz5vYPCCfwGh7h
	 53aM/zUo1sY4w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/2] samples/damon/mtier: handle damon_stop() failure
Date: Tue,  9 Jun 2026 07:21:17 -0700
Message-ID: <20260609142119.68120-3-sj@kernel.org>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
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
