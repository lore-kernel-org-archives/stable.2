Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6551FCD9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547798; cv=none; b=Zk01EOqjPW+5i2f7/st78QuwMntD4780tqemznElflvD2PLLPkOnkmoM0jVEbWzSO7YJ646cd5EsjX7JMxDMoWf/PGHHvPtwy02GMxKk2iViZyBkgGjngvcm6LYbFH0UU8xSMQsKg1ZI9CJjlnudSqG8yZdPqeNeEa0JsX2JlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547798; c=relaxed/simple;
	bh=9AwPypf/qpKfs1npw7BWvlw9eJSG08DYVRljxEUd7P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q51hnM5XWZoqRkSExRz6DrI4y61zsXjYSwe741qXgHi72uQt46FKn197ZySPImKn3CZa+fk1jnYWH2S4JMcI/6tm8qtrnGwwHXCwe+9/oITk/j0qzGLP0U2hdTVe2+Ke41SjrGQzCBkY2to2Azut61aJSt4CoNr/c/neAVgbhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5W6jMvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5W6jMvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768431F00A3E;
	Fri,  4 Sep 2026 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547795;
	bh=sm57zttihAPHKpcZPPWFK9kt4VucyYo4V81/MnH7flk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T5W6jMvAslwEKL4hvwCXpLZiGDS3t3vqCEcYaf6v4TUc/KA+55VJckwg8/gI2oNha
	 g6Laeqe1pi+GqXTLnKCcsQhYu8OYk1kG0OJHK1Jx0mY3XqhPImiOhWRrhwx5oQdKT5
	 yHLqJm5JL71NNCeKir4ZBYci6ngxsi/pQuJiTiFArOFw+R5lvjMPsrBNvqsl53ojWX
	 YH9Qs1cWORqxHDbhz7xabmSSyAg35/4a3LuMf/v+WQS0QfXXPbIH5SwjjXbENCWKhO
	 S47e64ZvIRH8Y1I09h3wWjb9DapZSPEf/EJq7B77oi6ymXqZRo/YKLbjLdjPbMlmIk
	 ffJZlXs30Hs/w==
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
Subject: [PATCH 5.10.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 14:49:51 -0400
Message-ID: <20260904184952.1353914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-barricade-goatskin-e135@gregkh>
References: <2026090354-barricade-goatskin-e135@gregkh>
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
index 16db4fae51456..ac5965ee64b2c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -883,7 +883,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -898,6 +897,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

