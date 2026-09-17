Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB14DDB55
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658269; cv=none; b=LHfXedeqdH8sdQLA9cHRtkN9+HFaiNCvelBrLtDxv4l0eQoZOE2jQTsZcvv2pG3uRujtj64VDlpqM4qFSdxmmh78S9nMSMlNqhsPEYOVv26FXh3wCAeRccZrHeBILddQFJtX+F4lm0ArQrYoXwuhXqyUlCFRhpfhUZ8+KpdHoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658269; c=relaxed/simple;
	bh=pYc8bw2grWQwoMUu6cqxPkxYASVtggamfJTXdKqA3I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzTMuTTorQeFZ0+mRf1zbezxpPe9DGahXzTP0xFFqr4XPCZ3yYi4aTweuDEY5XP5npbns3wBp3r9Jm2gOXGF1G11EJS4sSbcvdTu6fPcEnbAWWLojOsSqSIJQw+pMNaMsOqkWsXwVRgYOiElpJHkivi25BtMn6M9PdEh0mdZi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8NzLhyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8NzLhyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33D01F00901;
	Thu, 17 Sep 2026 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658250;
	bh=l7dieEOAS/dgJDiznu/MZCEZ+GGygJgSOy8swifjFX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8NzLhyM0V/fpzxGCiqyTZDWZUh0JUUnvGxbMRLwIsnTJJ3DX+6tRXbVZa2mDqHM5
	 7m6KKH33T6nYTUiNJFoSehjgZDeHMSfNTKqS5ToyNyApp6ZRrMdtr1zOHKxfzk4F6b
	 gH0QYC2VhzImFD/MRPMkOe1BGUnC0D2ZHVCwhOzVYrLzFh3VZYCzb+PKNRFNpgdOjz
	 LVqX48E51o8vJaI2HURjSag5yPu5HGFWBt04RmVZ6XiMN7I47W7xCAc4WQJgsnW4j3
	 A6BNXtiWgmNglF3CkQ7H1LRmPtBVzrahiugm6ei1GGZa5VZlNUEUMSgzkFj7vY8gzG
	 BNeXl+j9XY2IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/9] xfs: add a xfs_rmap_inode_owner helper
Date: Thu, 17 Sep 2026 11:17:20 -0400
Message-ID: <20260917151724.693663-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917151724.693663-1-sashal@kernel.org>
References: <2026091651-freedom-anger-bd4d@gregkh>
 <20260917151724.693663-1-sashal@kernel.org>
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
Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 fs/xfs/libxfs/xfs_rmap.h | 2 ++
 fs/xfs/scrub/bmap.c      | 6 +++---
 fs/xfs/scrub/reap.c      | 3 +--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 33a4f047dfdfc..ddcba236b07ec 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -819,7 +819,7 @@ xfs_bmap_local_to_extents(
 	args.mp = ip->i_mount;
 	args.total = total;
 	args.minlen = args.maxlen = args.prod = 1;
-	xfs_rmap_ino_owner(&args.oinfo, ip->i_ino, whichfork, 0);
+	xfs_rmap_inode_owner(&args.oinfo, ip, whichfork, 0);
 
 	/*
 	 * Allocate a block.  We know we need only one, since the
diff --git a/fs/xfs/libxfs/xfs_rmap.h b/fs/xfs/libxfs/xfs_rmap.h
index 7188459f61cf3..6016fd5fcad98 100644
--- a/fs/xfs/libxfs/xfs_rmap.h
+++ b/fs/xfs/libxfs/xfs_rmap.h
@@ -37,6 +37,8 @@ xfs_rmap_ino_owner(
 	if (whichfork == XFS_ATTR_FORK)
 		oi->oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
 }
+#define xfs_rmap_inode_owner(oi, ip, whichfork, offset) \
+	xfs_rmap_ino_owner(oi, (ip)->i_ino, whichfork, offset)
 
 static inline bool
 xfs_rmap_should_skip_owner_update(
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index ba7cb3837c752..7f5aeee495727 100644
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
index fbd0460dc06d3..e6784c7615d8b 100644
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

