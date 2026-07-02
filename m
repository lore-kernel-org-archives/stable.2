Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8743E4A6
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997854; cv=none; b=km28CSo6celSYY2NUkxNJLwv8ntrPTvrwhKjCfzaIv+uhovajg/FO76chemY4qanVaDOwvWa5v6DFUMYBQiGFDT+FYjRhng116dC/sdkajUFdca/u3c1gz0qH4qDUpyAmr4ug7F749vTIsIN+kXWEZ7sgf4FRgNbtHhgcSUZros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997854; c=relaxed/simple;
	bh=/pAirxcpS41wN7PxNJeastI2r/Fq2Bn0wHTDwfXKCeU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I1suNuee9hCCWQibj70wSUXW31IXrktdd6UA8WcWUOvdD8sE9bbMFaPYGHuLmfHIJAB7CNR/cXvAHhJU5o8IJ11fqdZWOQJ8NKh4NwjXkIFQY41TY1K+UoNmEKwSvNDpSdr2sH8yWg6YiwYL0N2lwDGTLN9lVCVcVMlXdMPgy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kl8VSYd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kl8VSYd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05691F000E9;
	Thu,  2 Jul 2026 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997853;
	bh=kpxdthhZelc5kRw4mwaaiMhj7ZQlsBngnmxIAUviNk4=;
	h=Subject:To:Cc:From:Date;
	b=kl8VSYd2wVmsQSA+IUcGJc2iR5topoJ8hs2NoT6+RMPeqqWz7G26JLbk0WQQkcqhi
	 ozlg62u9+bx3+xmS8ABSq8NMa/luOdF0VZ04b4EwrtayxEoG+nhFhzzUfuPZfB5kSI
	 TLexnZmJMFtN/jHxfKJ4ffafWdFtKnDjjaSRU53Y=
Subject: FAILED: patch "[PATCH] f2fs: keep atomic write retry from zeroing original data" failed to apply to 6.1-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:11:03 +0200
Message-ID: <2026070203-junior-occupancy-679e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6d874b65aadce56ac78f76129dbcfc2599b638f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070203-junior-occupancy-679e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d874b65aadce56ac78f76129dbcfc2599b638f8 Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Wed, 27 May 2026 20:06:28 +0800
Subject: [PATCH] f2fs: keep atomic write retry from zeroing original data

A partial atomic write reserves a block in the COW inode before reading the
original data page for the untouched bytes in that page.

If that read fails, write_begin returns an error but leaves the COW inode
entry as NEW_ADDR. A retry of the same partial write then finds the COW
entry, treats it as existing COW data, and f2fs_write_begin() zeroes the
whole folio because blkaddr is NEW_ADDR.

If the retry is committed, the bytes outside the retried write range are
committed as zeroes instead of preserving the original file contents.

Only use the COW inode as the read source when it already has a real data
block. If the COW entry is still NEW_ADDR, treat it as a reservation to
reuse: keep reading the old data from the original inode and avoid
reserving or accounting the same atomic block again.

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..edda2ff72073 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3862,6 +3862,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
+	bool cow_has_reserved_block = false;
 
 	/* If pos is beyond the end of file, reserve a new block in COW inode */
 	if ((pos & PAGE_MASK) >= i_size_read(inode))
@@ -3871,9 +3872,11 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	err = __find_data_block(cow_inode, index, blk_addr);
 	if (err) {
 		return err;
-	} else if (*blk_addr != NULL_ADDR) {
+	} else if (__is_valid_data_blkaddr(*blk_addr)) {
 		*use_cow = true;
 		return 0;
+	} else if (*blk_addr == NEW_ADDR) {
+		cow_has_reserved_block = true;
 	}
 
 	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
@@ -3886,10 +3889,13 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 
 reserve_block:
 	/* Finally, we should reserve a new block in COW inode for the update */
-	err = __reserve_data_block(cow_inode, index, blk_addr, node_changed);
-	if (err)
-		return err;
-	inc_atomic_write_cnt(inode);
+	if (!cow_has_reserved_block) {
+		err = __reserve_data_block(cow_inode, index, blk_addr,
+					   node_changed);
+		if (err)
+			return err;
+		inc_atomic_write_cnt(inode);
+	}
 
 	if (ori_blk_addr != NULL_ADDR)
 		*blk_addr = ori_blk_addr;

