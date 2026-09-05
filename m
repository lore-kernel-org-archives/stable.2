Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61582533D6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570783; cv=none; b=h8kp//Nl6xtDzacl3QhlSQV3LfMTAPmXCI74hQNie5h1mQg2wiXNOKBfihKoheex7BOVvqapotdPGXB1oX60CqDosh53t8HKQyB+yxMiWBIS3IBUhkz4OrjtaHsUzx3W2WC+hPNKPnAgK2t5um68jtSW8toyEU5HtjQSGUZ3wH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570783; c=relaxed/simple;
	bh=F7pJeM1Mm8tzALoUleBDACSS/fv/iM9yLl2jvMr7Bh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJRLdT3UOUBsoGqs/PkI6y078U8JgvcIWI0mznEfGjoIMXrzkTic+3VSFDcm0Z8AWLvm/M1anOETbZFMrrlhugqGpgxWRqCybKPbpgbUJzQ4XnLo4ItfbsP56Y4ZR71gkiJw7wWP/fqSCAtK92Edv0OnTwWyf+Dk+//z/PDgwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbncOhBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbncOhBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695871F00A3E;
	Sat,  5 Sep 2026 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570782;
	bh=btGQ8/H5Hbm4DyJCM3ky1SycoAiEF38TF0RhdsQfcuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GbncOhBGME95kufd777+6DSH9Tnhh6jUfcug0fM+MUtl1SenUVg8M/lJkZsc1hKRX
	 QbinR1+iN9c3h9KO4tJA0Zsb6nQ9Ao4uyq7/cT/gU2M2RV7uysvi9rJuUQHkU1SJYf
	 Ig7OcMxo9dW8MPvkODtRmcpPuSKP3LFMMt773DF6XGiWULX2xh6ePaj5Iqx82oGgsv
	 B9lTOwRqDjUqtKO1cCfgvZPjaL/DHw3n0hcK+9UhjRDenLKwd+2Oi93z7V1ioFYzhH
	 d1RHM92i1brr3zEMD8SRasn6IsNhcrIRLZvw7J7gDVerJ56w6xc6dSgxrIJCwEQUi9
	 7JoTyGVDb7Giw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] zram: move bd_stat to writeback section
Date: Fri,  4 Sep 2026 21:12:56 -0400
Message-ID: <20260905011257.1770985-3-sashal@kernel.org>
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

[ Upstream commit 910bbb441c004050e188dd8da5071054099e592c ]

Move bd_stat function and attribute declaration to
existing CONFIG_WRITEBACK ifdef-sections.

Link: https://lkml.kernel.org/r/20251201094754.4149975-5-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dde75313eed0 ("zram: set default primary compressor in zram_destroy_comps()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 54 ++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 64a1136447cf5..6a4870cf6e590 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -364,6 +364,24 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
+static ssize_t bd_stat_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret;
+
+	down_read(&zram->init_lock);
+	ret = scnprintf(buf, PAGE_SIZE,
+		"%8llu %8llu %8llu\n",
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+
 static ssize_t writeback_limit_enable_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
@@ -1200,27 +1218,6 @@ static ssize_t mm_stat_show(struct device *dev,
 
 	return ret;
 }
-
-#ifdef CONFIG_ZRAM_WRITEBACK
-#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
-static ssize_t bd_stat_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct zram *zram = dev_to_zram(dev);
-	ssize_t ret;
-
-	down_read(&zram->init_lock);
-	ret = scnprintf(buf, PAGE_SIZE,
-		"%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
-	up_read(&zram->init_lock);
-
-	return ret;
-}
-#endif
-
 static ssize_t debug_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1241,9 +1238,6 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
-#ifdef CONFIG_ZRAM_WRITEBACK
-static DEVICE_ATTR_RO(bd_stat);
-#endif
 static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -2014,6 +2008,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram_slot_unlock(zram, index);
 }
 
+#define zram_comp_params_reset(_zram) ((void)(_zram))
 static void zram_destroy_comps(struct zram *zram)
 {
 	u32 prio;
@@ -2034,11 +2029,14 @@ static void zram_destroy_comps(struct zram *zram)
 			kfree(zram->comp_algs[prio]);
 		zram->comp_algs[prio] = NULL;
 	}
+
+	zram_comp_params_reset(zram);
 }
+#undef zram_comp_params_reset
 
 static void zram_reset_device(struct zram *zram)
 {
-	down_write(&zram->init_lock);
+	guard(rwsem_write)(&zram->init_lock);
 
 	zram->limit_pages = 0;
 
@@ -2053,7 +2051,6 @@ static void zram_reset_device(struct zram *zram)
 	reset_bdev(zram);
 
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
-	up_write(&zram->init_lock);
 }
 
 static ssize_t disksize_store(struct device *dev,
@@ -2180,6 +2177,7 @@ static DEVICE_ATTR_WO(idle);
 static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
+static DEVICE_ATTR_RO(bd_stat);
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
@@ -2201,6 +2199,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
+	&dev_attr_bd_stat.attr,
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
@@ -2208,9 +2207,6 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
-#ifdef CONFIG_ZRAM_WRITEBACK
-	&dev_attr_bd_stat.attr,
-#endif
 	&dev_attr_debug_stat.attr,
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
-- 
2.53.0

