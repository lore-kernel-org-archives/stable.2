Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A242472A6
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791691392; cv=none; b=Df37kylX2Jfd3TrfTwTaI+RJb9MzdRC6kzwjdKXnHzMuN8nr2OkxWpg+E5RJ+LZlWT0w0L9KJtZXGcSouK0MDd09cqpX6d4/doKY68jTziXIHQ60LNIrdqaAjRkENuUMSMy5ZHkgghePa5PxQq4bySPyispyx0v/bV9o2KWSpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791691392; c=relaxed/simple;
	bh=92bn38WSBxROjiO2VDo/EHAooEFSNkgafI+zVeLorqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqUjLeKBUjKv1z/Ov7jj/qjpVknZUwYLI270eaQrwmQ+Xy92gGrYyxHMqDhjnARkZeZjDuNFZI13K1Hez/JQNJMnUISr+xXGzCAQ1tW0MTt0NkjyIfAEYcaTZYOPnvs9JTYEl/iGSmv6gcRhdrblM+qlmFC904EU1VaFateftIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TlLiVAye; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TlLiVAye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=By
	IMgzHlHKSnpusTEI/Blb9NGNki/9e4oGULv6zhbck=; b=TlLiVAye1NuuDobsxZ
	E9LRM3BYUSiOZ63E9cmNbPaXJPzlxS1QYuTx1cPt0C8ENqQRPBlAimN9IgG6nB11
	hc9nsLUgQVgrHNMQLcnfTJPXJVWV9NfSIfOEt+Yzg8Ch63L6xn2Wq6PnYNue7NbY
	2ROhRTWejUK/I3sWQC6ZhR9h8=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgAXzutYCstqTqVQBQ--.42864S2;
	Sun, 11 Oct 2026 12:02:33 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Sun, 11 Oct 2026 12:02:32 +0800
Message-ID: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgAXzutYCstqTqVQBQ--.42864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4kCFyxXF47JryDAw4fKrg_yoW5Jr1kpF
	9xuF1xG395Ww1UWrsrG3Z8ur1rt3sxuw4xWFs7uw1fXa17ZrnYkF1fta4rZF1UKr93JFWI
	qr4jkryrXa1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_9N-UUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohkm9WrLClnnPAAA3B

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip marking the folio dirty.  Chao Yu
pointed out that this is not only a cleanup: it causes the following
race condition with filesystem freezing:

 CPU0 (write fault)     CPU1 (freeze_super)
 ----                   ----
 f2fs_vm_page_mkwrite()
 sb_start_pagefault()
 /* shortcut: no dirty */
 sb_end_pagefault()

                        sb_wait_write(SB_FREEZE_PAGEFAULT)
                        /* no waiter, passes */
                        sync_filesystem()
                        /* folio not dirty, skipped */

 finish_fault()
 /* PTE writable */
 fault_dirty_shared_page()
 folio_mark_dirty()
 /* dirty folio on a frozen fs */

It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
folio zeroing.

Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
f2fs_read_single_page().

Reported-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22c..35d9ddaf78f4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2260,7 +2260,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..2d763e156d06 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,12 +217,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
-- 
2.43.0

