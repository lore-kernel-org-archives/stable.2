Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E53C2B8F;
	Mon, 31 Aug 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165187; cv=none; b=uMwGLn3aTAcTclGFfkvy3DvRDRGwCPe1/AmoV+3eJDJkQXopexeSRkZ34dXL6T/n9TPIQnJvLEOYVIC7ZIZG61ytYaFbX+ZIRUl4gQ89svMFxX/UMwlt0M37v4+vhq+elPhaRHdV1EfkYjFWCe4DVvqoOo5+wYHU3fm40229CVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165187; c=relaxed/simple;
	bh=nIh5bjO9DOn8o0Ezblesw0ycVq4L1R7Le5AL9py8VmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUuP2SxX89svWpnGfk4xJFsjSmQTNc3NGKE8dyAFvyLFqsnORsLh5jgibOsHOyWuyLQfXF8GX8nFjuG93swJQqqdQbbPk9kioJFUC+4ljSLsw6phH41eihKhmYZM66TPN/DoMlCi81MuUHs1qVeqotbslr6kpcjP1azub0sjINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 910ccc64a51611f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4c413782-d5de-4e69-9490-3b1440934c25,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:8dbfa9f84f2fb54f35e67f86f0f5ffb8,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 910ccc64a51611f19a56ed5b684f684d-20260831
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1995291466; Mon, 31 Aug 2026 16:32:56 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
Date: Mon, 31 Aug 2026 16:32:52 +0800
Message-Id: <20260831083252.80732-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
mapping->invalidate_lock, so a concurrent truncate or fallocate can be
in the middle of invalidating pagecache and rewriting the runlist while
the write fault maps blocks and dirties the folio.  This races with
ntfs_attr_fallocate(), which merges clusters into the in-memory
runlist, drops the runlist lock, and only afterwards zeroes the newly
allocated clusters on disk; and with the punch-hole/insert/collapse
paths that free clusters after truncating the cache.

Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure
there are no truncate/invalidate races, "usually mapping->invalidate_lock
is suitable for proper serialization".  xfs takes its mmaplock (= the
invalidate_lock rwsem) shared in exactly this path.

Take invalidate_lock shared around iomap_page_mkwrite().  The read-only
fault path is already covered because filemap_fault() itself grabs
invalidate_lock shared on instantiation/read paths; only page_mkwrite
was bypassing it in this driver.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v2:
 -Move truncate_pagecache() and pagecache_isize_extended() inside the
 invalidate_lock hold range in ntfs_fallocate(), per review comment
---
 fs/ntfs/file.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 585ab2145797..8164326b7812 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -676,6 +676,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
 	vm_fault_t ret;
 
 	if (NInoWofCompressed(NTFS_I(inode)))
@@ -684,7 +685,14 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
+	/*
+	 * Serialize against truncate/fallocate which hold the lock
+	 * exclusively while invalidating pagecache and changing extents.
+	 */
+	filemap_invalidate_lock_shared(mapping);
 	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(mapping);
+
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
@@ -1185,13 +1193,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
+	if (!err && mode == 0 && NInoNonResident(ni) &&
+	    offset > old_size) {
+		truncate_pagecache(vi, old_size);
+		pagecache_isize_extended(vi, old_size, offset);
+	}
+
 	filemap_invalidate_unlock(vi->i_mapping);
+
 	if (!err) {
-		if (mode == 0 && NInoNonResident(ni) &&
-		    offset > old_size) {
-			truncate_pagecache(vi, old_size);
-			pagecache_isize_extended(vi, old_size, offset);
-		}
 		NInoSetFileNameDirty(ni);
 		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
 		mark_inode_dirty(vi);
-- 
2.25.1

