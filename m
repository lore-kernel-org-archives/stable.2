Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16B4FB9C6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553938; cv=none; b=rnjor2e73fmxTGbD3Qu1bL/ip7f5SjH7ACfy646bBo3Em6vrmD7/jf0CcQvKaOq/G7MXNEsbsjwK/BsmoCbBNKOxkNzByEb6zH3Th+CMflIE4B33lOEVbaorCXsY9PpUjrU+BZvKuLccZxGGuJ6E2vN9ZLcqHqrFPSBs86CD1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553938; c=relaxed/simple;
	bh=GX8K/cmkcsseYg7gICgTS7wtOoPTCu9mA5QUWV0fHYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rba1zY9i1MCZ8l4TAEQRKGvGVUDOlzH5d58RBsOgQj3js6w0v1vEVva44NE1Bo8SM8bPW5vBYtky97aXHI8PGvGECjOyMalXP9ha+3YXxHqNgYb4TnDYMsOlu3SVTDYz6x2ZXAFG8baxvv5PDXB+JCnNNUHR2xOnk/BW8HAjYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhWhYYEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhWhYYEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFBE1F0155E;
	Fri,  4 Sep 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553927;
	bh=3uPUZIctwNFcPZCtnHBl6+PGDKNPKGSbrPm5q7+tNYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhWhYYEg3wZ9L/GB3MnzLsQSPwMKL72nNRuheBnUfjMSKK2snoG63NlfAwmh8UCnb
	 JHvlNde3YHFHkqwjztvxNYkFNa9JlA3PafYueATF2pXvS4orQUnxeCZQNxiA2NUlav
	 l+7PnXQvlNL8waN1UIKg2wGdvmDr/rs79IBOpymyVE4AmOrLu9XNrtCxNbPnnQkrO1
	 7M7Cz1tODeAZlCpbtTcDbzJQwkiAKN1VEQ1niCjvO0UD7UnNpcl1QB0IpCHZKOlAHW
	 sw3VnGgnahfFiahjPaHLXn0szbaaWnR1I2GdMjdaHcUZ8qT3zbT1yHHQYdsmnFvSOq
	 ziZ57MMpXRGKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] zram: move post-processing target allocation
Date: Fri,  4 Sep 2026 16:32:01 -0400
Message-ID: <20260904203203.1546745-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203203.1546745-1-sashal@kernel.org>
References: <2026090305-dimly-backboned-037d@gregkh>
 <20260904203203.1546745-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 7e1b0212d4d59281a80c836841539a91b724bf24 ]

Allocate post-processing target in place_pp_slot().  This simplifies
scan_slots_for_writeback() and scan_slots_for_recompress() loops because
we don't need to track pps pointer state anymore.  Previously we have to
explicitly NULL the point if it has been added to a post-processing bucket
or re-use previously allocated pointer otherwise and make sure we don't
leak the memory in the end.

We are also fine doing GFP_NOIO allocation, as post-processing can be
called under memory pressure so we better pick as many slots as we can as
soon as we can and start post-processing them, possibly saving the memory.
Allocation failure there is not fatal, we will post-process whatever we
put into the buckets on previous iterations.

Link: https://lkml.kernel.org/r/20250303022425.285971-12-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894913e2d35c ("zram: fix out-of-bounds access in writeback_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d547f2d251fd2..3b87e89a9a496 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -636,12 +636,20 @@ static ssize_t writeback_store(struct device *dev,
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
 	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
+	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
 	unsigned long blk_idx = 0;
 
+	/* Keep the newer writeback setup context available for its fix. */
+	(void)wb_ctl;
+	(void)args;
+	(void)param;
+	(void)val;
+
 	guard(rwsem_write)(&zram->init_lock);
 	if (!init_done(zram))
 		return -EINVAL;
@@ -649,9 +657,6 @@ static ssize_t writeback_store(struct device *dev,
 	if (!zram->backing_dev)
 		return -ENODEV;
 
-	nr_pages = zram->disksize >> PAGE_SHIFT;
-	hi = nr_pages;
-
 	pp_ctl = init_pp_ctl();
 	if (!pp_ctl)
 		return -ENOMEM;
-- 
2.53.0

