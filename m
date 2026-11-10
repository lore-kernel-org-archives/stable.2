Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333991;
	b=GXHEEJbNIQfgfpe3D8TfVuqicN9BEAatO+DRE7wOifJoUJCup/SBZYI10kY9kK5KSfI6
	 FwueyceFTCuQcsy7RXYNQMJwMt3EF8tDRMqZY5oLtEDjYTf4Gwx1z8wvH3mUaR3GBUg2A
	 vZz6PFwB/pq1nbWlpBq47Zcu7b8Z0aHZ+UIKU5ihk3+T3hHJSGzKwBqAlojjPQFslyLKb
	 QsiMVqHE43w8gphJUSZMCv3lcQ9xOHVILa8kyAOLuQiAH0ZORfccvT54Sibryym+yewUL
	 QYPE63aM7eksnxNFvmZ9jNoTR+VHRUmYctJQAfDBfxuX7Ml5E0vur9TCIFHl3E4rzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=12PTd/6Pp2GXmH1FksLbbJ56lhHXgLf+F7jZdkRnKy0=;
	b=vvLVPBZLoYOCb8IafaiablvdccRCR7u11D3buNbh0/MbwSDvXuaNKuCjmNx18+lBqM9q
	 fL46UfYBy+mH47+fboIC17shCwIod4xZlUfQX4TOAjnIrLelANaSDclzjCB3gBctLoyz7
	 wGI/zovWTRdCPbZhBuvm1TGMbhjhsj/lDpDRGUBu9vac6n2ETDFHfLJ5RzNCQOpn+dX+8
	 aUXgdYwy+kJR0qnvEwXzp3fuH0UYbsJHgWtByyjBGrW6aMR7F3OuCG3sVLpJECEgOC7yl
	 d3kaZKER7oiuti7SUNIUwZfeIJuovQiHJTBdW76IxaQanL91N58LB8mqyjovKt9vtVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nngIBkap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15A60A261F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nngIBkap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884A1F008A3;
	Tue, 10 Nov 2026 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333991;
	bh=12PTd/6Pp2GXmH1FksLbbJ56lhHXgLf+F7jZdkRnKy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nngIBkapmiGk1P+BuKFDmh853ZISBiHoutLarImRn6bbtlvEYY7bAJU+3+SK7EIYe
	 cy0dHgWRMS6oAXDaK98dG7MprZF2LEZQ46PxOH70NE6XMYOwAnePBO99FIYKIiNK/A
	 xT9j29e/txFRppiyW5+VKuAw8EgEMm+sZWh89bj8+FkxEUfz396nVGBGwdJI6JByBs
	 Wi6ikhWmN6/WKcirdgLBl84xT7DNOS0sbd5ay+AUOD3fTPcOSThCgalUVfcE9os+8g
	 1VkJE3eHYFCpx2xf83ij0RktxZYFLE/ccQulZ3m/SQ1R01KcpbcClYq1Kn2i78wtAJ
	 4jwFCKE37D7cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: disallow mmap write and data-modifying fallocate on atomic files
Date: Tue, 10 Nov 2026 13:06:28 -0500
Message-ID: <20261110180356.3017239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054834-failed-6.1-06dfe4a7eb69@kernel.org>
References: <20261107054834-failed-6.1-06dfe4a7eb69@kernel.org>
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
[ sashal: replaced the shared out_unlock cleanup with explicit invalidate_lock releases on all error exits ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bde1c9cfe1df4..13a61e6ef448f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -102,6 +102,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
+
+	/*
+	 * mmap stores bypass the COW inode and would break atomicity. Check
+	 * under invalidate_lock: f2fs_ioc_start_atomic_write() holds it while
+	 * flushing dirty pages and setting FI_ATOMIC_FILE, so either it sees
+	 * our dirty page and writes it back, or we see the flag.
+	 */
+	if (unlikely(f2fs_is_atomic_file(inode))) {
+		err = -EOPNOTSUPP;
+		goto out_sem;
+	}
+
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
 			page_offset(page) > i_size_read(inode) ||
@@ -1888,9 +1900,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 
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
@@ -2174,6 +2188,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	/* serialize with f2fs_vm_page_mkwrite(), see the comment there */
+	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2184,6 +2200,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
+		filemap_invalidate_unlock(inode->i_mapping);
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		goto out;
 	}
@@ -2193,6 +2210,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		/* Create a COW inode for atomic write */
 		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
 		if (IS_ERR(pinode)) {
+			filemap_invalidate_unlock(inode->i_mapping);
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			ret = PTR_ERR(pinode);
 			goto out;
@@ -2201,6 +2219,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
 		iput(pinode);
 		if (ret) {
+			filemap_invalidate_unlock(inode->i_mapping);
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
 		}
@@ -2215,6 +2234,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
+			filemap_invalidate_unlock(inode->i_mapping);
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
 		}
@@ -2229,6 +2249,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	stat_inc_atomic_inode(inode);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	f2fs_update_time(sbi, REQ_TIME);
-- 
2.53.0

