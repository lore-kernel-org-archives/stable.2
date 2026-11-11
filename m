Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408254;
	b=GNC7ZoPkU9VxsV7ZAy9WICNjYyW4NZgUwBLlAy/x4h7xMMu9iEqMUBE+JXv8RImO3aEg
	 f9vaIcmI33AxShs6tXLGgJkCt+BNOXTw2FxGv3CBzT1TrH8wTcXRJRe4qljveZfaxIKrc
	 VuwnWKPYAnOszGLHaB6RADzGFjK1pTxqhL52dkiLSgakr6PPlICogaQwzTaKa7n+NiRVl
	 EJFkB7ehFhktaVtHABdZZNsMb1/0Ow1Oo27EiNM4zIX3mcok/8fP/Vio2XrDZ5YYGVmpa
	 k1MCt23x/9KX2YdMB7DxHW6B43yqgRB0OR21Xd11o/FfJYCwbdLcxU2ikFVQzpqwycw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XPa53x228mNuuWUbbAQw4xoqYzvnNlHyDbSw7/N05fA=;
	b=wFQZmb+pRCvw8NSIKLI9ltXqzTsIDJRossUtZ8r7JrdMxkJ6opUVmvP5iAoRc/huHXi5
	 H04yk+YBKMtdTyuuP7EmjtVpyX0qr9QkDZsn2zCrCUU045nncvrv1JBJt/LZZUw9eWYCT
	 cgkDsS4ZLvItaGSzQXcm4a2YBhJH046jUbkkUjuoqyyCienLRrLmQFaswhSENZMyjBoSe
	 zLWofZf+79XsTnVtSd4cuJDod7j/Ygu2INsVEP3B1N+VGqO0Hk7tnsS9pyHAzE0ATksVb
	 7oti7L86n0QHHuhoX+djPai+gNeHl/2Afm3zOR0en0t+tHh3Lxwme3dCH5xEsW1ZO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFZrlgfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57807606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFZrlgfY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522351F00A05;
	Wed, 11 Nov 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408253;
	bh=XPa53x228mNuuWUbbAQw4xoqYzvnNlHyDbSw7/N05fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFZrlgfYY0e0Si5ab/CF2MH1vAdjteBTkVUdatTGdNhXHRVrUEzN77J45kbcEdQPd
	 VI8aETa0/s5HmxGcWi55rBLsMxHWn6T+NycilcmzM3Kq6qitm941CagUWggcrGvtxF
	 KZLJUKp1UdMFSrq+gqvRDr+aDzxHBwWno6992MyQIpiZ1Z9TDCIdoCWDnPWXYEZ+WK
	 5wOlVuum8858ggmwKzIUs2OKOROYfU6XGXnhRrf6HaGWAbo3FRI3A7C/LFk7KZ0uh/
	 PXN5fDvR7RDNp2tFpQmshEaHC0WobdaU8ozu6yEDdRYCdWJaCZDm18sGubK1Satwvo
	 SW/wFVKYPCjkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: fix to invalidate curseg if change_curseg() fails
Date: Wed, 11 Nov 2026 09:44:11 -0500
Message-ID: <20261111144253.2376985-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050438-failed-7.3-e74476ad8162@kernel.org>
References: <20261107050438-failed-7.3-e74476ad8162@kernel.org>
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
[ sashal: Adjusted context to retain the existing folio summary API instead of the upstream cached-block API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f3a73b6c24c3f..32ed7b8f69fe4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3234,6 +3234,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(sum_folio)) {
 		/* GC won't be able to use stale summary pages by cp_error */
 		memset(curseg->sum_blk, 0, sbi->sum_entry_size);
+		reset_curseg_fields(curseg);
 		return PTR_ERR(sum_folio);
 	}
 	sum_node = SUM_BLK_PAGE_ADDR(sbi, sum_folio, new_segno);
-- 
2.53.0

