Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904383C0A12
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723055; cv=none; b=QmCi2fHJ4jsJnWCAdCmBzgH/XVk7FdgNqLi8W1in2Lv56dE7kmcmJbE89Uc1fzToAUiwfkkgPViMyppfVwdw8n+9IxP0fXtwU/Ls/ZBiUj8EPxBLtjXpAtGrHrqGaJz+gx2zcK6NHP7KZUS0y6yNnb1bALzZuekMSvto+mcPxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723055; c=relaxed/simple;
	bh=b5+yAdH0/B+7kFAJtIuKuhyfsc8GJAm7OlAp1+m2lic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjYKsRt7iYFegCffSwqoU1XKh8sg4Nd+ZTn1yEUYK+nnLeytPnpG0Kf4Mu9ClomEZTQjp7wPewtJc+CmaQS0UXkiKNeKoAqumQcE8fJjI6FhdVCEjg4ltsQzy58yyZST7erH2FAGaslUTVMNijdQtgKbd4JJqlYTsM3/bdpklEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjuB0v+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjuB0v+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CB81F00A3E;
	Sun,  6 Sep 2026 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723053;
	bh=sUGbDwc/MiA/CrKWAGxAGiAaSN8maUZrlWaeKOQP7qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjuB0v+DQYbd/1WqWQPGb5zunoMPZ+n1Tl/nYJLCM4MdOIpRePas7VFL+D4cXRRZr
	 V3H/1HnFXGmdhtC3FwseTSaAF+OFDXrlyzPtB86lc501QfKBdRrbcFrwl6nBxnMP/e
	 Pi+NVlnU6RAp5fCB7e0qXPXI+DorUWKW0fu4h2NwWeh9rkR/byoo0aRzeeUF4aZyWn
	 l5btg9IDyvMeDwoxbW1RKmF+nio64NycxHfrMfbWhTBthbtoZlvlqqTxqfV2z4N+WQ
	 fWXRuTQ289HQIpw7rIF9Bo+Q838f5G/bRkmqgtlridoIy8+OlIsVgeAvbOtNwcyC3P
	 dRfxwJJhOourw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/8] btrfs: expose per-inode stable writes flag
Date: Sun,  6 Sep 2026 15:30:44 -0400
Message-ID: <20260906193048.1791749-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193048.1791749-1-sashal@kernel.org>
References: <2026090330-nappy-discharge-0af0@gregkh>
 <20260906193048.1791749-1-sashal@kernel.org>
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
index fe60f2d7e8aec..8701f94002571 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -884,7 +884,7 @@ static int prepare_uptodate_page(struct inode *inode,
 
 static fgf_t get_prepare_fgp_flags(bool nowait)
 {
-	fgf_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+	fgf_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE;
 
 	if (nowait)
 		fgp_flags |= FGP_NOWAIT;
@@ -954,7 +954,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			faili = i - 1;
 			goto fail;
 		}
-		wait_on_page_writeback(pages[i]);
 	}
 
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab7f19ca21457..9f8b6a8a36928 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3851,6 +3851,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->i_mapping);
+	else
+		mapping_set_stable_writes(inode->i_mapping);
 
 cache_index:
 	/*
@@ -6310,6 +6314,10 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (btrfs_test_opt(fs_info, NODATACOW))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
+		if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+			mapping_clear_stable_writes(inode->i_mapping);
+		else
+			mapping_set_stable_writes(inode->i_mapping);
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index df288213f91be..8997e65d32863 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -391,6 +391,10 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 
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

