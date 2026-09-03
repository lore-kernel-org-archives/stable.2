Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7A4A8FEA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440800; cv=none; b=Ob1EJ7XEaJY4aFlMU5WUD1+QI9ADO75FTKodleibcJWeCXZ+pEV/eNZdC3uzblHhJ3YQmMKr9WOslMmbGrW39XCCyhbdX0PFUZw8DA0B3wXNnVxQnFScRO5B3mnNaOaWEaj3OztEhldXIKz3lTLfqoojqP33+n64tBP8L0A8xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440800; c=relaxed/simple;
	bh=y7FoP7qwCJhbcLnxkZsYDFTOLOQpyv8HE0e84Adca6w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W3PQgpuPClfqJXgCER2izQr0WV+J/v4qiNygJCVBvJDOe4l8UoCpiow2XeMpn5sZsK9jEJrkVTej+9IGcJnUZmiZougGjm9t3z2lBrQfjPLZE+hDQe6eNuHqaMsWhqcCz0ytBQ/7MwwZuTUUh3Cu1/cW1S7MTpvoqdX4epsVLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vcZvCYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2vcZvCYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBB91F00A3A;
	Thu,  3 Sep 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440793;
	bh=gLFROfpvzpsPVlq3tAOUpadCc7XaLieOddyYcd3wB7w=;
	h=Subject:To:Cc:From:Date;
	b=2vcZvCYeTJdy1GYnp8pew3DJz9uLl84bTa9eivy2SRgO1ssLj48gobiYQeKMY6e7q
	 uci1ruw0VbkywFHmi0blqq/kItUnWtxePsQ1CmiDYgfAlWbWKvwQJl7Z0K9zCdMSJk
	 uYyRFqHtG2wcxZ6YftJ7p5/0nW7yJuEoBJ4/FjQU=
Subject: FAILED: patch "[PATCH] zram: fix out-of-bounds access in writeback_store()" failed to apply to 6.6-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,axboe@kernel.dk,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:01:05 +0200
Message-ID: <2026090305-dimly-backboned-037d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 894913e2d35c46ff19a77530907771ae57862b96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-dimly-backboned-037d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

