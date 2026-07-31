Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D534575A;
	Fri, 31 Jul 2026 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478352; cv=none; b=ohsFc1L+SvsDWw5pc165eEt8kfk8FVQBp8Z3VqfrS0F/kZEuu6N07FAsnfUt7BVG4RCY69YHhBwLoqpnm4w86DTVq5tG85jK/iA8iIRqmPp1x6AqRUPmYhpbijcVc59zVnQxIJ3vrpwNaZDjDGcq/HVSzg7poEGnQV8wdrkKio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478352; c=relaxed/simple;
	bh=Y1JcFfsMxAYuwnrefStKU1BC5LEV95g+1EolWcU6v7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BF2EDs3XKx46UG2SZRs3J/SP5EKTplfhF98ySTzr+uPH1pKAzcQGQ+tG9cfOVAqy+BfPJLUmzSwcm57jKnAkFPyZUSeQsAcKhIgX6o6UxEwp3bkFtJJnukCygQxOGVIDdH+fUZdKyWiTmaJGeX4hOM+vxiplCasrF/xiNNbA14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h3AMcw8H; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="h3AMcw8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785478320;
	bh=HPZGktnGKJq0YPe354T/UoJt6OFSxF0ZOdTB9mSN2bI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h3AMcw8H4ECTYuf7DzuRkUN+zKVOHH2AJkidNxD5I/lpA81X19mYnHFaZNZnrK836
	 QqogL0mamMYltQdgLY9Q7ke8rGmyidY8SP9MM11AB61UFi+ygd8AVZsSTbrLfmHfTc
	 CvfzyzgSOfoYSheWhnDBwZsr2jHIOYSIUWZA84iE=
X-QQ-mid: zesmtpgz4t1785478302t530aa3c8
X-QQ-Originating-IP: Gaat/f7YMJd9JCUXk1SswtxXLqm8VHOGGirS3P+YNKg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 14:11:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15113661807862631467
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] zloop: restore finished zones with reduced capacity
Date: Fri, 31 Jul 2026 14:11:39 +0800
Message-ID: <2D18C0B4D202858C+20260731061139.1190909-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5aCtjAndv5OwcANG6NBvvryKQk1nRVaV99UhrIFmOxpmSIINYNaNBbu
	0WUr7znt3ed+hF2W22i97ztirySIvDP1DyXqaFURScVmJBuOMr9T4XFb3Ar2oEYTpJcrgG5
	ZhkCYBfq8AzCEqFD+78VtZhoTBx7v8yl3VBoOjROX6BMftnB8fN+rpvRWJ+DLlwUc2fuTWE
	9u8O13XsBTNM7EwmeZOX6hiHVV0SaSNGdemW5MrqYhXkvWHYFAXdiTcTDRpFqkPmBQmammq
	stIUcnWeOhX9t2doRnFnEm6p50DTHWUq1f9g4JRv85GLH/tkLsbgXmsdtIlL59m9HJofT1B
	oHGI2gEoRCshZjFqZMfu2QSIzYKV4MJJil/0MbsCSHvN8Fp5Tcp2I0/LFuOWZHE9TBy8dag
	yl0PywF6HiKLFz4cSmMvUzCK86FXDjCZrIH20nFqh/f/pHvL/Zx+k7uTKdWAATw5uRCsSlC
	/jCjBzQsCjDMfZymxo95gnhLjK45kvl7eHhxdi+owues5CSMDuX5exw2j184sWxbaE9PDb+
	RHlD2FxQrFqpavXiuJhvP+p3oiNZOlfSLnavIGPnaAqfqH8+lB3N3VSvdmGhxa/npNRopco
	4poidQ7y2h3bZIcTcQc4PKTGxBNzWRWDZjFB6aycettEnG1ouTWuZZ9qd1y6SedvVM4DQ0y
	k483WUu0BGxYB2T3Wujh0dU+uIhxEA62sIHX5JEfbcMXoOdEJ0d2ORcU7kwvZPnrhbI0JJw
	P0Cz01oP19oiwaGIxM0l6G0jJF7pfqTGO3ddXJsv4nW6JOAhsdLwBeuoP+dBVRjsQSPoK5S
	YXDTIXHcBVu5g5ihGw25FHf2i3c2g7aFpTgMUZ2tuZAJCE1ZugcyEh8qucXOcWnDAqWZc8+
	k1M1tUHSOjxoAah5PTgmA8lVZGD/eeXWfo6KBRg98DXsRZMbi4Mav97kyrUvssRl7BvnqJV
	Eu8kucrgT86vL/kEi4jaupAxf1jy1sXd4rIZMHhrRCmi+N8C9w6eMqmF4gtfvKymB/whVJ+
	a2Vx9toqCW6mY1+7X9F+3KScwbSwyw3VbaNj1kghvVaWqQ43ec5gIyVE92zjg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

zloop_finish_zone() truncates a finished sequential zone backing file to
zone_size. When zone_capacity is smaller than zone_size,
zloop_update_seq_zone() rejects that file when the device is re-added
because it treats every file larger than zone_capacity as invalid.

Documentation/admin-guide/blockdev/zoned_loop.rst, section "Overview",
states that a zone finish operation truncates the backing file to the zone
size. A file whose size equals zone_size is therefore a valid
representation of a finished zone.

Accept both zone_capacity and zone_size as full-zone representations. Keep
rejecting all other files larger than zone_capacity.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/block/zloop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 55eeb6aac0ea..b69d798f203c 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -324,7 +324,8 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	file_sectors = stat.size >> SECTOR_SHIFT;
-	if (file_sectors > zlo->zone_capacity) {
+	if (file_sectors > zlo->zone_capacity &&
+	    file_sectors != zlo->zone_size) {
 		pr_err("Zone %u file too large (%llu sectors > %llu)\n",
 		       zone_no, file_sectors, zlo->zone_capacity);
 		return -EINVAL;
@@ -339,7 +340,8 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 	spin_lock(&zone->wp_lock);
 	if (!file_sectors) {
 		zloop_mark_empty(zlo, zone);
-	} else if (file_sectors == zlo->zone_capacity) {
+	} else if (file_sectors == zlo->zone_capacity ||
+		   file_sectors == zlo->zone_size) {
 		zloop_mark_full(zlo, zone);
 	} else {
 		if (zone->cond != BLK_ZONE_COND_IMP_OPEN &&
-- 
2.50.1

