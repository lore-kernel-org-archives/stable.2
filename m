Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89058448B9D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538544; cv=none; b=YoA3MH+QkeBvhcmz+vXC0iOjOenWVxZXTdC/a15DYiVDfgn354nVe6Uq6/aex4Eez9OVexEhzU51+ICMxZpHfhu5CPHm85TArzHxwHARr+zXY7nEhBqK6++ahr6yFnkYjx/VsZn/wKL0cGpXLj5gN4D4/gI9wB+kHFk+89ybUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538544; c=relaxed/simple;
	bh=J5At5lRjVzrU83gdmyHHQJApo4irksAPwgvxyTJMw4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXIeHDUoubWkSYvKXinC9lEZAYMdb01BaYxZ8MmgXq/X8e098SQKvIXBxr0Hs6zn9HpN55abqGFh9Q4R+yS17p0CKQkR1fFo1+GJGz61xqZoIPvsv/yMTfyg27rjZnN/VMtlHgkdcE3RWuJzQq0nWgX45cb2n2rrVt52au4EU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZzqzNDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZzqzNDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F321F00A3D;
	Fri,  4 Sep 2026 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538543;
	bh=gzyeVR9LPb7cNd8EmjTkkAzKm1EiTEcN1dwd5bgyElg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZzqzNDXRUTZGKFUmZOLIQ/3RMGCcw2P2+rvPfKk2sNhWNQgdIF6SKUvxmaUfeGaM
	 I8NAtRt8zX2KYXkaT/NLQVnTiytnIlHEA5Eg2h6D0JGRVWH+1Jjjq4O5cDdfKn8pig
	 BmP/cEhCst2MwrrSteYoK2kI7ITrBX3TEHZXBEHuN6UcuiwYZW56zHESQwY+XcbvNI
	 Czw0jTYydF0HfQTaVuGoHrdc6lw+rtu2UrQIvyLVLUt1c6j0S9rgHwaR3pRs3QDcFE
	 V019ITEFegF9/rdfmZZ05iBndhxwle87fOpls11Cfr9Y32+rofPlFyEcpCKwuaR00p
	 0juthjF/IWU0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@meta.com>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 12:15:37 -0400
Message-ID: <20260904161538.1194097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-unmixable-girdle-2b82@gregkh>
References: <2026090352-unmixable-girdle-2b82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 8b05d2d8af817c6a1e23032df51e7ad83030d543 ]

ac_time is now in seconds, do not use ktime_to_timespec64()

[akpm@linux-foundation.org: remove now-unused local `ts']
[akpm@linux-foundation.org: fix build]
Link: https://lkml.kernel.org/r/20260115033031.3818977-1-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lkml.kernel.org/r/20260114124522.1326519-1-clm@meta.com
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Stable tree note: The ac_time conversion described above is not present
  here, so retain the ktime_t conversion and microsecond output.  Move the
  timespec64 temporary into the scan loop instead, allowing the follow-up
  bounds fix to move nr_pages initialization under init_lock cleanly. ]

Stable-dep-of: 391f057f44a5 ("zram: fix out-of-bounds access in read_block_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf3c789945b41..5f207afafe71f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -869,7 +869,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -884,6 +883,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

