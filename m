Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36253ED16
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954177; cv=none; b=Q6YUuKzFzrtY/6RvVlkOJt/8q+wC4EAi97cceRF4P8mew8Z+h4iJTLKlvfuCwTHTIiDI0J6ln3qfDT8lB+R2B6SnTYFeJbb/DuH9fSmdkKyCYxeGcfNi+AQe6DJM2+76BcZ2vBB4y+Q3acC5CFburBOZIdC8R0rYUCyoqQobS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954177; c=relaxed/simple;
	bh=yUYHm5grZQ4DvhLs+zdEnE0WIGZd3rf/QuX8k+26/pw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OZN0RNKFMBdfiiODGRhpSjynDV5HImI+8omu5cuuy85j9CkKu09I9uYoG5W90ggVVcKISC+vTmTQxpqTxjbqcTQKgHtDXJaTkIH223BCHSMyNainVOq8aYYc6BRmwyMdWXfKAl/xVc5cdN5ZJOz8yD0JJjDGih1SzaYCnhxmWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ncNLZfI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ncNLZfI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2324C1F00A3E;
	Wed,  9 Sep 2026 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954176;
	bh=IF1lAMTQ6STQGZSMFQRrgn9K/95QKva9c5rXSmbk+nA=;
	h=Subject:To:Cc:From:Date;
	b=ncNLZfI1BgM0J6WoHkK+nBsJNQ5grIr1o3sX1TUUQDCDLVaHhZmdg97uZy4i/mepo
	 H3f5zZh3M3BhDBQXCrHePCg8sXlBCExic5FIGslBWDG82tYzg+Po5fsrYkNABFgJ1v
	 JeY4uh8Tp4xudUGlE6DYp8WGvsrk6cphsh5JcNc4=
Subject: FAILED: patch "[PATCH] f2fs: return writeback error from collapse range" failed to apply to 5.10-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:25:21 +0200
Message-ID: <2026090921-luncheon-anywhere-f22e@gregkh>
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
git cherry-pick -x f8a4108800254d6f7b2755515fbbd9d0caac561e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090921-luncheon-anywhere-f22e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8a4108800254d6f7b2755515fbbd9d0caac561e Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 27 Jul 2026 15:49:10 +0800
Subject: [PATCH] f2fs: return writeback error from collapse range

f2fs_collapse_range() writes back pages moved by f2fs_do_collapse(),
but ignores the return value. If writeback fails, the ioctl can still
truncate page cache, shrink blocks, and report success.

Return the error before truncating page cache or updating the file size.

Fixes: b4ace3370324 ("f2fs: support FALLOC_FL_COLLAPSE_RANGE")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2773c6ce7ec1..c19f0de271a9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1623,11 +1623,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(inode->i_mapping);
-	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	if (ret)
+		goto out_unlock;
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
+out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);

