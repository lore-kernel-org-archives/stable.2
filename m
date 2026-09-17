Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935264848B7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658285; cv=none; b=WP1qkhS1mrVf/G6Diz89Pvu/6qw2OBIothByGHLqm8P9J/a2thSNYfiI7JewJCOOlnVOXrXy2RzjD37Dt2O9SSI34S8XLmPEGXpfth1LjQgAZLY6NKVEDaq0MPM+BjXF8uk8qxqelRiMs2O4MwCmDgeK6IDEkJzTLlodiBR61vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658285; c=relaxed/simple;
	bh=SL9THriHGcv5pnnOxtV1IFlAT+RP84jmzYkp3eA4wSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMos2T6FelXpRo+yQvCe9S2y6xtN9kwkgcE2wBWvhM+OD2p5+2w/Iv3v3vxLu839DaqONp9xGURsARWX3C2xEwUHxtUz0vpjqtPYffB/mGS0G1Z91D7rhsiIqCS0I83edTmteXkGOkmUQWjuqJLH+uX9aVaW6I4t/iXDuj3QzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZF/qxRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZF/qxRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02761F00904;
	Thu, 17 Sep 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658252;
	bh=eLr7pGEfE7k/wAFu9bv3NI/YfpcAN75wARNbdH1TIYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZF/qxRVXvX3oJErt54sw7WRzH6fCPgoUlZNVbXlyYNAc8gxbrMhSIdEnHYQqCqYz
	 eDIRZOV80xlKij1l9ujtekKWE6EyuA2+5QKtyzfigVk0NtfmoRtI5kbZ49b2bFdpKu
	 vWnR8QPM3bvdzzf2qIQsabxDOiBXJ0gF6FrM5/Eb+Dv4gDE84ewxPpEiy3UF38d3zg
	 pi84rAqA9CA9Njw2ruWzvgtWp7MQsYBmNM6abTAmcUR2841rA/oQcnjH9Iij2XRmC3
	 0ihUmuPHZhxAgNCb774k9w+kmARCIzggqCfC602yC4LdWjXFBj6UTWmbKi1ZR8AwNt
	 +AqOaxMX2Qh1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 8/9] xfs: remove the i_ino field in struct xfs_inode
Date: Thu, 17 Sep 2026 11:17:22 -0400
Message-ID: <20260917151724.693663-8-sashal@kernel.org>
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

Stable backport for 865b751e75039fc07838b3200f9740256653da9a:

The 6.18 VFS inode still stores i_ino as unsigned long.  Keep the existing
64-bit xfs_inode.i_ino field and its initialization/reclaim lifecycle so
that inode numbers are not truncated on 32-bit systems.

Retain only the I_INO accessor and the two dirent-stashing conversions in
xrep_dir_live_update that the target patch needs.  Define I_INO as a macro
using the existing XFS field, without introducing a function.  Drop the
remaining field-removal and caller-conversion hunks, including references
to the absent health monitor and newer parent, tracing, and inode APIs.
The upstream subject is retained, but this stable dependency deliberately
does not remove xfs_inode.i_ino.

Also convert the remaining xchk_rtsummary error-path call to
xchk_ip_xref_set_corrupt(sc, rbmip).  The preceding stable dependency
7a4a29522ee8 renamed that helper but missed this stable-only caller,
leaving allmodconfig builds with an implicit-function-declaration error.
This completes the caller conversion without adding a function.

[ sashal: Reduced backport -- upstream 1113a6d6d5d13 touches 91 file(s), this
  backport carries 3. Not backported here:
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
 fs/xfs/scrub/dir_repair.c | 4 ++--
 fs/xfs/scrub/rtsummary.c  | 2 +-
 fs/xfs/xfs_inode.h        | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 92603d1e51c47..a56eb621bd978 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1374,10 +1374,10 @@ xrep_dir_live_update(
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
diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index a1e2aa580bc1b..8fb06ce4a2003 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -359,7 +359,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ino_xref_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_xref_set_corrupt(sc, rbmip);
 		return 0;
 	}
 	if (error)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bd6d335571943..5271d2680c2f8 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -184,6 +184,9 @@ static inline const struct inode *VFS_IC(const struct xfs_inode *ip)
 	return &ip->i_vnode;
 }
 
+/* The VFS inode number can still be 32 bits on this branch. */
+#define I_INO(ip) ((ip)->i_ino)
+
 /*
  * For regular files we only update the on-disk filesize when actually
  * writing data back to disk.  Until then only the copy in the VFS inode
-- 
2.53.0

