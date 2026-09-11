Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC752D2C7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155150; cv=none; b=Koo2a1mY3T6OetgpbhMP7hUNlYDYQGErZtT4ROwyEBK2L7UQqgwF85Me+HQfQ/JxnXEukLHiQMsKIgP4OBwS0OnLsuURmrx+FqRcK0ZAEN1gUvTBD+3g9zZ+Dv8Pv7Pfc5XX1bXd+J8znc7F+mht7/0g7w6Ox534mF3/FberSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155150; c=relaxed/simple;
	bh=CH4872VFWSUG8bB4xgsCN9vbsrp8hUfC9IsloZnAbZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6G1qU/JcMxNDZQH5QblfVs7gEOkvjs8LavHGVKc5lH5UGLh/nLaVaN+Q15bD6nsUAkg5IOonZYgZW9ws8dSoKC2Ec+l0pZTE5jSaDh4Znj0DkIofz3TS2/GofHeNfpwWnwJbPKDP2I/5YzLfGTsdIU3tz5vvkCqnzCrNtCS0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4hPixe+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4hPixe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342881F00893;
	Fri, 11 Sep 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155147;
	bh=G/4fnvrErQtUlxLSUotkxV9tZz8yMq+cyDt9RdqAj4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4hPixe+YY3eJ/jwiVR+bR0oN5BqSb6hMq5McTUoHqkvDNiOzMMwtNnnMVzmC9073
	 jvrUrv1SAmCfgJ1sIXL3SefiNYoXitt8cjRizQLuXdl6zXrLMPj+ifhDXmcggGcgc/
	 Zzob+LA6k7R3dgPuma2KP4AXISKSPd1Pt86pfcWqTOuI3M+W2oqT6E6msHyOiDyIzh
	 hG2veB4KCd1zs1YbhdN8fxq9U0rLFXI3+CMkt7Hp+zST/TBdiow6sGijNENLQW8yiA
	 aHOr5bzR1bMLvNZzj4N+/Fyw5ybTSYwJMGDx/bSzIKRVPST3dw3AFtZy4as2batTZl
	 yF3PU+xEcYAXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: validate MOVE_RANGE destination size
Date: Fri, 11 Sep 2026 15:32:25 -0400
Message-ID: <20260911193225.1413886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090931-net-monotone-74ea@gregkh>
References: <2026090931-net-monotone-74ea@gregkh>
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
[ Adjusted declaration context for the missing `struct f2fs_lock_context lc`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5f69bdca95c27..f4c386512c14b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3030,8 +3030,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
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
@@ -3088,8 +3089,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
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

