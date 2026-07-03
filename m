Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676C3D2FE6
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085021; cv=none; b=JlnXmkJB6pYma8ejavupl4QKDElyQgYsKSLb6aXHQOxtmyoVGqLhAErxRFkxMJ43+asxbRBgGtj1hOsdBJZbswyrzbtQ3YWBcPzOHt85waVMM8dm/3iGAlRLWkWkho4i53KvQ7vPiY0RQ79v8qNw3dphfOjRGUo2DqviEv0D/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085021; c=relaxed/simple;
	bh=bHhLBk/omfy3rPjRZVHG360enJGhW4JDSP3Lrw71934=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0iMHI3dTEjpXVRjmsotdjT2TRWZpQUseM1XLZFUshZF/Hi9hOaBoM5UGR2JKemM/ZCtvqse2yKbxdyf0uawOUYS0ndQLsKazm77cBHaro5dZW6HQW2nqXLL4jg1ElfucCqvWRd7eKpLQ/ObA+CCBqLFuzpHbi09Op/xRkuiCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEKFQ5F0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEKFQ5F0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EC31F00A3D;
	Fri,  3 Jul 2026 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085020;
	bh=KvKyyLnYxykF/sm5KlYT6J4CbxHGige1OE0Yu9jiHHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EEKFQ5F0A2QvM599MOGsn9QHuom7m8uczDfVIuSNrA4piZyaKhvPk3L04InghSuzd
	 SINxmGX/Epox4Csw5RxwKXzq6+CwzX8yzHuA4EaWu4qLSzaDTjcQFO1b5YCMehf5fx
	 KqNC6Ra2UCVzHEydbQlitgSZNG4L00uDkCJyvJVJA5sLWFIbY0DplLeeNWvuwGx+ME
	 miI0Bs2kMLWbAps05RCr9/zERJ/Nf4h4HYNtrjzqhIXitbrwbFae6rbKISrqeWJM9T
	 rHQ7IxahkTdGh1kEFOxDKbI95HscGx5KqmnJ1tPCD/RKOvmuB2SuLCq+LxxD1FQHLZ
	 w2jqYEsLdesUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: validate orphan inode entry count
Date: Fri,  3 Jul 2026 09:23:37 -0400
Message-ID: <20260703132337.4099385-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070201-evasion-negate-eca9@gregkh>
References: <2026070201-evasion-negate-eca9@gregkh>
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
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ec815e615e731..c629b5580b724c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -742,6 +742,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct page *page;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		page = f2fs_get_meta_page(sbi, start_blk + i);
 		if (IS_ERR(page)) {
@@ -750,7 +751,18 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
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
index fed8bec024db72..8414b7ff254326 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -102,6 +102,7 @@ enum f2fs_error {
 	ERROR_CORRUPTED_XATTR,
 	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_INCONSISTENT_NAT,
+	ERROR_INCONSISTENT_ORPHAN,
 	ERROR_MAX,
 };
 
-- 
2.53.0

