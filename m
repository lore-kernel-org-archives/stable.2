Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469E566C6A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653721; cv=none; b=Z5Lrg95orsn4wCLkYxk33PH6sLwH4mzgM6GnMwDxlV3CkiMj8sIWRdsB5qcL2KhVE0ltFz++711m8tmYCVJCN0E/UdomB4OoVJhqFigGQfDc19zRpsVu5DUY+pQvkGz4f0Pc+l82hSek/Qr3EiDfmeg7HABRoxWUf6osSzrMFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653721; c=relaxed/simple;
	bh=dQHA2K/gOwK89/t45HtfmDwIHwWYEQlUgZG4pOPweKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTY9b4YKL5SzxO1gEbDNTQSDYqipnY4G9xJ5MZQ6+7wtwTaXVUA73rvuM5NiNgoajPixQ4i6N7B09Z8ea5H/x6ftkTCGYWJYt8MNb4MA06Ebm168iscP62DjOCvKfPAEPvIuau/42BPkGgFaO+z1zkcKdhTNlfyz8hUHMXeTH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oucI2l7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oucI2l7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C41F00898;
	Thu, 17 Sep 2026 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653719;
	bh=kUBKF8N+U1UQ4dLlr2Gvg875DRoSK56/7xLDHzDfQp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oucI2l7n5NQPFzkfsjj9GpNrxDHLVqKY9KM8mzLB2SceBD7Dd7zXo2esck5ymLH9m
	 YqLRXUx32aQrBzLO2XGeCEkLh2U7Q3AIj+QDbT+95jceRTkbfJciAs5VkU9yYohfCl
	 MCoYy5di6pJedGo4gRX28LUOdSTUUdmUQIPnw6pXF6ETpJbaRA7HFBPdL/AegkqNGv
	 hXyBiupQEojCjBlqr0nrKUziqUc+/Ka83fQNasIfVNcDyCiHgzyMK0ebw/NbqDIJ4t
	 qV/rPI/J9nw7a809yUHA4tGNTOIsfEfTA1xS7f1srzp0e7BMEjUlCWjE9B3WjNKdnY
	 9dAm90B37EUYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] xfs: remove the i_ino field in struct xfs_inode
Date: Thu, 17 Sep 2026 10:01:54 -0400
Message-ID: <20260917140155.504217-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917140155.504217-1-sashal@kernel.org>
References: <2026091628-approval-prefix-a4c6@gregkh>
 <20260917140155.504217-1-sashal@kernel.org>
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

Stable adaptation for dependency of 4d3c07591534517c633945c8d8e6526f10e3fabc:

The stable VFS inode still has an unsigned long i_ino, so retain the
64-bit xfs_inode::i_ino and its existing initialization/reclaim handling.
Define I_INO as a macro over that field instead of adding a function.
Keep only the owner conversions in xrep_xattr_swap_prep and
xrep_dir_swap_prep, which provide the context needed for the target to
apply unchanged.  Drop the remaining conversions, including changes to
helpers and health monitoring code absent from this stable tree.

Also finish the preceding dependency's helper conversion in the stable
xchk_rtsummary error path: call xchk_ip_xref_set_corrupt(sc, rbmip)
instead of the removed xchk_ino_xref_set_corrupt.  This preserves its
cross-reference corruption reporting and fixes the allmodconfig build.

[ sashal: Reduced backport -- upstream 1113a6d6d5d13 touches 91 file(s), this
  backport carries 4. Not backported here:
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
 fs/xfs/scrub/rtsummary.c   | 2 +-
 fs/xfs/xfs_inode.h         | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

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
index e0fa5e6ca1fe8..5375f677bc7a9 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1468,7 +1468,7 @@ xrep_dir_swap_prep(
 			.whichfork	= XFS_DATA_FORK,
 			.trans		= sc->tp,
 			.total		= 1,
-			.owner		= sc->ip->i_ino,
+			.owner		= I_INO(sc->ip),
 		};
 
 		error = xfs_dir2_sf_to_block(&args);
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
index bd6d335571943..11598ee7c1792 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -184,6 +184,9 @@ static inline const struct inode *VFS_IC(const struct xfs_inode *ip)
 	return &ip->i_vnode;
 }
 
+/* The VFS inode number is only unsigned long on this stable branch. */
+#define I_INO(ip)	((ip)->i_ino)
+
 /*
  * For regular files we only update the on-disk filesize when actually
  * writing data back to disk.  Until then only the copy in the VFS inode
-- 
2.53.0

