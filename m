Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050550;
	b=dxqqUk5+yOpyGYeA53jSMrWntOuS/ViQcrypBZKQNCVnLPtvFPm7G73g3pPKJMEmiYSg
	 4oNmnkDA1rm4vLcF3P2w/sBZ/uspdEK7JUoiW4LAt5xUkJoZ7X3xh7GGrTv5eF1DVrfM0
	 AJ0YAVY1TU2BcE5dW9JRAb+aCIoEkU8MLRo0fR2hlSvf8b31VRtJeBllceZEpH4/sxgCe
	 LesDyaZuzh1U8QWOU9ZStzds10owY9DlkiruojJr1Gnw7CUYumPYfYmXlVxmLOe9Ya8NZ
	 lifdF9PNOrbvvNipaOw0Wv4Z/oJlYOwcLp3cB9uWurOCMqyU785bpQXodXR2v7gdTRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6pJjbSTcq5tVPB42mGO/EyU4kOzknL9STzHSxkjA84U=;
	b=UaY34Jw749cjySW5s5nAobuuGtlg0VqyqmwggAyDguVObM2E8xAxnYMBHS0TYC3XxPL1
	 3omCO3tWBvrwkAlZIeITFerdKn5CjCekURW6eVb1rDCQKDpDygOTNNyMXNQe2Mp2Rtq/K
	 ioDi8rjtzyvfpl5V3/yBpiXz1EoX+zDcIRzGBcba/CAgTIkAMybXqoF7PePUBG+qO/ebZ
	 qTx6mw93ewDw7NZKUwACIk+Ush+E89QqGD8NkDatsUUCcDed5KYfKTXt1CNuKPbN8WJxo
	 MeU80m3ofjlxFtCgmXskIqunl17gDxMG4qijRrIgWuCNRrnpfgejG5VQZCebYPSzmfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGhy0c0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGhy0c0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E9E1F0089F;
	Sat,  7 Nov 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050549;
	bh=6pJjbSTcq5tVPB42mGO/EyU4kOzknL9STzHSxkjA84U=;
	h=From:To:Cc:Subject:Date;
	b=VGhy0c0yvNP4cKPzo8W66N58KdHEKBq20v25OGAOrzwuSWpo5LFS6UCJ9gXWnE7KM
	 uLL5tT/ygtdQ5S0H7SdnCCAdZL202aPXtEpNAqvYl2JAPZBLh/cihyvvCF3wWXjgU3
	 rHvHTzjEO++SdZlrNcWNUeUHcc3f41iimaXvK4hKYN9gHoYsJ/NtRESfbkppsiPYOm
	 49UNBSOCpxLOzcPd2vfsvR0jJfdOZvPP/xoVys9tN3CFeN3zAXGxvq1ay7Fctnwcly
	 vUId3gAZ/SnI+WnG+DQbK7CKuMeFEojMPhQZFrX5gR2PECIoouCeyr/wLkOu0G2s9K
	 1qzYmMlcq+7oQ==
From: Sasha Levin <sashal@kernel.org>
To: zhaonanzhe@xiaomi.com,
	chao@kernel.org,
	baohua@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: remove mappedtodisk flag usage in mmap write path" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:27 -0500
Message-ID: <20261107062227-failed-5.10-b3c984358925@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b3c9843589257631bac18f30655e82d88970688a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062227-failed-5.10-b3c984358925@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b3c9843589257631bac18f30655e82d88970688a Mon Sep 17 00:00:00 2001
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Date: Mon, 12 Oct 2026 11:03:15 +0800
Subject: [PATCH] f2fs: remove mappedtodisk flag usage in mmap write path

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2613e8821af6d..348ddc8b748c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2494,7 +2494,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694bd..4363e28056e6b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -218,12 +218,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via generic cache */
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
2.53.0




