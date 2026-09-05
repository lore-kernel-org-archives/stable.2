Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14429B766
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567324; cv=none; b=dwPyF7BlDdRAbR3J+dhyk//UhhgZ5SsyfIBNRdLCabdGQw+8zR8r95kcRlthRIjZ0LtTPTDjY8s7+MrwNrTUnAZjMcaQnx0xqIIN2lA8brzS4mU5ErnItUgZJNrgWZ/pzYX4QVzJM7KTr8opxhdvUVAMRpW4EGpVQWh3rSDhqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567324; c=relaxed/simple;
	bh=bPfpMIEpVHwQYefMTwEvxX6mQdwXpjDH1BUihxdSPeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlkXnupGTdK4PV/3Vr7p6nipe6ND6tGlE5NVxOOwhirMg3p/VghI+oOxEYJq6DGXE+JiC6DpiOQrfAsGnoMBFMPd9Jpi80+nU3i/IRNYbvJ/3PqDdqzJONV2f0bnYaq/pQWXSacCRYDrbfjPNrP91hYRkpgLrA2fAUfsImoyGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhEZQl8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhEZQl8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64981F00A3F;
	Sat,  5 Sep 2026 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567322;
	bh=cJWLktE9L2mU9xhy9tQwm/63dgEkWuJbuYIqGpXXiH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhEZQl8dwQtX86POMtAvbn35twvNhsR8eN5jbHSIE8OTKpZ+S1PDHRgMKv6Qjjkcm
	 7ixWKgIEVUGSVzMabR6KWKujYxpfCjIO4BQn6BabwbteTe98P/J+UbEPQ9HrDYd89s
	 FH6WpMlGLZvFSeADqeildxJLvjGKugJ8ZBeJF+KMq9Mx7LzAaX1CM4toGvHKzViwZW
	 O0+Klx+DhJH22ZZyV2I4lp9CfN0HnYZIoNN2F6UU8z2diIg2Ctx8IMswYZ5LcGrVUy
	 rD56fy1xR/q6fvswGPiWCj9laKHGhadHPRdy5n9PWFGy8Yf8NQkBob2pKnxym3aP1/
	 2wq6g8ZjSeP3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 20:15:20 -0400
Message-ID: <20260905001520.1674355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090306-quartered-glade-f172@gregkh>
References: <2026090306-quartered-glade-f172@gregkh>
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
index a9f71b27d235a..464800ea61768 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -627,7 +627,7 @@ static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -644,11 +644,9 @@ static ssize_t writeback_store(struct device *dev,
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
 
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
+		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index))
 			return -EINVAL;
 
-		nr_pages = 1;
 		mode = PAGE_WRITEBACK;
 	}
 
@@ -663,6 +661,15 @@ static ssize_t writeback_store(struct device *dev,
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

