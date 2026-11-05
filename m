Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895830;
	b=g6q4oqxciGuYpxVZsdE4Dc9irVxRLfMdSBTVgVUxLM430aakMyvhAeWnUTSyBro4pZi6
	 zftYtAWq2nU++vSmZ4w5xh61akR7mNravBN0rxQXIi2Ith1tWOcmcXcSOWcVYJ77C6TVR
	 Pcd60ch3I9Ii4I8UtHmG35h+0Hd451acz8IqK84w10keIeqeaOybHrIobEmjEcLw/bzcu
	 RFVgf0czQCeb1gjARWAIW8/tJP+/rdZfSYfjPzupSMUGCmv2INKER+/9x4EDABY4mK+fv
	 nIErVhYuRLgKgG5aEEF2IbFwOT/w39EMqwJfEMR/eFNpP6XUl6jcu69NwT9vcuM1vyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oUhimcHcCMI/Vtfe/EFUD7qMgpOrpJwxhlQi2BdPp0E=;
	b=SI3nSuvIpBaDW92nqwymtDRhMf6Zk63nqwjXIHeVtv1rVt0bWRVjaKgpVmXlLDdplOvz
	 2UoXJ+10Rt8pGHhdmsGSq6WcelZeLC119HOqsh1eCW77y+qKpB5hUbQ+9ThgWqvTO7+Cs
	 7LsVo+RMnhK0BLD2jhaGw2Hsd5wCpWA7yZ+dOOBYpTt6a0sbu+sJU45ZhKRqOVUULuqIB
	 jfGDvXy0CqUKyq/q6t7ew/L/VnOv9hQz5+w+1x0Oy92epDFiAJqO9Kmjh5wFzuIIpNtUh
	 +oygKYYa73KYarmJptA9gkhxWTt2DMYwTO7f1cMRazJ745dO2tNEQlXJxo7G4mGGSlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFQDUMWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58E606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFQDUMWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572311F0093A;
	Thu,  5 Nov 2026 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895829;
	bh=oUhimcHcCMI/Vtfe/EFUD7qMgpOrpJwxhlQi2BdPp0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFQDUMWmSJxgsLHFuXVb6/1sRwfHCNSF0PFTF3ywyjUVJqc3Wh0o/CBq3mOxnm1xR
	 dGx8/qnskzZyowJUXmYDyheWjRzt7Q3riR6Mner2mOw03Cc40/ct9qHeM44V9zb3pQ
	 pblZsb/2WN7Qpt0nXugJAmNk7SeBeWE7KZVNXkoWAR8TpYWQ/FLpAh6qi4G4u9e81w
	 x/pE/7OrbYzsAn/CQiQc/OjDnLi1lWdLxM9oLG4e0odhrrCnNfUwfbfB7yH4TUJjK/
	 ryNsl3nxGZx1zzeBgmUnsPCgNsHeq1mgtKUkVSydPf54R/H8pUwJpbUts7WFqk7VRW
	 U5zR/WqESLiYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] xfs: forcibly reset quota timers when upgrading to bigtime during repair
Date: Thu,  5 Nov 2026 11:23:47 -0500
Message-ID: <20261105162325.2112852-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105162325.2112852-1-sashal@kernel.org>
References: <2026110433-tingling-faculty-9098@gregkh>
 <20261105162325.2112852-1-sashal@kernel.org>
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

[ Upstream commit 780212c8d8105eadb5f56b4c7aafb94937755582 ]

If we decide to upgrade a dquot to BIGTIME as part of repairing it, we
should zero out the timer fields so that they are re-evaluated and reset
in bigtime format instead of letting through whatever was in there
before.

Cc: stable@vger.kernel.org # v6.8
Fixes: a5b91555403e3a ("xfs: repair quotas")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/quota_repair.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/quota_repair.c b/fs/xfs/scrub/quota_repair.c
index cf17d35b70cce..44806ce8c0bf4 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -348,6 +348,8 @@ xrep_quota_block(
 	bp->b_ops = &xfs_dquot_buf_ops;
 	for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
 		struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
+		bool			was_bigtime =
+				!!(ddq->d_type & XFS_DQTYPE_BIGTIME);
 
 		trace_xrep_disk_dquot(sc->mp, dqtype, id + i);
 
@@ -356,8 +358,21 @@ xrep_quota_block(
 		ddq->d_type = dqtype;
 		ddq->d_id = cpu_to_be32(id + i);
 
-		if (xfs_has_bigtime(sc->mp) && ddq->d_id)
+		if (xfs_has_bigtime(sc->mp) && ddq->d_id) {
+			/*
+			 * If something was broken with this dquot and it was a
+			 * non-bigtime dquot, we'll grant everyone a fresh
+			 * grace period by zeroing the timer field rather than
+			 * try to interpret what might be garbage.
+			 */
+			if (!was_bigtime) {
+				ddq->d_btimer = 0;
+				ddq->d_itimer = 0;
+				ddq->d_rtbtimer = 0;
+			}
+
 			ddq->d_type |= XFS_DQTYPE_BIGTIME;
+		}
 
 		xrep_quota_fix_timer(sc->mp, ddq, ddq->d_blk_softlimit,
 				ddq->d_bcount, &ddq->d_btimer,
-- 
2.53.0

