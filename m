Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405044;
	b=2Q0dRn1qyieW0MoWRRy3hWGi3nI8ncAxbRi1r6NMRs5kn6R5byUvylqM3o+xl+8SQ/q+
	 ecGZhGlBlR9cxkVtOANHEy5Hexue4uUDITqNm4Ry4OOIBxAWYxiEJHea0siJ7qoKoF+Rl
	 LljWKM+zDup32KovSgezMwjRwkLsc77SF+BGUsSKfrYrFQYQyQZ0Y8K1F0p9kgR7fOtMg
	 bCxkdUq3eEAkcdcQPZWmDS08wIrxLNmyCZNTwt/6PbHOjBPWKX7XKQilXjS4d+y8URU3w
	 0QqUVrlXLNyQUSDgYaVskyHYxY5FSmskTHmPQ/FM+PLVufh8ARotWCN0e47ts9kwt/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PGDdvqI10RAjGUxCdw5RGgj79xDWMx/etfDrIYtjTyw=;
	b=1bqKgtfG0xkLAfGk/o8STk18EW4+w1Q4h3NWgwUuqr5dIO/0AtYJB53Os5HzNQrWZm/m
	 U4USeloyck1/yX5s9QkhdtN5ykvah7X1fieqq2PMOB0TgBAihV9VpVFIbhGYMcu+JaqJL
	 QWv5QFzEkYSN3UN9GndnX99DFR1qUNfVJa8NxW/OFHeYao/d1ugr+KNFvnWGxP62Z+dwr
	 YQgHJFoZLlHGg6P1KamV8w4lEix2tIuSwImS+G1VZ1bzqRypgXGApEQ+PddK/V7It+UhI
	 GKDTc5qi9FFMll6fgTGQO7Q2yKIwzr0cibZ0JPHJfUikEgpvtM7N43AHaFurERYp5lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPkP2s9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455C60A3831
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPkP2s9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9A1F00A07;
	Wed, 11 Nov 2026 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405043;
	bh=PGDdvqI10RAjGUxCdw5RGgj79xDWMx/etfDrIYtjTyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPkP2s9w77ev1xogu01tmeinCO8mPkP12/OHLXAUzvP9NpRBRDQPAISMOBuXskMlo
	 wY6lf7nDTEsD9jQCJz+vpRM1osDxY3Roa70kGRO9AdMyS/6SDmqxSL7QbQPaBsOyhd
	 /kevElV/bKD2Qt8dVGnZLeYn/Vo/bxEuoWUF0iGymDT+AIVjndM0Ct6mT3GZ52lJ9g
	 pJlvcFeYbhUZKaaPQBLI8fWEAWf4PVY4TZSSAW7YUEAJlQQ9ubSXzeLgZWO386c1Q9
	 DK/P4ztlkb6MBf3r3Zc88uhbnypmfbUohucJZRIqKz2RV+pvmFs6N2/+rhAKdxAhsF
	 R7WbawbAeKENw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] f2fs: fix to adjust appropirate defragment pg_end
Date: Wed, 11 Nov 2026 08:50:40 -0500
Message-ID: <20261111135034.2134948-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060550-failed-5.15-92154fe28c37@kernel.org>
References: <20261107060550-failed-5.15-92154fe28c37@kernel.org>
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
index 892f19f67904f..36a2fbfc19997 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2616,12 +2616,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
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
 
 	/* if in-place-update policy is enabled, don't waste time here */
 	set_inode_flag(inode, FI_OPU_WRITE);
@@ -2631,8 +2632,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
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

