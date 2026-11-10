Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332554;
	b=CuS2gr6jIb7Bg8JlhbidFD3SdbpUZp+3CBY6NxuWdM36YSAR7aY9oaWmi2XCse6iAQBg
	 don1xXp6yYwG/0bPx47RS5Dys1v2vzwM/5IMtHdVbFHAX6FkSV6ec0JLwwiYN9dJsKWhV
	 AlEN2kePh602qg2G96CmNu5wn7TuckTGTjEneRWASLI5g16PaPrB2uzdhf1vRTGDwczjH
	 SWLYZ7CfmCR/7+zQOYk4DUCtZQwhDP+GzMi/xJvh0WQO3BMVSlYU3lLwiU12WICsxxemi
	 IYlIoLC8cNOSxBoVORGa5NUuQKOIdKTnoR4zuQVL/ZUnfxnMenZLYtkXUexsopdHRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GqkUFWepws1vBwqcMm8H0kfanqhuDXTJwi7mc4C7ETY=;
	b=ievixSvRN3UyNxxx6FVDGLYew7yWIHh1R55mLy1m0hMJ4py+ZpahkFcGEdAjlj2GVOK1
	 mrOkP7zIFm4mMrMW5d8eI7xMIDCQ+WIilQHcwxtJFtFYCjXrpIc+kKeaqYEGJqUTSquQk
	 nfe3rwIPS+S8ZCfIl1hUQ4YTS5ccpRP820HDqbHDeP2/5UQjiJNEb9VvNue+9rGCyuSOd
	 Ds5TgUWUWP4HTd3MjysJl7JYuuiVriPDD67xuUj+82yJxVZE+a6HBdUlW22p+mpsfrb6d
	 klxPB5Z1lZqnWhDujNO3tGgkg4TyEYaxSson1B0LTotct9PXN3C7tKIEQu99iBA15eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsykCArz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918760A3803
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsykCArz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233F41F008A3;
	Tue, 10 Nov 2026 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332553;
	bh=GqkUFWepws1vBwqcMm8H0kfanqhuDXTJwi7mc4C7ETY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BsykCArz0Af03EnoFuLAlyDvCm7JevH0vYHNVLGZKBt2ff96vLgJkSNizn2Qmztzq
	 pB3jsH5uf6ivfZDv1a5sItq79UNbBXtCKWBSY1PLE/IzOYXrjDf56deLdnTwUJamFM
	 XJX6oyUjDstdeXRUDtYFqHS4+ctx90pzYqmsjN8Mz72N09cnWjmXZ15swI+HeaLcBN
	 zDmMSwrguMd+oGw1hZq5OkLN5G2bag1s9s9cW9kkywo49SsROBsCqu2zALVoCjpq56
	 ri1ZUbZSgSLvSQwSt9Y6V7e2xyU9OPcVrKR1pFa6nmklaiBlQkwDdx8HpNC81pks+9
	 5SfQ9WJ2Dyxxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] f2fs: disallow mmap write and data-modifying fallocate on atomic files
Date: Tue, 10 Nov 2026 12:42:30 -0500
Message-ID: <20261110173914.2972639-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110173914.2972639-1-sashal@kernel.org>
References: <20261107053447-failed-6.6-06dfe4a7eb69@kernel.org>
 <20261110173914.2972639-1-sashal@kernel.org>
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

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 06dfe4a7eb696d868b196c2a49873142f19bd862 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42eb530cca9f5..79bc005ff4d4c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -178,6 +178,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -1996,9 +2007,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 
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
@@ -2282,6 +2295,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	f2fs_down_write(&fi->i_gc_rwsem[READ]);
+	/* serialize with f2fs_vm_page_mkwrite(), see the comment there */
+	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2337,6 +2352,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	f2fs_i_size_write(fi->cow_inode, isize);
 
 out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 	if (ret)
-- 
2.53.0

