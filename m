Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D03BB57
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566689; cv=none; b=GCEQd9Emr9wr0HY872lrG9LEhvu+KJAT/Ru9TlkxYzZi1cDHoMjRh8c53jsixh5bFvjwXo62qnAAIxi8CkUL3fp9ml8lKrONTIS35e0zZVgMmVDgDCuP7mzTXCNbGiqsgelmQ07qQSOfqIgJbep5ks7f+AfJD4NcoVIvA9jccEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566689; c=relaxed/simple;
	bh=CTb+vKqWHPVT8hiWAlUrKuVN+0pRH0aKmHHTwwMt5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZS7ZhFAdKOr2v0fBkssNihnlnUcDSBeJFo7xKvNJAoEpCTcXdq/5hRzmZd7HE8ZfiFd5U6LCVd/k+/ulvZXuVTcv9yHAc9o2UGkuMFCT9SdKIXRPWmRGJbi6ah4UQQSoSorZs2LKoJIyoojBPH8fBg755RKM1rcdAXV/DcUL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrIhVFck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrIhVFck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E91F00A3D;
	Sat,  5 Sep 2026 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566687;
	bh=qc5xT4myPSrD+BBFTmDNzAy9AecGrZCP8Ek0qNC8KhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OrIhVFcke/HN3Jz84+zJNoAm43/cOVOJsXBh5UWVqvnWrY/5eOnvu+2GqDGSHYhxF
	 dxLRjG0GhWaZ62MsmiFrZH6BTi8FVVmNycIfwFDAgwlVqJ+HNhnAO4cyE0chnCJwos
	 4hAQJWTvDguOO7n2QcJzopTLxgfkJbM4YGXm+N7NdtPCMdwdbXPxCX8XWbRBBZua6s
	 6Whvb22otypPyDq8OIDuDJ/KM7N0ViIABZElQqbFKS+LqzIL9MrEk52hIm+FkdJuLP
	 +Y2e5+QLs8KfKeNweJqdexgnB+WNzVLs7E67o087I2yplXsEfEHwzZ9BWcl4jGLF7X
	 lQ/eeyrVT56Rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 20:04:45 -0400
Message-ID: <20260905000445.1656128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090306-supremacy-tulip-9586@gregkh>
References: <2026090306-supremacy-tulip-9586@gregkh>
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
[ adapted locked writeback bounds calculation to the legacy init_lock and page_index parsing flow. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bef5388e4e28e..072f5f2675064 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -644,7 +644,7 @@ static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -663,11 +663,9 @@ static ssize_t writeback_store(struct device *dev,
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
 
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
+		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index))
 			return -EINVAL;
 
-		nr_pages = 1;
 		mode = PAGE_WRITEBACK;
 	}
 
@@ -682,6 +680,15 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	if (mode == PAGE_WRITEBACK) {
+		if (index >= nr_pages) {
+			ret = -EINVAL;
+			goto release_init_lock;
+		}
+		nr_pages = 1;
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.53.0

