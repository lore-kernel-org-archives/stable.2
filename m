Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049542;
	b=fJezu0dcqrKTDlLe4VydOm+t66peXLvImoC4z3zM2RvH7PiXlm8tUp7uQkEU7Qpt/+gx
	 A8RH0XaZTT1S7IYWGi6Ym5PZn6RsgJevQ1CSaFubTyK8WJ1ljw5p+9/AH79rny8RAy4MY
	 yqKPi48h4/fBA5XuiI8Jxuz2n4Z8+gr2sjocxSdwvtxq9cbSYO3IxacfV9en4VKZyVMM9
	 /INdznqA/pmZlRLV7e7Dn0QYslNoQcYIqk6716taEGiF6ZiVTJ7e0u29oql6Tm9jysRyT
	 nUkWwEvKpIg0FCudHn9MERO60oMNfZHFb74SyKVsOG9GTL8Vaa3P4YVV0PTbslCeTWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049542;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pPUQA2c4Ww5Fnn7Ow3K+PcW1e5yDNYX9CrEbenbaAa0=;
	b=uAOX6lnKUIDwuaTgTWlesjiIWK5smbx0tdLPikDHqFwxAyX7kTikQbQyJlUhIm/bQjKi
	 lyCCSfFenA39L36HPs0+DIXkClhpVRgdcy5OtSeiPYegwcz/h907Jm7Vbc7aDOupMMhwR
	 1mQCqSSHUWVf0mIFyORWz3PnyoUavKZogBxQEr9Zlh1iu6WAKBsZaSjV7bDDvOhA0lmn5
	 t66HzIxHj9nPs7xufofi0COj+fBMME/saO/2LTJuzyLjyGoAN5YeDwCgewLJftQlL4BpW
	 Ka81x5RWvRzPYLvkoxwrdR7BQ6avzUemXTPflZBTLrEAZvVkzs2i3Jnjx7OyzmVUTFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gupBQIvE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A566606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gupBQIvE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F51F0089F;
	Sat,  7 Nov 2026 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049542;
	bh=pPUQA2c4Ww5Fnn7Ow3K+PcW1e5yDNYX9CrEbenbaAa0=;
	h=From:To:Cc:Subject:Date;
	b=gupBQIvEx+VZrQzhqz4FHfHhbfYcO5FQaVi/kAa6eG53E5ELjjGFfifTMUdUBuEG2
	 beWMYO6NCRGlCvIwwrjti6NzrF4IEaLUnHG6yGFJ9BE3avyA0FGxnv24A7L3fp/dUx
	 FLU+Io6ScKCpZ6eL0cmyaZ2139LoTjq84JTk3nOTpuo0kTFTy4NRAK907odC8xXNVh
	 B4gvDBtITxXyJD0R/8pXQE0RKY8tBXmivqCc895jJ6bzm4lTY2Fg4dAqxrwRrsc00d
	 G149sCw4y3KfrG4iR1K6igHZkbX0apB+qBRqLk99f/iwq9BxLxqBmA/DbjscMQsw9D
	 F1oaCAaGqu11g==
From: Sasha Levin <sashal@kernel.org>
To: zhaonanzhe@xiaomi.com,
	sashiko-bot@kernel.org,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: read i_size once in f2fs_vm_page_mkwrite" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:40 -0500
Message-ID: <20261107060540-failed-5.15-c04f209773ec@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c04f209773ecb31e592cababce0d6658ee0b8d58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060540-failed-5.15-c04f209773ec@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c04f209773ecb31e592cababce0d6658ee0b8d58 Mon Sep 17 00:00:00 2001
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Date: Tue, 13 Oct 2026 18:56:28 +0800
Subject: [PATCH] f2fs: read i_size once in f2fs_vm_page_mkwrite

f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
folio is partially beyond EOF, and once to calculate the offset for
folio_zero_segment(). But a concurrent buffered write can extend isize
and cause the following race condition to corrupt data:

buffered write writes [0,3500)

CPU0 (write fault)                        CPU1 (buffered write)
 ----                                     ----
 f2fs_vm_page_mkwrite()
 folio_lock(folio)
 if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 i_size_read(inode))
 /* i_size_read() = 3500 */
                                           write(fd, buf, 200, 4096)
                                           /* writes into page1, does not
                                              wait for folio lock */
                                           i_size_write(inode, 4296)
 offset = i_size_read(inode) & ~PAGE_MASK
 /* i_size_read() = 4296, offset = 200 */
 folio_zero_segment(folio, offset, folio_size(folio))
 /* valid data [200, 3500) is zeroed */

Fix this by reading i_size once and using the same value for both the
EOF check and the zeroing offset.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4363e28056e6b..713fb6f49bcb3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -125,6 +125,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -188,8 +189,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
+			folio_pos(folio) > isize ||
 			!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		err = -EFAULT;
@@ -219,11 +226,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
 
-		offset = i_size_read(inode) & ~PAGE_MASK;
+		offset = isize & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
 	folio_mark_dirty(folio);
-- 
2.53.0




