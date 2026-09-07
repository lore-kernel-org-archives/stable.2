Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AD1E98EF
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743002; cv=none; b=SGtXQNVqU8SqoY8ZtqWHTWbgeN8alXk8AvpYo9FAD4n7ev74T/Bx2z7Vbp2TFZmOE3neyBd+s1BK83S9No0OsbTyCwTLNoNoABbtw2IY2LKB/FhSLGiU0DZ9LADtS/RRNsqNzdfuVpt8UoHtoi7909+0+eDezQAxcYA7In8eLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743002; c=relaxed/simple;
	bh=/txnJEYRBq8Fhn1NT6nzjkbLvsvM0WNBLWMQBJh9+1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts04fwND+dy9ciesOn2MEbI3UxqSG1nDZiWjGmCZOjhtB1ZxFV5WoX7v2eJkpg5dq+sK/IoTb5tarwokYRM0tdv2G1SlrmjiuxbH4yuvuWRFzcHgSEih4rB4l7p6iYzkovh0qURboMEJlBvdfzgIG5S+0SXoRmRlxwqRybhPHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naceWPjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naceWPjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1051F00A3D;
	Mon,  7 Sep 2026 01:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788743001;
	bh=GXSvgjIQd/+IFzzbi1D9r8WqZjFVNIf7jxGi9jITiwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=naceWPjP2BXN33bwFFl1IudndkeTtyw1ZlCvVqQEU730yA6m36YRrZqSKvOgXtdsB
	 6Zdp7W+QBb0oQnVnHcZHQtjf6Mt8zJl98N2gT0na5A2cM8dJXFsBx1VZg9nVHSgSSB
	 O4r6qOn5Hu3nkMtTlpvPhuxQ0bX9m8cM4kQomChXy61r2e9Gk1wpVp5Pb3c6CFF7/F
	 fIs6Kn/BuzdF+0qg+Id0ZBjRtXZcGNdk+pTEXqetSdMeGlMq21FpnzT4mprVeAWgZq
	 ckBlFsY4U+Q0uu9AFFJFn5kGJ9QEmlN3hNe4oFVBamnPBNbHy+1ruvUBeMYdMtG9e1
	 tofmlRdhEa4dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] btrfs: expose per-inode stable writes flag
Date: Sun,  6 Sep 2026 21:03:16 -0400
Message-ID: <20260907010317.1950131-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010317.1950131-1-sashal@kernel.org>
References: <2026090330-ferocity-flavorful-f5e4@gregkh>
 <20260907010317.1950131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit ecde48a1a6b3256bd49db8780bf37556b157783c ]

The address space flag AS_STABLE_WRITES determine if FGP_STABLE for will
wait for the folio to finish its writeback.

For btrfs, due to the default data checksum behavior, if we modify the
folio while it's still under writeback, it will cause data checksum
mismatch.  Thus for quite some call sites we manually call
folio_wait_writeback() to prevent such problem from happening.

Currently there is only one call site inside btrfs really utilizing
FGP_STABLE, and in that case we also manually call folio_wait_writeback()
to do the waiting.

But it's better to properly expose the stable writes flag to a per-inode
basis, to allow call sites to fully benefit from FGP_STABLE flag.
E.g. for inodes with NODATASUM allowing beginning dirtying the page
without waiting for writeback.

This involves:

- Update the mapping's stable write flag when setting/clearing NODATASUM
  inode flag using ioctl
  This only works for empty files, so it should be fine.

- Update the mapping's stable write flag when reading an inode from disk

- Remove the explicit folio_wait_writeback() for FGP_BEGINWRITE call
  site

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ sashal: Reduced backport -- upstream ecde48a1a6b32 touches 4 file(s), this
  backport carries 3. Not backported here:
  fs/btrfs/btrfs_inode.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c  | 3 +--
 fs/btrfs/inode.c | 8 ++++++++
 fs/btrfs/ioctl.c | 4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a188467a9fb3d..b2865f6987e7f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -870,7 +870,7 @@ static int prepare_uptodate_page(struct inode *inode,
 
 static fgf_t get_prepare_fgp_flags(bool nowait)
 {
-	fgf_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+	fgf_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE;
 
 	if (nowait)
 		fgp_flags |= FGP_NOWAIT;
@@ -940,7 +940,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			faili = i - 1;
 			goto fail;
 		}
-		wait_on_page_writeback(pages[i]);
 	}
 
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e843531201bef..6ce7df69aa650 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3867,6 +3867,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	BTRFS_I(inode)->index_cnt = (u64)-1;
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->i_mapping);
+	else
+		mapping_set_stable_writes(inode->i_mapping);
 
 cache_index:
 	/*
@@ -6342,6 +6346,10 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (btrfs_test_opt(fs_info, NODATACOW))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
+		if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+			mapping_clear_stable_writes(inode->i_mapping);
+		else
+			mapping_set_stable_writes(inode->i_mapping);
 	}
 
 	location = &BTRFS_I(inode)->location;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 46eb80580d3bd..c38d7cd0f34e5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -381,6 +381,10 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 
 update_flags:
 	inode->flags = inode_flags;
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
+	else
+		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
 	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
-- 
2.53.0

