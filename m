Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CA4FECDC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537536; cv=none; b=G8PcEeXUnGrnvoPJL1IrO6qMZEYIEYKHukJW09yCShHTGODpP2OypJffgRp4uaZHkqnfuS+YvfShAJqzp0yQowj9b26/t6MLvSS0Ti7MXxXze9GOvQDcNQGusvDBLMZ6nU8uF1aom+rZm6fEwqMSSK6QHaKiJZK0Yv5Eq5dFFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537536; c=relaxed/simple;
	bh=V8VaD5mKGf5Mx9oBPH+au9YsOCQ+8gEKWn6ekqzXz2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/bqU65iSQQfsgn2aNQniBNVPTc3BNRJZfw0q92M4+4GIO4USShxx/m6KOA7bQ/HaRe0kkTQgWjK/hkSNih/gfHXBL7xPHVgm15kt30+9jRMe1oN5bYr/QW0JF9npSR2SYd3voe8j6/Ca7m/hutdzSEk/01Z4bRH/bKAGIh/5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAx5XjXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAx5XjXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D922A1F0155F;
	Fri,  4 Sep 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537534;
	bh=k59Poq50BvscHZZ/NDHxfRRslOzYQNBbabZY4zeejEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAx5XjXR0rKRf7bZhxYDVpRio2aMavAFLwFF/UhgeW4F3cUg8T9POXLHDlZNcOg7x
	 E1buN6lHxSQVK8ZPL7hx0FuIFi4qf9x5naVPgZnOShhDmjFIRma3ABaZM65vwDzPe1
	 R4qpVhWvimyGR71BNjgvUppZHm3ugZRpe+7kHgmtNQbsDhNbah5eFuveivoJ8rlL2J
	 ZWLPTGlJ64mIJftH8j+Vn0iNKXCbc8a15eaeciaiq0dUcgDOzcbJWFeg6EtCPcI7XN
	 CY0PqYOrkuub4qaAAKnzAFwHg0xGsGIV0Jlm1nCM/UDkqjybxxiu7DECXXliPvIMep
	 Dw1+AqMXb1p8Q==
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
Subject: [PATCH 6.18.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 11:58:51 -0400
Message-ID: <20260904155852.1071464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-imaginary-automaker-68e8@gregkh>
References: <2026090352-imaginary-automaker-68e8@gregkh>
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
index f51dd33784291..84d977505ca52 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1136,7 +1136,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -1151,6 +1150,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

