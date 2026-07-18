Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A029D266
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388782; cv=none; b=l4rAhsjKrcjy/jNpF5Wne7VXLuUQ7XCgt+g69IKSTbMEd/NIf6CGMG/1ebikhptF0dQCfcy1P9KTqD/7IrWDcXU3GNrz50Ft8hLGV3fe0WXEi9/UWsM7Rv94C2tPhRdbZsItv2WyobDS+iGX4DIiTPz3tI53Y+o7K9P5U7vMnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388782; c=relaxed/simple;
	bh=/lpqxllZWHIgB/4vmSIKn5oXU/Het6C0cNonBZCAzd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSaajdlimNCb9OtZzrx9Cx6vHTd2D4XUoF7vSW1naNaPiTDqrNSye1AA8gJ8rqiZ53wfM3sdV84JbVraZebPhPJTdlLTymsEHTCHfL6yGBwiDm7nNWOE7lZ/ZvgwGHIeJxiielEgt/2F6R0tn0l/3OHPS+KhyHABfk4Mv9xBgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI1mZI1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI1mZI1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846E21F00A3A;
	Sat, 18 Jul 2026 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784388780;
	bh=d3YXQJocNlupqzyH/ymFsZpJySl2XQRfzW8CLDdUa6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TI1mZI1Nzl41GRkcGVSoSUjxD7tn07hGnqQWp7mOa3pJKx9+taZzjjSbA7mhlumdN
	 gzwDxB3OOE3NroMX2bPsokt4alKzrnI169O46mrnvNi208WW6SAgVr2R9oOzKlzduz
	 eNvm30rEYcDxcXc236jWI3DfpuzFaqTbKefmiy61hmuMB3GeDllGj+rReSLJIAB5xV
	 tdv2HZ+OuYJMjPk4PCQWES/OLloNMRIXN4VEgoeVoQaq/hAvmcejmt+zeMTqeAGVn/
	 ea/d7T+gzcOj3w2rqPmI8/3b1VuyzNq0nIXxKOPbXjetZGHhcmPZaITC0zqBvCOxwd
	 e+XAmN/x7WwaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] xfs: only log freed extents for the current RTG in zoned growfs
Date: Sat, 18 Jul 2026 11:32:57 -0400
Message-ID: <20260718153257.3311310-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718153257.3311310-1-sashal@kernel.org>
References: <2026071441-surfacing-postwar-8451@gregkh>
 <20260718153257.3311310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 44cccefe65749821d9a13523c8b763bf1262ef73 ]

Otherwise a power fail or crash during growfs could lead to an
elevated sb_rblocks counter.

Note that the step function is much simpler compared to the classic RT
allocator as zoned RT sections must be aligned to real time group
boundaries.

Fixes: 01b71e64bb87 ("xfs: support growfs on zoned file systems")
Cc: <stable@vger.kernel.org> # v6.15
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 59fad43063a781..907c88034c8dc4 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -887,8 +887,7 @@ xfs_growfs_rt_sb_fields(
 
 static int
 xfs_growfs_rt_zoned(
-	struct xfs_rtgroup	*rtg,
-	xfs_rfsblock_t		nrblocks)
+	struct xfs_rtgroup	*rtg)
 {
 	struct xfs_mount	*mp = rtg_mount(rtg);
 	struct xfs_mount	*nmp;
@@ -900,7 +899,8 @@ xfs_growfs_rt_zoned(
 	 * Calculate new sb and mount fields for this round.  Also ensure the
 	 * rtg_extents value is uptodate as the rtbitmap code relies on it.
 	 */
-	nmp = xfs_growfs_rt_alloc_fake_mount(mp, nrblocks,
+	nmp = xfs_growfs_rt_alloc_fake_mount(mp,
+			xfs_rtgs_to_rfsbs(mp, rtg_rgno(rtg) + 1),
 			mp->m_sb.sb_rextsize);
 	if (!nmp)
 		return -ENOMEM;
@@ -1189,7 +1189,7 @@ xfs_growfs_rtg(
 	}
 
 	if (xfs_has_zoned(mp)) {
-		error = xfs_growfs_rt_zoned(rtg, nrblocks);
+		error = xfs_growfs_rt_zoned(rtg);
 		goto out_rele;
 	}
 
-- 
2.53.0

