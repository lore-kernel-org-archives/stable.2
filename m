Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4551E451
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546928; cv=none; b=Zu2aNjCvJbQzBUhFVpXBxVzPw7GBD10/MDSiRhyy4sRPYFtu8FCmehMHxCDrymWHuRR9YksaZBdI+59XUVL1EcgmbP1B5LtAVV0/bHqPlFShUAwMxPJEr0WVzj7sV5rrSlKElezItZLVY5UEjEcsr+ijQAVa6w4+FCm5Nre8i68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546928; c=relaxed/simple;
	bh=QtJsUMgHJOJIc33sbmop/l2ZekYx3ng0MiphrHDYvJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAjLNlU7oRvA2tWWH7DWil9EDwiSdIaUtsHdesuWl0aiPXsH1/N2/gSZFRWV/MKL+6oXiOgEF3nzzbFptYLbTvU/CN0JIceKqFJeFCxardDUW3U+IfBu4Jn1zwfIchg1c603jdee/ef+OXHYvcZva8ywEod3xChRLWScJl7+vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgqNiwla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgqNiwla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81061F00A3D;
	Fri,  4 Sep 2026 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546920;
	bh=NTKZPum495vfURWuP/EyT8TQQ3roRqlKFvU0pEFpVIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgqNiwlaFkfNKGLstCHqTXVtJ0K59e5+t0mHuS5rzHjsvB55WLspexzMKgprZ5/99
	 dGVYBEHUhsFRaCwRpA/sOrGbbouyCCcbsStB+MwdBHqi4Qm0Fgxu45R8nkGxRYA130
	 nlEcSQIdc2VkT2Sy6cA4KYnABWGRvSWhRUzKwdMsPlUxB5smUUh0W6NjxEhvc94hff
	 iwJ7urhMpmCg4dHpmlNruQLD6ZBkj/bKSqwNUlrjCIxYptvDcWfv/6qHk8/mf2vlDf
	 K/MA/2LUEL8H2JjDuETXb3+rHZA1RwpyW9IzWrVtXMWq6qukXdWCgh4by0UvMi9jHi
	 PFCfZc/NBCnkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 14:35:16 -0400
Message-ID: <20260904183516.1323937-3-sashal@kernel.org>
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
[ adapted the fix to legacy init_lock locking and single-page bounds validation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 28b4ce88cf145..615a634c8ec28 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -599,7 +599,7 @@ static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
@@ -620,11 +620,9 @@ static ssize_t writeback_store(struct device *dev,
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
 
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
+		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index))
 			return -EINVAL;
 
-		nr_pages = 1;
 		mode = PAGE_WRITEBACK;
 	}
 
@@ -634,6 +632,15 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	if (mode == PAGE_WRITEBACK) {
+		if (index >= nr_pages) {
+			up_read(&zram->init_lock);
+			return -EINVAL;
+		}
+		nr_pages = 1;
+	}
+
 	/* Do not permit concurrent post-processing actions. */
 	if (atomic_xchg(&zram->pp_in_progress, 1)) {
 		up_read(&zram->init_lock);
-- 
2.53.0

