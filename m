Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6F2E22B5
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101835; cv=none; b=VTmU5dEGCLyNjZOSZxwEPeIVJWvk2Prg2oAzK8VRCJ/Qb20zF2Xxly8f1ByBUya+pUvt1i+gmG3tFdoj2/dHTcRaSd4y11EdUe0AVbRvmr9PfQRyEK53HvY3wEu5gk3m4I3wmMO5b8tj0gRsKL7EaS3t/1tZsaP0NLyoAcl7Gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101835; c=relaxed/simple;
	bh=H05PUEhrE+U+7GkMexx5D8KstZrpBoGeraowmXRk4C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myrwq+IpjtwdVoewjqfwAlfD7jrASxE1x1NxWwNmk1mfCDkNJsXJnE8r1AjSej3JTXLezNqx9MlMtiH+7DitgLTkGk4N7UM6xFgwBhoePKwxSdAKSb12bcNhScyMIKxCIYNIxRGlS9gK/YLz5TSmP9J4eRe4yvzHnq/NOUxukhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKqwS7F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKqwS7F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850DF1F00A3D;
	Fri,  3 Jul 2026 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783101834;
	bh=7WefwkkxIeSI6mJQMUvnT8k9p+gWl6Xn3lZ7/c8j4pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKqwS7F7seRTeCkyIclBqxS8MXGCMm6AShzzfFWlQSv7IUGSfn9ExTu0hIL18vs+t
	 uYDxwap0pvEA45MubN0giDXMuFYe7TdmRZHMm8Yk84uW71ney5u9nb5UKNPGeztMej
	 hL9R0RFspE5quz5xFjGBz8bYsqaEXYYbiwU+bn0LU+szWpU+gAQhRbPk/+iAefQ22d
	 T5c4tn0oSFye6/zp0xEKhC5SQAbGBp9SRO2Nb/qAoazm/M1XeXYZl51qKq3Lx+j61O
	 Cb/dDvcLFSnE+j1nG2cni3HrI6wLW7VQ+1jEXay2ZUUbTaewUvyLfbt9g76aurHGOR
	 8rUCcTqDu3FeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: validate orphan inode entry count
Date: Fri,  3 Jul 2026 14:03:52 -0400
Message-ID: <20260703180352.199841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070202-mandarin-hangup-b590@gregkh>
References: <2026070202-mandarin-hangup-b590@gregkh>
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
index 71a3714419f850..29c372e421d02f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -738,6 +738,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	for (i = 0; i < orphan_blocks; i++) {
 		struct page *page;
 		struct f2fs_orphan_block *orphan_blk;
+		unsigned int entry_count;
 
 		page = f2fs_get_meta_page(sbi, start_blk + i);
 		if (IS_ERR(page)) {
@@ -746,7 +747,17 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
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
-- 
2.53.0

