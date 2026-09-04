Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A950C2B2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546926; cv=none; b=PLiJgJEL79gN/zAYKSO5aFofVDgioaAMoCbvA8JkJsHxMM+M9RuEUny27qOcGouBeBgTLuDa2nSBmt6PkJkPDk7k/exS8RW5YtJhg1t0+6ftr+zbOa+q+U2j6yse4PpDfQaSuVILHbZHwr4VFPsTkuNAT1Hyt2CkViDnXFEPCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546926; c=relaxed/simple;
	bh=FTrU9uzrsTkKuT1LtyzCHXRtwTiHxqguNP+SHH6ihaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj1BPyALnqE8XdwUqjPcAbLkKsGZvZ20ae2am7yEHSkziduht3FeUBSqYp/HFfvcey1dkqAmTIsJ/PNtN6FdSZcFEHPnLhBYC/VF/VWOOZQeKAEn20+sBwwyUGiLbOSoFvPOcZLyuIKFbSfkxeBMK/VQNZygOpfhVPxTUfQU2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8lNqKZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8lNqKZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D011F00ADF;
	Fri,  4 Sep 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546919;
	bh=sFkeiC1d3NLCVwN0ItX6nVexXWKQ/M3u5RpZr0JziQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8lNqKZbPRnmYDs0wgDYBcODmDjaAY9YqfXcyDWih0x3q6gTQchHxYvYB54qqaKIl
	 qfM6gATsmOc7cvINlaC67zvuN/+VE2UMEilcKkmzn55sBlSoPV6VFRLlLrQp76eQlM
	 DhWj8yTJ82FlqR8srrIKdmePJfLE0w4QS5bQm+b6lr8kQpVMYhCubiZrHonggDBrFs
	 SzZuRL7fp31B6cmuQh9GuIoriJz5sTAjLIYeku4eM73Jlpdd1IBYaEw1knbwhQQ+GU
	 0feQNKVL4GpDG5ul1SEY2iodGshkneKq3tFKzLUOVmG3O71oyt4+LYkQXYZmw2VIwT
	 ZTYpKtm77sJQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] zram: use zram_read_from_zspool() in writeback
Date: Fri,  4 Sep 2026 14:35:15 -0400
Message-ID: <20260904183516.1323937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183516.1323937-1-sashal@kernel.org>
References: <2026090305-desolate-sports-060e@gregkh>
 <20260904183516.1323937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit b8d3ff7bb5111c6a88d5672469de445d9b46cf22 ]

We only can read pages from zspool in writeback, zram_read_page() is not
really right in that context not only because it's a more generic function
that handles ZRAM_WB pages, but also because it requires us to unlock slot
between slot flag check and actual page read.  Use zram_read_from_zspool()
instead and do slot flags check and page read under the same slot lock.

Link: https://lkml.kernel.org/r/20241218063513.297475-7-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 894913e2d35c ("zram: fix out-of-bounds access in writeback_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index afd1eb7a8fffb..28b4ce88cf145 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,8 +55,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
-static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *parent);
+static int zram_read_from_zspool(struct zram *zram, struct page *page,
+				 u32 index);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -694,14 +694,12 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_flag(zram, index, ZRAM_UNDER_WB);
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
-		zram_slot_unlock(zram, index);
-		if (zram_read_page(zram, page, index, NULL)) {
-			zram_slot_lock(zram, index);
+		if (zram_read_from_zspool(zram, page, index)) {
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
-			zram_slot_unlock(zram, index);
-			continue;
+			goto next;
 		}
+		zram_slot_unlock(zram, index);
 
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
-- 
2.53.0

