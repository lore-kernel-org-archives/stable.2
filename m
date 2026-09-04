Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612348876E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553940; cv=none; b=eO2NUXO3ztnToh2zHU7zcsVZR7UOqOErQEscJ8wbUhzZdsFNIsec+2ALk3RDha3uZBmCcN9kMWEzyzxVRpMlPcEGT/VCyIYwiIJ0gdTmYuDVJNFezsmht/NvpHgEn2ND+3feppqGijK45k5zQKILj1RNepKq1spSMbuKK2a8G2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553940; c=relaxed/simple;
	bh=RtMJK7PHAH9cNJLizgwCWrA2Up32A7fCWVu1py/K10M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFT96YMH1wYTp2l6q60fih7r6mgan2uRQOH0YZRx2lb5LqiS/Fnu0NultWMGfA3W07uUcSp0unwd8d/UGEZC2h+Y4sc6Qyivfg0/aNIRhXFTrlCwyhesluaXergVyu0ae7rwiX7In7nqP1M/Ll+IAiVZOdQP2XD9uuMdIEW94XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orgl8evW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Orgl8evW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A61F00ADB;
	Fri,  4 Sep 2026 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553929;
	bh=StzhH3tePX0moy4DzE3XZ+KcJ66cEzp8VTMsI33Cee4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Orgl8evWeKZsDVja9j9EgyCQCDUkxm/UzuaRQrB1DvhjPsPWBi4zCSpJKMDZ1JdOK
	 5od7rKji3xUjHd+3OQfLx7MH+4cnMmlsJwqYcJq4AAo4Dx1yUapjD0GNdm1xj4LqTJ
	 yfWYN9NggBqz+/ZJo6jncpwDYZ6shf1PXaK81WYnKTV901yLAe4i0mbSjb2eWLa1HN
	 +EPz4jRxhB0vU9bzUUQEQY1csjJFo6pVXo4o5me46kYdYYGqw3IGHCBVGDIVi3gdNV
	 +9S9x2jeRCrOfZ0ssf0FkOhE1hSJkTtuuN8hPhZRg66w3Eb7wW/MUsJGTeF/u8IZHz
	 zHmkz7B5oyscA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 16:32:03 -0400
Message-ID: <20260904203203.1546745-4-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf02efcbc47cc..9af91e8e4c41b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -633,8 +633,8 @@ static ssize_t writeback_store(struct device *dev,
 			       const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long lo = 0, hi = nr_pages;
+	u64 nr_pages;
+	unsigned long lo = 0, hi;
 	struct zram_pp_ctl *pp_ctl = NULL;
 	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
@@ -657,6 +657,9 @@ static ssize_t writeback_store(struct device *dev,
 	if (!zram->backing_dev)
 		return -ENODEV;
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	hi = nr_pages;
+
 	pp_ctl = init_pp_ctl();
 	if (!pp_ctl)
 		return -ENOMEM;
-- 
2.53.0

