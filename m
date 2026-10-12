Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9F9463
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774249; cv=none; b=epFTB4/RXp62mVGfoH97KGkITcR5KopHsQacU1Jh14/Phdj2foVQJvLgUM3WJCZ2OkdUHwPZfMRguIxUGk/MusJqZI4TyVNkyVKlRnbBYoD0tunt7kMl2OUOGcKpTCXl8c1blg7LbQFasBimX3227kOKkI2oJF2F41hzyBzetv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774249; c=relaxed/simple;
	bh=fsa81yZxZgd0024s9ensYNWnpb0O0We5ciygmngwkeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dr7o7l/YCltpYHnChJqAm/GjuAA9EOF7ZJyJbuStZhExOFVczhdSFQjNjm34H1Stuf2ZPC1U0lFGLTIqJcznx4XwUtIz+butEnW7PASQTqCigruVXbxOlVNMcqB0xEBJKF8WJPyafxU5C6vbyQtAc/x7w8EtWGHl1G3moePMTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QtV013Wh; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QtV013Wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=x3
	DPsizR66wJCaQJx0+u3kmJi3wdWuq2hudqePkWk8w=; b=QtV013WhTMJuxkTFHx
	qRqdZkEIoa/7jkR2nQn+YSkAwyMI99e165lJNYOIxK4sgLsfgKBj39XZoNyPh5jz
	STNZ8lo2S3P2ocaeaHoUA8Ih4CXQOi3yHnX+auUTKYxYrOHzkxzm8v0YO5DgQbHo
	oPu5BgOJtavW+dEzPr28GP1rg=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3N_oGTsxq8KSUAw--.15003S2;
	Mon, 12 Oct 2026 11:03:35 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Mon, 12 Oct 2026 11:03:15 +0800
Message-ID: <20261012030315.978375-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N_oGTsxq8KSUAw--.15003S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyfCF4rGw43tF4UZF1fJFb_yoW5Gr1kpF
	9xCF4xGrZ5Ww1UWwsrG3ZxZFyrt3sxuw4xWF4kZw1fXa17ZrnYkF1Iqa4rZF1Utr93JFWI
	qr4jkry0qa1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_9N-UUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAdiMmrMTgdgHwAA33

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip marking the folio dirty.  Moreover,
it causes the following race condition with filesystem freezing:

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
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

Changes in v3:
- reword the commit message per review (no code change)

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

