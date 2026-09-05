Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45C2EEE93
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573599; cv=none; b=gbGjTL3rhd5B+YDJf5uIfgNJQ4wvZq0odzHWVVeFWrBV3s37NdvxELNYTHwUz/fv6B5kWGfgK6UqEga4c/xK2ZcQ8zfeQsKPJJ7snjUOnRCAxV1t8EymrigTu3QZiRAfzUUogLx/gzkCBQTlc1SJNOOguUKxfyHChJ6CNjgmIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573599; c=relaxed/simple;
	bh=pVvBPCPGXvTr20DJFgXK1q93dN3nr0QLH8rm9EVKbYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx53qRxmW9rDmryYu4w5Is0x2BpnLfWC9Zo6O96QkzB61DXwDWb/P4EJicFKAMuwQVvq38A97Cdpn1Rl1T2vSR+iHX3L6pH1UpFgrlRYSq/we/iXkFSmBAoTv519+23x9G4RBe3AV4Pg1rFN/h945IxBYKLISxGxNbDkBluNMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGqQMlnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGqQMlnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01661F00A3F;
	Sat,  5 Sep 2026 01:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573597;
	bh=CihwhE0cbzs0MWdzBSAqD/t5euMNTA+cyCQI8SIEf7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGqQMlnOrakkzZZmo4wiDVyME0cidkaDVjZrRPrnWkYYxXe19S0Yu1GjESS/LZc7y
	 62AlSaOjAgUhtCYBSbCltHQWO+PAkDTp8SyGkW9jjuNEGrqklyN9H6bKLTPg0u6mhe
	 LdrUOxDNElbax0YwlPmEQQDFjTCk++gqZ4mXYOd7a7P1Ob/akGWY+baUJS58VXjfZa
	 wH2NbhZbkwY6XeKFtg9ngMpQ7OQJ7lHF2+oIW9aFWEO0JxehdAvLpZW2V+GNPHmn31
	 dxYAHIMUS0Q9wsgqIYOIzd9imVuekAIo9aIaejVL8DeFrO485Lf9/5t3ttyzu0Md8N
	 GO+Wj9uLYs9IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 21:59:55 -0400
Message-ID: <20260905015955.1825906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-skeptic-mocha-fa40@gregkh>
References: <2026090307-skeptic-mocha-fa40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit 894913e2d35c46ff19a77530907771ae57862b96 ]

Patch series "zram: fix stale scan bounds after reinitialization".

Both writeback_store() and read_block_state() derive their table scan
bounds from zram->disksize before acquiring dev_lock.  If the device is
reset and reinitialized with a smaller disksize between that read and lock
acquisition, the bound can describe the old table while the scan operates
on the new one.  This can lead to out-of-bounds slot accesses.

Move both bound calculations under dev_lock so each bound remains
consistent with the table throughout its scan.  Keep the fixes separate
because the affected interfaces originate from different commits and can
be backported independently.

This patch (of 2):

writeback_store() calculates the table scan bounds before taking dev_lock.
A reset followed by reconfiguration with a smaller disksize can therefore
replace zram->table while writeback_store() is waiting for the lock.  Once
it acquires the lock, it sees an initialized device but scans the new
table using the old upper bound, resulting in an out-of-bounds access.

Calculate the number of pages while holding dev_lock so the scan bound
matches the table protected by the lock.

Link: https://lore.kernel.org/20260804065919.3970386-1-xialonglong2025@163.com
Link: https://lore.kernel.org/20260804065919.3970386-2-xialonglong2025@163.com
Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted dev_lock-protected page-count calculation to the older init_lock-based implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 16db4fae51456..3f2872b45bc8d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -633,7 +633,7 @@ static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 	unsigned long index;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -660,6 +660,8 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.53.0

