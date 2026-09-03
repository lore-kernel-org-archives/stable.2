Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE84A385C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440809; cv=none; b=W6keqJrsMGUzu7gPzlJonBfXmrEAWDTHW6mv6vrgCRUnitEe59aBfoKt6JIM2JBb4PVJT+rHvRVJH6C11uU2CZZE05oFUHBsuqonsKfcMBj5LnCPVCUaByCY/XIC8HoyYOdM3SMEePcF8Xyx/WR3mhjhGANQLbWWEW41d8mDOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440809; c=relaxed/simple;
	bh=/EJC4/wyDoojtm4hbqRtAlWucjeMkzKPkTCal6VRSkE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ge66UZ7YPzS4T9oGP3rTV4cgeb4X/5j/Qm3SqfLRLWH1R1jVdiWmF/IpMJyvqzH4IaqihPVsEvOnvWkUhVVZ3oQmILDvcc8Tmuw6bKE81pgHNeWz9FYXixQ12mWaT04HfYEUqb8Sb+JCdCDFco8raCVDJ8KwSdYsz1MogtWXmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQTluSI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQTluSI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6821F00A3F;
	Thu,  3 Sep 2026 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440782;
	bh=9a1ManVvapIdTQfB1zKZqcIjbYFKhivyl43qrxrpH+Y=;
	h=Subject:To:Cc:From:Date;
	b=uQTluSI6UgG1Vd6mOpeAqBlsXuI0RbbiPMuQ3/N3mhVPfm6iw+o0naOgdzTPOAJCD
	 m6gdiDJfvuMhvOUc+uU1AYCCyQRCUyrgXC8fxnnqLZcRa1ABnFRBuZvjue7CGRWmNe
	 uIb5qsrh06dikqsFfkl5TWZc71Jf9OVSEclbaH2M=
Subject: FAILED: patch "[PATCH] zram: fix out-of-bounds access in read_block_state()" failed to apply to 6.6-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,axboe@kernel.dk,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:00:53 +0200
Message-ID: <2026090353-pyramid-reanalyze-9bb9@gregkh>
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
git cherry-pick -x 391f057f44a51cc9418da5cba78b014324174264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-pyramid-reanalyze-9bb9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 391f057f44a51cc9418da5cba78b014324174264 Mon Sep 17 00:00:00 2001
From: Longlong Xia <xialonglong@kylinos.cn>
Date: Tue, 4 Aug 2026 14:59:19 +0800
Subject: [PATCH] zram: fix out-of-bounds access in read_block_state()

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

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2be5c20e3f14..82b78e6e55b2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1543,7 +1543,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -1555,6 +1555,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 

