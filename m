Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CA478E25
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214209; cv=none; b=Rnq2TsHvq6tt6Gi7FCrGFgfnxfHuKHOqbS48IsbPCBkjyAchp00XvCMbPyt1a9wtQPNS4IRyScTX6I1uBf5xCNd/w9sWwGBaVnyikFi+g9JOQXBg6csVYcj4HhAbKWaSF1/993s0IKMhIBWcBbMzaqKYw+NBXA/E8OfOCXiVcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214209; c=relaxed/simple;
	bh=0lNtiiYjiKHj1hY3I7mB1ysp0MnYizqCf6yElH5532I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxJ4nymZO8wA1pygPYg58/TL4aVXUT9E/U4OBXKif0ndVImPMzzx2D9bpGUc/VlM8mO2fB5oil7dbFMiPlgNgMldVQGhMPt7tcgO5M+HvOxLbunrcct5BI9QNKokH4vlmVOSvC4EXNituZyw73Lj6V66v8WaDKUG2MHxsqPbp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvd9RQOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvd9RQOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C341F00899;
	Sat, 12 Sep 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789214208;
	bh=31oz+FatAKwC9kVqPzhNOxyMk0gIEs9GxOGL5uQmxQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvd9RQOQPjOQFraUoq+go018di8YE1DZQBux65+NOzsdU4jp4syIG2pzhnygUgTCw
	 GFpjBs8PeA8eS6Mfjr4ua+qjTAXn9aDUkTRaqGCrWSs/KET5RpF1kb9j6tUqMLbNJF
	 u2kAaKwo/CN/JJErJDCmGvwIlSqXrxXS39dnEfY2VeBkb7U1XdW1WN1TO7xPqzoIkE
	 V1bw7gWY5LY51ekuzBaIMeeLKCFVqKSubG+OXg/AtbCmCPMrtC3Ore1iAoHAbSP46s
	 uI3byImG08Ct6XCOmVsJ6aJm2KASdYYmpPsge22PNNljbm/DtwtHlWeUsqFV/oSbK4
	 IvXiTANG9H1eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] f2fs: fix to reset all pinned status during fggc
Date: Sat, 12 Sep 2026 07:56:44 -0400
Message-ID: <20260912115644.2476312-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912115644.2476312-1-sashal@kernel.org>
References: <2026090944-celtic-lavender-8b43@gregkh>
 <20260912115644.2476312-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 80a88748d71f2..0bf8041050add 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2137,6 +2137,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.53.0

