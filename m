Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792047255F
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538545; cv=none; b=TOjUHwhC03bfO47JumJxsl8Ar5/GSgiAoJ4Ry0wbGT2Od8mWN92/sSijHUUhmKNNOljL/JZx2dwEHREdHfDqz3yGb5uShLUgbq/PtnBLrQO5Np6+HQN2fjbpgFxuvPc7LNiAqWsHLsjHK5ib1V7UqRrMCWSh3JWXk+2xymVi6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538545; c=relaxed/simple;
	bh=oAS9N0LozNoWy0qYx+H7Z8MS6eGNBcqSCKkY2jj1w8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b17eMax9NWpMSgXIAuw7TsRBu9crR+33UzTbG3gGgBMdmM5Pj5N79RazJi8Qfgr49oERtPuxuZBZvNEwyMM9XSwrZmo/+80qUX9ohcbrA3W55Bhf5IXS3aCICLzUyfpCzSMvs2hfdX7d6vkP0rRqwTpxK0/AgKOd+E9UIPO5qVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0igQBj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0igQBj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0C81F00A3F;
	Fri,  4 Sep 2026 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538544;
	bh=g2AUcg7Ag+YyaR87t9CTJKxcqoCII3lp4IO6xR8M6Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f0igQBj2bdAUNzTOjK5qrCwvhF8KPzM45olug3i6OgwcQzB/Wi0dW0T9vrN/3ZOEU
	 E5xTqa0zArawiD4tbuMgxVBJgUDqfL2zm/HhleHqStX/JPlnM4QvqZM9kYwX5P+JLP
	 JTiYV9p/1Oo4xwQhgC3HHrWHAZx6HmxChF3uLJsQq3LrRGdc0/6X1PK3MwABipn/GN
	 zIr/8X3aLcejFg8YYhMsIbB0cN5Bepe+7Tw/J3EZAnpmpPl0W1y88gCO3kT2yalny7
	 ceWXK95QJLsBuoESFGKtqd4Hu0a780IpSwRBpgqsqnE813gOQP17q2JFvf7c3vRrW2
	 TSo6sxBn9RpZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 12:15:38 -0400
Message-ID: <20260904161538.1194097-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161538.1194097-1-sashal@kernel.org>
References: <2026090352-unmixable-girdle-2b82@gregkh>
 <20260904161538.1194097-1-sashal@kernel.org>
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
index 5f207afafe71f..2e915e52b745f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -868,7 +868,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -881,6 +881,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

