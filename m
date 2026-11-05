Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898829;
	b=Arr1dAgMrRiCIbMv5F6bgLqUPOFbq/0zor3e8PG66nJ+tjyjn4wo6aNPPoIejCRo8S6Y
	 L8226ZlvG9dxL3+YA2BZ/3ezYCtW6Z2uc/cMQzgPKOiMd11NZedX2CRne/lVHW1e+8gRJ
	 VDD95fcI5o2eC4SV9wBM4teSLnVOVLIzPwU58yhp+BTnyHr5+UjJNdXHFN22GXPiNlz+U
	 WMJPlndOf4tUGyWePhCLWDlnZnSfdeosma1EEaDog8R4xslorsw54k/p8NcXY28hYVOw1
	 /PQZXcqtBfO4Op21q2Qr22ecJWsJuLOimXd7eHwVr5IkE+gD7WqsskS1P3rkVB2DYog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HbkYZdwBVRPKznegyuKiPJo4XS3NaEmcelzjanIgMYc=;
	b=ZyX2R+nZFbADueoeJDt3m+ZEXqbST0z6Zx0CkuixnQOXDNxzObmA7iOMDmDPpNU6O5UR
	 e9E0LiJi28BOEdQu2zuMGLoxg+AiYE94ETmdIvr8PQefi8gvZpj9pAxxChDOsPlSwwd9u
	 LDYBjJwZtAewA/AsLNH5iAkIdQWshTpWivQcYBNF4ha5QXNiwEgIK8PgxD+x9c1d3oqwn
	 zTH7Lzsd5+E0QPIMP4bZKAfXFerM8jll0TVQ5YpZg8EDkV1ZXOguMqJcHIAUXaw+77Q0A
	 ZTWLrP0WnisN2lXEz/cYCOU0q1Ga6GeAPjXBRsvALZa0264fnxRVfjRDBzbo7D/FM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVQbkldR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3366606D81C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVQbkldR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A691F00919;
	Thu,  5 Nov 2026 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898828;
	bh=HbkYZdwBVRPKznegyuKiPJo4XS3NaEmcelzjanIgMYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVQbkldRbSGpGEE2bIRSp6Qh+nVHnoGrrePHq39Q2Njjqsellj8sYPNddbdfC209m
	 yZPGk1esSCy5xVHCa4W/nMmo3aYy9NZ8EWSoWz/eq4uwzA6Jy/z/nurifhmz/QROIs
	 bVd1BBBVL2suEZ4snrHb77Lw2pdir4PGfxBDFaMEM66bT5N0qWb2pqOECtyBXuY7u/
	 sXDV54PFL3V3WL/4KhMy2QnoNKWCN2Nh7vN4soA8pr/r7F6TNPibwDlXej9pSq2kF9
	 8V9IPDm9arNjYINKGugRPNgtud8hICCTkWeca/8irx94Xj8jmInBJPRA/+OOpbWROa
	 WbbepATcZbQ+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 12:13:45 -0500
Message-ID: <20261105171320.2145841-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105171320.2145841-1-sashal@kernel.org>
References: <2026110428-batch-urology-d8d3@gregkh>
 <20261105171320.2145841-1-sashal@kernel.org>
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

[ Upstream commit 91c41f9524906a8ebd2ae68c98a07b4bd5255ddb ]

LOLLM noticed that the xattr scrub and repair code can walk off the end
of the buffer if the xattr entry record starts so close to the end of
the buffer that there's not even space for the entry structure itself.
Strengthen the bounds checking here.

Cc: stable@vger.kernel.org # v4.15
Fixes: 13791d3b833428 ("xfs: scrub extended attribute leaf space")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c        | 12 ++++++++++++
 fs/xfs/scrub/attr_repair.c | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 84507c80cf945..68d9666ab201a 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -306,6 +306,12 @@ xchk_xattr_local_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 			be16_to_cpu(lentry->valuelen));
 	name_end = (char *)lentry + namesize;
@@ -335,6 +341,12 @@ xchk_xattr_remote_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 	name_end = (char *)rentry + namesize;
 	if (rentry->namelen == 0) {
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index ab5bd7a4d4abb..2c573897c0c6a 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -285,6 +285,7 @@ xrep_xattr_salvage_local_attr(
 	struct xfs_attr_leaf_name_local	*lentry)
 {
 	struct xchk_xattr_buf		*ab = rx->sc->buf;
+	char				*name_end;
 	unsigned char			*value;
 	unsigned int			valuelen;
 	unsigned int			namesize;
@@ -293,10 +294,14 @@ xrep_xattr_salvage_local_attr(
 	 * Decode the leaf local entry format.  If something seems wrong, we
 	 * junk the attribute.
 	 */
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end)
+		return 0;
 	value = &lentry->nameval[lentry->namelen];
 	valuelen = be16_to_cpu(lentry->valuelen);
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen, valuelen);
-	if ((char *)lentry + namesize > buf_end)
+	name_end = (char *)lentry + namesize;
+	if (name_end > buf_end)
 		return 0;
 	if (!xrep_xattr_want_salvage(rx, ent->flags, lentry->nameval,
 			lentry->namelen, value, valuelen))
@@ -333,8 +338,8 @@ xrep_xattr_salvage_remote_attr(
 		.attr_filter		= ent->flags & XFS_ATTR_NSP_ONDISK_MASK,
 		.namelen		= rentry->namelen,
 		.name			= rentry->name,
-		.valuelen		= be32_to_cpu(rentry->valuelen),
 	};
+	char				*name_end;
 	unsigned int			namesize;
 	int				error;
 
@@ -343,9 +348,14 @@ xrep_xattr_salvage_remote_attr(
 	 * junk the attribute.  Note that we should never find a zero-length
 	 * remote attribute value.
 	 */
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end)
+		return 0;
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
-	if ((char *)rentry + namesize > buf_end)
+	name_end = (char *)rentry + namesize;
+	if (name_end > buf_end)
 		return 0;
+	args.valuelen = be32_to_cpu(rentry->valuelen);
 	if (args.valuelen == 0 ||
 	    !xrep_xattr_want_salvage(rx, ent->flags, rentry->name,
 			rentry->namelen, NULL, args.valuelen))
-- 
2.53.0

