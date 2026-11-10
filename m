Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332830;
	b=o4CEfs6v1TozzRM7G5J0wgymvU5aDNVl65fMxjlD/eRSsZ7oc03c0FuuTbcCoiUQU4BG
	 tZ3Lpji+eT9VlcCqleR4tkS1VY4+RhZhovEqKrujPzf5X71qdqjfcaxxNNAoTdJN0d4Ii
	 q8yc/2nASqmpdVbq+D8ge+9QUxW+Nf4jV+1bwi3v+7tjDsk/RwWW91lBQctIDAxiInqDC
	 Y+21A4OCLc2np0fAhP+57doH4utHTVMpxEev5sAE+22L4PX2Ha2RyIFpxQ0wUzXaCFTC3
	 apXlS/vQmGCKG78aLo7OPT6K8yfPyrNltDkuYC90LhNGVS0In+eDerHKggpHyiULtUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w5Kv+zdeUbTbhYECsBx7UwYQCvZA3UOyU7lm+ANCUrg=;
	b=MUhC4VfnrtbH2ImD6Rdi+jY40zi9HdfFAgfwnJqHGTwnJHm6aC+9DN45RCG0ATgwF4HE
	 JczdgYFYPnhC8Wr4v2c6LGPBp1+R5d5PVNxs8U8CKvU2Tb1t7tC6JzBTxwotue5cMFPzi
	 Hgo25cQkySCNF77JGZOMsNA3JpUMOMSwrzZ+XnmSRHKFpchEwJp0395Ss3FrOj62qaf+E
	 xhiEotwcPzGqoT/G1fTQztUWkWq5LuY/xAv/KSGSsfdQOiKVzB589pt1I9bsOGHO1j1DY
	 UckVMzrUriehUISA7IjneVT2RdjCVQFUh0GIHMlzFxiycMFOEsFT7vvuLZp8+OUYr9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwJerboC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BA606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwJerboC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934931F00902;
	Tue, 10 Nov 2026 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332830;
	bh=w5Kv+zdeUbTbhYECsBx7UwYQCvZA3UOyU7lm+ANCUrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwJerboCIk4BLopiHc+JxJo26JQNrVjSC3kiSZn1ab7Y5emIMiqAWy5/i8lMCaDLx
	 SIUQPcWaB4Wu1L2GxkZLJHJmGE/GbAikeRZAO1jbURoco0MiNTuSodQ0dEfk7CS+gU
	 mSBGOekDL97xnNFSbZ2JkDOlt+R1I2ydEK6wJQDqwnlLgVxFV6APnVNvRREX8hfukX
	 v9VbhVpQrDj6RlvoSk0Z7VkjWzKeSQtvJlU6Vwr7twSBwFP+9e5ffhmOYqYiLMKeD9
	 HIyoyfX1ynr0QeE7OY+rg1khIicMhjhCMvp0ibye/oksK2P9g8e8y4YmbIySmr4phF
	 3Aeq4Vch3ZgJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Tue, 10 Nov 2026 12:47:07 -0500
Message-ID: <20261110174229.2999978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062227-failed-5.10-b3c984358925@kernel.org>
References: <20261107062227-failed-5.10-b3c984358925@kernel.org>
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
[ sashal: adapted folio-based mappedtodisk flag removals to the page-based SetPageMappedToDisk() and PageMappedToDisk() helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2933b32032e79..f1b0b9dde7abc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2144,7 +2144,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
 
 		if (!PageUptodate(page) && (!PageSwapCache(page) &&
 					!cleancache_get_page(page))) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c12691ace0b6..521c824fd8f5b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -133,12 +133,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (PageMappedToDisk(page))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
-- 
2.53.0

