Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84292572685
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653719; cv=none; b=Fsith0RALieBQP2JCK1T599UqxsygA++pOfKqt5+P09U8odVBpQQKZ7hLjpbsa+dsMKznRPr4aaOv4ZfTf1ZluohHDHKWkQ0aUv/uyfJcIKiABa2VFQruqPRkd6IaNrBxrJyoxrslLHS8zngZ9FXsYmDmdWrbTJYIDieEblF2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653719; c=relaxed/simple;
	bh=1j199KxQkMw+/bX/5grecaU2dbsxgBVcrk/E/n2xslA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmkqvoiMotG080+TCMMeZ3Zpfv7yxnuoYX8iBrUS46QQxPdxyMdJ+uffhTVasiJ2WJUGLszEHMb6zVrevncHpB3SF/7FK12TaTnAyqQcYhV7ZUsUM9qNyEnyZgHlp0u4jIga3jQbrIoT7uFETiqWXCfjR/JrkfRN5FkCoXLTz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+FvtyC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+FvtyC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F451F00893;
	Thu, 17 Sep 2026 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653718;
	bh=jICwpGY9kcgojiQO1Ir4hqN3yPdwBwjyq7s25vvV+5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+FvtyC2WQZvmCPyjz59uxjvU3VIZHDff6vPGA7Qj5H4sV4t/i4ka0KR9oYrAPK8M
	 PAv8C3kZULGhh0pFWBewHhJD+i4l31c7oysHW8/01z7YdKAkTHk3r0T7naJpIPaG7/
	 FvPtD1iDgIL2phXG2mXsIoavA98GqSa2YNgIW8fQcQgSjjnx8+vDmLP1aZJIVdPx4I
	 pS/kF6ao3bSIj1KCsSt1S1/XZcpvh41CzdoqeL1lnZRA+MrQswQ6jrBl7riQVmgECq
	 xHLmJBaBxed1MABBSUx9aHtI5dvZ2YjFC+h/86xX86AJ87+BL091EsnMXKokthrhNX
	 PAvzW9uJeBXZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] xfs: add a xfs_rmap_inode_owner helper
Date: Thu, 17 Sep 2026 10:01:52 -0400
Message-ID: <20260917140155.504217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091628-approval-prefix-a4c6@gregkh>
References: <2026091628-approval-prefix-a4c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit f882fc7dd9f04f73d94379deb9e68d8db613c976 ]

Add a small wrapper for initializing the rmap owner to i_ino.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 4d3c07591534 ("xfs: fix under-reservation of blocks when repairing sf directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 fs/xfs/libxfs/xfs_rmap.h | 2 ++
 fs/xfs/scrub/bmap.c      | 6 +++---
 fs/xfs/scrub/reap.c      | 3 +--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 53ef4b7e504d6..bdffade9848f8 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -820,7 +820,7 @@ xfs_bmap_local_to_extents(
 	args.mp = ip->i_mount;
 	args.total = total;
 	args.minlen = args.maxlen = args.prod = 1;
-	xfs_rmap_ino_owner(&args.oinfo, ip->i_ino, whichfork, 0);
+	xfs_rmap_inode_owner(&args.oinfo, ip, whichfork, 0);
 
 	/*
 	 * Allocate a block.  We know we need only one, since the
diff --git a/fs/xfs/libxfs/xfs_rmap.h b/fs/xfs/libxfs/xfs_rmap.h
index 5f39f6e53cd19..3670a33fc927d 100644
--- a/fs/xfs/libxfs/xfs_rmap.h
+++ b/fs/xfs/libxfs/xfs_rmap.h
@@ -35,6 +35,8 @@ xfs_rmap_ino_owner(
 	if (whichfork == XFS_ATTR_FORK)
 		oi->oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
 }
+#define xfs_rmap_inode_owner(oi, ip, whichfork, offset) \
+	xfs_rmap_ino_owner(oi, (ip)->i_ino, whichfork, offset)
 
 static inline bool
 xfs_rmap_should_skip_owner_update(
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index 845e1538077e3..910a1f42622a8 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -352,7 +352,7 @@ xchk_bmap_rt_iextent_xref(
 	case XFS_DATA_FORK:
 		xchk_bmap_xref_rmap(info, irec, rgbno);
 		if (!xfs_is_reflink_inode(info->sc->ip)) {
-			xfs_rmap_ino_owner(&oinfo, info->sc->ip->i_ino,
+			xfs_rmap_inode_owner(&oinfo, info->sc->ip,
 					info->whichfork, irec->br_startoff);
 			xchk_xref_is_only_rt_owned_by(info->sc, rgbno,
 					irec->br_blockcount, &oinfo);
@@ -407,7 +407,7 @@ xchk_bmap_iextent_xref(
 	case XFS_DATA_FORK:
 		xchk_bmap_xref_rmap(info, irec, agbno);
 		if (!xfs_is_reflink_inode(info->sc->ip)) {
-			xfs_rmap_ino_owner(&oinfo, info->sc->ip->i_ino,
+			xfs_rmap_inode_owner(&oinfo, info->sc->ip,
 					info->whichfork, irec->br_startoff);
 			xchk_xref_is_only_owned_by(info->sc, agbno,
 					irec->br_blockcount, &oinfo);
@@ -419,7 +419,7 @@ xchk_bmap_iextent_xref(
 		break;
 	case XFS_ATTR_FORK:
 		xchk_bmap_xref_rmap(info, irec, agbno);
-		xfs_rmap_ino_owner(&oinfo, info->sc->ip->i_ino,
+		xfs_rmap_inode_owner(&oinfo, info->sc->ip,
 				info->whichfork, irec->br_startoff);
 		xchk_xref_is_only_owned_by(info->sc, agbno, irec->br_blockcount,
 				&oinfo);
diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 07f5bb8a64212..ab0c133ffb98b 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -1249,8 +1249,7 @@ xreap_bmapi_select(
 	cur = xfs_rmapbt_init_cursor(sc->mp, sc->tp, sc->sa.agf_bp,
 			sc->sa.pag);
 
-	xfs_rmap_ino_owner(&oinfo, rs->ip->i_ino, rs->whichfork,
-			imap->br_startoff);
+	xfs_rmap_inode_owner(&oinfo, rs->ip, rs->whichfork, imap->br_startoff);
 	error = xfs_rmap_has_other_keys(cur, agbno, 1, &oinfo, crosslinked);
 	if (error)
 		goto out_cur;
-- 
2.53.0

