Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB43E317B
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085469; cv=none; b=o4qReemTOdfWw0XWUd5ukudxDmNr72VMJD2DWcme4ST0m+IReJMNIDggt4A8N4NvxHqghOrm3/QW19+jANLXRRd8D31+obzg7QRsZH1U9lYarMxACH3rzAdHQfUSonH3/NPr3bbduzCX/5pgc9VTfK5fbjVaFfXG6IZcttR2Ems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085469; c=relaxed/simple;
	bh=a28YZQ+5NWfLLJgONKTEJZk2w1Bq3lIvrQIutsDC7Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU6TaCn038HsIsHxh7+0bmXQNcJZIwpc84UgvY08p/4l1FMuOd5uOfoHHKRet59pmI6AmmFKwbC9CQQyDC35Gh/+LT6EMB26HQ29+dwpz8WYdFNiBmiuYkwofc61vNouyfTi/u+faHwKeOWgqCSvbyzyGRLz74qykN3kNpyCaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omdnSfg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omdnSfg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047491F000E9;
	Fri,  3 Jul 2026 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085467;
	bh=Yk4qJOAflG/F/JKT4EUYznJKnQ42uMxf9lSqRTxoL54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omdnSfg6gZ+Nk1cuPPGxMITVO/xDmqLbI/3fOj4yPEJy0nQh4jnhxIlpAVipDIxEo
	 hKyk8pHKnWEtwr7QncNoNrR/h8aKyH8FVUVoTCwORN7zTj66yXuDJzik4ZfNGqppQw
	 UxnZGfgi5UvFEBbx0ZWhgbnbs77DdvUaA5HUVdueKazjIBpodp0ryzCK952LgsE6m0
	 5vKca1HfUPDJt36TtRhlr3A+e4ulH8ZxOmvtoL+NrSrvfCB5tkoHVOUsS922/x1MIj
	 sh0j+wH2nYNXc6/04AXyePHOqpYjRLXmC3mmvW826y/s/QJEDSBhrP58sNnvmMG6qu
	 VMUmXjhV6EZUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sunmin Jeong <s_min.jeong@samsung.com>,
	Yunji Kang <yunji0.kang@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] f2fs: fix to round down start offset of fallocate for pin file
Date: Fri,  3 Jul 2026 09:31:01 -0400
Message-ID: <20260703133101.4123681-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703133101.4123681-1-sashal@kernel.org>
References: <2026070256-cranberry-relax-7024@gregkh>
 <20260703133101.4123681-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunmin Jeong <s_min.jeong@samsung.com>

[ Upstream commit 4275b59673eb60b02eec3997816c83f1f4b909c4 ]

Currently, the length of fallocate for pin file is section-aligned to
keep allocated sections from being selected as victims of GC. However,
for the case that the start offset of fallocate is not aligned in
section, the allocated sections can't be fully utilized. It's because a
new section is allocated by f2fs_allocate_pinning_section() after using
blks_per_sec blocks regardless of the start offset. As a result, several
unexpected dirty segments may be created, including blocks assigned to
the pinned file.

To address this issue, let's round down the start offset of fallocate
to the length of section.

The reproducing scenario is as below

chunk=$(((2<<20)+4096)) # 2MB + 4KB
touch test
f2fs_io pinfile set test
f2fs_io fallocate 0 0 $chunk test
f2fs_io fallocate 0 $chunk $chunk test
f2fs_io fallocate 0 $((chunk*2)) $chunk test
f2fs_io fiemap 0 $((chunk*3)) test

Fiemap: offset = 0 len = 12288
    logical addr.    physical addr.   length           flags
0   0000000000000000 000000068c600000 0000000000400000 00001088
1   0000000000400000 000000003d400000 0000000000001000 00001088
2   0000000000401000 00000003eb200000 0000000000200000 00001088
3   0000000000601000 00000005e4200000 0000000000001000 00001088
4   0000000000602000 0000000605400000 0000000000200000 00001089

Cc: stable@vger.kernel.org
Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2a4faf04331ee..8e68546987af52 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1682,8 +1682,15 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 	if (f2fs_is_pinned_file(inode)) {
 		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
-		block_t sec_len = roundup(map.m_len, sec_blks);
+		block_t sec_len;
 
+		if (map.m_lblk % sec_blks) {
+			map.m_lblk = rounddown(map.m_lblk, sec_blks);
+			map.m_len = pg_end - map.m_lblk;
+			if (off_end)
+				map.m_len++;
+		}
+		sec_len = roundup(map.m_len, sec_blks);
 		map.m_len = sec_blks;
 next_alloc:
 		if (has_not_enough_free_secs(sbi, 0,
-- 
2.53.0

