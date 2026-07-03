Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAC3D6488
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085022; cv=none; b=AHahaAsthNd6sdMxEiYQbOjenDAPy2aVywSTogoqc3TUWVpQ+xXwBUWvvwYbzFDGwiHeJZLVMVp8FpKr3eidn0Ve8J1ylpEObJm7FccntchD5QjEI/VJR1ISVCu6rqAPX4J2D1jwgUg9NPyj6wZLocyw6M8zJmy2nWrPPwebCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085022; c=relaxed/simple;
	bh=NJDSUfVrYEpex+e549WvmMEHs3G12Spna2GVhRIK9Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq4W8ofcXuQYANmO5G77FLWktAK0Sp8trowXY0XHpk0m2pzDlqPGdBVaRSvYpq1DAF8xJjFYY3cvieoK0VYKGAugoDhlT5uRNOXz/3jNYEiRLCaegvLgtVY37OamLV05xHA8THkjwsYb7riDQ0CrWRGqNbfuYgc1MZ7LjadRtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkOg6zQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkOg6zQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0311F00A3A;
	Fri,  3 Jul 2026 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085020;
	bh=7jPBbgit3jIHQLRh11TwU1p1v1IdI+1+fVlqB5oyykQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkOg6zQ/aSF2CtwRXVeXmsnaAdPE+noKLvtn1aLWDtNs9TWBUcaVkhB/HUzz6L1kX
	 plIF1C5Dk2dbwgC4FrfGjE+8+17Oh35iPHIlhTq5LwWcH0UX8EmRWnPfc4XFUl/8FZ
	 JVhWOWkA11BnEZmKsNnlazr3fgltrd70gqnUilgmeMVTo1yNqy+yUbExT9QcxQMZf6
	 4JwT7RiRAFkklC9fzT0By6zRw03aUjSLMM81nGtnqd/5hu0gLZJufCHjyBUby1WPHH
	 KjJk1fwrKvUMAOccWJR9gbLDjeLkYVY/ymDNOvNcntTqObMCu1h2NwqUwQABptoTnO
	 tIx6aln+/rwSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sunmin Jeong <s_min.jeong@samsung.com>,
	Yunji Kang <yunji0.kang@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] f2fs: fix to round down start offset of fallocate for pin file
Date: Fri,  3 Jul 2026 09:23:34 -0400
Message-ID: <20260703132334.4098206-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703132334.4098206-1-sashal@kernel.org>
References: <2026070255-livable-cheese-d39c@gregkh>
 <20260703132334.4098206-1-sashal@kernel.org>
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
index d4d485032e6ea6..3894c5889df8fe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1695,8 +1695,15 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
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

