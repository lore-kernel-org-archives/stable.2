Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402916;
	b=FzpKMWhu70Y4qox9EZGm8rIefSACztpDq1LQ2tpDrYD1cfFoczEHPWyX+LKeT7yX9iaD
	 fnYTg85t6TgePqm8rLvYPa240gQA8MTmyeRs2Ri2F57bDbSQW9JIUYEXlWgrFcDs2lik3
	 emhTLd0WUkTbFpMf+Tau0Vi4IwWlnoK62qv5GfgbvRrje5l+cC19NeqszC9fOYVrwwF8D
	 0p+ZALz0IloquuyawwTnucLHUSp2sTYvdRNNs15ryi9k5SUHnvdndlRGCORP7ESwNwbZy
	 CeDDMCfJ8Ru1PqDey11/pEaOMvjQZYBTSctw/jBxzFsQYUVgRux42h0xd0BURd2ABlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7ObB/fiQRiAB1spYLLxpqZscb4BVDGZDX96vE43wjhQ=;
	b=W0LzpBK5IH8eBt3e1EFqNnUVPQFcALrGn3YrWJLOfn/4pJbTWezK1UQ+MDrLxc5Xdsbg
	 BdEpBA4EM7IYHjJO7btOhwxgJAxXT6OJcKKyOZ6d53mQ7B3SR7qn+lxGs/1KuRVhC0xLa
	 NnhmDl4qsC5M2OyaSHP61w8sh7Q0BdcQ3+l496TU8MUDZPoLQed/R0oD54uBRUW/T2wkC
	 iy7uOPVFv3kTtMA9MK1mdq71BYzdJwr01VweiI+IAvEha6OtnXWFmyNOy+H+MMKsYbcDs
	 O/GlFpQmO9WUsV4ccIW3He/99npiCOSQehh1VU19vbMA3d2ysroFYrWts72NFNQYMTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjDbYTPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504A606A883
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjDbYTPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F311F00A0C;
	Wed, 11 Nov 2026 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402916;
	bh=7ObB/fiQRiAB1spYLLxpqZscb4BVDGZDX96vE43wjhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjDbYTPHnJjd5iCLeIITCrpoVmt3mKyP6GuwmOz0MBwYdcxJ9hTGBNRShE6YtHhaT
	 2qE/2AHNfcx3rjKyXS4sovnQaCCZL2eRxZS+ueiK5Xeh/9+BVDjy+WqoR/QnosLIZC
	 SA5wCJKCKDYpdGIe9BAyeAOEJOUXUI/1d6IgBJS+eYJBoy1FKi7Wnx9pn6t81oV2UT
	 qJxu4RP7xilPFLbw8qu4vz+/xG3N8/cjodZ2KPFPvZ/f+oBS/Ec1yUJKl2SIcM0YF9
	 5B+hIC439zqZ/WhbhW3yhA6f0nWhq0kwwL101fA/ii91ewbdln/dnNq02fEyLbYDus
	 1NrGPbW/+OTow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: fix to adjust appropirate defragment pg_end
Date: Wed, 11 Nov 2026 08:15:13 -0500
Message-ID: <20261111131438.1022037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053449-failed-6.6-92154fe28c37@kernel.org>
References: <20261107053449-failed-6.6-92154fe28c37@kernel.org>
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
index 7ec8d054bf1ee..f787a5a64ef02 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2865,12 +2865,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
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
@@ -2886,8 +2887,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
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

