Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895829;
	b=KQmTcxZ74R9Ump5vEUnRjM3woj/mvyduffBi/7NSW2v4Q3A+jkxK463es0MSzqJcu6G/
	 YnjM16kT+sB+FcqZmPwvc7qAAaT4mSwbkGFj4Mq8Qj/E70I8jJZdwQnfBC3dlWh48o+l4
	 EwV0WCI5z1W1jlpr3RESbzkibbWFIos+BRgi3VRaQCavOvIyT3eX/+34OUlKrCW3oLFt7
	 d++NH26nJx7d0gbk0mZ59EgqdXqy9uvxQQWIY8uyecirDWlnGS8594CnCf/HUZ9Sx2v4E
	 BpbaPyCULLbbKvk9PqAti3V+l9afOR8ZIHyVjS4IwE9LZrNwiFYgwDo1AylKAYtqJ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DT8CHEE8Ji4nC5ZmKpf/Bfn2S96saqsgqsfOhi6NcmE=;
	b=ROwLMrD2XpoeLiEsfGO0VoagMgfZcG+8Ku60pDec8RGNVCTNvSGig4JTtcgU0S3F5ms7
	 JrVa0HT/Eg8RjvrgsFabU3+1CWHp3JaZfopZyaP638hKcZs899x4Pt3m/02F69wCBkyK0
	 0qwTOa5Jyya0c1HjvLGHGT0e/qKW0vMLdj+9U8P/2JBrNzjqdAFAX2lbXy7JbV3bs25bn
	 OTdhK2PEuFZjpfdOeIg85sytNShuL76Yv9c/uTalxg0jOAnEA2EVXtolKps58z877XhMX
	 wN9XwfW7hJtmEZd8FlvKPKsDCMeV1dCpVht0mZPN9Q2dPziM5dotBgAinpSMLyE+lqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7H0JqxE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EF606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7H0JqxE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A061F000C1;
	Thu,  5 Nov 2026 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895829;
	bh=DT8CHEE8Ji4nC5ZmKpf/Bfn2S96saqsgqsfOhi6NcmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7H0JqxEznYVT4xGIRjFb48QQlSTEnw1KRnvg9wL3zPuS+iGNVRFRbYImi4GjRahF
	 fchmVxjROH4Orjbhiy+oSJltfRrd22G8FyY4RxM0NBC16OHhC2TZPFwes0YuyeRgUl
	 iqz1ksQd5LJXaQB7SA47hwF7k+vxJY5PtV3s794ZZB13qdiAOs5IbBVmH95wlW1Amk
	 3uV0PqWikoEicIHA8x5omz5OAt2+j0b7hbnalu5PbW6c9e64cSmeokfx18ktWmMHb4
	 KPQFPzqcAHxTUN5KqU+iRxbNzLYNZEmGuUl0NHPnhJZl9iSkcb6imacg00gF6+HS2R
	 PH+sGf2cY0ZuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xfs: reinitialize dquot block if non-first dquot can't load
Date: Thu,  5 Nov 2026 11:23:46 -0500
Message-ID: <20261105162325.2112852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-tingling-faculty-9098@gregkh>
References: <2026110433-tingling-faculty-9098@gregkh>
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
index baf77a158eac8..cf17d35b70cce 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -299,7 +299,6 @@ xrep_quota_block(
 	xfs_dqid_t		id)
 {
 	struct xfs_dqblk	*dqblk;
-	struct xfs_disk_dquot	*ddq;
 	struct xfs_quotainfo	*qi = sc->mp->m_quotainfo;
 	struct xfs_def_quota	*defq = xfs_get_defquota(qi, dqtype);
 	struct xfs_buf		*bp = NULL;
@@ -321,14 +320,21 @@ xrep_quota_block(
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
@@ -341,7 +347,7 @@ xrep_quota_block(
 	dqblk = bp->b_addr;
 	bp->b_ops = &xfs_dquot_buf_ops;
 	for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
-		ddq = &dqblk->dd_diskdq;
+		struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
 
 		trace_xrep_disk_dquot(sc->mp, dqtype, id + i);
 
-- 
2.53.0

