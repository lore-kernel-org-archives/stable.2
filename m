Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E50326945
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570784; cv=none; b=jlIpYFCe42I38sAF2A/F+9Z0+x/onO9gwF8QDa4S6kU7cRXY+h6RE1wZWe+luYUwr0I8+XBbxP+qwMdrGXFwZGRgh7Hi7jsH32N02Hf0DV3aVihhnM+vsOfDidrmgqPNgLz3eN2CCLSP/FdP6p96x3WlRU6zKEVrcwWZG8FkxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570784; c=relaxed/simple;
	bh=g7IJaQ7ovSLsl+0oQt9xl1KXWa3Gmha0h5Z9AaHQub8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClduskY6/gpJaoJwKiifQxwVWfqBTDaJIIuv4BUlnL1kKDf+0LuWh5Po/aErXQJ8d50//9d8dKR7z/AqMHX5ZzUp2pbD+wpb1Mrp76wt4GNM7Ir7iorj3qLLFhn1m4coDDR8PjTcctDaDWxlx2z4vEFaN6dFbN8NIe9MjVC+76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEMcGDnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEMcGDnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C341F00AC4;
	Sat,  5 Sep 2026 01:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570783;
	bh=4OcGqq2Fx+/da77hpn3aqcVzTNKFlfUgXrKY762BkvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEMcGDnz3AkxrcA423YuNuIYLZ1i7LrMYhZDMqf0N5Xnk/ltzquZ8OM2Gyoe/SVDQ
	 U0s+mp+3k33X2FMMCRpeP7iZcgtcddw1RYAY18LboQeSipY2x0VoOmYnCD/IoZzGiA
	 OBkAwl8QvdZzYMc5s+ccprqId22rKUhg+L76zq48sXWv4mCzckzUVMfgnqciSO22gR
	 GX2w25CAY9puvRytNQdYDf4/hx7nufWT56AEbQy43jhCU7eG9ddg5HpOggJ6qxuN+5
	 MdnrVbj6+2dezpcDKrXMSbrCzCBJJOOvuu1Ux5hprbNNhk2X15FoZ9a+hb1lplvNVb
	 ZJv9CG6/zHTww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] zram: set default primary compressor in zram_destroy_comps()
Date: Fri,  4 Sep 2026 21:12:57 -0400
Message-ID: <20260905011257.1770985-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905011257.1770985-1-sashal@kernel.org>
References: <2026090323-gumminess-earthy-c60d@gregkh>
 <20260905011257.1770985-1-sashal@kernel.org>
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
index 6a4870cf6e590..d7d4e39530392 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2031,6 +2031,7 @@ static void zram_destroy_comps(struct zram *zram)
 	}
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 #undef zram_comp_params_reset
 
@@ -2049,8 +2050,6 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.53.0

