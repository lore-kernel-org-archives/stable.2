Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E121CA13
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705409; cv=none; b=YDDNALVf0Yep+jeJyGjCZdRvFaHxRQLAc93FL8UV6pVnmeBqp3k4+nSYDTsTrLaNLKQJHfeA+w1TYwfDV77MZvCGZ93kg66Cvu0uHHtCctYX8/uWpErg02ixzA4HgNh2xnIMaJ4PmXgX8OSmxds3Vm3bKgbZL7a4+8gFDjGNhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705409; c=relaxed/simple;
	bh=YvFv5a0O11ml7aPtUs3GUzsgXNOp++3dGUne/lcIpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emMfpV/npoJRUS45Q8PdkKfO9ZLn1917J8bsqs1SdbLeK6tLi2GnjQIWH6QjMJSd6PZiPzT8rk2yPLBp1vs0asIy1dMzSqy6VzY+ZFfXvWzWNnTMtf1zWoFItFWxmfEpQ5adCZkX3Fu9tO4iIrV8CDCZtG/WS8zoV2ncjcZt7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0Uje5LZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0Uje5LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3851F000E9;
	Wed, 26 Aug 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705407;
	bh=EgRkrBLxeXYkiQWxAhbNWtW9e7kzdhIJ9qu2UQZfAlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0Uje5LZcyIGvILRziN3lZAMOgzoM8Z1RmKXS1GgONtowRSWcoJGen3LW+6sMSQ8K
	 Nr/xIs2ovv1ZiWGqqVbVc/XumJ/eyWqeRT9bo8JjiudGXePCrHPSHMwfA3IZeqe/yB
	 iFusDZfK5yg2vJe15ECrw7Etk3+guaBa5lH8L87EYr2taUjTbgS/TY3ci5GG3EYy8K
	 SeSQzOUiT1GHFeyD0VPf15C7HX8J3DWc7RECGRnWMzRPeeD4nsSrGpf8GDlJxpsAYh
	 13BjLSUZgIVpFrAsOeBcRu8b8T77TUqEtSuw4MwYIb71QOoJLiES/kOeXf0hzH772U
	 0nyGWwj3N98tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] ext4: track partial-zero outcome per edge in ext4_zero_partial_blocks()
Date: Tue, 25 Aug 2026 20:50:04 -0400
Message-ID: <20260826005005.830778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082417-smokiness-hacker-071d@gregkh>
References: <2026082417-smokiness-hacker-071d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 4c1f6931395ad026415cbdb924ffc240f86eb557 ]

Replace the single bool did_zero output of ext4_zero_partial_blocks()
with a bitmask that records which edge (start, end, or both in the
single-block case) was actually partial-zeroed. This allows callers to
distinguish which edges have been zeroed, preparing for unaligned
FALLOC_FL_WRITE_ZEROES handling in later patches.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260714080044.4038124-7-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: a5179156ac1d ("ext4: zero out whole block for clean edges in WRITE_ZEROES")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    |  5 ++++-
 fs/ext4/extents.c |  2 +-
 fs/ext4/inode.c   | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6569d1d575a01..bc25746c8b726 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3119,8 +3119,11 @@ extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 extern int ext4_block_zero_eof(struct inode *inode, loff_t from, loff_t end);
+
+#define EXT4_PARTIAL_ZERO_START	0x1
+#define EXT4_PARTIAL_ZERO_END	0x2
 extern int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart,
-				    loff_t length, bool *did_zero);
+				    loff_t length, unsigned int *partial_zeroed);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 125f628e738ab..c68feb1697090 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4715,7 +4715,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	loff_t align_start, align_end, new_size = 0;
 	loff_t end = offset + len;
 	unsigned int blocksize = i_blocksize(inode);
-	bool partial_zeroed = false;
+	unsigned int partial_zeroed = 0;
 	int ret, flags;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4fce9ec176f88..ea0b2359ca0cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4253,13 +4253,26 @@ int ext4_block_zero_eof(struct inode *inode, loff_t from, loff_t end)
 	return 0;
 }
 
+/*
+ * Zero out the unaligned head and tail of the [lstart, lstart+length)
+ * range.
+ *
+ * On return, @partial_zeroed records which edges actually got
+ * partial-zeroed.  Set EXT4_PARTIAL_ZERO_START/EXT4_PARTIAL_ZERO_END if
+ * the head/tail block got actually partially zeroed (in written, dirty
+ * unwritten or delalloc state).  Cleared if the head/tail block is a
+ * hole or a clean unwritten block, in which case there is nothing that
+ * needs zeroing.  When the head and tail land in the same block, both
+ * bits are set together on a successful zeroing.
+ */
 int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length,
-			     bool *did_zero)
+			     unsigned int *partial_zeroed)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned partial_start, partial_end;
 	ext4_fsblk_t start, end;
 	loff_t byte_end = (lstart + length - 1);
+	bool did_zero = false;
 	int err = 0;
 
 	partial_start = lstart & (sb->s_blocksize - 1);
@@ -4271,21 +4284,32 @@ int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length,
 	/* Handle partial zero within the single block */
 	if (start == end &&
 	    (partial_start || (partial_end != sb->s_blocksize - 1))) {
-		err = ext4_block_zero_range(inode, lstart, length, did_zero,
+		err = ext4_block_zero_range(inode, lstart, length, &did_zero,
 					    NULL);
+		if (did_zero)
+			*partial_zeroed |= (EXT4_PARTIAL_ZERO_START |
+					    EXT4_PARTIAL_ZERO_END);
 		return err;
 	}
 	/* Handle partial zero out on the start of the range */
 	if (partial_start) {
 		err = ext4_block_zero_range(inode, lstart, sb->s_blocksize,
-					    did_zero, NULL);
+					    &did_zero, NULL);
 		if (err)
 			return err;
+		if (did_zero)
+			*partial_zeroed |= EXT4_PARTIAL_ZERO_START;
 	}
 	/* Handle partial zero out on the end of the range */
-	if (partial_end != sb->s_blocksize - 1)
+	if (partial_end != sb->s_blocksize - 1) {
+		did_zero = false;
 		err = ext4_block_zero_range(inode, byte_end - partial_end,
-					    partial_end + 1, did_zero, NULL);
+					    partial_end + 1, &did_zero, NULL);
+		if (err)
+			return err;
+		if (did_zero)
+			*partial_zeroed |= EXT4_PARTIAL_ZERO_END;
+	}
 	return err;
 }
 
@@ -4434,7 +4458,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
-	bool partial_zeroed = false;
+	unsigned int partial_zeroed = 0;
 	int ret;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
-- 
2.53.0

