Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CB4A9D78
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440796; cv=none; b=E9EbQsnNp2PVczZ1XmvctGBOV6wOmHE8Jvv6OZ0BddRUDyuFXqQWFWTPUvm/pl+GKf+gcp5mM34bSiP9aWtz40u8s2JBMvOYJJv+DKXVKvQYUt3UwNsbPjshG/wUx0f6N9iYS+GqI6QhWC3qaqLhTzrJgeDrkYNeGmyrKBXnemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440796; c=relaxed/simple;
	bh=jQyx0otWkoH8l4gCprykpfms1OVRd0dsVK74NWhMJjo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PBzVBoNWlwkICZAtBnm+d5Ecd7X67r6AKkDirHSfxGRk6e7i9Ews0hJpeeXHuFCSCUQl6e3/0/Lz45N8agBCtXi1duPafRn6VSlt77Wit8LVDQGSC52HPQ6YbhiYHJ7Qp8Aqz6FtPYxdEaqu24rvW92doSovoXIge4UxlfLLDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AbShXSTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbShXSTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C81F00AC4;
	Thu,  3 Sep 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440788;
	bh=h9NMa+vNnYn7VMXLtmMpj/iFf9Rde7w994AVGGxh57o=;
	h=Subject:To:Cc:From:Date;
	b=AbShXSTKPV1rOHtoQgPQ/DLwELpMtxrp8N45hukWPzR6Nlpd0+pGd32/0TiO6UFKT
	 5AvgIKjfvr9pKyDzAqnV/KtF8eYDrQlKDka0nzjPSDZZsnlWHopOGRgmS1xDmvTvHf
	 5e026kd/+EY6dFvzQBkCYeSsDrJl5JxSriJ3zUoo=
Subject: FAILED: patch "[PATCH] zram: fix out-of-bounds access in read_block_state()" failed to apply to 5.15-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,axboe@kernel.dk,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:00:54 +0200
Message-ID: <2026090354-deafening-decorated-22e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 391f057f44a51cc9418da5cba78b014324174264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090354-deafening-decorated-22e7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

