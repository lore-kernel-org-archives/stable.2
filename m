Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042845563C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211797; cv=none; b=Vne8dKrCNB1phT7j7Uhhp36WFmGDyOVzf1vk2QGQe04RQQ2E8uYEJ0e/G2t5PFzIQZ2gxiH4gOxhr+Hr7ZshoU9VZieBV2zNFOOQI1SsRCBrzD9zOXO4bZFIV43i2TJNazg6xrS31MrcWTvphTGtyHHFOAZX69jBUP5/S1AKdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211797; c=relaxed/simple;
	bh=7J3p9rzADdmEuSG8J++LR16g96U70R2E+6slQDlxFMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSmW3e3/QSBYIc2nw1scf7KD9HCfyang75NGE8CsLOikPWX5PucTaEd454ZbWmDcUHdguJbgMb1fG4Jg7STDX4g6fa+IsRLbyyjYwnpukDRkdmvBDv5r7wQyQaNiCg1Ij+tO3+j7XKnUV0sCx+ksFaXn/UiXFSgW09clK/DYoE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMEm8/i3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMEm8/i3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70CB1F000FF;
	Sat, 12 Sep 2026 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211796;
	bh=I3J2yKFkK8Bp0dacJgKInrd0VzR+5KQcJlmoOvdYybI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KMEm8/i3qgaokl+imhGE+Ig9LIwLtEHqHApzMZQo8N5agJX/qvPBYXGrWY8p0qfgP
	 qjYT7hIKl6ifNa9aiHf7F2yg6MoEX31u9VenE3NR3a2mYAGJR2/kHhm/4bj/7XA0wp
	 1F6mRfu9co3oZuk4ezfDpS/xTaAnmzLWD5IMN9xkJco6PhqxMZKPGMNJUAcqClRsNn
	 mRM0w8JA4Q774gNHPSo4BGFcgAzmgcPSCvFD79Z6lhXU77rfhw4Fc4o1BDOrOe8uVt
	 XFJMX3PvtiJH11VyBy15lsTZAkxDfBHMsR9ohdOL3pwGHuiBwybo9x1J7ozqrYaPXt
	 Lp86vfYuHYDiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] f2fs: use memalloc_retry_wait() as much as possible
Date: Sat, 12 Sep 2026 07:16:33 -0400
Message-ID: <20260912111634.2264257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090937-monsoon-alias-8907@gregkh>
References: <2026090937-monsoon-alias-8907@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 30a8496694f1a93328e5d7f19206380346918b5a ]

memalloc_retry_wait() is recommended in memory allocation retry logic,
use it as much as possible.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8c963d1738fd ("f2fs: accurately adjust free_sections during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/super.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d185b209f89a5..337eaba11db97 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -223,7 +223,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
 	if (err) {
 		if (err == -ENOMEM) {
-			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			memalloc_retry_wait(GFP_NOFS);
 			goto retry;
 		}
 		return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9d1b5699f5bf1..ab40f1c641068 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2613,7 +2613,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+				memalloc_retry_wait(GFP_NOFS);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
-- 
2.53.0

