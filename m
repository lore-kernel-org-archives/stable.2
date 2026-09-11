Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD84BB269
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161340; cv=none; b=oJW4rZoEJoHtskUteaIB+KROh0KNaH9Nmo586+UkND5G4ZZiBGWUafv1jZF5i1sThFbdnr2+87Etfun5nZY3mNQV1JAKUSEeOueeIIA5cKEU8B93D+5mg2Zp4+eYQhaVA5boumvrn5/njaS5GOXoRUvEVTbwpV+kgy0hucu6ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161340; c=relaxed/simple;
	bh=YQqyGhufXeQsq4VNewYsyk13YXbgmAB863rJV4bPu6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6p+0PAi+9BZ3SUm+yJlp3PM1rJMSyTJI7dqKP38Xmwf0mphd+9refuhqHd/hSOx0w4OJgLy67tKWFoXQQVerqF2HzZ76+HiTi0X1jaitqdz/4umcvb+DmC2psZTLR0ntIJybtWM0EKI50HmvjfcCWa4CdAelRFtY8VjCUYmDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd2Mg98L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd2Mg98L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184F21F00893;
	Fri, 11 Sep 2026 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161338;
	bh=nZ8caau7Ev6Ix8wzVmg1YSzK6cY5EJsJacZG9gvhKn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kd2Mg98L1SBmYQhVa4Q+EYN3yYXZfXhzslFtZTPwOMz8wAuzaod7/AQ6Jv3N0Zx0v
	 tU+fhtenH1epzCLPpZlu1y67PPkrCJ91JMpk+xEn3LS6hAlW34OWkktMMA4n3H6CyW
	 q0eg/nitbh8Jl8PmAArvp9zR9PofJ+7Pa1vlmxLlq+gw7Dm1aIN2nxT8Upk+vUC8j6
	 6lZiPnf3WsObAnfhiVmO4TSj991uuIFhvj/QPHtarIRQgb/Y0gcqRdqbEpOSmZF18W
	 PmgM3EXFDd0idlwvKHOtg5fpD/4p23RROFbLAWdn503eGssGYkGCEQPUo2FE6QT0Wd
	 FXOQXinkhkIhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: validate MOVE_RANGE destination size
Date: Fri, 11 Sep 2026 17:15:36 -0400
Message-ID: <20260911211536.1531690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090932-greeting-crease-8344@gregkh>
References: <2026090932-greeting-crease-8344@gregkh>
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
index d321a42f97c89..fc41ac59b083d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2995,8 +2995,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
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
@@ -3053,8 +3054,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
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

