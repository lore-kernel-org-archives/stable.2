Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9894A840F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440809; cv=none; b=V0aLZTPmAfjzPTyetYSl8S4cvE0lvWM32pZpgOPmzgCuhyToBQjLq06RTKRILNQp36jf/wwyNxpMI9XDBUO1oIfgIrp+J5M2o8q9rhWoXkOxjof3EtPExmUZI00VvtW8/I5zxqBnRajL1w/mF/3yc0u/cscVCH1bFRLTQHtO1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440809; c=relaxed/simple;
	bh=h5w3yNN2GB0kEhQEDq2qAZdmHYXSmVPrRdvXl88cbTM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tPYzP4yK+ipfw9iXUYsSolSqrTNuurQN6+vCe7Ps41TZBw7UwPV1jyDpK/ErjW38FXlZ8Me3JV0+P/n8Llb9tFHHIkww7PPcspFSMRH/C+gzdUsnoGqZAlfCGUqw8j1x21VovbJHci8+Zr7as3l9PV8nFmNskMUBU177A5vIoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djAckSfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djAckSfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C61F00A3A;
	Thu,  3 Sep 2026 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440802;
	bh=lkzq9C94JHM3yPFMgLT/B0uFbnNP6bUn3DzvUy7qdLI=;
	h=Subject:To:Cc:From:Date;
	b=djAckSfPd2Tm4ysEL1AQZ+ipk1qkTw76hfO7+dsgCpuMKr4b3BZZ9O37bRmkKsvCT
	 Y8pR98Fzo+ipPu1mqPcy9GWfkIb+IYMXS1WFZghAksvPqVZjLsNvOSlSicZJiMo4TF
	 mCNW5HbMk3YoOeYMbDFoupXbIn5db4Q0HIa2bIOE=
Subject: FAILED: patch "[PATCH] zram: fix out-of-bounds access in writeback_store()" failed to apply to 5.10-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,axboe@kernel.dk,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:01:07 +0200
Message-ID: <2026090307-skeptic-mocha-fa40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 894913e2d35c46ff19a77530907771ae57862b96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090307-skeptic-mocha-fa40@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 894913e2d35c46ff19a77530907771ae57862b96 Mon Sep 17 00:00:00 2001
From: Longlong Xia <xialonglong@kylinos.cn>
Date: Tue, 4 Aug 2026 14:59:18 +0800
Subject: [PATCH] zram: fix out-of-bounds access in writeback_store()

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

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56183c827e1b..2be5c20e3f14 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1235,8 +1235,8 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -1250,6 +1250,9 @@ static ssize_t writeback_store(struct device *dev,
 	if (!zram->backing_dev)
 		return -ENODEV;
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	hi = nr_pages;
+
 	pp_ctl = init_pp_ctl();
 	if (!pp_ctl)
 		return -ENOMEM;

