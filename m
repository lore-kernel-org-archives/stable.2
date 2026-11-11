Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409070;
	b=yka+fjZRjxfKo28p7o96q4PUnfHlDDW93Xh9JQzE9DC3xccEs1fDFFT3SnPHV8+076ha
	 GxyljliLnzCNU0PiW4l9+tK8jBbq3iSFOxtu0dhkz1599mizuFaSbaE86ATaalwjxlV0g
	 iRPKm4N+61T1Nv6/PVIT3RePD9caoWPAhLsjm54pUSRhGX8i3Gpf1lUPuYIJorP5h73yE
	 uzV/jDp/tRTkDiL8W3Q83MIPFGTYxjtFadnfd1xWuzTwswGU3IlRqN8KkowbVl22hb50p
	 YW43CU7hcwaqkgHaxyef6GQCJyd0ipmk4rVEm8+JCWepMYByRnQDBQnX9mcgodOfeFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fG8Omq6mBUwuOX6b157t8JQua4sOhqEfgSWchcnlqhQ=;
	b=invXCM2L9xE4yoh7cxvbPndGML7b3m2/dnxaPd7lHEWrpI92sp2LkkhJncY3aPVUksbM
	 8fYlQAtQ0xUs6NQkFbAgRl7QdHk91ST1Zi5naYJ/W7a3r8lB0iQKAEP5uJ56xnHvFBobp
	 Swi8s8KwrpwYktkqF2zx03Mxf3bKaxWClYnL0DGT2saUTvVnqnY1pV6vE6exkdx1HYMUs
	 rJki6uTVpeHnvtPzcyj3+GjLaI/pU0g+kyb+PRU3gOM+hW2mzsJiSoM0YwhDZELI8FJZi
	 G7eZHzzz4MI175ryft/qZpZX1OPAXoaeyNsDL7gW2uOGPkUKt6usN87QX74lNM59msw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcaTpXbB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7878606A8A4
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcaTpXbB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AAF1F00A07;
	Wed, 11 Nov 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409070;
	bh=fG8Omq6mBUwuOX6b157t8JQua4sOhqEfgSWchcnlqhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZcaTpXbB1jl9K5271+G/kA6UXNP5D11GdM4s6URLlQy2XHwZHPANoKNlkn+kCb4Ci
	 w4C19R4222vHaZGmK2ciF1lyxbU62dtJ9j6WNyjhFT0O6o6+Tt269/oBqxkeZNJMcd
	 kH50lCkeNvryui8zwpBV9VrRG0aa4bwq9hJC/IKIRhq8c2fJJ/NhckZWzUGyZ7UIAS
	 DUgXDuZBYntJ3en+EJy07/i9qORiyrC+PVl+9+dD96bRI318ocy9mKdaMfLozwSYc6
	 CHFTICgeMkxPTpxRwy3Gv/14N1PLrgUG5L8Mz6C3tR/Y0eemKLGPRwgkUmqocEFBXm
	 NbBqn4AV0M42g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to invalidate curseg if change_curseg() fails
Date: Wed, 11 Nov 2026 09:57:48 -0500
Message-ID: <20261111145732.2461477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052217-failed-6.12-e74476ad8162@kernel.org>
References: <20261107052217-failed-6.12-e74476ad8162@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit e74476ad8162c1facc74b74ce2d1372492df872e ]

