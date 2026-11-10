Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331099;
	b=Sw1rNYkzTbP7BYBYuxDa6LULU+fiLYClRKnvLOxJyD1gMwJzWBDsSHz7DsE5s4iKG5DN
	 S553xkB6dtgViLZsT/wfAcMb9KlRD1+HwjtJ0e6bCu42AKTMi8O7nP1GJS8bygS/KNq3z
	 ny9IqxatJzczdQkZKy3P45bCQxE76dwh/YP5Nr+Jv5HABCoFSrkCb+T8Ob/1FsMwShA9c
	 M2CzR2cuXa53AYpiZ5d4O9wdinSwmaMGdV6Kt0q8c/P4iN/k0iEuL++S/AamnuUYaH2iv
	 MG/F9b7XSXnxt3l1G6wBBykeQ+uOOUj9GVtwX4PpaMtcrrGuDuwhL4WzVFiDTNGLuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4Tk/Aj+/GmJv8VYrhqdO/bkdjhVf01tbOreedTtB2z4=;
	b=UvBAX/6VBuBU7xVKoOzrUb4PKxkYVCzX14AAvXoYUYqDMj81s6+jFEpOfFzsoq+91LFk
	 wOY/AfFxZQCrZC9pUkYf0pdrcMyI38wALJMmq/ohGOcjYcKTm/+Xpg8usU9Kd5fK0FLWc
	 /2p7D6djTYXoNZGHI7+9yx7QVOS2l8b7T28+/V0pV3/WM2/wM3iYmZDOfq+KEK2493LHz
	 QaxhjyRgQCknOQorI9fcOsG0pg905lkEZE3E6OyCk8hQivNPhxFF/s8J/F9Y39LPoNegS
	 Tr38rVuneWlZlXJXjlZjUk7e8r4oPJe89VUgO8WuJzH0sVaPcLnXGHYGnyUR9ajXTAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyognTs+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyognTs+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6731F008A2;
	Tue, 10 Nov 2026 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331098;
	bh=4Tk/Aj+/GmJv8VYrhqdO/bkdjhVf01tbOreedTtB2z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cyognTs+a5rCH/5soKbfqIksBv0ILaq2k+F8PdTEkFd1BxU0yFYhLyWBfK19O+lyT
	 zShUCym97+v7AMIJt5hFKEnmNxyMIQs2BPCdhfSvTlZfa3uGTq47rrKUGV+z2yik1w
	 i3gLJcdw1RBJ3abjGKarYnbDXQfpbIsaiQG6O/HmFM0izTaVftriIGPUy3ED80UstM
	 9E6O0kRMLks0qJMRTJdFVMq/n7ygX+wbXlAwn636Jw2jJpfXNUwgJRarM8zvO1eHc2
	 KwdeXzRlP8JgKFVkrjP3Fq3dKVbQEHJGPkBoT0v5SGXTII9hyMlinMG5Bm5lnzVrYE
	 Xhjhqjkmx3izw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Tue, 10 Nov 2026 12:18:14 -0500
Message-ID: <20261110171210.2630515-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171210.2630515-1-sashal@kernel.org>
References: <20261107053437-failed-6.6-b3c984358925@kernel.org>
 <20261110171210.2630515-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

[ Upstream commit b3c9843589257631bac18f30655e82d88970688a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e1c66f64aff38..288de302e83be 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2136,7 +2136,6 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ec8d054bf1ee..f4863d7331802 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -215,12 +215,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
-- 
2.53.0

