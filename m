Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259733CCFB8
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082024; cv=none; b=Qdi4vtqdh0kog+/VUU7KiWqX5q5dYqxHd2scRB08oOgM9KtcoD095vXV7Rl0qIbNTd6GL84eu6MrZAH+r2rEbtz/D2+tP//aKBsRV9rwUNYGI0mBTQUoSYfOU3ImLZjmOcyTYdoUri45k19JfE/TUwPDNC7aaWmwj60CtxVXzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082024; c=relaxed/simple;
	bh=Iwx8oZ7/7Jr4sTS3vwCIMK2rRu3GdndaIh9ngB4ncgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqbMJ68hosYsMU3YVRxonKFtMNW8hSI5raNAYA+ktPa+WFqS6mx8dP1/Dd2FWNszKVAcWTkWmkVmls/QT6fZdxyWZYn/hRcpoa3ES1+utCMLjxPzwvk4ohLS7whugjyqmZHNTKXRzt2psbzoUQJ/63Mf2U/naYjj6g1T2jTulnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcV2Ko/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcV2Ko/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE0F1F000E9;
	Fri,  3 Jul 2026 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082019;
	bh=IzTtUWvcvKwy5/CaSNmD9QE0NUxcM1je/AKQaH18lH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcV2Ko/TStpr5aVfO7MqhWtbfXpGuoLWol5CjTq1AfCqcbrtdG25RKszBkXSvfRP0
	 NEl3dCyfhRxNwzXrM92U8LkkjGAjwIEkDOVKx3MK6cDcELOK4r/Wtu1d0v3L0SpU8s
	 QHvIQrZCCxCPo0TfuWWhK0rAkN1F/l9j+PT5A3UZdEDqiWkaJaBWri2PdA+0eFkEpj
	 RMRxcMs2zOokI+4FEDHCOkoeNOx0K4eE1LHYYBf6q1SDDtx20JML9YJyb03P1Qs8j/
	 liTO+XVnBqWSLenIsG7Ng8rfSp82MY4Gvq87s1hPNDMY9aVA1kGuuLVymmSocF7/t8
	 Vx4IB8B29HhdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] f2fs: fix to detect corrupted meta ino
Date: Fri,  3 Jul 2026 08:33:35 -0400
Message-ID: <20260703123336.3945189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070218-taekwondo-skeletal-13d5@gregkh>
References: <2026070218-taekwondo-skeletal-13d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit fcc2d8cc96b2f6141bbbe5b1e8953db990794b44 ]

It is possible that ino of dirent or orphan inode is corrupted in a
fuzzed image, occasionally, if corrupted ino is equal to meta ino:
meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
call paths will get meta inode directly, it's not allowed, let's
add sanity check to detect such cases.

case #1
- recover_dentry
 - __f2fs_find_entry
 - f2fs_iget_retry

case #2
- recover_orphan_inode
 - f2fs_iget_retry

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5073c66a96a9 ("f2fs: validate compress cache inode only when enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7494a68a53196f..4a99a9eab8291d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -496,6 +496,12 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
+static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
+{
+	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
+		ino == F2FS_COMPRESS_INO(sbi);
+}
+
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -507,16 +513,21 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		return ERR_PTR(-ENOMEM);
 
 	if (!(inode->i_state & I_NEW)) {
+		if (is_meta_ino(sbi, ino)) {
+			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			ret = -EFSCORRUPTED;
+			trace_f2fs_iget_exit(inode, ret);
+			iput(inode);
+			return ERR_PTR(ret);
+		}
+
 		trace_f2fs_iget(inode);
 		return inode;
 	}
-	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
-		goto make_now;
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (ino == F2FS_COMPRESS_INO(sbi))
+	if (is_meta_ino(sbi, ino))
 		goto make_now;
-#endif
 
 	ret = do_read_inode(inode);
 	if (ret)
-- 
2.53.0

