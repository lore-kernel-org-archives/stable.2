Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413063DA7FB;
	Mon, 31 Aug 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165031; cv=none; b=TOIYtLusj968NnM+pj26rQcwRmlK1t3LiW5dDdqvDp8CZQTPhzCXNTUHus7l63ZdLEziIgIpFtdgFeMEyupuJDQPQRror/BcVqKvxW1Qabv0fwOP7SwbTcn1SQ4rmErJ3k78oX5iQzXP6fS3SSn2/QXPPY1uhCoITAhg658aSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165031; c=relaxed/simple;
	bh=Cs/FtVOHd4Hy/bH3NtIPuFxWw9rytXuKP7JMV4qPfvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cW2WsbAWOk7V2B86Ap+4ZyELlqET0AkXjDK/fQPWQxqqvDGgdd8lZ40oSdUpm862ewMCc+K0U1GZKoNz66DcbUaAgF76Daxf2OObNbHHrQHVHa/klWpbyIwwYjrndre/cqw67LFhG2GJR3+HUCXUtYzWTM6WdRBdmGVD1W6GApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 347101aaa51611f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:11aa1790-5758-460d-bb13-c487a77e9fe2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:0512239b95e893dfc728865e2659f886,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 347101aaa51611f19a56ed5b684f684d-20260831
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1675361273; Mon, 31 Aug 2026 16:30:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
Date: Mon, 31 Aug 2026 16:30:15 +0800
Message-Id: <20260831083015.80396-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831083015.80396-1-zenghongling@kylinos.cn>
References: <20260831083015.80396-1-zenghongling@kylinos.cn>
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
Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Change in v1:
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

