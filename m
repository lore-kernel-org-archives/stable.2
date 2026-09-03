Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB014A64ED
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440790; cv=none; b=gmodrZrF1pX6lWSyn52VAhFsnnWVHdEzgGsVNTHr47vmEcrEP+ED+X2jgq/S5jT4JQ9YWStdTAKGk/yh9Q72UmcK6qyYePdU6qc7Mcn1/3L/0ol+B+QgDii6H4PeC+Qe6O/HQgzQ5ETBjPLiWAHrsOiWmsGxhiynAUFnonFSwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440790; c=relaxed/simple;
	bh=fMZsdeRpKuGTlcyrA/pS8GhDmJDOARdfucnCJwRo3sc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DzZaUXuxBP/ufXXS/lCC7x5bHkaVkCjpwZmn5IXPEgz7GDh4zTZR+1+DvOWvk2CLVi2rQZwkWQ+BWZMDisIJOsovm9or6B2nXdEB03s0GfiArPeYN+mUG6gN+/HZe5Y0jQMEc0khNP+j9Hi/OtBExyM52jo5zdu9vulc08NyhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRvXRE+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRvXRE+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D31F00A3E;
	Thu,  3 Sep 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440773;
	bh=pl7GHc2FYFwDoKuxDrmiuU9khJADcSoImmKKt5MLEhM=;
	h=Subject:To:Cc:From:Date;
	b=hRvXRE+kO/7x+1GLOFU+hyLia/XoWCV8+KsWp3+LLZ/pWUr+24hSh2j1EncOBxbB9
	 U/EHXkrczgfUmyCjnjBiWrmpnDOSegD39mX9HTvK9yFcilIV3sjeprffq99JJZb+jA
	 OnpJoXx5snz/Bk7u7IZbAdYAMItXVk7eM3f6Bjgo=
Subject: FAILED: patch "[PATCH] zram: fix out-of-bounds access in read_block_state()" failed to apply to 6.12-stable tree
To: xialonglong@kylinos.cn,akpm@linux-foundation.org,axboe@kernel.dk,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:00:52 +0200
Message-ID: <2026090352-unmixable-girdle-2b82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 391f057f44a51cc9418da5cba78b014324174264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-unmixable-girdle-2b82@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

