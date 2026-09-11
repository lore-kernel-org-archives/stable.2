Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B73BED18
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152533; cv=none; b=T0EpHYBEEkGGMMCn9/WG/SNwTssB6bQDMyi+II+15zI6foqh/4IoxPusJ/BabPkV2mX42S7ef0SYK0xJp0ndEXZ1tl5up8+iceZW148ED9UM15x8i2nCMQOlae/xgXvSGsiWHchYA6vkDW31DtI/1pQg30dTvizFMcV1IeReAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152533; c=relaxed/simple;
	bh=IdcZEFu/pKRBWmz9tVX42vURRFHYke6fbyEK4t80FGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHjGHzkCTWk9j4XmVxd7oMhDGlPnb++xgc7sUxMtR+9IcLpwTOY5V7r6uVV8V+SJ/plMCv0YnP3AY6aIVYU4p6ANxjy4pvIqWTRYyh9Ig9PeZXDIGQgMP2rtlTsHFy+8r1QKXntI5XaaXccWGurdIOeGxxiHjSaq9B5hHz/TZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3ql2Cda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3ql2Cda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B621F00893;
	Fri, 11 Sep 2026 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152532;
	bh=eH/aPcK33EXUvjYt+InznUy1hSSgZCL2eDrfvX0HlHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3ql2CdaTpGBmR8bPgyP5uutMaboitO66iO7o6cNe0IhttO++wx+vyl5woYgcFpA8
	 B6tzO4mzj7+oteAaUxoygANBoITihRhHmbe0h1nxSE5s868bwpaDvyyK0wl1hiqArC
	 qyEps3+34UE4wDeTUUQkblE1Jol2j40uZX83QZvhESVIFdntLtaC17wQIlzCdZO4LF
	 bhUrxJ8g2EGgmh2xUsIU4cyFe6rSXigc4Rmnw1NKNw01m9R/g7LPTqBdvQRF9mwz82
	 RImkwyEWiReMaHxeFlVXxg5NlLbeZZ+6gwPcAxxwS/5ebDgHVczWtajyaPh9RuLKGg
	 MpMtp30JPlD6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] f2fs: validate MOVE_RANGE destination size
Date: Fri, 11 Sep 2026 14:48:48 -0400
Message-ID: <20260911184848.1352437-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911184848.1352437-1-sashal@kernel.org>
References: <2026090931-unlined-lushness-1f58@gregkh>
 <20260911184848.1352437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit e533889fc26aea0cd83c90327063f272061dd820 ]

F2FS_IOC_MOVE_RANGE checks the source range, but not the destination end
before updating i_size. A source hole can expose this: __clone_blkaddrs()
skips NULL_ADDR entries and returns success, so the caller can still extend
the destination inode with unchecked pos_out + len.

Reject destination overflow and use inode_newsize_ok() before extending
the destination inode.

Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ adjusted declaration context due to missing struct f2fs_lock_context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 47b94e57cc7f2..1c7f1d71449df 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3175,8 +3175,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	struct inode *src = file_inode(file_in);
 	struct inode *dst = file_inode(file_out);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(src);
-	size_t olen = len, dst_max_i_size = 0;
-	size_t dst_osize;
+	size_t olen = len;
+	loff_t dst_max_i_size = 0;
+	loff_t dst_osize, dst_end;
 	int ret;
 
 	if (file_in->f_path.mnt != file_out->f_path.mnt ||
@@ -3234,8 +3235,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	dst_osize = dst->i_size;
-	if (pos_out + olen > dst->i_size)
-		dst_max_i_size = pos_out + olen;
+	if (olen > LLONG_MAX - pos_out)
+		goto out_unlock;
+	dst_end = pos_out + olen;
+	if (dst_end > dst->i_size) {
+		ret = inode_newsize_ok(dst, dst_end);
+		if (ret)
+			goto out_unlock;
+		dst_max_i_size = dst_end;
+	}
 
 	/* verify the end result is block aligned */
 	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
-- 
2.53.0

