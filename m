Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EE59E333
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161360; cv=none; b=A+d8RwYAuqbXuYdUtnmnO9RYVqdoXyl35fR6mVmdwXdeK8vkKiAISG/dtG5WLTeww+IhZsuGpVT0GYTlqf0YgH7XtiTEnn5V/ij4z/wZ7g690gBBerAaJidgJAC1PP9+8ocvjwIAVhKPSKOuC1l/MVGKBFMNbz2aSMeovBINkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161360; c=relaxed/simple;
	bh=kysZ0Va4sXk4YJ1G/NLKiIOJNWSuG0Sqw0+aF1/8QR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfSMPQyIllcdyYbkuHoNUSscTIzUJyySmgX7nn5qOZTYOGVgunm265q3DjUgzn4L46UIr2UW3YUVp+ObNNbf0MIFMB61Zyo7xXscmRYXo0B5YlE2YA/DRnOZnLNh6v9m+aSCYFXiHmot9p3mFsLZLbuJ1DsQQRlBbbGVl02z54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4oYyj+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4oYyj+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03AC1F0089A;
	Fri, 11 Sep 2026 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161356;
	bh=Cz2cvjdia/lku21ilyW2PLM6EoI1c1jj2npivgPrm+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4oYyj+lxaNIpEPglSn5isWDRBSV+3iPaMxQq1HRojY37EjEwd5v3yo+FsdMY66Ka
	 QStQCaSfLrfjwpZ+QAzWK4Sf30qwZvPGsXG/OG4Drpm0ylZ+ildix4Ob4HwXQn+GAH
	 02+UGd7Zq7khX1rfm19m4RTc+sSH+SxJCR6NaeR5XK9NFBwPsp2d7AkpmtshyK3ofW
	 +Uk4EbQ0v6souw/thNI+Ql9WCj9qUmhz9ovfcbw7H020Qxm6P1rNG/iNHDLEnTAi24
	 IvJG3IpP54EF7aJejaJJy61Fl9YeWj13dBqCbMC6aQ4wQxppqIipqerTFNWEgRZS+/
	 qmopEUpj8e5wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: limit recovery filename logging to stored length
Date: Fri, 11 Sep 2026 17:15:54 -0400
Message-ID: <20260911211554.1533186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-skimpily-unvarying-9950@gregkh>
References: <2026090931-skimpily-unvarying-9950@gregkh>
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
[ adapted folio references to pages and retained %lx formatting for unsigned long inode numbers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index bc105da3e7460..f05206e32ff51 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -157,6 +157,22 @@ static int init_recovered_filename(const struct inode *dir,
 	return 0;
 }
 
+static const char *recover_printable_name(struct inode *inode,
+					  struct f2fs_inode *raw,
+					  int *name_len)
+{
+	static const char encrypted_name[] = "<encrypted>";
+
+	if (file_enc_name(inode)) {
+		*name_len = sizeof(encrypted_name) - 1;
+		return encrypted_name;
+	}
+
+	*name_len = min_t(unsigned int, le32_to_cpu(raw->i_namelen),
+			  F2FS_NAME_LEN);
+	return raw->i_name;
+}
+
 static int recover_dentry(struct inode *inode, struct page *ipage,
 						struct list_head *dir_list)
 {
@@ -169,7 +185,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *entry;
 	int err = 0;
-	char *name;
+	const char *name;
+	int name_len;
 
 	entry = get_fsync_inode(dir_list, pino);
 	if (!entry) {
@@ -228,12 +245,9 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 out_put:
 	f2fs_put_page(page, 0);
 out:
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = raw_inode->i_name;
-	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %s, dir = %lx, err = %d",
-		    __func__, ino_of_node(ipage), name,
+	name = recover_printable_name(inode, raw_inode, &name_len);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %lx, err = %d",
+		    __func__, ino_of_node(ipage), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -281,7 +295,8 @@ static int recover_inode(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *raw = F2FS_INODE(page);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	char *name;
+	const char *name;
+	int name_len;
 	int err;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
@@ -330,13 +345,11 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (file_enc_name(inode))
-		name = "<encrypted>";
-	else
-		name = F2FS_INODE(page)->i_name;
+	name = recover_printable_name(inode, raw, &name_len);
 
-	f2fs_notice(F2FS_I_SB(inode), "recover_inode: ino = %x, name = %s, inline = %x",
-		    ino_of_node(page), name, raw->i_inline);
+	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
+		    __func__, ino_of_node(page), name_len, name,
+		    raw->i_inline);
 	return 0;
 }
 
-- 
2.53.0

