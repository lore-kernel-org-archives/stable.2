Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85057395ADC
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657303; cv=none; b=uHlvFq7t7gFGoUrmYsN1I4Ne6x9JWHLDoJKkkrHWjLeO3DF5byZNXuKRrAHFVkQsP5ADpKknwVKbj7lHK2xjF7/oWEb4Ak6AtZs+CmRHpMtLoS5tHzsee41WLfoYQ330YsyWdAhe4IRvawN4l+utqvpjMoTe+vZgis9N/j28yj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657303; c=relaxed/simple;
	bh=o/NWvGtwKDyeZF62reG18knTUGwXGh+UqyihPLub5tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THGJzF6ajGVD4PhbUnHgaVVOVmt8918hb6Rdapg+Z/rOsEz8YcUH9UnV/VavPrfGlXIgtgjdlTyN907faA6fF+w12pU0N3sqIhQL5r3mxi0l4/ZofEyyRzrhm7FdrJIHXzKn0DtwWZoTnA0XDyxLrKHUd+py71Y11fgWR8Kns2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clzlpRwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clzlpRwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43531F000FF;
	Thu, 17 Sep 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657285;
	bh=ksWfk8+yqFRimPxlx6h2pNDXIGYBWXvHFQNv0krhVjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clzlpRwTawJPD9HlSi6yyJUW0aEOxHR8QJkOmxHb7G03kEavvvMueLqwaDqb4BwrT
	 cOFnLKSPRkTd2OG2WU25KYbLyJzh3N9fw5Mpy4uZWH/GyT3yIGJCSt1hUt7v+AN95E
	 1R7jq1URf5Im1acxhH3JsmJuQWmylUWQpGA4zphDdC/rAxpYmj1zJeWPS+FGdobi30
	 wS4lCfuJDvPbHBt2/vePFZ+8r47Zm87jopIvRlz6h24aEY/BB3GPP2jb0CEv+CuX14
	 Nmkfvqqak6QhEQd5hYvgI2E7lJS8/a4lLleMczuxB203r4IOX3L+whi112S0racq61
	 3tGoGdHHHGGUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: remove the i_ino field in struct xfs_inode
Date: Thu, 17 Sep 2026 11:01:22 -0400
Message-ID: <20260917150123.670190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091629-runway-straddle-168c@gregkh>
References: <2026091629-runway-straddle-168c@gregkh>
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

[6.12 dependency adaptation]

Keep only the inode-number accessor spelling needed for the attr and
directory repair hunks of 4d3c07591534517c633945c8d8e6526f10e3fabc to
apply cleanly.  Define I_INO as a macro over xfs_inode.i_ino and convert
only the two xfs_da_args.owner initializers in xrep_xattr_swap_prep and
xrep_dir_swap_prep.  No functions are added.

Unlike upstream, this stable tree still has an unsigned long VFS i_ino.
Retain the separate 64-bit XFS inode number and all existing allocation,
reinitialization, reclaim, and VFS setup behavior to avoid truncation on
32-bit systems.  Drop the remaining tree-wide conversions, including
changes to metadata-directory, realtime, and health-monitor files that
do not exist in this tree.  The accessor and the two substitutions are
behavior preserving; the reservation fix remains in the target commit.

Original upstream rationale follows:

Now that the VFS inode has a u64 i_ino field, there is no need to store
a copy of the inode number in the xfs_inode structure.

Introduce an I_INO() wrapper as a shortcut to the inode number so that
we don't have to propagate the VFS inode everywhere.

The only non-obvious part is the clearing of i_ino to 0 for RCU freeing
the inode.  None of this calls into VFS paths, which makes clearing the
VFS inode field here just as safe as clearing the old field in the
xfs_inode.

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
  ... and 80 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4d3c07591534 ("xfs: fix under-reservation of blocks when repairing sf directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr_repair.c | 2 +-
 fs/xfs/scrub/dir_repair.c  | 2 +-
 fs/xfs/xfs_inode.h         | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index fa68ecabd983f..8dd88d775376a 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -1295,7 +1295,7 @@ xrep_xattr_swap_prep(
 			.whichfork	= XFS_ATTR_FORK,
 			.trans		= sc->tp,
 			.total		= 1,
-			.owner		= sc->ip->i_ino,
+			.owner		= I_INO(sc->ip),
 		};
 
 		error = xfs_attr_shortform_to_leaf(&args);
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 29c48c4db53b2..09e8d389a4ab6 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1466,7 +1466,7 @@ xrep_dir_swap_prep(
 			.whichfork	= XFS_DATA_FORK,
 			.trans		= sc->tp,
 			.total		= 1,
-			.owner		= sc->ip->i_ino,
+			.owner		= I_INO(sc->ip),
 		};
 
 		error = xfs_dir2_sf_to_block(&args);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 03944b6c5fba1..b8b795aa6f02d 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -178,6 +178,9 @@ static inline const struct inode *VFS_IC(const struct xfs_inode *ip)
 	return &ip->i_vnode;
 }
 
+/* Keep the full inode number on systems with a 32-bit VFS i_ino. */
+#define I_INO(ip)	((ip)->i_ino)
+
 /*
  * For regular files we only update the on-disk filesize when actually
  * writing data back to disk.  Until then only the copy in the VFS inode
-- 
2.53.0

