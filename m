Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1B3C5523
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082023; cv=none; b=E32t8OFe5PQx4npO3S1K+KXxzxUZIKkoCQMBPQBubkud4RBtM/1J5/6Svm8rf5ekAervwL/a77BQdfHLCR4BnYxpr0VU7cvsTr7nXgR+JX+HV49to7bsMkHcvR0rLQAeFqypP1S2WVkEvWMVmWD4bou3SFsyjHWTE+/s/7bCjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082023; c=relaxed/simple;
	bh=op0ULqGxyNRwzZg5qtLfkiC+5pNewOm0ja53C01NTMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7eGjj1nAdIGeNOylydhJ/A+G+DKppjB3WbNLAJTGWhwn678FmwPPvifKMnrs9KwlY7bO2P6Av7q5m5+xdE7EO9THn3p+o/4J1YZY99TxEO5AZIWL3px/OD67LOsBqZfp8E0vrRZO3RxlG+xG15fhouc+peW1mfnoHwkGxQd2y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnCZRzJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnCZRzJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD3D1F00A3E;
	Fri,  3 Jul 2026 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082020;
	bh=m3eIFex6zxFjsjoIjoVCFg/kUv75K2a+SjtAsrtZU2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnCZRzJOzdjFxH1+e/AthjYz/wTXhIYd3NSdZxFqs+Jhe7TLjxAlJWz2OQ1YaWEZH
	 ZU7Li8fvhpzCxrjpFRO1Wcedr8SSMPuLyrF+Q554pePDBjaxknm3WLBejam+vrweg/
	 JCKvwkUutOEfUc3D+g16BGKdthpfHHCdt1OX1olHGHLgKhG6mlVgxZfMCT1qHFFWS6
	 T1U4iiBQjJ0i0xZm43K0jVP878NB/EV0afidTSd6UTJrzTK0i78k5Isi5WsoaaQWJQ
	 onq9tnjSoZ/7Z0TxkrfmqZh1WTtavOgOg0aBBJ+wp0N7g7fCLSGGHx6EM7m/Ruls5p
	 LypS190yjCwjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] f2fs: validate compress cache inode only when enabled
Date: Fri,  3 Jul 2026 08:33:36 -0400
Message-ID: <20260703123336.3945189-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703123336.3945189-1-sashal@kernel.org>
References: <2026070218-taekwondo-skeletal-13d5@gregkh>
 <20260703123336.3945189-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 5073c66a96a9c23c0c2533ed4ed06e42f9021208 ]

F2FS_COMPRESS_INO() uses NM_I(sbi)->max_nid as the synthetic inode
number for the compressed page cache inode. That inode only exists when
the compress_cache mount option is enabled.

When compress_cache is disabled, max_nid is outside the valid inode
range. A corrupted directory entry that points to ino == max_nid should
therefore be rejected by f2fs_check_nid_range(). However, is_meta_ino()
currently treats F2FS_COMPRESS_INO() as a meta inode unconditionally,
so f2fs_iget() bypasses do_read_inode() and its nid range check, and
instantiates a fake internal inode instead.

Gate the compressed cache inode case on COMPRESS_CACHE, matching
f2fs_init_compress_inode(). With compress_cache disabled, ino ==
max_nid now follows the normal inode path and is rejected as an
out-of-range nid.

Cc: stable@kernel.org
Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed blocks")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 4a99a9eab8291d..7b387edb6ef642 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -498,8 +498,13 @@ static int do_read_inode(struct inode *inode)
 
 static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
 {
-	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
-		ino == F2FS_COMPRESS_INO(sbi);
+	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
+		return true;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (test_opt(sbi, COMPRESS_CACHE) && ino == F2FS_COMPRESS_INO(sbi))
+		return true;
+#endif
+	return false;
 }
 
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
-- 
2.53.0

