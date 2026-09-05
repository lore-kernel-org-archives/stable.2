Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121E26AE5
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566697; cv=none; b=IAmOKyihkjWY0JVr2/XL2erq4KwbRDgVCtXYeZRylKe/qhsqwWthvWckYlPCLz3J6ytlHYhoupWIlK9L2DPqfb/N7AqUMMyqidRMT47nVQBWeo6rFFn+x5bMm2b3WPt7Fr78RfqIusbmTG06uZIvnutqTTHKLFSI/IrBqvwyFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566697; c=relaxed/simple;
	bh=NqU/BX0NRTWzepZFWsLXhXl13mbQIeWQST9u/QmZoQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzEk+ucumNiw6KSHKkz72Uq2N3MnxHzrtiFpdg71BIh/R09BxeZr9OxKFhOntOTjJ6UmVBQ7X8NEaOWsQbLVSSi/boe+1gKnilmNJQd7k5RIzU7HBTJf2CgRr0dJ3jzwS0WmG66BqDny+mi54BQ/2RRNFpIksn9yVBRuYQMz3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOHibaFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOHibaFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE71F00A3E;
	Sat,  5 Sep 2026 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566696;
	bh=3VAHJb832JIKfIpTs0P4+UR6XI65YYnYBVVPF0uAUCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JOHibaFaL5r1F9xq10Gh8CdmHOalXtHTXaeSRfH2+xwGX9MBkhiC3FrXAIayExE80
	 uy0Gs8UjBX8rfKRMbFV9odIrOpfCKboQbh+ddrsYNakLzUM3asu4sGdALMUtzds25V
	 ItSJnVWYHLRUY8R1RtmtBU/7RViTcc5U5UpK5xG+CeUaTE5RIoDxCtolepx/5Jm/h3
	 hbL4K5czGJKCyA2sGdBW1fNk/0W/HwZr2gjZn50GBMCKABVVlV7Du2jIDtJT/34uwV
	 0ajBSjOfq9u6MUnVfAKJWIpOdSZSoVke0zFYSBW3nEBTLumVzUs3zCNZXWr0bUCY2A
	 eloDRBFgFuM6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] zram: set default primary compressor in zram_destroy_comps()
Date: Fri,  4 Sep 2026 20:04:52 -0400
Message-ID: <20260905000452.1656571-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905000452.1656571-1-sashal@kernel.org>
References: <2026090323-reflux-devoutly-8bce@gregkh>
 <20260905000452.1656571-1-sashal@kernel.org>
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
index e11f0ff18012a..c97e025b82b44 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2169,6 +2169,7 @@ static void zram_destroy_comps(struct zram *zram)
 	}
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2187,8 +2188,6 @@ static void zram_reset_device(struct zram *zram)
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	atomic_set(&zram->pp_in_progress, 0);
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.53.0

