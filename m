Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9F4BEE43
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177428; cv=none; b=cl9DmYJNBqp0dqoIzEOARrn/K3Xw4Esn3amgDKrSffrsvE1er8QA7Nhngt8PfoNj2guX1/SpvJFOs8Yxkdmmz+vQ9Sm1jUmz9D4X8k+jo3BsZ+hglWx5zwBktAWMTwFqGCTGI2JgUKKNVq9yFU+nAwreah8rBCVYTjr0p7vsD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177428; c=relaxed/simple;
	bh=l7ClgsbE/ahgZDsXOvZCHM4JhIzDNivt7osl49vq/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJR87DI2TE0txV0DYAZwCzyECIHnYxG2WgaGYHnTdWF1oDAYcE9y/1I8CaVJ3v0frtA9KK5DJvlnt+HJkYzf6ilqBgxGK1vUu12K7nDXTvtKriug8r7YU6DyQBEf5c41Y4NPQkb3vh/r40naaU2CmHiJmEE6f06o9SIX4wH1NFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRfWxZRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRfWxZRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39FA1F00893;
	Sat, 12 Sep 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177426;
	bh=eVlqsuM3s4iVnM+Q1cOL5gEIVgKvqkG3xxndQVWHJR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRfWxZRpTz9/M3J2emCoxaTI24LcKxS7EONIBHLm7oYEd+ms2/tda+npGZI2Jle04
	 46di5OLAvWpTDjyGN2bSTwSeOODzspISiipyN15SOb+SEUyvff147XnTMj7p5pyEHt
	 /kvV6Hwwe4lldf/dR5ABiBSufSnafsZWa/if1xerNl7ih6RBemxW4HWq/gyYZiY9kW
	 wsxNHwP2yO+BofYDlmCD7z8riIhS8cC1ee9hauQHMiHyDk0E1Tl8xqs86LBogHbYAd
	 NDqz29wzf219bk1AOUzJUkUdcJimqHCvCo7VHESXNqUI3M4I+bQVenn3qzASWf85UC
	 shDvoYn1SRxpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: limit recovery filename logging to stored length
Date: Fri, 11 Sep 2026 21:43:44 -0400
Message-ID: <20260912014344.1817950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090932-award-goliath-372a@gregkh>
References: <2026090932-award-goliath-372a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 01027b2fcb74dade59fb833b51023f6593b6a9a2 ]

F2FS stores recovery filenames as a length plus a fixed-size i_name
buffer.  The buffer is not NUL-terminated, but recover_inode() and
recover_dentry() print it with %s.

For a 255-byte filename, recovery logging can read past i_name into the
following raw inode fields.

Print the name with a precision bounded by i_namelen and F2FS_NAME_LEN.

Fixes: f356fe0cba0e ("f2fs: add debug msgs in the recovery routine")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ inlined recover_printable_name() logic into the existing page-based recovery functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 339239bb7f63c..fd17ed279f282 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -171,7 +171,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -230,12 +231,16 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 out_put:
 	f2fs_put_page(page, 0);
 out:
-	if (file_enc_name(inode))
+	if (file_enc_name(inode)) {
 		name = "<encrypted>";
-	else
+		name_len = sizeof("<encrypted>") - 1;
+	} else {
 		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %lx, err = %d",
-		    __func__, ino_of_node(ipage), name,
+		name_len = min_t(unsigned int, le32_to_cpu(raw_inode->i_namelen),
+				 F2FS_NAME_LEN);
+	}
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %lx, err = %d",
+		    __func__, ino_of_node(ipage), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -282,7 +287,8 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
 static int recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -332,13 +338,18 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (file_enc_name(inode))
+	if (file_enc_name(inode)) {
 		name = "<encrypted>";
-	else
-		name = F2FS_INODE(page)->i_name;
+		name_len = sizeof("<encrypted>") - 1;
+	} else {
+		name = raw->i_name;
+		name_len = min_t(unsigned int, le32_to_cpu(raw->i_namelen),
+				 F2FS_NAME_LEN);
+	}
 
-	f2fs_notice(F2FS_I_SB(inode), "recover_inode: ino = %x, name = %s, inline = %x",
-		    ino_of_node(page), name, raw->i_inline);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
+		    __func__, ino_of_node(page), name_len, name,
+		    raw->i_inline);
 	return 0;
 }
 
-- 
2.53.0

