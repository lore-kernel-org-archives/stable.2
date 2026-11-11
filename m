Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404292;
	b=Dr5Ur18Iw6VvFXjsYDMeltua+Bi32dThxkI1yxEwPQ7J9SlZRzZNaqOmW/Z/buJwX/IJ
	 72aciFYHeMEzZJ3RLCGy9MIKsrsb2OSHSqWnIm21IQpG/f62WBjKpmiTihby0LWtsflXk
	 nsnYQstbvQ2xs+HzM2JNrfVVKUndbD/A5U/7devJqESRcT1P7ERs/3SraCNmRSjH7rfr5
	 kKbcLvhshoM2d8VMNb/nmrBwTlKy6hYEcSH7FEz34BlFHzoNRsSQhEFmWJHQ1rTT3Wx5v
	 vJm65G0mB/daJQNlakxM4Wacb4hTjDFKKxgcC1CMPTz7Tar8enh3xk7FFKNWvRzz5Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404292;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FPFFwIjtZ7Za+AhwZ6bbtyh1kFz0B7eg2/yNlVrDdFs=;
	b=iyEnPCFtBxu8wCDmHDhUWaKxO4/O3JOVpO/jv+IMaMJbByY7cAMGYcvILO7dMFf86oY9
	 4MkX58m5FRWUrXugQSKFKlY9qHM61Cje8fSAAC1o5Lyi0jeo+QkIHzWZ28Dr5QVhTTn6b
	 9wy7jfGi6oMtR4qPCLUr9zmfImN7N1DS4WPyeSlW++GKxowk2jixjxNpK7mpBL5K2K955
	 rPG9W4G08iUkt5Da/B6gJkO8/KvlH/wuDKO7H5W2ZV1AI+SS+fDgjwrcX92YJluIMfO8s
	 E+j6d24Q4mXQxDcCZTZ94Y9kOfmNqmxAcmk3whvAnUS/6n9Q6ioxaReBu54aZ6xBPPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIAEGilQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B7606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PIAEGilQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D8D1F00A05;
	Wed, 11 Nov 2026 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404291;
	bh=FPFFwIjtZ7Za+AhwZ6bbtyh1kFz0B7eg2/yNlVrDdFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIAEGilQrdo9l80tt+04LZNw/okeyaZdge5BdYDPXPuAj7svkUZ7/l0tF4G4jPQ7n
	 j6Whfg/AGKJnhCwFCmh+um6niV/O3yhuq28xUQwYUVNY5BOEQa9vqVET1WrlOjLsZ2
	 AuFn5I6gZBCPS5niXMbnodx2/BScQGoQ1cAu+SKBljzMwr0l62eMtZ5QnuGGuaJW1w
	 hCeRo7OBAP/XiBpnVscPHK/4Too/LkhNABoRhdnLpD7IDaiUZg/wtgbtp2qFrHCHCr
	 UQOMKOUJhA1g1YcqPvJPfuVQAdY/3hpixMd2UqEKhoCTbt3w9xddBITZx8pJHIm8yH
	 BV5ZVpnE2M40A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] f2fs: fix to adjust appropirate defragment pg_end
Date: Wed, 11 Nov 2026 08:38:08 -0500
Message-ID: <20261111133754.1652660-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054825-failed-6.1-92154fe28c37@kernel.org>
References: <20261107054825-failed-6.1-92154fe28c37@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 197080156f27b6bf8cf198e9313dfbb94769c736 ]

A length that exceeds the real size of the inode may be
specified from user, although these out-of-range areas
are not mapped, but they still need to be check in
while loop, which is unnecessary.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 92154fe28c37 ("f2fs: fix defragment writeback range truncation on 32-bit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bde1c9cfe1df4..b2db6a5beba1b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2731,12 +2731,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	bool fragmented = false;
 	int err;
 
-	pg_start = range->start >> PAGE_SHIFT;
-	pg_end = (range->start + range->len) >> PAGE_SHIFT;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
+	pg_start = range->start >> PAGE_SHIFT;
+	pg_end = min_t(pgoff_t,
+				(range->start + range->len) >> PAGE_SHIFT,
+				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
 		f2fs_is_atomic_file(inode)) {
@@ -2752,8 +2753,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	}
 
 	/* writeback all dirty pages in the range */
-	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
-						range->start + range->len - 1);
+	err = filemap_write_and_wait_range(inode->i_mapping,
+						pg_start << PAGE_SHIFT,
+						(pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 
-- 
2.53.0

