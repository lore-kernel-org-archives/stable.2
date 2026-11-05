Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893652;
	b=gU9HNrVjR2gWfN8TAE4QebvweA5qTxMC5/jDG+IY8We5lEoNzIlPB5wmZxqqegA6LKOO
	 2/vX893eMeRXySzh9JZwmTOSQbY99zhZnkSQ0798wJaDqeae1fEq/LBMcxpnNOldcWXYs
	 wkF0TpV6ol4GayU4FEuAn1bCbjpdmIRyrpSpb9Z2Fi6m/NfdjOLn8d69YtQd9HRbKiPeF
	 Kzue9J0wPNsd3CyCMeXl9Ue1kyAiEWMx3ygsR4/hqQhh6mOlg9Tbn7RrpcPcVzk6ywYdT
	 PiX0F9cRXkSuCqyQ0WqiJCvj9fNKAceBFtMB6kGLjQeOLIp9bvZTBatQcgUBER5lYTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NYuM+CC7JEQ0Lc2CZUXXWkPej3UEIDvCqZau/w9OnKY=;
	b=WBKW4KGnvvQsihGJE3CFeNEPUmhWTPIW9m2+FbqCKDaXslXUfHYsWRHuLlt/Urgmj3nZ
	 uKD0353CeOiZX0jb9gzcrXp6HXHRd+YvbBYu1lMjQ1FqGySIIfyiplWL5lglZAuX4SauG
	 cA11cuLd02VMvjRJyJLtB7s4ajoCNQL6ZlCS25PjXw//nX2lOMVOaNyIDOJCu99URg0Lj
	 heAJaTa1Kmo1e9SqI+Qjmruutezb1h/Surf8WRXIYd/u1I0EvWGHi0okgytUj7PZe6rGt
	 KGyeHKslzC4IUnoc4Ht8zra6D/0xtovRabSUWrlWbAjFNBROyKIHiY+SrZjxqOmSDwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggyEh6b9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38A606D830
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggyEh6b9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA1F1F00919;
	Thu,  5 Nov 2026 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893651;
	bh=NYuM+CC7JEQ0Lc2CZUXXWkPej3UEIDvCqZau/w9OnKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggyEh6b9KGwv4gyZ6tBiRJ6HSoWTsggCXOsVU73pixFPJxbR0hDGK2w99ctSa67OP
	 vKdKOPGFWM/Muy4aEqMvR67vOYlFBQ8vokWx6+ZQDgpXEZWosQQw7RPfXost1ko4Wo
	 dj7AsTPeHWuwrmcykqdQwDiTEEmOwu7NEvbVOr+kAEBxtupkt1uQCmBBirXuT+L1F+
	 oArCXd/StNZTtIfAChUdFI9VuIEZYHyDh6nV5EG+56GB6+QmolZGDAsyzc52vPQFBi
	 fHP2CuqSpk+jG+O/xUs9Z9ynxtKIA2Urti5Gd0/PGNk5hJYaT1GiRAIYzkh2LUGUno
	 hv8ARCwqQ+PFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] xfs: break out xattr entry checks into separate functions
Date: Thu,  5 Nov 2026 10:47:28 -0500
Message-ID: <20261105154712.2073712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110427-acrobat-squeak-f5e8@gregkh>
References: <2026110427-acrobat-squeak-f5e8@gregkh>
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
index 842d65834afbc..f7c00ea1af5d3 100644
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

