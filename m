Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D34D2EC5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538912; cv=none; b=F+lAXwr6Pv8vf0OL0dOeUEG4Mjof8seS8zKRIQOZKQdsWw2xT6Rry0zbGm8e0xSxd3tGCf0hSVLGkVzF3TCxwzzb1tf1hRJhAHvZfKBXV1a2qElCgyuLhfxo2V8Md4W/U5xBCKsxaAqgAucgEkvgdxtwykGVEWOJwH729ilS+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538912; c=relaxed/simple;
	bh=0HB/ZvoM9h72JpKBfd75CU530SbUUC1O1yc77qcnQ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc8RIArWb3y4G+EqSTGOfZw6utRDjP2ohQTGDcxQsWrOJt7cXXTLI81QVKy7BEJoK97hpsEIkMM58WlVtQKtGgYXR1NyrfMICJaPnbn0gBDfrrG9rGX+Q/4p2d/BqRitWVnngAU5rCY9KGfb70Cc6luwt+RVc7y+NIYg0OWVUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZheE+dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZheE+dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70CF1F00A3E;
	Fri,  4 Sep 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538910;
	bh=/ipNylu59QHAJ0Q4cpe1Ihdd3PcR+OqrPt6Zh1mVdaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZheE+dnDT2taG5qtm8KX3wAWbPjLymGgj3Sa7XPpu8ORLrFcH63jN7YNcE8O1E1g
	 k6LENFfXH+WK6LKrpcrKYXh57ahhouWBeAYK3xj/gOPgec3UMKzQ4wYljIWf7gRgyc
	 CIBAmDFCWX7lmcpqJbkNZiYx06CjBMMqc3m+yzB97Y7AMNnvNM3h7gasUgjx8U7/mS
	 hyF/gy6ywC8IkS9Ei8IND7GKa5GJuFg1qXBOYEOFxY55DDV2Gqis4OIn547EMgPlAy
	 e9d2x7kMb3gDy1ibuS1QE2O7s5GiPyqqS1zTIRLBMPiehB0E8Hdd314nFk6A9dIXvL
	 UQzPrWfRhW9Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 12:21:46 -0400
Message-ID: <20260904162146.1210685-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904162146.1210685-1-sashal@kernel.org>
References: <2026090353-pyramid-reanalyze-9bb9@gregkh>
 <20260904162146.1210685-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit 391f057f44a51cc9418da5cba78b014324174264 ]

read_block_state() calculates nr_pages before taking dev_lock.  If the
device is reset and reinitialized with a smaller disksize before lock
acquisition, nr_pages still describes the old table.  The subsequent loop
can then call slot_lock() past the end of the newly allocated table.

Read disksize after acquiring dev_lock and checking that the device is
initialized.  The read lock then keeps the table and its bound stable for
the duration of the scan.

Link: https://lore.kernel.org/20260804065919.3970386-3-xialonglong2025@163.com
Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 91a1cec8a6e3f..c83ef64521ee5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -878,7 +878,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -891,6 +891,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

