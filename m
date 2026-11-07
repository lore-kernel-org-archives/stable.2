Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048517;
	b=sNCtlSnwlP0vlkGpGZsWRAyB916Ifeq0DmTHVELis9JLIfAs7/ePpNvubwBzuXM/cq2+
	 CjkhEVXzt9A5zxS01Y64DE9ZFoNrLaXA2/AS/TvSvKRUPFwcL1DEcFKWGDE9VrW7H4ue6
	 /eJykYf1LIv6/+bw01qRotK00wxd3vh2xsjeFLkCgCnyjhb4e7ef3VHuWEFObOWFfMEe1
	 7JrZ9UgbylxVZ0rYkA4QPwRyIVWkyIZIorpelWfZmrsLgfrA1/b5HFW8W1+fL8J78M44F
	 TvGvlQuwwiVUuB26sdM8HhazGXPMIcrYC3kSIMv7WnHKqh1KAil97xBhr+bf+3cD4Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EDovJVMIvU5Y3gGB6q3ZceH2l7B8fbdjRgbC+EXnT64=;
	b=laPCgwT+gy/rHo+lgojyCrxKU6pI1NGM08veToBj0Dy5lpzYwgFe6RTgUL111YAJH8cl
	 ymYmrrrn7P43FMViRkLfhpdF4ig6jDyCVXF/ww2Lk3EKAcWrX7CPmd/q9e3GXE2VzDIHF
	 KON9mfdjydDCcF8xlIIROmJHa9XPAD0T6uAeRCL1fODF99FXOKyhFEqU5Z5Mv+tzp1/9o
	 amivwg8wYAvodsEfNyJsoKXDLWC+GipK8HvQHCKQCxvISpR/eqcsWF/j0FbHIlD9gVdaQ
	 +J3UWJ/HBdt9LfdfQIcsKsDVXlt/THc4/p++VMAesY1uVSR9Nfnv1O9bUMXlzqzbfFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+ajY4aT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8185606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+ajY4aT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBA31F0089F;
	Sat,  7 Nov 2026 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048516;
	bh=EDovJVMIvU5Y3gGB6q3ZceH2l7B8fbdjRgbC+EXnT64=;
	h=From:To:Cc:Subject:Date;
	b=Q+ajY4aTR4G0Jewjx+ab97CD459vIBlWD/L02OrdT1FS84R4PwbouDelPuewGT9uy
	 8dYgJCzYVPfXgmUJkQSp3X6xamG2/J2QBM6uEIrJhdAHIgFP52nb2Sx46R0zo19ufD
	 CWJpw59AzeAdC5w7ByThFmIfossnH+TpuPTxGTKCifhH8AexAZCjoQ0oKmUD9cro1D
	 pH3HCkA/lgO1kristHDen7AqhgXUHVDKv4S1R2rHN2PO55JaBjBUjZN7x5Uxuckf0e
	 lS9kWc6Y2F+HvHWgd2koH3RPa6vhxN6NFIIZIuxq77fYk3hkT4RiTaCAs1h5ZtPqxy
	 96tBrcc5f2StA==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: disallow mmap write and data-modifying fallocate on atomic files" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:34 -0500
Message-ID: <20261107054834-failed-6.1-06dfe4a7eb69@kernel.org>
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
git cherry-pick -x 06dfe4a7eb696d868b196c2a49873142f19bd862
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054834-failed-6.1-06dfe4a7eb69@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




