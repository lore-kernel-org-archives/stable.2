Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893646;
	b=2tHBnB9wrQ+dO/QRbVU1ouWQM/jCtwArMi6/Krt1zYyNo1TUibEgaH1Q2XuddCzFhblg
	 L1ttJ1H0NwEJ+whxWaup6pA60e3VFAjhLcGet6kv4gwiqFJ9dI+zhhTdeU+uUgAMJWNMT
	 FPvW/u9hW0pG9gCrqTbtqUURsvg/hLCGrqthlVA/QQqVhumkLTWbw7ACuj7fl2upYc3Ui
	 bX/rg0hQtbHyXLkL7L7OaQwece9z4RIo2/tjggwlq2dsa+RKj2aS+ArHlHZURN4GSnZRU
	 ea7o98HU5ytfAyVE90mZLWAEg1NWbF61fnWPJWGV4QKISkyk0qoN6X3MAR/DDpmvJyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FHMPzIH841SMRQPPGxokTxdLlPMqx2RJSN+ShsgKvkg=;
	b=LlnWnBKYMypNWkMaAngBP3c+XBhebZoUIM2l9uBwEPyhxjr/YQeINwTKE2tvwwkhVHRr
	 iNaG7Qu+cqkqAKIr/2d2dFIScW9gM6JQgtM0fZuLz3C7uGGjgFnu102m9DN7YRYIGccjT
	 sK+orCQnXLyeaNUfEoKgEUkKx2Zm/z1GlToWF57pqOgR1AHWq/42y2B4GetY3IxxtV1Hp
	 rLVG59Y6ZJ5JXSlh73yCU43H0lUzriMpeE7L8UWNNRz9vMBW9EiL69rnfp2FQ6TxKGTul
	 92h7PeF9g/S1Qba3UznQKN4Zz9AHNEjpJQMtfFgRjj1/95ZaJGzzsC3YOvRkhtW15QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JC71WZq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04404606D82C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JC71WZq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99641F00A02;
	Thu,  5 Nov 2026 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893645;
	bh=FHMPzIH841SMRQPPGxokTxdLlPMqx2RJSN+ShsgKvkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JC71WZq6eJqMBc7GwU/oRbdeYeSv8ZNtLNoEpJZ0eaoWeHwTILkA/MlbnL7bDl527
	 nESxS2QIkpAG0ltb7Rv/3Bcb0lpbBVDOowOLWvkboo1M/0bRoUsOyZT6S6CqR8XwqA
	 6trBkpahcL0eIIgt4/0ixfT9AaQaNe/sq5/lzasr/TK3VYD5aa7+IRdCRnocSLOK7b
	 RPvOEt/GYMLYsfrVc1UrorKszcNAlH0oHuNtFg/vXHsVMg5P7Oofzf/e2LYjjUPc2h
	 s9hRArD6bAVBL0730oQT48TFzcBH5KW4/e1sXB1U65GYMt8jcaiFuC5L3SCsZfpuP3
	 7ct0BuusdXI8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] xfs: forcibly reset quota timers when upgrading to bigtime during repair
Date: Thu,  5 Nov 2026 10:47:22 -0500
Message-ID: <20261105154711.2076300-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105154711.2076300-1-sashal@kernel.org>
References: <2026110433-diaphragm-obsolete-bbe9@gregkh>
 <20261105154711.2076300-1-sashal@kernel.org>
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
index b6a270010b8b6..3be56d73dd665 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -346,6 +346,8 @@ xrep_quota_block(
 	bp->b_ops = &xfs_dquot_buf_ops;
 	for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
 		struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
+		bool			was_bigtime =
+				!!(ddq->d_type & XFS_DQTYPE_BIGTIME);
 
 		trace_xrep_disk_dquot(sc->mp, dqtype, id + i);
 
@@ -354,8 +356,21 @@ xrep_quota_block(
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

