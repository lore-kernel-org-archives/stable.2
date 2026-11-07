Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047679;
	b=tW7iAsgNBsDJjOT3VYAAmgqwcZOeU20rTKJ4ltMsXnlOhrWDZ5zqmeqo7/OJO9z9t3Pw
	 lP8wzletSCf/AzWtwjhI2+jvCDSGlPfR+ZE9eY5pGloWZ0/DoDlmk8p0HtDY4KKONQS9z
	 h98Jqh6E7Uu5vhZTyWKLJ5D17KZ11ttPdq05KyKBV1qlz0PHEWM0wh2A/vLPI50mrqlKm
	 KIVQJHQIrXinLuWsceO/AevY6J79cSjalM1rMJ8LmDEBgy1iXx7GSUyK1KysUmeZhriSX
	 Yh+damiX2xkwq/3BT8xWHif/i3WkdspBPxmYn5v5IdwWck4I1tNDmFi+MSMWHY6F9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ULWOdN2wsVX2bqLxOVTcI7JpAloJn0RBy8G1/dnxTTc=;
	b=YiAHXU2XHyOvJaRdLBjosf71j5I18l8kDvOzOUk1XsDRKSiHdl8Tu7PUirPgLMmrMQ70
	 SGn1b4/jmS7CuayPY4Vr2Mj08K58oV4WTeWf7ItN994muts8ThKwMEptXT3ljmJFIvTh6
	 +ORlgla9NFkYdZLEsVvpC3PzqXYzoAbyFAbX+/6Y5vDT6XxHz7vFCSS6SKqGzJijreR7s
	 dbCGZmMpES6knMVzdHiIwWARlExCoyeFpTV8zbbWSkHPwt/KGZJSOEsQ66QtgNy2XFBZ3
	 pSuZ28C16gMrUFn3gsIlo+Iv5jfJAfkYNaxecW7uytT2y8sZpa5zzc1UlE5NnKBbWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnykUwmD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98746606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnykUwmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CDA1F0089F;
	Sat,  7 Nov 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047679;
	bh=ULWOdN2wsVX2bqLxOVTcI7JpAloJn0RBy8G1/dnxTTc=;
	h=From:To:Cc:Subject:Date;
	b=dnykUwmDV346PYsb/7j/1YElPYaiCAKHfnG3t1it1pIl8JxiDHQQEXl+ubaQ+G9F0
	 dx8ZgEgs5YATqDDK3m3yeD7Y5GwHvDn+KSIW/f3+kld61DlQzzuhPVVJxH0IFAuOWm
	 ufn1aVm/myYeo3WP74IeCNrn1x+3w9r4yWyuicQ2pdtdFxz/Y4ReqD/ViMbijygjlz
	 QkZqVW+XbCe6SU1Z0RGj4DcfVciaoVOPOovcy9DTDZCqB2HJlBZ+U7Ixe4EJb9hLMm
	 tvw1pErc7JkVZa8jnSy4WpugNyFxqDoxQpH1cMDs0CrENImJh93zX1KYsYHfuUcgeL
	 1xhlmU95rwejA==
From: Sasha Levin <sashal@kernel.org>
To: zhaonanzhe@xiaomi.com,
	chao@kernel.org,
	baohua@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: remove mappedtodisk flag usage in mmap write path" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:37 -0500
Message-ID: <20261107053437-failed-6.6-b3c984358925@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b3c9843589257631bac18f30655e82d88970688a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053437-failed-6.6-b3c984358925@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




