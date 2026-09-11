Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896037E5C4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161352; cv=none; b=NMNFOpEQL4Bx23oxL8EHFcnbjFEX30OAx81AtBV7D62/M8wGmgF8SNo6jO/JZDqmqjedU4z/B+T32l8UpCT0ZwoHdht2Y3dHxqLWyOl8gfnG+iB5rvcl7M5N59ezQrwGF47MU2C7rC7BZsgyveIZS4VDddc7fN9LN25Zo4Cwir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161352; c=relaxed/simple;
	bh=8G/cBlfp0Thv840xzxUEt0Bnv8f4GaNtCgYFoTcmGkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVEzGhYhhpru469zh5I2WuWppX3edbvVz0aUZldjr2nkSVVyo9uYGDN3nzOUp4He0Uf+Yn9tqWEQpV4OqMJMagtQdZD4UFhZiqKNVhXoX7x9jidCugzm2/sg0YHpjTn/A7q9pIfBzYKYFJvXQ9w//iX+QS4cI8QXTo+iI/O0F3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJF6SVgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJF6SVgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42E71F00893;
	Fri, 11 Sep 2026 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789161350;
	bh=8qXO+q4ttao0jaOAGnbZ0DsqbTJv2AYyEzlhbsj/EWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJF6SVgMZlz06BCza6ygXHq/OYcBetN6nIjmuOidrnd9g/pvVBeipfauMi6MufEU1
	 TA/bcLmlL5swb1yl//ElbGc02ta/elV4iaGByzfe7PWZHwS3j+1KC/Igf4ZlAutNXt
	 HJkUij30AcPLwVKQ3stlfdNaggdraitdWEcCawmV0zqU16aXKN38y2ss/t4Zr9CuR3
	 d1SD07rPPo1N8TjpW+3Cv2wojrgw8WUj4mXdzdtQ6vs7asj663kIixPlqXoqB2c0kY
	 lrjOvGfX4nuQJBtLBNiUjkER0/t53Gr7RMRULr/luGJ1Bxm8SH66ezHRCNF7amrJiq
	 1jYyXeMAR+vRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: return writeback error from collapse range
Date: Fri, 11 Sep 2026 17:15:48 -0400
Message-ID: <20260911211548.1532911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090921-luncheon-anywhere-f22e@gregkh>
References: <2026090921-luncheon-anywhere-f22e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit f8a4108800254d6f7b2755515fbbd9d0caac561e ]

f2fs_collapse_range() writes back pages moved by f2fs_do_collapse(),
but ignores the return value. If writeback fails, the ioctl can still
truncate page cache, shrink blocks, and report success.

Return the error before truncating page cache or updating the file size.

Fixes: b4ace3370324 ("f2fs: support FALLOC_FL_COLLAPSE_RANGE")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ adjusted context to retain down_write()/up_write() on i_mmap_sem instead of filemap_invalidate_lock()/filemap_invalidate_unlock(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8e68546987af5..092ec12b6d638 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1402,11 +1402,14 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* write out all moved pages, if possible */
 	down_write(&F2FS_I(inode)->i_mmap_sem);
-	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	if (ret)
+		goto out_unlock;
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
+out_unlock:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-- 
2.53.0

