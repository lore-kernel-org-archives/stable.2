Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B13368B6
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176747; cv=none; b=jUtQP0h5eJHXo37Ve4w7PZfocSNXf9e7MA0Cr4vPGEhpKhK5HZ2QQaCLb7ATR8IeZG+PUcmE7U+g2l/QyKKMP/HmPcXpmq++NhDNsNPg72nXI1vYM5mVhCofmw4lvaMaHxqvgcDTdUY1DKIqkOReF4UnjtiMeYPOW7zyi/SXC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176747; c=relaxed/simple;
	bh=/N58/x9iEJA2qJppBcNmz53UqmFRhOYDUQpxgOc++Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8PUI/X0YpNFply9denSbWSNBYXG6kD/0DIZRXkKuA6vwbTLtjXTS6m8fXCM27QCGrf03ZvVJ4bfdlmOLi+Xu48srpQ5XXubdYeRT7j6fGDV1i3vWUzLTB4xejohW4Qego6MuDX5EX7Cju9MmQ84KGWnBsyJeYJ7u6YnCEhCPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVmnMKNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVmnMKNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BAB1F0089C;
	Sat, 12 Sep 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176746;
	bh=FcfsKUAOsifPontIZskDc+gINvT9otuG2y/qSZVrmkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVmnMKNIGhsPHo05npZnhgcsj+luiNWuy+AUyKBh8588qPBcVwXPsCl3rnqCuOrr1
	 jpHKBdDt7V4JDkrEt2TIkQhDqXv6IwQdKgeMH7h0FGp2bePpRya+Yn/SxfS4IcpYaQ
	 NnMkomWheGVbqRzFIoUwY5cN3J9hltGvgJWGcBDQw7hL7GyfnXqIIbU3cjv+kYnRAh
	 chDUsZ17uG/2xwpdM5J5DodGNIeJNvDdZve9SZ2zXULJ5beH1oyKzYRxFXu6+eMKUt
	 kwgjuUvzA8yUMHJJDzg/iouhz5dnqZGDlU/mcYbzPjWuU2gv/gN/PYbKKuhLZs8yNk
	 qivV34Yu4ieLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: limit recovery filename logging to stored length
Date: Fri, 11 Sep 2026 21:32:23 -0400
Message-ID: <20260912013223.1763261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090932-garage-squatting-72e9@gregkh>
References: <2026090932-garage-squatting-72e9@gregkh>
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
index b33e5220aa187..45572d1d2d4ee 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -176,7 +176,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -235,12 +236,16 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
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
@@ -287,7 +292,8 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
 static int recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -336,13 +342,18 @@ static int recover_inode(struct inode *inode, struct page *page)
 
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

