Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F63471CEA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781648; cv=none; b=VVB43dzWrr9dSdpgTNf4VeO/xXrwcx0UiIu3XtpR0jCONe/843tAQP3disaMS6JzGAA8nrz//jzI4IyoMoOInEt4NX1IlXgxUqv9VVV2rDcBzc2jwiZmfTHbtFS9UO6tseQYD6Eb1rbaA8B08GueEWmS+LlHOj0a+i1CTbPeXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781648; c=relaxed/simple;
	bh=Ui9Ve9gWC3VGKtdYUx94LShWTo4ebwooPu/zT7MT+uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGZLJWWyaHcWcXq2VRI6tir5G2sB0JyZsYxYyV0zgTnAkBOtCxMmYuXthEXxh+KUMlvsVv4vMqcXAc3B970xvJyETBOFU7v/mdm2AQgwBMu7EMIrb8dqna2PDU8wD33Ddfz+DSyJJdkGCNjltu58yITB7wl6OhHgMgWyacf9VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQcu0pDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQcu0pDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F751F00A3E;
	Mon,  7 Sep 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781646;
	bh=0qfoPc/QvS00/LGsxFqTxKSxGcBy+D5Gpb8Km6c84ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQcu0pDtGHlF3TRnyo98CslIkJAOVDs8c5iv5aEAHIIJvVRzzKUPF+UX0D0jV9Ivi
	 qmRgE6KZ/pGu87vM0NzGSD+xev+ACUgcP4Oc3Y5yE2fEVod91qYEOPQD4vT3/p5BMB
	 A1nVNWZdCQ2469cygYxQ9Ce2lq1SBLI9o259YnJiLTC2pp8tavjVCL/nWZOSy5qrPq
	 HPrkb+VKCgL5zwmEwtpxFYJ47wFAfU2HBAYqM8b0BAf00BGNEh4nXREANnZGDM0Vae
	 Qb4YJEhZ6FcedRwp0HzA5/VND1ofw7eqKKWqRoCroWzspTWIr5nROm0rPNI2OB5FUc
	 76aBf7zt85sBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] btrfs: expose per-inode stable writes flag
Date: Mon,  7 Sep 2026 07:47:22 -0400
Message-ID: <20260907114723.2870432-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114723.2870432-1-sashal@kernel.org>
References: <2026090330-antelope-bullfrog-bfbf@gregkh>
 <20260907114723.2870432-1-sashal@kernel.org>
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
index 0970ec776ff8e..a0224ea15e0fd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -863,7 +863,7 @@ static int prepare_uptodate_page(struct inode *inode,
 
 static unsigned int get_prepare_fgp_flags(bool nowait)
 {
-	unsigned int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
+	unsigned int fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT | FGP_STABLE;
 
 	if (nowait)
 		fgp_flags |= FGP_NOWAIT;
@@ -933,7 +933,6 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			faili = i - 1;
 			goto fail;
 		}
-		wait_on_page_writeback(pages[i]);
 	}
 
 	return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2a1d96a806a9..8e34328fa5da5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4092,6 +4092,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	BTRFS_I(inode)->index_cnt = (u64)-1;
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->i_mapping);
+	else
+		mapping_set_stable_writes(inode->i_mapping);
 
 cache_index:
 	/*
@@ -6582,6 +6586,10 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
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
index 6dc4e88827740..6c003682f3650 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -370,6 +370,10 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 
 update_flags:
 	inode->flags = inode_flags;
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
+	else
+		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
 	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
-- 
2.53.0

