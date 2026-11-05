Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898818;
	b=ogICuTGe0EOBo7LF/qm2Bk3An4wedQ0428lyj+BU0jRWGjOPkOmbt3TWI2d5U/XLb8ak
	 wtSCj5hoKWuTzuJvDjOCIpENSnOqnXOC1EIdGPgX+PT9X4jcLwtWbErA9ssqvYSn9fruW
	 Gnv2Hey8KkfhiDVqMRp242KxP5zNMX1vLmj1Dm+Wupw8dtfquFt4sS/VAysHjRivkkGAj
	 jLPSWOoLETkmsMk+e10IsmsCKjKfYCOPmSlgR+V44wCBEUccLHfAyNCiFdYHlYaNFV3yX
	 vAHYg85RB4HLoIzKb5n4EgFr9GOZrHxrFx44/PsMa1s/QCBuf63gGzYITGVdsb+xlhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5qtN6iAqZlZcgjIu3i2Kkt/E0vZ5lT6wIFZ1ejiExJE=;
	b=LnpMV8+wBL+dPzOr+zVV8ZoiJe0R3HMDyt5R0MQzOkpwCMOgqTQ1B4kod+PwJy55zLkD
	 Ps8GAh+xmEetFlVhqTTQNDI3VdrDnZQwm9WR/B4BzRl6MMzv1+sVqaonniYNmOZMMR6/4
	 Oyp1G5vmDRFxl5qhNiunmL4Q4fELBaBQyOofBAwAt6MxKVq10W0BXPGdcSbefHQlAdz3K
	 1spgkqULWKuuIpcZh0Vd6aX0sghoB+TOA7DmFfV2J75tCz9CVOFFhn3m5r9a5SB/CUOil
	 hmMyrDOaKQL23OBmNUoUH/DgLRGe1sHKn7vSEWxcFoN1DuvyQxMS31wKZfP78DGEwJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRFPleSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC4606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRFPleSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A951F000C1;
	Thu,  5 Nov 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898817;
	bh=5qtN6iAqZlZcgjIu3i2Kkt/E0vZ5lT6wIFZ1ejiExJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRFPleSn+XXvV4se5OXAuI1EcV5UjPbq8XN4ahpKSmmdmF0mR/nyqDTEEwX/JcWIC
	 e7iSWm+qwrONsyzMQkwU+gIQrZW7nS7lFE94pZ0OLcsXthMj7FFM6401IGrrEV3uUI
	 J5KjLllJGU8eQ5qyoKccvOnMMsBZVVxIKiFTtDOoottcoDVHsXTsc4DR1s8yhN3+5P
	 LRG6T5qpsCP4O0o0H+LdMIGPZb5/ELeXh89TPXXkKGXb5HCW7ASt0L00SQm7ZKbojK
	 5ikFYkrfozzii+/qKxs98isGFGfFW3dbSQfus/DGdd0k2d60IH1H98BpTWMPWzR2E9
	 4PWGQcQMKNlFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: reinitialize dquot block if non-first dquot can't load
Date: Thu,  5 Nov 2026 12:13:34 -0500
Message-ID: <20261105171316.2147033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110434-purist-sureness-e19b@gregkh>
References: <2026110434-purist-sureness-e19b@gregkh>
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
index 95d5bb8c10032..368be503334fa 100644
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

