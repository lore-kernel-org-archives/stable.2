Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAF2C3757
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388780; cv=none; b=cPgL/uJk6PUqR43AXZ2TLp8y9/Bb+aMiTVOwJIwJ98y9INFz5aUbaEDlwKq0MJ0bJDRVnHfWhxUpKiCCCgiPDlx6/r5NizsgKKxoNpY8erYer3nIlq01egLSI+Bxm5erUkjLa0XkFAktPQlKz1xV49Ca8NxtvG0mErz0uTOiG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388780; c=relaxed/simple;
	bh=xPjXlggnxAeem1C75EpcNeusoWq+h/PP6kWFx47ZrXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPIb6cRT3KERA4/5esMeENSNmzJ4CFKTMvSLA3k85hg1t3Rry+EgMzps8uY8zAsj0ynBCtzEJ655fkT34JcBQJgyEFnAm7QCrDjP1dkIpStpnn0/73j0BoCuC9pD8C8aEv/enwBBpkaV+ErwE2iu/+zi8mMHsEZC9ers2kziSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvDYyxTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvDYyxTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68FF1F000E9;
	Sat, 18 Jul 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784388779;
	bh=TxO4D14aS+jYFu+bnx3bIy/JXPfgMlGpUPJiT5HA2ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvDYyxTpO+OXbA9U7vKsULU8I683BhJKtdgz1xpi2FFvwWaEub77t32s3Csah+Nkc
	 +QD/A0THiH5jXKleHDk4hHhwwirPiFcTqPt1rAkLrtltVlyoigbAg8347a0y5IeyBY
	 G4XfsUNWXsICe9OIprNnG/bQgvfqm0nzSnI5AtJWob6iHpZo36IF6E6EIrw6lbGxxd
	 le2oQEqQ6hiUM0PIFiFnF66u2xvfey60vE3lWo58S6uwhO1/Y36yyt9vFEbOsskW1e
	 CQgS3UGQ0xgcby8gEpAfyDVglHem683N63FN/S3K4I6BOegQdqouVSKQVbq609lWhC
	 87kjMbsQ+l4/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xfs: add a xfs_groups_to_rfsbs helper
Date: Sat, 18 Jul 2026 11:32:56 -0400
Message-ID: <20260718153257.3311310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071441-surfacing-postwar-8451@gregkh>
References: <2026071441-surfacing-postwar-8451@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 0ec73eb3f12350799c4b3fb764225f6e38b42d1e ]

Plus a rtgroup wrapper and use that to avoid overflows when converting
zone/rtg counts to block counts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 44cccefe6574 ("xfs: only log freed extents for the current RTG in zoned growfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_group.h    | 9 +++++++++
 fs/xfs/libxfs/xfs_rtgroup.h  | 8 ++++++++
 fs/xfs/xfs_zone_gc.c         | 3 +--
 fs/xfs/xfs_zone_space_resv.c | 8 +++-----
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_group.h b/fs/xfs/libxfs/xfs_group.h
index 4423932a231300..4ae638f1c2c519 100644
--- a/fs/xfs/libxfs/xfs_group.h
+++ b/fs/xfs/libxfs/xfs_group.h
@@ -98,6 +98,15 @@ xfs_group_max_blocks(
 	return xg->xg_mount->m_groups[xg->xg_type].blocks;
 }
 
+static inline xfs_rfsblock_t
+xfs_groups_to_rfsbs(
+	struct xfs_mount	*mp,
+	uint32_t		nr_groups,
+	enum xfs_group_type	type)
+{
+	return (xfs_rfsblock_t)mp->m_groups[type].blocks * nr_groups;
+}
+
 static inline xfs_fsblock_t
 xfs_group_start_fsb(
 	struct xfs_group	*xg)
diff --git a/fs/xfs/libxfs/xfs_rtgroup.h b/fs/xfs/libxfs/xfs_rtgroup.h
index d4fcf591e63d08..a94e925ae67cb6 100644
--- a/fs/xfs/libxfs/xfs_rtgroup.h
+++ b/fs/xfs/libxfs/xfs_rtgroup.h
@@ -371,4 +371,12 @@ static inline int xfs_initialize_rtgroups(struct xfs_mount *mp,
 # define xfs_rtgroup_get_geometry(rtg, rgeo)	(-EOPNOTSUPP)
 #endif /* CONFIG_XFS_RT */
 
+static inline xfs_rfsblock_t
+xfs_rtgs_to_rfsbs(
+	struct xfs_mount	*mp,
+	uint32_t		nr_groups)
+{
+	return xfs_groups_to_rfsbs(mp, nr_groups, XG_TYPE_RTG);
+}
+
 #endif /* __LIBXFS_RTGROUP_H */
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index d18c43598d4b39..935b21c2b3bf52 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -181,8 +181,7 @@ xfs_zoned_need_gc(
 	available = xfs_estimate_freecounter(mp, XC_FREE_RTAVAILABLE);
 
 	if (available <
-	    mp->m_groups[XG_TYPE_RTG].blocks *
-	    (mp->m_max_open_zones - XFS_OPEN_GC_ZONES))
+	    xfs_rtgs_to_rfsbs(mp, mp->m_max_open_zones - XFS_OPEN_GC_ZONES))
 		return true;
 
 	free = xfs_estimate_freecounter(mp, XC_FREE_RTEXTENTS);
diff --git a/fs/xfs/xfs_zone_space_resv.c b/fs/xfs/xfs_zone_space_resv.c
index 9cd38716fd25f6..0e54e557a585e3 100644
--- a/fs/xfs/xfs_zone_space_resv.c
+++ b/fs/xfs/xfs_zone_space_resv.c
@@ -54,12 +54,10 @@ xfs_zoned_default_resblks(
 {
 	switch (ctr) {
 	case XC_FREE_RTEXTENTS:
-		return (uint64_t)XFS_RESERVED_ZONES *
-			mp->m_groups[XG_TYPE_RTG].blocks +
-			mp->m_sb.sb_rtreserved;
+		return xfs_rtgs_to_rfsbs(mp, XFS_RESERVED_ZONES) +
+				mp->m_sb.sb_rtreserved;
 	case XC_FREE_RTAVAILABLE:
-		return (uint64_t)XFS_GC_ZONES *
-			mp->m_groups[XG_TYPE_RTG].blocks;
+		return xfs_rtgs_to_rfsbs(mp, XFS_GC_ZONES);
 	default:
 		ASSERT(0);
 		return 0;
-- 
2.53.0

