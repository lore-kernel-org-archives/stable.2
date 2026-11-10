Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331918;
	b=BQEHxYRB4fNIMc7Kjcc6FeJui1dLJtdcl5JLqdKfznHYhPnlQst5NWi9Z2WrI8DWBJRU
	 87l7QTtbSznSgiBKITrbEzEw5S+e42VsHwJ6OigY3Q6aIOiPILvpbpH5+Ky60vz9iSoPp
	 wePSzNN9+QRD4kCbHZ0cXrRoRu1Ih0iHp43J5hZaP0f2iGXaCDHULOwLUPMNAR/sfbquK
	 SDlgoF/oTltfUr6WwP/29r4teO5je3sx5fthQvOYXj9/RpXBXHX31jNofMuaHit5yqwEV
	 orKKEmGy6CW8UmXJVKMDiLXcVO5p4TvkTHycbne82OhE6CQwnhNrOQTsdsDioCwSOTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FhrnmeExsPIAMI/ORvYLqEjy6g6rsnVPt1SFbWVRXa4=;
	b=v5S6kSnXyjNteL2qYGO0i210j+UpC0FG9mddXYr2DR1Y/NeazvaFcS4EV9SJqBKZCBEC
	 XhHuyLbLvokI8EfKR7FeStPRR1oQREC65cEz7hZwzSyB4JpbSLDb5fu68M9C9Y63XI+Kg
	 SX7l3kRhNy7fyh5KhljuhrW+pyazwWamW9E70bmY0p9NHZQBMdTMiUZmfaNzKpxUowE4U
	 mgSOUfFgYDtP/BckWlIqy1BwlChmnthEqJsaSYtt07ls91YvYIvrx9GYrxt5V8nnjZ8Yz
	 9qrDC2Jh0RfO3f5lV/ID7OJ69yPbOALL/KcGntcfd33yTMR5RnJ2A2576i/7OmKjI3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONo+pdYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EC606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONo+pdYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56B71F008A2;
	Tue, 10 Nov 2026 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331917;
	bh=FhrnmeExsPIAMI/ORvYLqEjy6g6rsnVPt1SFbWVRXa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ONo+pdYt/BiUkOjo7tnwkypjlSL20GnL78uGLWe29xjZnno4Cj9zzVQBMdydXMUpE
	 JrkdX7SHVgVYwJOT5RpXdoovsoiLbLDDfmPAgkxbgTwoyqeo1S4L920VyvajE1Ap9R
	 aJtG0mBWKjIeFbNeg93UV59qK3sUBX+uyPw8+S/joM7dGd/rLpZPfYKpAsH6Q0lLc9
	 CjJ995PpNBD2vEYxfNZ16UotwnChXm8nYQ9CDA55Id53/LkWBgK1pDx7I2ztfFeb6e
	 Gvt7DacXzDrh2x2tgLnd4gD1QzKMgFOfkZunaVFss/NznV2XWgkgbVwqgRv+wde4AA
	 DnFdBelSLV0qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Tue, 10 Nov 2026 12:31:55 -0500
Message-ID: <20261110173142.2903923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054815-failed-6.1-b3c984358925@kernel.org>
References: <20261107054815-failed-6.1-b3c984358925@kernel.org>
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
[ sashal: adapted folio-based mappedtodisk flag removals to the equivalent page-based APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6384ac931bb7d..838bafc476a49 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2158,7 +2158,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bde1c9cfe1df4..8f94cd81944f1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -134,12 +134,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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

