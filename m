Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883699;
	b=aEwHQTgRwISXx4FDlsG7xdov4TC49Am8TipVTKmQWB6gRL3g1XprETOxmCqLF1CihSo2
	 BLOx5x/pYinhQUw9a+3bIQ88/CvV7BoQw17jN4G0pPXzd8v2MQDRz2mgbaVnwYbHI1Xhs
	 FrLdnZIg28nEgDlY2VwjfkmOtWe6FnaNu4rSBBjxJbW+JWaFktiTD7GNPkg+ezlgC6UO+
	 YAh8zHJx2PkBHvqzRsnELRsaJu9XRzPzhek+dAGd3rGQ/03PLdnJBoJLL+byVnFysHOPp
	 avfp+gHwaBPCL77EFFA7rOdJ3bIgMl8CM/mm5JpWBDpK3kc6eNdeCVMJ0D8uLFVSIZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PH1VawWD3ygc4tBNHCXSLnld+rwlMiLOAvBRw3K76cQ=;
	b=X4nXnWt6TlV6Kz4/spJ4BfpSGBb2Jj9+m8uGhEFDut9JtbyrmBKWQAavL43qp8RcC69i
	 Foh8b8dM/PyKaEdhPJERHfi6D67w8Gr7pCkpbmu2QMSieLhmG6KHSmGEy+Q1O3JS6mXtv
	 yMjprMVfdbrn95I3vXv05HbY2gvMd7tqyWMZL61ZbBpfK/+WO/jdCqyy/YrZxFzy/vh28
	 co8B5QDNIOWQeT4XWppQ5lXJPmLXLWY7ESNQchRpVcd0VqhLU1bhsnaCau+V9SbF0h6Lf
	 QfaCDy9pffaJ0YLXI3Hpi3yQnAtxV+u0p7d2bFum57O8QxLHv4/QTwJnZIPE+Mt/3Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjorwE7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39071606A332
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjorwE7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2231F000C1;
	Thu,  5 Nov 2026 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883698;
	bh=PH1VawWD3ygc4tBNHCXSLnld+rwlMiLOAvBRw3K76cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjorwE7j+QkOqPbdb0twRv+x1yeGrq6OEISSo55si1aDluZwyzLZbVFeyMej8+ap2
	 qMhp4NhWVRLl4DlW81MNykK07o4JpdHokDTA+Kr9bKQD9ckh8yCDJ2kSL/4ncHBWGU
	 mUT8isNjqmE0fomqbBVXjFyFFZY/ZiLZf86kG4ovTmCsyeiMONuc5B3dFC6Nb04GzB
	 ixSohmyxebyfI7hlT0jllU3UpK1C4HU8fyaCl1j0FuQ3+bsaG/Ih3pY4YrJ7XE1ESs
	 /ERL89HfHQtti92lUl86KYn17xwbdJv4k2uBj96gPNU/o/jDaIojXEsKHb57Ctcm3B
	 mfCWEomQY7XkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: allow softlimit with no hardlimit in quota scrub
Date: Thu,  5 Nov 2026 08:01:37 -0500
Message-ID: <20261105130124.1399455-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110442-disdain-studied-1f00@gregkh>
References: <2026110442-disdain-studied-1f00@gregkh>
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

[ Upstream commit 342c2e00b3a99099a7088f7b8c8f075670c603a9 ]

LOLLM observes that the sysadmin can set a user's soft limit to a
nonzero value and the hard limit to zero, so those aren't corruptions.

Cc: stable@vger.kernel.org # v4.15
Fixes: c2fc338c87a31f ("xfs: scrub quota information")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Omitted quota repair changes because quota repair support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/quota.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/quota.c b/fs/xfs/scrub/quota.c
index 5671c81534335..a2eb19ef72218 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -109,21 +109,21 @@ xchk_quota_item(
 	 * suspect, which is why we flag it for review.
 	 *
 	 * Complain about corruption if the soft limit is greater than
-	 * the hard limit.
+	 * the hard limit and there's a hard limit set.
 	 */
 	if (dq->q_blk.hardlimit > mp->m_sb.sb_dblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_blk.softlimit > dq->q_blk.hardlimit)
+	if (dq->q_blk.hardlimit && dq->q_blk.softlimit > dq->q_blk.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_ino.hardlimit > M_IGEO(mp)->maxicount)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_ino.softlimit > dq->q_ino.hardlimit)
+	if (dq->q_ino.hardlimit && dq->q_ino.softlimit > dq->q_ino.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_rtb.hardlimit > mp->m_sb.sb_rblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
+	if (dq->q_rtb.hardlimit && dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	/* Check the resource counts. */
-- 
2.53.0

