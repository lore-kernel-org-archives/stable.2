Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF2533D6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570781; cv=none; b=DQF5ohHALu9td2z2Mjt7oSWdpIdyyGn7Ftclb0joCl7IpvpFRqeoRCjWHhARjqUvtvSYMaiTrev32RZa4WOOxZxIEzyrzivuDo6do0N4wQnkKU13I79QFOBn5hQ1qjh832Fae49EwVJ5ahHwmknZ0hQe48wYT1Df42fZKeq49S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570781; c=relaxed/simple;
	bh=0NCn6HDD3RwMTXtYz8bqh2yHjr2JjkQ1J52zEuPE0F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD/4jPd+O5THXcGHWc/aEGi4Feb5aNvkWFanUxR/Asq5RkR9A/p81qFUKIQ89jLtGtpLpRrGAUPZZAwFzWncghz258i0N9PHxtv2HSdwb7dO/FUk9BpSng9ooIRqWG1vuhqV1MtK/MrrSYqtQuAmhpxHbNk0W8tXxl2w1APua60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km5K6tlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km5K6tlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB81F00A3E;
	Sat,  5 Sep 2026 01:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570780;
	bh=enTfb3kek0jHs19X/rCkzxOTHGQlscVNDxJ+zgTDdnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=km5K6tlzx0JV9Jh9ucTWc9iH3iDgmPHcUN/zXEb4KA9r0wM1Xnl8VrL/XxTmi40CL
	 wx3Q1Zd+NLAIYHDrq3fVopNVpJxc7lSx32f7ZcJltsMj8zbYqsDMLpUEHyRIC3QjXQ
	 bjxAWwA8vhXLTs13bz8W+gb6OMWd7ZP34Ohlzl5GWg+8+/zCgiYTNh2qrH7Hn5yN9c
	 VDM1Pe37ihCmDtikC0NQXb3H8+NT86KpaqLprpBQfa99jaHQ+VW7gmc/Ee3hmuLSo2
	 N3TGWylR+XZcVAebsjA34MNYIJvrmB/6GaBrHD+dM5yQY6L2p9GYupHieENiKmuqQZ
	 d1+2cIpA+XCnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] zram: take write lock in wb limit store handlers
Date: Fri,  4 Sep 2026 21:12:54 -0400
Message-ID: <20260905011257.1770985-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-gumminess-earthy-c60d@gregkh>
References: <2026090323-gumminess-earthy-c60d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 7c929664fddfdaaa4afe5ae833d0f3044709d95c ]

Write device attrs handlers should take write zram init_lock.  While at
it, fixup coding styles.

Link: https://lkml.kernel.org/r/20251122074029.3948921-4-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Cc: Yuwen Chen <ywen.chen@foxmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dde75313eed0 ("zram: set default primary compressor in zram_destroy_comps()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0c422e4179ad5..8e99f453371e3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -365,7 +365,8 @@ static ssize_t idle_store(struct device *dev,
 
 #ifdef CONFIG_ZRAM_WRITEBACK
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -374,18 +375,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
 }
 
 static ssize_t writeback_limit_enable_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
@@ -400,7 +402,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -409,11 +412,11 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
-- 
2.53.0

