Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19A577E50
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653726; cv=none; b=cxXlcpx6iaEmDSXTF5WgU02rECqpea3NtTl5THZGsOcqpiwmFxY8S/YMwn0HX+3042NdDKpe7mpktpp2pYjPA0eHtxQ4hIxTOAJJp83GTn0b/yDkU5D0DIwopV43AHJju+V3rWxKDJkVkIgnzb8vRQxa3OD7zE9S83/6bI66YhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653726; c=relaxed/simple;
	bh=mBdrO+YLGZXw5hvRaoqu7oHbg91kb/bbSsvQlcMjGRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rghozaM8uJBASmXF8j1hgzLpDBN/R2/Yv2C22gFiue1p0GI2m+rTUoMjNlgIC+Ni0zbegWZLeFgyjIIVfu61m1A0xmcSbDTAu8v7LwuFssS03bydsUo0TV0zSg8i4dNJBuoJIc3wdi5mjG6hB1Eu7YCR6UMyK1YAZJgWdn4Ye6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxE64VOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxE64VOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507F21F00898;
	Thu, 17 Sep 2026 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653725;
	bh=LyB680cAqkHXdwHbuC62t1GwfrgtCAf5Hl26UxPfoYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxE64VOgh+PGI2CBCGBuWUsT76OQV3VGqdXgAVfWl4K+JqUuTUHI3NmeDhQ8LesnI
	 ZbDJIKMShX+eYGm6RCKsJOdvSqwkoxAJWxL7vu4FGR+VMbMaE6MUrIHO494yehZWHU
	 7xZbuHsrX7Th5RRBC+ZvSDK4kPYQ843fzl2Gia2GdO6QLhRAVm+mmS5Ugltfhh6N1K
	 6gESNTmTV+1kjtyLhINS7uQ/Uh6MmHj6Wn5Ib9oeCfzqWMUzTy3bjhvwJr1PEPhIYO
	 x0+Rr/i7vhQRCrxpGy6M7unJ94RN3Pdeewk6b+Fm72vNNZz4VP6wZAWCiblDIVuwRV
	 L4lDkzXT8/Owg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: report healthy filesystem events in scrub stats
Date: Thu, 17 Sep 2026 10:02:02 -0400
Message-ID: <20260917140202.504518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091600-festive-identical-c500@gregkh>
References: <2026091600-festive-identical-c500@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 0ae61c331ec552ad0c278c5c48a1c4ccb90b4bab ]

LOLLM also notices that I forgot to expose the "clean bill of health"
scrub stats.  Fix that.

Cc: stable@vger.kernel.org # v6.9
Fixes: a1f3e0cca41036 ("xfs: update health status if we get a clean bill of health")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ adjusted table insertion context for missing METAPATH, RGSUPER, RTRMAPBT, and RTREFCBT entries. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/stats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/scrub/stats.c b/fs/xfs/scrub/stats.c
index 7996c23354763..c6edb8c827dee 100644
--- a/fs/xfs/scrub/stats.c
+++ b/fs/xfs/scrub/stats.c
@@ -80,6 +80,7 @@ static const char *name_map[XFS_SCRUB_TYPE_NR] = {
 	[XFS_SCRUB_TYPE_QUOTACHECK]	= "quotacheck",
 	[XFS_SCRUB_TYPE_NLINKS]		= "nlinks",
 	[XFS_SCRUB_TYPE_DIRTREE]	= "dirtree",
+	[XFS_SCRUB_TYPE_HEALTHY]	= "healthy",
 };
 
 /* Format the scrub stats into a text buffer, similar to pcp style. */
-- 
2.53.0

