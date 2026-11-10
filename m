Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332247;
	b=UbuF94DvlsI2nWFeEiePcvHckpVfIBopjW0tZKQ2C7T3fonrEr0nLfT3jGoS3dlWZbdu
	 PBXAbyrTUt3B8TDx57G1hRBUlNg6M+Gqqr63l2LJjOWIKEEmLmK7KO3GkBsuMN0iJvlnA
	 THXwJVNIqpaz0BoLld9xYkxpEFhXsVPRTtOmp+KByTDim3aAWsjDu+bRBELZBjvOBeptz
	 +5zDNEMbCrIH4GzuBPriXLn+hqx12tnkR45NnKyXYb/4Ys+vIk1VqXFzl7quJOTz7Z/a2
	 urSKS+1lzY/+Qpu3ZEr2S7Qv0kYlITJLUcgxzJXz1XRWdRe78j6mbooGpeKVHog3djA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I9F5kTMVg6XTR6qfdDMXgSzforUB18H9jRqALhWbfu0=;
	b=Sw1ShNP+AT4sJW+LLemRfMAPZAjPDN14aXkdLOhKakFYgLpRn6V3hF2FyfREy0Q2fYhT
	 u8ZQh1bMIBhfsa1ggUazSvV/CwiHPckoxJMExIT1N0C7BbQFaIK5QPwsjGACkt2U/g6+T
	 GOMDVa9H2P446R+GvV4jM/g+DjuN5ZdS9cC5IErz9iXt5rN/zAKvIjgF+MXeB70/sOJYU
	 t670XqPoofzRv6u5G0QB6m7OuDzOSEZPX/ZUTXG6LF1DSikV3ZHmQPphc2tDceQgyQ+Jq
	 l6A2DOCblo3e0Q1PjAq3NRs1AFHXLJOQ+7jqfvOt7qMT4qkQjDCvvYX9R4aq6M0PNRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Db/nCmOi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFB606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db/nCmOi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36721F008A2;
	Tue, 10 Nov 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332246;
	bh=I9F5kTMVg6XTR6qfdDMXgSzforUB18H9jRqALhWbfu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Db/nCmOiZwCm341hlRIIIc2qOK9nsbX3sUO6CEnyzEER4UdXu40cTPHHyEewYwX9T
	 g+xIkHxkpMORdbvdlGJh/CvoPmxIr6LGVYVIDyjPJpSfZBJ399K+amO6Z0O1c8O4U0
	 Koa8+sbDNMNenpbTpBU/3fg+YKQSR+3SWOHD73bmiEJyNPJ18IWqY2gh7EWUSavsnJ
	 qv3dkRrfgE8pj1GICwCpllIfD3uXhPwTkVRIyL2TArNIbN8Z9Az8fGYwoE1cQ/GRu3
	 rMwxyNxwj33JZOta/cXe6ropqc6IGR1Ba45OCSigeMiXy1MawWGMVbqqgZo+2Lz8C0
	 421g3dVC9LnPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Tue, 10 Nov 2026 12:37:23 -0500
Message-ID: <20261110173704.2986892-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060537-failed-5.15-b3c984358925@kernel.org>
References: <20261107060537-failed-5.15-b3c984358925@kernel.org>
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
[ sashal: adapted folio flag removals to the page-based SetPageMappedToDisk() and PageMappedToDisk() APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90cb8560af1d0..eceb3179173d0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2163,7 +2163,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
 
 		if (!PageUptodate(page) && (!PageSwapCache(page) &&
 					!cleancache_get_page(page))) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 892f19f67904f..dd4eab6367a66 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -135,12 +135,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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

