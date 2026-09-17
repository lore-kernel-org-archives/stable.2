Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC84C10CB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670383; cv=none; b=nE/qoMfwikp86a+EVwZXqaYGAaz9mhM6SPnREn5w9NYcfs1xzRUgac9DTJzQS+dMxZhfdllcLh4wS3Jz1Uo0M/EhC0dQTYBIFG6KzEadeesTq7BZpFQqCYwziOwgnkT661tMfhWQczrrVnbtDK1kccLJd2iH9wQexIo84WjDlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670383; c=relaxed/simple;
	bh=0GzLXo2U94+PK2h0ChNDONpTPUHR5k0eQlUoyk0jXm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTUmsM8vUShfwFq9wjq8alFt8Pu2pWOW6+ijJHNjbh6Nc4DOPQ4hKYDQlWbfGZv7D4kvVHFIOMkjtzcD4LeK/dKPzNQ5t4nxYysu2NzRYL9FYC5fnnzzPGCbOnWAvUxpZGMeeY9Xf0s/8W5rON8CXeaZInOUeE9ntPJqjKpnT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Kcy/Od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Kcy/Od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726EB1F0089A;
	Thu, 17 Sep 2026 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670381;
	bh=85B1bWBxKDLsg4GGxpRhE4HC7GDU5v0uQ0pGKiesam8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8Kcy/OdoJXMj9bj7F5Ch9FUYDH1bz+MgMUZAu4XAMT1r1f8Ozmz6xw55Y6aip9+M
	 ojfuEZbwNPGoZ3qXeJBCH4mtb4doqZo72koN7FEkrrJD/uY5g5V5In+nDn3Qj2J7CZ
	 MkNsTK1zwLTGfwri9Przj5/PBdjZHPBnarNI7AZA3ZSGTSkCmciUnn7Rx8Kmr/Fv5W
	 RvdJPAdLQiM4xTzhuzS/BCmzxSqP0JNnDCzJQH9v+xetvaYP5Wk8xTX66nS60ECf70
	 OdRd0y1O4H9I0GjaZakTw4HMRiAEZXFC0CQyMfJYNiPE9q2MYEGddn8PhuJHPqIKsR
	 KaMkvaS6pXELQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: remove the i_ino field in struct xfs_inode
Date: Thu, 17 Sep 2026 14:39:37 -0400
Message-ID: <20260917183939.1201122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091654-contented-triceps-9bbc@gregkh>
References: <2026091654-contented-triceps-9bbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1113a6d6d5d1336f4415fa1367aac0f853f0892d ]

Now that the VFS inode has a u64 i_ino field, there is no need to store
a copy of the inode number in the xfs_inode structure.

Introduce an I_INO() wrapper as a shortcut to the inode number so that
we don't have to propagate the VFS inode everywhere.

The only non-obvious part is the clearing of i_ino to 0 for RCU freeing
the inode.  None of this calls into VFS paths, which makes clearing the
VFS inode field here just as safe as clearing the old field in the
xfs_inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

[ Stable dependency adaptation for 865b751e75039fc07838b3200f9740256653da9a:
  Keep xfs_inode.i_ino because this branch's VFS inode number is unsigned
  long and cannot hold all XFS inode numbers on 32-bit architectures.
  Provide I_INO as a macro over the existing xfs_ino_t field, without
  adding a function or changing inode allocation and reclaim semantics.
  Retain only the accessor conversions in xrep_dir_live_update, which
  provide the context needed for the target directory-repair fix to
  apply unchanged.  Drop the other conversions, including changes to
  metadata-directory and realtime-repair code absent from this tree.
  The upstream subject is retained; removal of the inode field is not
  part of this stable adaptation. ]

[ sashal: Reduced backport -- upstream 1113a6d6d5d13 touches 91 file(s), this
  backport carries 2. Not backported here:
  fs/xfs/libxfs/xfs_attr.c
  fs/xfs/libxfs/xfs_attr_leaf.c
  fs/xfs/libxfs/xfs_bmap_btree.c
  fs/xfs/libxfs/xfs_bmap.c
  fs/xfs/libxfs/xfs_btree.c
  fs/xfs/libxfs/xfs_btree_staging.c
  fs/xfs/libxfs/xfs_da_btree.c
  fs/xfs/libxfs/xfs_dir2.c
  ... and 81 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir_repair.c | 16 ++++++++--------
 fs/xfs/xfs_inode.h        |  3 +++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 29c48c4db53b2..0cdd763250cc3 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1367,15 +1367,15 @@ xrep_dir_live_update(
 	 * rebuilding.  Stash the update for replay against the temporary
 	 * directory.
 	 */
-	if (p->dp->i_ino == sc->ip->i_ino &&
-	    xchk_iscan_want_live_update(&rd->pscan.iscan, p->ip->i_ino)) {
+	if (I_INO(p->dp) == I_INO(sc->ip) &&
+	    xchk_iscan_want_live_update(&rd->pscan.iscan, I_INO(p->ip))) {
 		mutex_lock(&rd->pscan.lock);
 		if (p->delta > 0)
 			error = xrep_dir_stash_createname(rd, p->name,
-					p->ip->i_ino);
+					I_INO(p->ip));
 		else
 			error = xrep_dir_stash_removename(rd, p->name,
-					p->ip->i_ino);
+					I_INO(p->ip));
 		mutex_unlock(&rd->pscan.lock);
 		if (error)
 			goto out_abort;
@@ -1386,14 +1386,14 @@ xrep_dir_live_update(
 	 * the directory that we're rebuilding, so remember the new dotdot
 	 * target.
 	 */
-	if (p->ip->i_ino == sc->ip->i_ino &&
-	    xchk_iscan_want_live_update(&rd->pscan.iscan, p->dp->i_ino)) {
+	if (I_INO(p->ip) == I_INO(sc->ip) &&
+	    xchk_iscan_want_live_update(&rd->pscan.iscan, I_INO(p->dp))) {
 		if (p->delta > 0) {
 			trace_xrep_dir_stash_createname(sc->tempip,
 					&xfs_name_dotdot,
-					p->dp->i_ino);
+					I_INO(p->dp));
 
-			xrep_findparent_scan_found(&rd->pscan, p->dp->i_ino);
+			xrep_findparent_scan_found(&rd->pscan, I_INO(p->dp));
 		} else {
 			trace_xrep_dir_stash_removename(sc->tempip,
 					&xfs_name_dotdot,
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 03944b6c5fba1..33ea744d5992b 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -178,6 +178,9 @@ static inline const struct inode *VFS_IC(const struct xfs_inode *ip)
 	return &ip->i_vnode;
 }
 
+/* The VFS inode number can be narrower than xfs_ino_t on this branch. */
+#define I_INO(ip) ((ip)->i_ino)
+
 /*
  * For regular files we only update the on-disk filesize when actually
  * writing data back to disk.  Until then only the copy in the VFS inode
-- 
2.53.0

