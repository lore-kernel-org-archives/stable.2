Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050567;
	b=PhHgX1i2JGwOkt3afi6TaJ5MfiD+qpRvYzcZoC9wL4iB/aDTFGHXsTXz1dkh0xgucRmY
	 o1ew9GMOKS2zuMbQIX6cLzf06BE+7sGVsareuWwgnVSWbLq20vKrc3qaBEDC6FvgHvAfg
	 0dfO4KBQBxD4PY95PUR/Ky8L777FyFwZZDE9xesEMCer81fOsbyUjZBgsxc6mZR09A6cV
	 UObeoZzb8NblaAcXy3MXReozWVTEAuR5s68ENDM8CVIJ6wZEXt2XH7MMcvG188Cdddpzu
	 cYU1tXHWhqHX6iFmtaAvkqkj926ICXOPVvgxuuJtriEqGjyVvC7ItpVj3y0yzhV7/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e0+Z4eBKDuLSFCp9m1JyBUKMoarjB4s81f6WZJnv6R8=;
	b=h4EcsvALRdOMeCd0suITmWW/3Msk4HyDkil5ckbxdE5VRfcK8n1KM5dTL4fcKjP6Ri6M
	 2s2/iFz8WObta80EKlVJa5heNrzI1csI35eZc+KSCUJVsPAg8sN8w7+1DeB01qmXQiyuw
	 wzaNf0WNS4RhHeX0A/rSy1NjV/0E6AW5TU2VdEtLwm2KvM8vguugRZzX36N46NZMua17b
	 7uR9W+TeMwo5f7S94sZ3Sj0H8mbH/kkImKbTjLsBAvavH32/vjVEh5hhu+q7HXg8DoMLl
	 tghY6tydUxUy7iTNnZfbCKmsJmkbgcd6K1XekqPC8a2eO4E/VhL2sLE/p5NMJmEyNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1s8NRMR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1s8NRMR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241A91F0089F;
	Sat,  7 Nov 2026 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050566;
	bh=e0+Z4eBKDuLSFCp9m1JyBUKMoarjB4s81f6WZJnv6R8=;
	h=From:To:Cc:Subject:Date;
	b=o1s8NRMRwrDjwvREPUh36sHEWBs4MRbz3JBc+9tDFwFWRWO0ome9EPBcanmKHdekK
	 nkY4obdGSckE34BU/3YCyOD+NyqatX2c8DB0ueBscNVPAHddV8GR4wZLwRqMr+WxiU
	 y1y7ha4VEJxi+sUDdc9q0XqC6Lyw4uq/fep+d0aTXBaPBpUEqSuEVuj6Ervyg2saM3
	 EGM3XmwL135qGfSqRU614vuagJZijZoUU2BEfvSAv82dWhCbxqqapmr6ohscD1wc5g
	 CitZdzAyASsSf56bMh3cd+ZkGyAkDZdgOdQ5Sj/caL5BGzLrmIB3Wi8xsxJRDpPo7F
	 JeNaYSJnd04jA==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to invalidate curseg if change_curseg() fails" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:44 -0500
Message-ID: <20261107062244-failed-5.10-e74476ad8162@kernel.org>
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
git cherry-pick -x e74476ad8162c1facc74b74ce2d1372492df872e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062244-failed-5.10-e74476ad8162@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e74476ad8162c1facc74b74ce2d1372492df872e Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 10:55:38 +0000
Subject: [PATCH] f2fs: fix to invalidate curseg if change_curseg() fails

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
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dab66ab3311d5..453f9284ec863 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3243,6 +3243,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(entry)) {
 		/* GC won't be able to use stale summary blocks by cp_error */
 		memset(curseg->sum_blk, 0, sbi->sum_entry_size);
+		reset_curseg_fields(curseg);
 		return PTR_ERR(entry);
 	}
 	sum_node = SUM_BLK_ENTRY_ADDR(sbi, entry, new_segno);
-- 
2.53.0




