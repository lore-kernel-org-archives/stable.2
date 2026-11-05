Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893645;
	b=u/RV1ddH1SoeVnpqARip411dfwBzFWzGr72cK89vw+Qv8R3q3VLSyKJnL9aJrBUwGNeg
	 cahduSKWJJ5BgdMQFKHKSqZI1fQBeymFtJKoUq2aHYzCipTV1cDGMvpqCBmQJlm5TKQio
	 DshUXuG9twqjn2nxcBctEWuvhOQNioWQ3Ej9blyvt6MXlOuK9DG6zw+ira1f8Y2wSOR2M
	 FGyiXnqg0oZrw96cxsevZvbTIddjLk7XRZy8y3BN6XcHzLaQhUpk0teNYcUJltI/Fw88H
	 vtK0NnRjzKE7gN9IssJ6QK5/riNYYa+iDJVrf8csRBuu2N3l+ZrCmCOkZH6552KSUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893645;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dAKU9hswIx5976Bse0E+qPWpPPq3CpFyaDMrQTrBD/I=;
	b=vdV8qoFl4wryUEcCEdaE8jFp8h1uKowS+IcJsEy1r/dD6KHx+akwZrJYWrfJZF+GDCYz
	 NDNlVNv0TCDe42WPC1en+Sa4r+q11PeWi9j9JJzy22b+rV4JyJXikS8LYdn46QleBPzbf
	 BkBj2U3ccgsI8tcMsjS1PDGpH+KMwLrqa8K+VV/oyc0Hj+r9RJwb9Wi/UVnLBXl77q2jr
	 C5BEMYQkZ4rcf0t5MlyOeQpesSefJyRLETYBXg2x8Y0vuqnDl/FpW7RGZuSBXfGPuYDF1
	 XdPkXfFR74QO40OYQ5g3XW19Igyl7h4IfzwCxmzXR3xnNMWO7WEt4NPITxM0/BH6+hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcsKI8Hc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07E6082BE5
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcsKI8Hc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4BA1F0093A;
	Thu,  5 Nov 2026 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893644;
	bh=dAKU9hswIx5976Bse0E+qPWpPPq3CpFyaDMrQTrBD/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mcsKI8HckAoqoeRBaHjYz6Vac78v+82G3cD2PUl9bUnDOWMwWZAahZ5cfjOTSseXd
	 2M/Qqjw7snb4BnI7n4u0ZvPzmcacAzRPUSnGMwjpOmZQzHzEkJqoqElpv0b2ZOCrqY
	 R4nrHp3FHW/UMh+wOPWuA4BlhBWZyVkKdFeyT/UIG5KIqyyfF23hAr+gEn/42UkcH2
	 HXQLCBR6mgPHhw1nK6QehhDzhzejiQajwH1DAc9sfjc2oUi2SPXNTFpABHaUMTft0K
	 CPoqaPeGMbuUJAsrwtT9RfIE8wllr5Z3ThyNeL5cxlyHiXaHan3r9HtOWk04/UGK2a
	 rrylibOoWrtog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] xfs: reinitialize dquot block if non-first dquot can't load
Date: Thu,  5 Nov 2026 10:47:21 -0500
Message-ID: <20261105154711.2076300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-diaphragm-obsolete-bbe9@gregkh>
References: <2026110433-diaphragm-obsolete-bbe9@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit faa9aa9e846332aaad78096a2cebfeafe68a7776 ]

LOLLM noticed that the early exit logic in xrep_quota_block is defective
because it only looks in the first ondisk dquot for corruption that
would prevent dquots from loading.  We need to scan all the dquots in
the block, not just the first one.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 780212c8d810 ("xfs: forcibly reset quota timers when upgrading to bigtime during repair")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/quota_repair.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/scrub/quota_repair.c b/fs/xfs/scrub/quota_repair.c
index b4f33f432b12a..b6a270010b8b6 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -297,7 +297,6 @@ xrep_quota_block(
 	xfs_dqid_t		id)
 {
 	struct xfs_dqblk	*dqblk;
-	struct xfs_disk_dquot	*ddq;
 	struct xfs_quotainfo	*qi = sc->mp->m_quotainfo;
 	struct xfs_def_quota	*defq = xfs_get_defquota(qi, dqtype);
 	struct xfs_buf		*bp = NULL;
@@ -319,14 +318,21 @@ xrep_quota_block(
 		break;
 	case 0:
 		dqblk = bp->b_addr;
-		ddq = &dqblk[0].dd_diskdq;
+		error = 0;
 
 		/*
 		 * If there's nothing that would impede a dqiterate, we're
 		 * done.
 		 */
-		if ((ddq->d_type & XFS_DQTYPE_REC_MASK) == dqtype &&
-		    id == be32_to_cpu(ddq->d_id)) {
+		for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
+			struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
+
+			if ((ddq->d_type & XFS_DQTYPE_REC_MASK) != dqtype ||
+			    id + i != be32_to_cpu(ddq->d_id))
+				error++;
+		}
+
+		if (!error) {
 			xfs_trans_brelse(sc->tp, bp);
 			return 0;
 		}
@@ -339,7 +345,7 @@ xrep_quota_block(
 	dqblk = bp->b_addr;
 	bp->b_ops = &xfs_dquot_buf_ops;
 	for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
-		ddq = &dqblk->dd_diskdq;
+		struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
 
 		trace_xrep_disk_dquot(sc->mp, dqtype, id + i);
 
-- 
2.53.0

