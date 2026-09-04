Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0589449B06
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553945; cv=none; b=pflKsgZawJyKnFsaL1KbkYAYl9/hs8wuWBihKSUg0IxWZ3kKV8WSWUjDmusAsfDuXVZyh8/3zRdCLfxONWOHu1c+dbeQbZ4icIn9T1MXhY+QaTtRBZfEEUIY11nGr6iF9rUlpE+RDFNl7LEKXuh88xrruJiFIVJRakrIe56pxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553945; c=relaxed/simple;
	bh=ppAffUcQMr6scMXew2G+F3fVTxN6vN2U04WkwDGJ+Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1gmCPIA/n7q3ZfArup63oN9cz9Aqc5m+Ahhd0t0NQm/1sR+B0MDs95t+kyuMct9j0EEBdHcR5Gc/Lno49MFBaZ6o6CIppf7QxxMOULB7XrzUvjw0JgaExKC1MBUtK/D3P8OKqmK1SPwZB/vdD8q8d+fOPA5ZpXTF18XA/T75ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3yaUF9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3yaUF9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778DE1F01559;
	Fri,  4 Sep 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553938;
	bh=1hS8NrlPsIHPjsXvEnOjoqfmvIYaXvB/h6qof/DIRTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3yaUF9C+bIsm/Qg8GtXTZ8fD3FjVvZSf5p5uKnSSJoKT6pMhg2V5OufXsz4gc+PB
	 Slf+fqACHmt2nuGYDAVUEr2bpxJUzXRaa8dqITevMrWzuF50rRq5tQxaG2k+4/v5Bu
	 uwmhs59rJYCuVW3+AIcHPmXV+5sc/ZWf4TZrjouB/cPdZRv55O3CnUqDLITaCezsDy
	 b/20OOZS7zBsII5lD3CSXrydqNaCwBddE+QAmyTQNE7GxNIZ/p8XtS+Isvbmud0LTj
	 aqvDZu2DfMKIvmFv6X+5GCM5EcR8hsFudPMvBb6/NZmg7U0u60Pznz1qDnR4yjF5bQ
	 pglSoIB+RWPcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] zram: set default primary compressor in zram_destroy_comps()
Date: Fri,  4 Sep 2026 16:32:11 -0400
Message-ID: <20260904203211.1547892-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203211.1547892-1-sashal@kernel.org>
References: <2026090323-dreamboat-stable-993d@gregkh>
 <20260904203211.1547892-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit dde75313eed0b014c437f48dd75c0308b592cbf9 ]

Patch series "zram: fix zram issues reported by sashiko".

Sashiko drove by and reported [1] a couple of zram issues:
a possible BUG_ON() in zlib code due to missing winbits range
validation and one possible NULL-ptr dereference in zcomp.
Both are low risk yet still worth fixing.

This patch (of 2):

zram_destroy_comps() resets all compressors and leaves them set to NULL,
including the primary one, which is invalid device state, as now
comp_algorithm_show()->strcmp() can be called on a NULL compressor.  Set
default primary compressor in zram_destroy_comps().

Link: https://lore.kernel.org/20260729045745.775973-2-senozhatsky@chromium.org
Fixes: 486fd58af7ac ("zram: don't free statically defined names")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com [1]
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2e26f40e70f34..37eb2f98ef3de 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2462,6 +2462,7 @@ static void zram_destroy_comps(struct zram *zram)
 	}
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2480,8 +2481,6 @@ static void zram_reset_device(struct zram *zram)
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	atomic_set(&zram->pp_in_progress, 0);
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.53.0

