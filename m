Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047689;
	b=z2Z64ts20alajsKnj4icLvst2pjgP8zfTc1yJEIBp9XYYeAkZiDz7ie4ymPnGvwEjz31
	 4VaIkXMn74dyjdkl7Ac53mqkDJ/cBFgrwN4hYbfFRhneuOS1ZR1L4qUjtRKPvu+gmMnmd
	 8zE5GOTogkwqj76o+qmvaRm95OyljfRUgJRrUAT9jgh+R6U0OI7OjsnvuD5orDA4FTYdB
	 kePDilW3FpdnOSqasE96sKKYStFfVhwAyi/Djcghq0axNzOZgrSfEmmpQkwOkRSHeg3ZS
	 nI1bQ+UBC7bzV6kt8+ZcvXcRjZisZMRyFTKLAr46EmIE0K/stdGXrgZlC8cIrYkXprg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6pjfbpmaIkZNT9Ie9TOBW4k1QfdABtMHSEwWsAxt7NU=;
	b=gAWqOsYaFgvIZBuk3T/G58rcVJDuFLrVzmk/OzVvqg5hMSFyBdLR/wF3r++5iEMc4pJI
	 S7bkO90FPmGs3SaA93UxHcNOUOV0tvcvJshfWpOeGMcwbzNXt7tA0DSUXwN0hhpwXluXH
	 9EfDfhzryoXRXWWqOnoiajhVM7dTl55H5fMtbKLeCGyAeJTqtr6A3TUcKtwFZdB3B64y5
	 sSSK7dM+MDJDKc7zxJjY4AJBf42fALwA00M4rcuthm5bx2p2yjefWQWT+l4WxhjarJezZ
	 nQUedh1eUdd9rXB1Uhs2g64/NxjDBml1381VJb1LZqGQSCLyAlsbRlT2zp7pyqc+t9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nr8xCJat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nr8xCJat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407761F0089F;
	Sat,  7 Nov 2026 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047688;
	bh=6pjfbpmaIkZNT9Ie9TOBW4k1QfdABtMHSEwWsAxt7NU=;
	h=From:To:Cc:Subject:Date;
	b=Nr8xCJatgpKJn47+SxxV6xZUtvs8xy6obncp1RfJJ0r8Im8TO7w2rMPtrq5t9cLxb
	 +qdtmgnWTklIPF9UcTibqfqHJrDcKABcGY9nvRziJfvj5n1xDlMj8Evn3OHZgKjSPf
	 BtaWQ837vrYpCZky3YJbM5M/zWqa70mpTSUmjcRRKony7Ic1ODJ+vW67O06FwPYhGD
	 n1hYmmNtuSyOREFQ9RUNv4/w/9k5hQPmbOVSE1UFUWZyVAGXtWKQoYA8r1OD6RjP/U
	 ScBKvYb7FWXO9DB/Lib5+vvPDaRMWH0WBgca+Elk2VoBJj9raD4GgVrD3EACGKtetM
	 r1PqpICcbzEaQ==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: disallow mmap write and data-modifying fallocate on atomic files" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:47 -0500
Message-ID: <20261107053447-failed-6.6-06dfe4a7eb69@kernel.org>
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
git cherry-pick -x 06dfe4a7eb696d868b196c2a49873142f19bd862
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053447-failed-6.6-06dfe4a7eb69@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 06dfe4a7eb696d868b196c2a49873142f19bd862 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Sat, 10 Oct 2026 02:41:33 +0000
Subject: [PATCH] f2fs: disallow mmap write and data-modifying fallocate on
 atomic files

Stores through a shared writable mapping and fallocate with
FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE, FALLOC_FL_COLLAPSE_RANGE or
FALLOC_FL_INSERT_RANGE do not go through ->write_begin, so they bypass
the COW inode and modify the original inode directly. Reject them while
the file is in atomic write mode, as fallocate already does for pinned
and compressed files. A write fault gets SIGBUS and fallocate gets
-EOPNOTSUPP.

fallocate without these flags only preallocates blocks and stays
allowed.

f2fs_vm_page_mkwrite() cannot take inode_lock, so check the flag under
invalidate_lock, and hold invalidate_lock in
f2fs_ioc_start_atomic_write() from the flush until the flag is set.
Otherwise a fault could check the flag, then start_atomic_write could
flush and set the flag, and the fault would dirty the folio afterwards.

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d4d859dbef880..58599ab4937de 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -188,6 +188,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
+	/*
+	 * mmap stores bypass the COW inode and would break atomicity. Check
+	 * under invalidate_lock: f2fs_ioc_start_atomic_write() holds it while
+	 * flushing dirty folios and setting FI_ATOMIC_FILE, so either it sees
+	 * our dirty folio and writes it back, or we see the flag.
+	 */
+	if (unlikely(f2fs_is_atomic_file(inode))) {
+		err = -EOPNOTSUPP;
+		goto out_sem;
+	}
+
 	folio_lock(folio);
 	/*
 	 * A concurrent buffered write can extend isize, so we store isize in a
@@ -2113,9 +2124,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	/*
 	 * Pinned file should not support partial truncation since the block
-	 * can be used by applications.
+	 * can be used by applications. Atomic files should not either, since
+	 * these modify the original inode directly and break atomicity.
 	 */
-	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode) ||
+	     f2fs_is_atomic_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
 			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
 		ret = -EOPNOTSUPP;
@@ -2403,6 +2416,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	f2fs_down_write(&fi->i_gc_rwsem[READ]);
+	/* serialize with f2fs_vm_page_mkwrite(), see the comment there */
+	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2458,6 +2473,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	f2fs_i_size_write(fi->cow_inode, isize);
 
 out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 	if (ret)
-- 
2.53.0




