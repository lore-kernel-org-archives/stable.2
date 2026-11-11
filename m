Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404293;
	b=PTHuGZ3utocn7QTF6RsuKZiFAYlmCmneIiLSTklreUPcwiSoaJXyyq9ae2/tijp745s6
	 pt4vaiUQue73o3BXvuX8nuCmbkRnobx/p3mDH0AeKOPHQBx/lthwDkLNijdl/hJ0LJVvN
	 KCgIedBGOTCFMuRyWe9uPHFRgPkoy75PxyBtzuj9TthJVtWcOPHX+32OCQyoyjrjbi5TQ
	 mThUR+oIPbJDtx4mLa7gPbgOmdFGToFppfw+pyFgFSKe/Oazf4j3cQpDpa+9CvEMkFXZi
	 k4n1BjrawxmWbY2BuX9s36tnTVI3dVl5q90AxZ2AQ56kVyagsxYUkySgm16xLls+3bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LOqWMPg6TKz9OVsWrPh41gTV0fxIK4SPwGC4Z+jlmsE=;
	b=eGfdYDvrNUfN8wixbdEsutgUYBVuvHSeGPbVRUGg7ZTTEkM7pwBIYVmaSWfVSG0HY+eG
	 O4ovafLzAn7EvD9uMcmmaMGbkBFPRbz5xjnciq6aS6bBuwK3w+RucL9T1Bq7zgXSGdsx7
	 Yi9YxzbDM8dYgYZ7MkmmZlQJzt0uvPQLDqo13nyJnqiIkegbxWiO/Bi/ZZ+AMJzYka6Jv
	 MwGssYa7y89XWilNzA63Pn4prSnuM1WyxcQUForOCKDYWo1M3/azR13smRHqqfDsSuwcZ
	 /wBpslHbqO9ub9YhmMAuQ358MsLweAJPDJ1WE+yV1nZmPifnmrYAOgEX0eClG9+e0Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6Kch3cn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23977606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6Kch3cn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA301F00A08;
	Wed, 11 Nov 2026 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404292;
	bh=LOqWMPg6TKz9OVsWrPh41gTV0fxIK4SPwGC4Z+jlmsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6Kch3cnqCPBECmWwPGSqx9ZnNsz134S3a8clMv1UiRk0Obzx1G7/WIBy/oeSbqQs
	 7N8P+AzgfP68vol+1ahotr/qcsGoTQB+GDXkYduoVWGseP0EQVbrJ3fktVjgh+lWY9
	 D8jNnWWqYjYtfeEYUvDExGuzDEwHsPyE4UaTavPkBqas/JKzcHDR6mnH7PRXdAcMMV
	 QS5us0Mw4Xwa0CmLKeQ6MamuBcUKwCdRWl6YV2V2D5vYzbGawh9Dk8/jrcZHkQs4Mo
	 BzZCjJIFi1eGr+noijasQV7IZ2G719IBFlZ6RIY+BNe9h7csqxw7K2ib228v/bCcBF
	 rvMT69x5CaMYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>,
	stable@kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] f2fs: fix defragment writeback range truncation on 32-bit
Date: Wed, 11 Nov 2026 08:38:09 -0500
Message-ID: <20261111133754.1652660-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111133754.1652660-1-sashal@kernel.org>
References: <20261107054825-failed-6.1-92154fe28c37@kernel.org>
 <20261111133754.1652660-1-sashal@kernel.org>
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

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

[ Upstream commit 92154fe28c3701bebf75176dc5522bec62519a8f ]

f2fs_defragment_range() flushes the range it is about to defragment:

	filemap_write_and_wait_range(inode->i_mapping,
				pg_start << PAGE_SHIFT,
				(pg_end << PAGE_SHIFT) - 1);

pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
shifts are evaluated in 32 bits and truncated before they are widened to
the loff_t parameters.  pg_end is only capped by the file's page count,
so for a file larger than 4 GiB the shift wraps.

For a 5 GiB file pg_end is 1310720 and the range collapses from
[0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].

The matching call in f2fs_collapse_range() already casts:

	filemap_write_and_wait_range(inode->i_mapping,
				(loff_t)index << PAGE_SHIFT,
				((loff_t)pg_end << PAGE_SHIFT) - 1);

Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
"shld", i.e. from a 32-bit shift to a double-precision one.

Cc: stable@kernel.org
Fixes: d323d005ac4a ("f2fs: support file defragment")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b2db6a5beba1b..0951f34df706c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2754,8 +2754,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						pg_start << PAGE_SHIFT,
-						(pg_end << PAGE_SHIFT) - 1);
+						(loff_t)pg_start << PAGE_SHIFT,
+						((loff_t)pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 
-- 
2.53.0

