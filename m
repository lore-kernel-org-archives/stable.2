Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895810;
	b=fTa6LMROrUKytUlrvirdNTHFleDerQIr4W3Q+00r2URY2vCCfAALc9j65ZpKf81YpB2n
	 V3LJ9zVQZX7/mskx3bzdjZMvkQwbcvFD06wEkm/aiUGKczjoYA3jJK9DZQjRfq9WPj3qX
	 z6Z6nAq2L1RBapL9pEH+h8zuH7ySGntSBQ3rzpZJZhEsen+7f4uYsIODFcBwfiUcQb2bT
	 GNfRv3NzAK/5nESHL9gAGdI87TBBRNAAUEhJHfYUfX3fU4fGpHpzpltdvoVW3OagUvIG9
	 iMRBOn/cmmkKmJ1ZPBTIqP62+xSj2mn9z2i+dnNQwfLI7cuYLM6GuQfbmp3UsI09Krg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SoWzIW7bEmjUW7FhBuDi30MWJaVlc04PymSszBYMXww=;
	b=Q3YDQ6CP9g4NZuc3oRvuu6Bf3BLSLCtDOfgmt4U5TsR1WKK0+W9q6kZNWgjN228NZGts
	 qcxvm2xPCpDy3IGb46JRo9QMkrWpoapNc9vzFlel6y/lDAkEsg+QGzxbcg0OKQQptVRTE
	 xXYKL8EqGT455pQxS4rns9TeqM7Jylmf+kIwZCyuYLHINdJ+GHvZk1+il+79K+iniXHRB
	 ruy0OhPAGcLq/eZj1iPAG5TH2/9vf3eQFfXRm5BYnCyhJRhqCxJCWDUaYpvcoLnjvqxeu
	 3bZ4nDPshjn291rQE1vF2mEKGOUMSeL5yvSMrOOdbMVuH92nbTYj3dRQvLgwMngC0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhNN0ijc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4D606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhNN0ijc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6759F1F000C1;
	Thu,  5 Nov 2026 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895810;
	bh=SoWzIW7bEmjUW7FhBuDi30MWJaVlc04PymSszBYMXww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hhNN0ijcJBHxqpw6CnUueuLx1TxSPbuZivs26+fwyxOtnaocHGdo34PRBMQws+fzt
	 cVOBVhWctaAvobQjg69Y2z94/gpPFJdqMf4e2g2mBBygXNPFmyldvFlcSGS/X6wdGY
	 JUNRs8kfKUVYSTQDftV0rV7vyM4oVQEMCMZe9GzHEpB8uHhud7DuNhoykws+CAsj1x
	 zaQyjJNvSjo/dmVjEIfJmrv8VTFmXZDsOkbC/NJ/tTZDjk9HLE5YSqg5Y/7j9hn7p5
	 1vFqSm+QbSf+BrwUnrxl3Uin5TRllmC1dfO5HhN30IYQkPv7nTFL2KkpXJcHU9TrwA
	 wqKKcTG+A5XJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xfs: break out xattr entry checks into separate functions
Date: Thu,  5 Nov 2026 11:23:27 -0500
Message-ID: <20261105162315.2113156-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110427-crawlers-unlighted-eb26@gregkh>
References: <2026110427-crawlers-unlighted-eb26@gregkh>
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

[ Upstream commit 9eb04a6d41c7e474d4665118895c3c2d8e5a2741 ]

We're going to add more xattr entry checking code in xchk_xattr_entry so
break these out into separate functions so that we don't go crazy
indenting.  There's a slight behavior change here where we skip updating
the usedmap if we've decided the xattr structure is corrupt.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 91c41f952490 ("xfs: check for buffer overruns when examining local/remote xattr entries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 90 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 22 deletions(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 7315d0cb1e2e7..84507c80cf945 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -293,6 +293,66 @@ xchk_xattr_set_map(
 	return ret;
 }
 
+static unsigned int
+xchk_xattr_local_entry(
+	struct xchk_da_btree		*ds,
+	int				level,
+	char				*buf_end,
+	struct xfs_attr_leafblock	*leaf,
+	int				idx)
+{
+	struct xfs_attr_leaf_name_local	*lentry =
+			xfs_attr3_leaf_name_local(leaf, idx);
+	char				*name_end;
+	unsigned int			namesize;
+
+	namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
+			be16_to_cpu(lentry->valuelen));
+	name_end = (char *)lentry + namesize;
+	if (lentry->namelen == 0) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
+	return namesize;
+}
+
+static unsigned int
+xchk_xattr_remote_entry(
+	struct xchk_da_btree		*ds,
+	int				level,
+	char				*buf_end,
+	struct xfs_attr_leafblock	*leaf,
+	int				idx,
+	struct xfs_attr_leaf_entry	*ent)
+{
+	struct xfs_attr_leaf_name_remote *rentry =
+			xfs_attr3_leaf_name_remote(leaf, idx);
+	char				*name_end;
+	unsigned int			namesize;
+
+	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
+	name_end = (char *)rentry + namesize;
+	if (rentry->namelen == 0) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+	if (rentry->valueblk == 0 && !(ent->flags & XFS_ATTR_INCOMPLETE)) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
+	return namesize;
+}
+
 /*
  * Check this leaf entry's relations to everything else.
  * Returns the number of bytes used for the name/value data.
@@ -311,9 +371,6 @@ xchk_xattr_entry(
 {
 	struct xfs_mount		*mp = ds->state->mp;
 	struct xchk_xattr_buf		*ab = ds->sc->buf;
-	char				*name_end;
-	struct xfs_attr_leaf_name_local	*lentry;
-	struct xfs_attr_leaf_name_remote *rentry;
 	unsigned int			nameidx;
 	unsigned int			namesize;
 
@@ -333,25 +390,14 @@ xchk_xattr_entry(
 	}
 
 	/* Check the name information. */
-	if (ent->flags & XFS_ATTR_LOCAL) {
-		lentry = xfs_attr3_leaf_name_local(leaf, idx);
-		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
-				be16_to_cpu(lentry->valuelen));
-		name_end = (char *)lentry + namesize;
-		if (lentry->namelen == 0)
-			xchk_da_set_corrupt(ds, level);
-	} else {
-		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
-		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
-		name_end = (char *)rentry + namesize;
-		if (rentry->namelen == 0)
-			xchk_da_set_corrupt(ds, level);
-		if (rentry->valueblk == 0 &&
-		    !(ent->flags & XFS_ATTR_INCOMPLETE))
-			xchk_da_set_corrupt(ds, level);
-	}
-	if (name_end > buf_end)
-		xchk_da_set_corrupt(ds, level);
+	if (ent->flags & XFS_ATTR_LOCAL)
+		namesize = xchk_xattr_local_entry(ds, level, buf_end, leaf,
+				idx);
+	else
+		namesize = xchk_xattr_remote_entry(ds, level, buf_end, leaf,
+				idx, ent);
+	if (!namesize)
+		return;
 
 	if (!xchk_xattr_set_map(ds->sc, ab->usedmap, nameidx, namesize))
 		xchk_da_set_corrupt(ds, level);
-- 
2.53.0

