Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1FA4EE872
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537393; cv=none; b=K5kqLGgSj7HhJHcLkNW9b5nmM6GPyh0gj7vSsJWXlDSTlfeXxmfhB344n1gRc+wHiwMnTLPs/EjQdj9PHTFteqk4ehjbi5o7yOseLF2D4zcPmG13udjqUqhGXkKAD7+0D5Ko9FYrtsIJ9t95Zffye/Khc6uhgSYC5bhdS0mCno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537393; c=relaxed/simple;
	bh=+kjV75Hdw7xdVw8wNajSXGH9UiBVJnxKgtz4TpScMiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPCm5M86CkoULNq1whuS4V+A9RhmsWaiwRpOp4vvTgwg7RJDClWLfAxMlht0/1wjg1m4nAi1RXnBhxqNOoAiBR+KW1mNF3dolfatiLPcOgmgLmwmITDkaRR1CL39OGf+CYev198XpJzK+uVKng0frC7tM0sl+HlgDRXPOIifWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awKEwnOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awKEwnOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5F11F00A3D;
	Fri,  4 Sep 2026 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537386;
	bh=KJoeSKRDrcJCUaw+U1Olvl5kDK1LdFcv4hqgLeEwxLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=awKEwnOVHe8kPcTaqvD37Fbcn5euUujv64HdKr5RvsziYW8406hhkF/114XkJQ6g4
	 5Z6AlGILtWpM5k7SB+Wehia638dRbvEG3u2IZpEH0MMktfYtk5nHGR8tXXG0voU5cp
	 OMLMQ9dJDA6fAbxK7TBEh640lkqsSVvld5+ggsS9+zevbHhVHmlC9/65VFsrlMZ3fj
	 CM3XIPSv260bT80unLSeVsxV5kYoYZkn8LxKIiK/JepwxtbTXQuFHJOjPeyZMa2W9f
	 6A/bV87Z2JXElbohMUo6f3TWh+bg/5kIh/IOxiFdcM7SJKE0dwmMTh4sAW1kHQ9xNA
	 E1MWOMDge2gCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] zram: fix out-of-bounds access in writeback_store()
Date: Fri,  4 Sep 2026 11:56:23 -0400
Message-ID: <20260904155624.1062954-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-strategy-zoning-2279@gregkh>
References: <2026090304-strategy-zoning-2279@gregkh>
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
[ adapted dev_lock protection to the older init_lock and pp_in_progress locking scheme ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f51dd33784291..f9e469cee927f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -946,8 +946,8 @@ static ssize_t writeback_store(struct device *dev,
 			       const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long lo = 0, hi = nr_pages;
+	u64 nr_pages;
+	unsigned long lo = 0, hi;
 	struct zram_pp_ctl *ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
@@ -970,6 +970,9 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	hi = nr_pages;
+
 	ctl = init_pp_ctl();
 	if (!ctl) {
 		ret = -ENOMEM;
-- 
2.53.0

