Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048497;
	b=Ab7470tMcT+ZFilO0QgvWWDGyfdGCRUKUKmySCynODOEdE5wIFGHHAEm5ZkbAnwbDWL1
	 LuS0mqANueMx6ckGmkB5WH+P7w91IVZXmE06FpXm/4SBdHLZNfbNvL9QA8Mp7Nyec4GAD
	 uxzYTUTnNahGHhZvKp1Gcg/jLKqFRJH4VOJhdxLfhDaJNMuG7FoNQQ0Pi2bHgm3t546Xg
	 /iV/WFz5iRHxtzRH+YOQ3xBMHcq/+zj13DxQRWJFEH7FnzAQK7pkIL7AJOcgfDB/lHHXm
	 Tg9kld5fquMueE8RW3hMZgdXgc3RAl4WDvZ3vVaRZygioSOuwWCTeHY7TPK9Jz8yhLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DxF+bYAPx+PBQNQiT/328bL43SqdQtzMNshuJ4uaFTg=;
	b=jHt9FQfLP77K5X9E4NUegVNP9pgFmL9FXoaD8EkIg5wXwfTFgNUZV6QhigmCy/WUkjdi
	 B1RWtfsq0lHbzL+cFI1npxGIwGIg3U65U+QZbPqZ/2eHPasx6kPwVixcW5hPSo+RGEgAb
	 z2hPzyCAV840B/uzEw408ru1ln6gmzUOXYP1MrO3C9phpJ0HC0P/p9CLXSfQsC2cep8Rr
	 9pKh9na2nIWhmXsdRtHwg8r+Ea+tpsr+rO8Qhoezf2hq1xqfnNcPiY0rw79nvR85Z55+6
	 AIMWNX+m6nyF+r8072t+Q6vuGfk9Nqurk9WjXg9mMHAIfRuXAmRTAIhi+FOtI6/dBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrKTdSsU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F449606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrKTdSsU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25A01F0089F;
	Sat,  7 Nov 2026 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048497;
	bh=DxF+bYAPx+PBQNQiT/328bL43SqdQtzMNshuJ4uaFTg=;
	h=From:To:Cc:Subject:Date;
	b=QrKTdSsUkOwMXQnt9CZVCuLqBOifq6xvCDKBbov9ETDFjhgBabMfscWfVkcixiksl
	 hR2C51uuf77tW9467VoKty79l64LPcxJ7kQcpY2XIMeVst6WQhJqJX9pjqeB9vLhzf
	 Fh2a3y/7aKqvUMYK9b/jjebxmjz53Yxw+/nNG7Tom8O6cqR5XPkGJ5nGMmGr7kQYzM
	 mY8gGfWT1ONax41DwT9b0UxULEpAmTG0L5jGiBFs8voaTjHUqGLeVfs447GlkdTiiQ
	 WNaeaRBqIAWx66BXZvgczwgt2yl146icv4mCp32a51kTcxG0VvSZPc+pmMZXnmS1GR
	 0EfH/OQoldVNA==
From: Sasha Levin <sashal@kernel.org>
To: zhaonanzhe@xiaomi.com,
	chao@kernel.org,
	baohua@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: remove mappedtodisk flag usage in mmap write path" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:15 -0500
Message-ID: <20261107054815-failed-6.1-b3c984358925@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b3c9843589257631bac18f30655e82d88970688a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054815-failed-6.1-b3c984358925@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




