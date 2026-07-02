Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172593EDE5E
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997775; cv=none; b=RaU4D42yPM3JXXQ8PWK0PGevNc6G4Itp6dyi7m/8aVm6V37JBQlWjNT8tj8IW9VkReGKDQXOQTd7k+u0PKoz34RXaXexN1bJI42CokvJE9N+ZDLzfXLbB+fd6Wlk9pfIkjGkNl3arRwVj/XIyOyqdzAPjt0Oo4hqllnKUZVlQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997775; c=relaxed/simple;
	bh=61l/Po+9brnqkodH34Viq0Dbb3GexMvksQ0sahrz590=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hwRSPW4DG//sCoHyQmLa7i3e1xxXQ6gsNdiPf76w4rqWH+LyIBvWEysaSvdz5M1gY5vgUKLYjSeSfE2WpdRHn8sPafrrDJVCTudsbBk/r5cCE5jzhrX29An+qBLZCsyDzY5V1wlvpUPwuJczcjB5ohAA8iHQ2eZBLcOkvWEYK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUH4igMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUH4igMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355D91F000E9;
	Thu,  2 Jul 2026 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997771;
	bh=OIRINI0942FizP9/qwBbLxSmREz+NdDyamdTLysiV9Y=;
	h=Subject:To:Cc:From:Date;
	b=pUH4igMHKaVig5MXhAcy00pIbG824Bt/W0XC4dH5/GU6pjGP1+1jxzA4BNdmQIclt
	 wOlVV7Cc6i7Y/G8GmKdAOrQMYpyRfZ2I5JzqCs2140n+hMR3EpGUAS7e4c7w7S8sok
	 PCR4pnVeLFp7KsnXQO4oyJk7w/NZJ5h1ON1Gb+XI=
Subject: FAILED: patch "[PATCH] f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode" failed to apply to 6.18-stable tree
To: chao@kernel.org,daehojeong@google.com,jaegeuk@kernel.org,s_min.jeong@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:09:42 +0200
Message-ID: <2026070242-refusing-previous-82e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e0288584baa5dc41df4a829a023c4c1b33fe53d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070242-refusing-previous-82e3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0288584baa5dc41df4a829a023c4c1b33fe53d7 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 21 May 2026 10:15:05 +0800
Subject: [PATCH] f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode

- ioctl(F2FS_IOC_GARBAGE_COLLECT_RANGE)		- shrink
 - f2fs_gc
  - gc_data_segment
   - ra_data_block(cow_inode)
    - mapping = F2FS_I(inode)->atomic_inode->i_mapping
    : f2fs_is_cow_file(cow_inode) is true
						 - f2fs_evict_inode(atomic_inode)
						  - clear_inode_flag(fi->cow_inode, FI_COW_FILE)
						  - F2FS_I(fi->cow_inode)->atomic_inode = NULL
						  ...
						  - truncate_inode_pages_final(atomic_inode)
    - f2fs_grab_cache_folio(mapping)
    : create folio in atomic_inode->mapping
						  - clear_inode(atomic_inode)
						   - BUG_ON(atomic_inode->i_data.nrpages)

We need to add a reference on fi->atomic_inode before using its mapping
field during garbage collection, otherwise, it will cause UAF issue.

Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Cc: Sunmin Jeong <s_min.jeong@samsung.com>
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Fixes: f18d00769336 ("f2fs: use meta inode for GC of COW file")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 99bc59889825..69e0a867219d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1220,8 +1220,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 static int ra_data_block(struct inode *inode, pgoff_t index)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct address_space *mapping = f2fs_is_cow_file(inode) ?
-				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
+	struct inode *atomic_inode = NULL;
 	struct dnode_of_data dn;
 	struct folio *folio, *efolio;
 	struct f2fs_io_info fio = {
@@ -1236,9 +1236,22 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	};
 	int err = 0;
 
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (f2fs_is_cow_file(inode)) {
+		atomic_inode = igrab(F2FS_I(inode)->atomic_inode);
+		if (!atomic_inode) {
+			f2fs_up_read(&F2FS_I(inode)->i_sem);
+			return -EBUSY;
+		}
+		mapping = atomic_inode->i_mapping;
+	}
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	folio = f2fs_grab_cache_folio(mapping, index, true);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out_iput;
+	}
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
 						&dn.data_blkaddr)) {
@@ -1299,11 +1312,16 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
 	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
+	if (atomic_inode)
+		iput(atomic_inode);
 	return 0;
 put_encrypted_page:
 	f2fs_put_page(fio.encrypted_page, true);
 put_folio:
 	f2fs_folio_put(folio, true);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
@@ -1314,8 +1332,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 static int move_data_block(struct inode *inode, block_t bidx,
 				int gc_type, unsigned int segno, int off)
 {
-	struct address_space *mapping = f2fs_is_cow_file(inode) ?
-				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
+	struct inode *atomic_inode = NULL;
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.ino = inode->i_ino,
@@ -1337,10 +1355,23 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				(fio.sbi->gc_mode != GC_URGENT_HIGH) ?
 				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
 
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (f2fs_is_cow_file(inode)) {
+		atomic_inode = igrab(F2FS_I(inode)->atomic_inode);
+		if (!atomic_inode) {
+			f2fs_up_read(&F2FS_I(inode)->i_sem);
+			return -EBUSY;
+		}
+		mapping = atomic_inode->i_mapping;
+	}
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	/* do not read out */
 	folio = f2fs_grab_cache_folio(mapping, bidx, false);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out_iput;
+	}
 
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
 		err = -ENOENT;
@@ -1473,6 +1504,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	folio_unlock(folio);
 	folio_end_dropbehind(folio);
 	folio_put(folio);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1694726122e6..939d75663a40 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -863,10 +863,15 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_abort_atomic_write(inode, true);
 
 	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
-		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
-		F2FS_I(fi->cow_inode)->atomic_inode = NULL;
-		iput(fi->cow_inode);
+		struct inode *cow_inode = fi->cow_inode;
+
+		f2fs_down_write(&F2FS_I(cow_inode)->i_sem);
+		clear_inode_flag(cow_inode, FI_COW_FILE);
+		F2FS_I(cow_inode)->atomic_inode = NULL;
 		fi->cow_inode = NULL;
+		f2fs_up_write(&F2FS_I(cow_inode)->i_sem);
+
+		iput(cow_inode);
 	}
 
 	trace_f2fs_evict_inode(inode);

