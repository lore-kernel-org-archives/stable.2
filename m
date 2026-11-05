Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892964;
	b=Cws6qZ3hPanVoRzpXJjH04BjHbQnRMr/QNWsuORelNEd56FlR6hV/FGaJ0c/fst0KoeL
	 whlHPL11K69O04KEhkEFx3QVESRWNiuYqiv3dvHSCPxHOts5/hZLkNvslCLNj+EP+A4Cv
	 byS6aQi4+hmYs1mncgi5inSlnbbHOmohSfdmkjlsXrHDB8FY4TZRNI2Mv7qKW4fRhUsdg
	 s4EY+QfyYMyJsLs/pB5dJjipnZCHMb4Yuc+/CZ6TrR74TOB6WzQYLmuQd7Z82plo+7kLX
	 d7L3NfUJzncF8JS40sHWU8bxdOHZgEA6KPG2A95yCQF96HR+bYxuyuXfzQ/7d2qmVaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m30tvlgg9O8McZehBh8Vzjn8Ft1fbHrU++xa3Timv24=;
	b=1Pvp8/MKfnUjiqmmGjek9fsk4oKpgVo/cOqloIQAexc9DxUfiIP4TxdA+wEHJsHqGR+5
	 7Q6U+nyRppeqquVn62Sg8v+Xs6nDpyQ2uY7wPOT3pzZNFBGqkrOY517mFSFdBQxxnhvhu
	 N+dlKld7/Wyx/PnX3g1KPK3Gy3AAibj75PV6azzK1I3mKqT6DOUkel3dhH5wl/5KRt/h6
	 hDn17Qw3u9inKQc0Gdz2H9mzPN/w6W+miNjJ4Jy6xUi/gB+L3W3QnQgt2/or7nSWsKX8b
	 fub4fkUFaWyOAiLuQNS56H+V8uTmH47+/6a5Rv4r+fIvVRq3L3gqbhKlxl7HaqMxy/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRlElye+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AA606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRlElye+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888721F000C1;
	Thu,  5 Nov 2026 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892964;
	bh=m30tvlgg9O8McZehBh8Vzjn8Ft1fbHrU++xa3Timv24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZRlElye+e13klUQY8auC+bk3kcEdLDmVMKqCVQfIp3PHWwBJl8kPcQMVccY64H1hw
	 //gigX80iD5hZvONTYw+G9A8/fqhSiv5Wpnza7AvZnFGFQA5tK7gjkybPpO07KiA+2
	 XQpk6oIWFvyk1CtMz/eiDcCvcCGXgoJxpwV4iQNHgkBj7oyzdIxRA2SQxZvdDXrpgt
	 /XUVSvTfL8ylyXulsCtrSs/KVz5NQD7+bBLQBs1HRV+TKgXi/JoWkQcPVE9QwkV5Fl
	 U7lCRVYILbsCa/xZ8BDZjvBhWaDRiNAN4ceOGU2mQl8Fr+wC+JUW/D7fAU5pQRKNgi
	 1E3Fw1HHwWpbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: allow softlimit with no hardlimit in quota scrub
Date: Thu,  5 Nov 2026 10:36:02 -0500
Message-ID: <20261105153535.1859622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-mobile-krypton-9fb6@gregkh>
References: <2026110443-mobile-krypton-9fb6@gregkh>
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
[ sashal: omitted the quota repair changes in xrep_quota_item() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/quota.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/quota.c b/fs/xfs/scrub/quota.c
index e34ca20ae8e40..42cccc6505f76 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -103,21 +103,21 @@ xchk_quota_item(
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

