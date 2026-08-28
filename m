Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F33C0625;
	Fri, 28 Aug 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897782; cv=none; b=tkAL9vwhAN5euZl1V+RRukMhFrCfZqDQ4GplAcuw+Kcsk1O9ZEukvrbNZ+EiLJkARbCQdwdkoIb062byYOL4aagQzpsV12VVrtZUvmkIyv2XAcO1PxHZifXjdZhxWJqRjfQALmEZhS2FSFyBwi7laVDB3yU/V3/hnsBfMTDTpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897782; c=relaxed/simple;
	bh=ivk4EpjbT7l4wfqHN29nL82xAGXLcKGpJoWO1LAemrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYZeAFTwXv6Cd0eVfq7MTsNHUpvtU4vwOcftKZ40k1qR0o+8HVlqwvO3Aj/dtwHlMYMycyztmMTsJeGO6vBZ2WI4Zn/UZNsw5Nd1M3WVLrDVzPs2Xv2lHmwUP2+TOSh5Jgos49ARdEnWwDhrs1FN8IVJMBHU+Dx9RtuTD1nL28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f7878036a2a711f19a56ed5b684f684d-20260828
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8728223b-14a0-4cc9-bbea-30d92b2ffa2c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1c4637a6193b801e528a8545aa4929ed,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f7878036a2a711f19a56ed5b684f684d-20260828
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 208692169; Fri, 28 Aug 2026 14:16:12 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
Date: Fri, 28 Aug 2026 14:16:07 +0800
Message-Id: <20260828061607.240845-2-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260828061607.240845-1-zenghongling@kylinos.cn>
References: <20260828061607.240845-1-zenghongling@kylinos.cn>
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
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 585ab2145797..df5c9d79ed09 100644
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
-- 
2.25.1