Our consistency stress test (fsstress + fio + atomic write workers +
"f2fs_io shutdown 1") triggers below kernel BUG:

 F2FS-fs (vdd): Stopped filesystem due to reason: 0
 ------------[ cut here ]------------
 kernel BUG at fs/f2fs/segment.c:3989!
 Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
 Workqueue: writeback wb_workfn (flush-253:48)
 RIP: 0010:f2fs_allocate_data_block+0x257a/0x38e0
 Call Trace:
  <TASK>
  do_write_block+0x155/0xc10
  f2fs_outplace_write_data+0x192/0x340
  f2fs_do_write_data_page+0xc57/0x1880
  f2fs_write_single_data_page+0xda9/0x15a0
  f2fs_write_cache_pages+0x973/0x1f20
  __f2fs_write_data_pages+0x6c4/0x1890
  do_writepages+0x21e/0x560
  __writeback_single_inode+0x119/0x11b0
  writeback_sb_inodes+0x67d/0x17a0
  wb_writeback+0x207/0x820
  wb_workfn+0x128/0xc30
  process_one_work+0x925/0x1600
  worker_thread+0x60a/0xff0
  kthread+0x35f/0x460
  ret_from_fork+0x474/0x7e0
  ret_from_fork_asm+0x1a/0x30
  </TASK>

The BUG is f2fs_bug_on(sbi, curseg->next_blkoff >= BLKS_PER_SEG(sbi))
in f2fs_allocate_data_block(), next_blkoff was 512.

The root cause is a race in between atomic write commit and shutdown
as below:

Thread A (commit atomic write)  Thread B (shutdown)        Thread C (writeback)
- f2fs_ioc_commit_atomic_write
 - f2fs_commit_atomic_write
  - __f2fs_commit_atomic_write
   - __replace_atomic_write_block
    - f2fs_replace_block
     - __f2fs_replace_block
                                - f2fs_ioc_shutdown
                                 - f2fs_do_shutdown
                                 : F2FS_GOING_DOWN_METASYNC
                                  - f2fs_sync_fs
                                                           - f2fs_write_single_data_page
                                                           : pass f2fs_cp_error() check
                                  - f2fs_stop_checkpoint
                                  : set CP_ERROR_FLAG
      - change_curseg
       - reset_curseg
       : curseg->segno = new_segno
       : curseg->alloc_type = SSR
       : curseg->next_blkoff = __next_free_blkoff()
         which is BLKS_PER_SEG if there is no free
         slot in new_segno
       - f2fs_get_sum_cache
       : return -EIO due to f2fs_cp_error()
      : return error w/o restoring curseg
     : goto out_unlock, skip restoring
       old segno, blkoff and alloc_type
                                                            - f2fs_do_write_data_page
                                                             - f2fs_outplace_write_data
                                                              - do_write_block
                                                               - f2fs_allocate_data_block
                                                               : curseg->segno is valid
                                                               : f2fs_bug_on(next_blkoff >=
                                                                 BLKS_PER_SEG)

Since commit 86f33603f8c5 ("f2fs: handle errors of
f2fs_get_meta_page_nofail"), change_curseg() can fail after the curseg
has already been switched to the new segment, then the curseg is left
in an inconsistent state: it points to a segment which may have no
free slot, its summary block is zeroed, and the caller can not restore
it. Subsequent block allocation on the curseg will trigger the BUG.
Moreover, the writeback thread dies with curseg_lock, curseg_mutex and
sentry_lock held, so the commit, shutdown and other I/O threads hang
in D state.

Since change_curseg() only fails once CP_ERROR_FLAG is set, no
checkpoint will be committed afterward, let's invalidate the curseg via
reset_curseg_fields() on failure, as new_curseg() does for -ENOSPC,
then f2fs_allocate_data_block() will fail with -ENOSPC on the curseg
instead of triggering BUG, and do_write_block() can handle the error
since CP_ERROR_FLAG has been set.

Cc: stable@kernel.org
Fixes: 86f33603f8c5 ("f2fs: handle errors of f2fs_get_meta_page_nofail")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Adjusted context for the existing f2fs_get_sum_page() summary-page API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1ef87b212681e..7559a85bb9df6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2970,6 +2970,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(sum_page)) {
 		/* GC won't be able to use stale summary pages by cp_error */
 		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
+		reset_curseg_fields(curseg);
 		return PTR_ERR(sum_page);
 	}
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
-- 
2.53.0

