Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674823;
	b=sy93ZwALNTyyBex4Wm81dkA6x/7eaFDb9CNCTJCtU4/6gRzGp/hEPlN3EkMkNlz0GV4r
	 V0MZz86vGqg/XfUZz72ko9vKbp8OYDchZEEAeuiOSM707g9B88fff400TeMV3HVdMhcXA
	 XHJkhG+IiKif2t6XnJ4xgirYmmUBXWPJG2uAaTysWt8bkD4yWYw3hcJLYMVUBlYWT+DYb
	 BeE66dpbOqsbfZZQdxp2itre40SaUY9YE/puajACLXbPhuGrQkN1W4HV/tmm/nARqsZFc
	 MyDAmbGWssowrjmMdgK/Se1BPonzicMRxLB1eyaYi1j4vD4yif+5QPffcgb5fcvcfDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674823;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eFYf5wp/cjB3/C7hIN2/gqghITRTz5C5bAIi9JZnEPo=;
	b=QcyVhtZn8UJs7ZNZLkUKb2nYQx+lL2286d1+P7m2cW0BCfogKnxHXiQGqbUYyzRQdc6g
	 e+i8e+JgQy4a9G09oWXQivvYvOF53CUCVPGcHGpUWSdmwYpRIeFis9XIyqhIOxTDhkaZs
	 MvsZF4ii2ddwBGO7FfRZzdMvAa6x3WZ9WtWlPqQ9Zdjw5O3hn7S/518b2byW3NXwcCFD9
	 tdTQsIIxAWgaKQG/Noh1pIfo/9C6BBu/d0wABo6H1fsGGRSxdP3GVm+UxYdIs77hm/j59
	 Z6KP+8/NFlGtZlVNrIiJTuYYIhimu6aX7nvGpWssAai3XmI062Bj5IaoQyLFCNvRSfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PJepMfuo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55872606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PJepMfuo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7351C1F000C1;
	Thu, 22 Oct 2026 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674823;
	bh=eFYf5wp/cjB3/C7hIN2/gqghITRTz5C5bAIi9JZnEPo=;
	h=Subject:To:Cc:From:Date;
	b=PJepMfuo1iGRn16u/zRBvEZstTciENKyvfMortpVonndEMHe0BP2RoZ66Vz4zp/pX
	 yGlug8yhZCzyo3pqYBx4W9uDN1Sl+GJe5r+17v9FvdUjjq78Q+STUHEk3UGrrmfAdR
	 zXwRSBGtbTXAmqpuPV0mqf2OmxcymX8Wa+/hUJAY=
Subject: FAILED: patch "[PATCH] ntfs: fix race between fallocate and mmap reads" failed to apply to 7.2-stable tree
To: zenghongling@kylinos.cn,hyc.lee@gmail.com,linkinjeon@kernel.org,liubaolin@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:12:37 +0200
Message-ID: <2026102237-durably-dimmed-c122@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 67aded1da114dc44808315f249bd9e7e440f799d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102237-durably-dimmed-c122@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67aded1da114dc44808315f249bd9e7e440f799d Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Thu, 27 Aug 2026 13:58:44 +0800
Subject: [PATCH] ntfs: fix race between fallocate and mmap reads

The fallocate implementation only takes invalidate_lock for punch hole,
collapse range, and insert range operations. For standard allocation modes
(mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.

During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
creates a window where concurrent mmap page faults can read uninitialized
disk data.

Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
it can fault in pages during this window and expose old disk contents to
userspace. This is an information leak and data integrity issue.

Fix by taking invalidate_lock for all fallocate operations, not just for
punch/collapse/insert modes. This prevents concurrent page faults from
accessing unzeroed clusters during the allocation window.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 88747217ba61..1969e4f444f7 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1116,7 +1116,6 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct ntfs_volume *vol = ni->vol;
 	int err = 0;
 	loff_t old_size;
-	bool map_locked = false;
 
 	if (mode & ~(NTFS_FALLOC_FL_SUPPORTED))
 		return -EOPNOTSUPP;
@@ -1148,16 +1147,13 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	inode_lock(vi);
 	if (NInoCompressed(ni) || NInoEncrypted(ni) || NInoWofCompressed(ni)) {
-		err = -EOPNOTSUPP;
-		goto out;
+		inode_unlock(vi);
+		return -EOPNOTSUPP;
 	}
 
 	inode_dio_wait(vi);
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-		    FALLOC_FL_INSERT_RANGE)) {
-		filemap_invalidate_lock(vi->i_mapping);
-		map_locked = true;
-	}
+	/* Take invalidate_lock for all fallocate operations to prevent races */
+	filemap_invalidate_lock(vi->i_mapping);
 
 	switch (mode & FALLOC_FL_MODE_MASK) {
 	case FALLOC_FL_ALLOCATE_RANGE:
@@ -1182,8 +1178,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
-	if (map_locked)
-		filemap_invalidate_unlock(vi->i_mapping);
+	filemap_invalidate_unlock(vi->i_mapping);
 	if (!err) {
 		if (mode == 0 && NInoNonResident(ni) &&
 		    offset > old_size) {

