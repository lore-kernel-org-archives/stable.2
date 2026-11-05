Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898818;
	b=JfrS1147xupBiTHDsecej55sOGCP2UHShssPMVZHlvpoY9W2Gh6kUHifsHP09ZLS1Egy
	 RF3+XmrhupMqF9JzkxryZqG5Kqwq/dCcmmjMilk6whvyFyj8AXrFdnZjenU4O0evwjBe0
	 ZEFlBNSLsU4+py6nJD5vtIBKK88fCOyLdzbfcR3JY6lu0w9HIeUrs1ABhxF53FZn60JWQ
	 cWHgPArQ6H8aq4XSV1Ip7H6FYDYNevZUAor9NUYhkoTy1wW3u+7SCDRtBQkFoGcOaHx2W
	 7g4DTxIbqictrZu5kW4zCd/kKj2Lh2zQ9q28uTLJb1UCOV8XYmKiKIQu1OKZLu64Iug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4sMYTQ7jwk1wqderGZz8Q2TnL99uyUEFZhNcvcTKd/Q=;
	b=g2KJEglK8QMMHtdCowxXFZK8Iubsvf3RLLCklPpwvqB1ZLovJl4Hb3iK1xynk6Ym4mSb
	 nHODWIsTvjCrkkpQa8zAs+rUWHP/eL29uWhF6KxpjoVUx095t+1YxW3ctADhsHiWUFEyl
	 tMGAJM5x4nI0U7mZs44fWC53mw4+DXzpg3j7kj58qNNXxBBxtEYq9w/8U0tskT7M/2v/p
	 4L/RTdQHN0nMu5UYHb/l8blw4ZRJMGtKaSmzC14KoSoskU6f88pricpZjvPs2d0UUzyH2
	 QRaSrUvpRojqWeFWqHdn6lteKl4J3qGg/5TpJlNiDmLksRYWijWA7hllTsIM+ZHq+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfarXm+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86587606A337
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfarXm+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4671F00919;
	Thu,  5 Nov 2026 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898818;
	bh=4sMYTQ7jwk1wqderGZz8Q2TnL99uyUEFZhNcvcTKd/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OfarXm+hz4OSfUl0gLqsGDGnBh16LHbG5MnQpvxJyPd8cP2w0JMKvkEXI18ENvXKZ
	 U3H5nqSBzzlHH2zsdW2DSiatqYzDokkjpDm28+Pjvqew7zIFb4Ps1/tuy3FefY+B4D
	 K7WWyHZPitQnRQQdmaqIWF95iJbU1SXo94Q1G1NJwAqHy3RWMjG24v/YruD0IvlMmG
	 07UA7Ex5gnBgfQ5OJTPKwFnT+8i9SoFgk1BGlLYdhKR8X3cSuTLBNh9KJ0jkcIudXa
	 QV9e1lEB8asinCKc3eeH/FwsvY0FWw33pxMXf+6TOUnwkgdEcIQSFtkW/DXvH8V2bR
	 5I4KJ2rB2l0Gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: forcibly reset quota timers when upgrading to bigtime during repair
Date: Thu,  5 Nov 2026 12:13:35 -0500
Message-ID: <20261105171316.2147033-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105171316.2147033-1-sashal@kernel.org>
References: <2026110434-purist-sureness-e19b@gregkh>
 <20261105171316.2147033-1-sashal@kernel.org>
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
index 368be503334fa..0def7a1b366a8 100644
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

