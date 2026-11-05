Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886334;
	b=1IpGyVcyfavKSvv6PrvrSAZYUtmWRa0f8gppNvadLJFCwixwreMK54fNuH696RIwZ7uc
	 sBE1jtEAwkd+ywH+bTEahhALNYjNxFuPq29Fx9o069yh2/a5nr/2QsEP44sZL929wTv2t
	 Qt3tR+mJmLvM9vJLlYCzPWfIXEyWFkQHOj+Whg1OHgRw3MyWUaT4C91Z7GKiHTuH+4MOS
	 CQ1HsfGwOidKRvi8LlkSekSSkeeO6NblpXCKKCOa6FMZPEiscAo+6ckddDqmwsSSeGVoE
	 MnYA1NRuEjpMUTvWroqeoK4ei0OBCwTkcN3lWMbBWKrRl707ZT6dcTs08PgN3LmrSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886334;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K9r9m4IdnBhF6kDMvDTdALVmouyUJSpdstSc0K6fWMY=;
	b=xJKhjvtdzH5Jht30Pp8dnkQ77q+fMaSv8YA1oSz5j3lHj2Ti1lSxMeJeGvXszaTkqs0P
	 Q7UPofqzzyApeBhCyP2z/BJGo8AxAQILVOqj6akvp1Td1bjQwltc4RwcrqvK9ZXoD30T+
	 POhnzKxb5j9giooD9RMlD4GvgBRnvCxp4LqDv48se4/wMDfzIhq1qgverDpf+oHgN3i9I
	 OvEZ16EuU20LygwW2XRMc/lHgQwBBbBvnNjcL4fGVKbY5LVN5Xg7ApSiESZa+/I45URFj
	 4W2W8AZyocZxLJNqLZFayxTByDTelv+inDEO7gxTaZRIohLNmwO/hxkOecif4AgeTuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQzeaQvv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B6606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQzeaQvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526DC1F000C1;
	Thu,  5 Nov 2026 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886333;
	bh=K9r9m4IdnBhF6kDMvDTdALVmouyUJSpdstSc0K6fWMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQzeaQvvJTwE6m+8CL9kXDpJg3wsW28Q3pLyrwdNpFD2ky1MX3MTJggmz/sxIlMHm
	 oDvmkj19ex3AKJE0ougrWHoMoVvVDUy1U/c3ndeo8EMgZejpvnkGetYgDunl866RYC
	 ULPptaYmxuwtGGSEgvQuteTBIdfds0/XwAK/kwa1I+ay5QgaRpbOrBO8GonnU/Z4G0
	 Kf+bgWZKFQODHenAbyz4xsAyJmA2Xceqo0vUKjsyNvkQqLhSmiNHYwGafQM01HXa/h
	 POxajOiFWOvmNWaDynURW4NooBgh+wcgudLgo0blGR00cRInoZnp9V0OcZ+KW2KE27
	 24BLB7TvepDzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: allow softlimit with no hardlimit in quota scrub
Date: Thu,  5 Nov 2026 08:45:32 -0500
Message-ID: <20261105134356.1611668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-cardiac-untrained-502a@gregkh>
References: <2026110443-cardiac-untrained-502a@gregkh>
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
index 21b4c90068591..172cd3792afb9 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -102,21 +102,21 @@ xchk_quota_item(
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

