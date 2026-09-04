Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4252D2BE
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553942; cv=none; b=jkTa8jMXQrbRsow43QvE6RTLdsdUoskA+VwlMqHUkUldDJGm7qb33M1HqH/iDzdKPV8/K+KDMmHSRblZgXR1GedCUOcTlS5IvwbErEoiJ/Czd998+ZU/1rWZSwqAWGs+ltoz3aIyz4OmXgoxl/8Wv3I8zpw5kIueVTllv2g6Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553942; c=relaxed/simple;
	bh=qzzor9uavQ5FLvCbWfgvOKSMhjLfq8tOP/PEKg4FhMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQbG8kOrbtPx5B4nXARenC1dM7zjhstoKuVclQC27tHZQMCWSV+Pq0YX2OQGxBH8PyAhW8X1xl40gzpZk1k0e9imkk4XKwlBAdAXQvYj7gc5Cl4JS0gneTVi7IICBuSu8bbLpcv8pG4zlmtJIb6eNPowyNpWNlvJIeKGB5LBMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0GrhwHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0GrhwHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6C41F00A3E;
	Fri,  4 Sep 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553933;
	bh=qivQQ6qxPW8ySHvIljXLLge2K5RQfZGNw929ny/sscM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0GrhwHA9K2hUD9RL94fELscPQQLAyWGoAKqOJlaWE/kXEnbaXjm7qGRXGenoxKRA
	 guFLbUGJMShdIZEote6PJpOHTu9T8gSUzQXZORZ1TbZqhT4u2lYcsk2KvuEyfAbd/8
	 3u+LTSnOljLFN0hlzbD1ZjdEwP3VblHwdzPuIIBNJj7tMFy86NK9K3hNrwUlBzRTn3
	 iMmvgsSXm6QINS+bcCPkuAtCYPFmElvGpiScU0poT7rHPHWY/6N6/j3x8aYBrtl/gz
	 Yzkb+h9LkrdyVVvrZRPAzXUJpIMF62x/ATnVIbFahMuMFWkYmWyNnr5xDk16aSfhoc
	 6kfq+vN8U4i1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] zram: take write lock in wb limit store handlers
Date: Fri,  4 Sep 2026 16:32:07 -0400
Message-ID: <20260904203211.1547892-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090323-dreamboat-stable-993d@gregkh>
References: <2026090323-dreamboat-stable-993d@gregkh>
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
index f51dd33784291..1f0727c0b1748 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -501,7 +501,8 @@ static ssize_t idle_store(struct device *dev,
 
 #ifdef CONFIG_ZRAM_WRITEBACK
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -510,18 +511,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
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
@@ -536,7 +538,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -545,11 +548,11 @@ static ssize_t writeback_limit_store(struct device *dev,
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

