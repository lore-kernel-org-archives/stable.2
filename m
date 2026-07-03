Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01E346769
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088356; cv=none; b=tc5RV45dHRyDaSQNoijYvYHaTFusBho4zn7zuXJHpdeb4C1/fK/6sd9eNmAt8etDT1QCrKuP9GwKbpcL1fZ0h0rp36zAlCAdAjJxKORMiUDEgUyRugd5Lg71/FzIUFsdZMt628jYRBIMwp6tLY1oeXR9Byv5/R/rNVqJBDoUGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088356; c=relaxed/simple;
	bh=54VXk5HMFEZa0a3ppAywuSK+KZpxDYSzt2F7yf9Pkwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN3a00ZtkxjwPD1ddXu1Byu5SpjQIx2tsX6TwuroIpO08TKvXfleZ6Ltm4AX2yMwMk72AdPEGb48Gv+gc5YXs0xDaVZfelCtqFlD/1mJlUjnCm4mH9jkfcX6GHaNFH/iP0ligQdNJvhpHHI+4F2KBDOYnDAXKZaIzkChIaAS/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyFlovX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyFlovX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA71F000E9;
	Fri,  3 Jul 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088355;
	bh=L1ua7OuCOzuBUfX0uoEcwU7W7VN0awg0dnnrvxR2geE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyFlovX/hQXThCNSXhEmQUQQHfA1Zb37bvYY58/d2IKYBc3jvtoagfXl2a3UTuZaa
	 Vqz6Fu/ohRa7gTyUJdn1ouv98IqvJh654Z6r7mWGppg8qBErFK9U+XgYSfJ+YICWqq
	 1fPUyn70k7cIznc2qpbD49Et7Yq6de4ZyOuE9Fktr+CYB+vT+QCMydAEd30IJwr+19
	 LgRO/0ujWivUUP+T3+5lU0Xz9e9nbNilHLy4k8uqY3SIzK9qhffY0v7WayNkM9Kc8h
	 GB3Wh09NX2Wsoonr6UrbbPTJjR2sYLYB3hE0h9G6nOVrnbEZkia4ErCS/fgJLunzqb
	 dR0kM6PzfOy2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: validate orphan inode entry count
Date: Fri,  3 Jul 2026 10:19:11 -0400
Message-ID: <20260703141911.37544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070202-reptile-shriek-5d21@gregkh>
References: <2026070202-reptile-shriek-5d21@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c    | 14 +++++++++++++-
 include/linux/f2fs_fs.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ad4073cde397b0..49000b1a7a6532 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -743,6 +743,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct page *page;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		page = f2fs_get_meta_page(sbi, start_blk + i);
 		if (IS_ERR(page)) {
@@ -751,7 +752,18 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 
 		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
+		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
+			f2fs_err(sbi, "invalid orphan inode entry count %u",
+				 entry_count);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_ORPHAN);
+			err = -EFSCORRUPTED;
+			f2fs_put_page(page, 1);
+			goto out;
+		}
+
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 
 			err = recover_orphan_inode(sbi, ino);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 26c7daca995984..1373c037255d9e 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -104,6 +104,9 @@ enum f2fs_error {
 	ERROR_INCONSISTENT_SIT,
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
+	ERROR_INVALID_NODE_REFERENCE,
+	ERROR_INCONSISTENT_NAT,
+	ERROR_INCONSISTENT_ORPHAN,
 	ERROR_MAX,
 };
 
-- 
2.53.0

