Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FF30BF70
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102465; cv=none; b=UOfnX2zSoEcSOhSJKH6i0ZKN6gdg76AEURBYk48yynyIG5FQEq9biMQH/MvWtEYsXosdLZxdFGCbzHx44czAWPfIvJnj9Wsy1QapZ2L79niZdKE6mQyzX2EtZQEWKHBJfCV+NFeIIVWhuGvS9uQlWpuLeXrR0aDQDlyllcKhB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102465; c=relaxed/simple;
	bh=+LeD1bHs5m0adZ0ovwYJXG0GM7JdR9nMFtTeTJ/1PBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPJP7sS4OOQGmtzHzLiL5l/8LYCt7zbJm7oLiUyqZlF9ABquuIArf+nqE1TWHMyJwnT6p4eI1IecVG1Qc/+j+ZxQ4G63WRVST5olPoMIcySSnThUTIR2xL5O7/J3+x70teNA3cTK6oMnWKQgSCHy4anCegKDMlu5DvQ0w+/BkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPhT3x9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPhT3x9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9702A1F00A3D;
	Fri,  3 Jul 2026 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783102463;
	bh=RoZQzv5ALuh2G/oWalXqzoFzVjKwIx8uOSZdnCzzQT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPhT3x9re5l6kBg/b0hUNkrfzDmtjhIwUASRTKaWR6zLJxqNtFtuADzOMoRd2A85L
	 Lh5iq32EOv9b/481Tt8mMd1gwWP1uwkh6pOSBvY84KIRPQ6Oy/ZmQbpO9CYbSDJt+t
	 y7DI65BmrNHEapn3L5btTZGcImtmJKjfLwAHPd2jMmxYFmUn+QIiQoRzABObRoUM6e
	 h8IX44NuB99p8tQRHtYWJ1dSETTAmw3M5hZVBSFeFF6IgqgaYvj+GYUDwn2eNLzwKY
	 213HPLE468yrFZ1GEOm+wiil/DHnE5qqjuLFnVzzmEvxK6/aLG4qIFdD8J7dzYENMW
	 Nv7n0o0paX0Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: validate orphan inode entry count
Date: Fri,  3 Jul 2026 14:14:20 -0400
Message-ID: <20260703181420.250032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070202-purple-travel-b718@gregkh>
References: <2026070202-purple-travel-b718@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 846c499a65816d13f1186e3090e825e8bb8bcb8b ]

f2fs_recover_orphan_inodes() trusts the orphan block entry_count when
replaying orphan inodes from the checkpoint pack. A corrupted entry_count
larger than F2FS_ORPHANS_PER_BLOCK makes the recovery loop read past the
ino[] array and interpret footer or following data as inode numbers.

On a crafted image, mounting an unpatched kernel can drive orphan recovery
into f2fs_bug_on() and panic the kernel. Validate entry_count before
consuming entries so corrupted checkpoint data fails the mount with
-EFSCORRUPTED and requests fsck instead.

Set ERROR_INCONSISTENT_ORPHAN as well, so the corruption reason can be
recorded in the superblock s_errors[] field. This gives fsck a persistent
hint even though mount-time orphan recovery failure may leave no chance to
persist SBI_NEED_FSCK through a checkpoint.

Cc: stable@kernel.org
Fixes: 127e670abfa7 ("f2fs: add checkpoint operations")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Folio API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f4ab9b313e4f55..2e6b861cf87657 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -723,6 +723,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct page *page;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		page = f2fs_get_meta_page(sbi, start_blk + i);
 		if (IS_ERR(page)) {
@@ -731,7 +732,17 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+			f2fs_err(sbi, "invalid orphan inode entry count %u",
+				 entry_count);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			err = -EFSCORRUPTED;
+			f2fs_put_page(page, 1);
+			goto out;
+		}
+
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 			err = recover_orphan_inode(sbi, ino);
 			if (err) {
-- 
2.53.0

