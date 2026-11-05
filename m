Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888901;
	b=m3z0Iectwg1jl0etTAdQDpKO2SpQkHBQhHQKB8cXpKgynNCRZ1ubeSROGPzsq5KTbCbE
	 hYKDmTnfQEKZqKqAanfIxNE3Y2rtravpScJuyYendNQw5pORKZpQdAenJfiLV5++kImEZ
	 n5dk+M1RHkCALtYNjGOtGOxatcRZrgGQzToYHXUHa8MqUaiQ15jixvBEzSp5yyzTO+pmZ
	 lPup8Wd8zkHaSaGNr9jFGMMDfO+M24DgnEPPQ3PqW7zmFthEWUSEWIwzLKjVpq/ybW8AI
	 cf2BMb3sE1TiIP8+ygPh0kfeDxW3WX9N2QRORSsgxTYnwvq8xhu5X7qiluMYUQBveOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NZO0Qmu713jFQm/vKYluvL9hJJFkxcgriVrbL4y9m6w=;
	b=BdUTebVuk6Gt4uLkpXGQhVXFcpc8BvL6aGyhso5s4iwCJcTXcWOuT/C1FuSYMdkry3Y4
	 xHw0ruMnZ011q8AdmLjcaJXbnkXvAjoaKaI896h/osCVjHge9ebfsuovi64aweRzpA8UJ
	 VsefnWk4oitVw5IQPgCNhZoNzziwD2gs9kiEHMFIsNkB1NBzdOIcTFKheQkl4yceOAD7c
	 RZilbQeytO5xX4PaxVU25azpuNP7YuWD9BxHamH5/+jCsJtzssvYlgetAhiOJVUEBSm5U
	 PQiDVczxzFYDzXabTkU8MVb/VHbFQNY2KFxpPhZfDg5R4KcPeM9G6K3w71VJkjfCQLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpI7asQc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6A606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpI7asQc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E691F0093A;
	Thu,  5 Nov 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888900;
	bh=NZO0Qmu713jFQm/vKYluvL9hJJFkxcgriVrbL4y9m6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpI7asQcVQQJHrkzbgPyomvIoO0Q9FjQGseA3T/mxapwJHkbLt+pmXTw1UhyrPre4
	 h893FQ5jDq4Os4dxRf4S1JlGMt7pAsAhJRpVuPdc/6LnR6F4M/EEayd+9k7jAMMUXH
	 0ArijT1PYeEBvfWiKqK1HRFD7CdmCf9bvOP2mNxVU26hiRnAY266YuhoBTspjZy/4u
	 7Xd2nIg14s5/rROwFUbKUW4FGJaT8sK+EEx+CI1OsnrZDBV5sTwt97KAileJyfuc8W
	 M7bcd6K69kDdBO6EAIDmRj7o6QfmglVax2E5oblnf3m5mc7IzuJFs/5WSUHlnjUErD
	 iMa1jZsLwiXfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: cross-reference the primary superblock
Date: Thu,  5 Nov 2026 09:28:18 -0500
Message-ID: <20261105142754.1656811-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-september-retiring-e3ac@gregkh>
References: <2026110440-september-retiring-e3ac@gregkh>
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

[ Upstream commit 0c61016006ab08f8346f9e7b1e38559bd4ea499e ]

Make sure we cross-reference the primary superblock against the rest of
the AG 0 space metadata.  Drop the unused @bp parameter of
xchk_superblock_xref to avoid complaints about uninitialized variables.

Cc: stable@vger.kernel.org # v4.16
Fixes: 52dc4b44af7419 ("xfs: cross-reference with the bnobt")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Initialized error to zero because the AG 0 path bypasses its assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/agheader.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 6c6e5eba42c8b..41de023cad2da 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -32,8 +32,7 @@ xchk_setup_agheader(
 /* Cross-reference with the other btrees. */
 STATIC void
 xchk_superblock_xref(
-	struct xfs_scrub	*sc,
-	struct xfs_buf		*bp)
+	struct xfs_scrub	*sc)
 {
 	struct xfs_mount	*mp = sc->mp;
 	xfs_agnumber_t		agno = sc->sm->sm_agno;
@@ -74,16 +73,12 @@ xchk_superblock(
 	struct xfs_buf		*bp;
 	struct xfs_dsb		*sb;
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	xfs_agnumber_t		agno = sc->sm->sm_agno;
 	uint32_t		v2_ok;
 	__be32			features_mask;
-	int			error;
+	int			error = 0;
 	__be16			vernum_mask;
 
-	agno = sc->sm->sm_agno;
-	if (agno == 0)
-		return 0;
-
 	/*
 	 * Grab an active reference to the perag structure.  If we can't get
 	 * it, we're racing with something that's tearing down the AG, so
@@ -93,6 +88,9 @@ xchk_superblock(
 	if (!pag)
 		return -ENOENT;
 
+	if (agno == 0)
+		goto out_xref;
+
 	error = xfs_sb_read_secondary(mp, sc->tp, agno, &bp);
 	/*
 	 * The superblock verifier can return several different error codes
@@ -354,7 +352,8 @@ xchk_superblock(
 			BBTOB(bp->b_length) - sizeof(struct xfs_dsb)))
 		xchk_block_set_corrupt(sc, bp);
 
-	xchk_superblock_xref(sc, bp);
+out_xref:
+	xchk_superblock_xref(sc);
 out_pag:
 	xfs_perag_put(pag);
 	return error;
-- 
2.53.0

