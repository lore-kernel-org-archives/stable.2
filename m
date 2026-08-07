Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215331327A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115970; cv=none; b=PTmQQdjk7DfymcjSA9UoxcS0PFZee8qnf4xrLBcOvStZJOU6bqVMuPtzkWYpuWEc7pK0l5iSywVB9LrvD0aGtAu7cHs2vaJ5fccX0aUXG53/eOL5uAUsHjY/vDS4Cqjv50Rc7lV3zRpRmyZNQVBSI1SyiN2XSrFkjyq4u2gmzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115970; c=relaxed/simple;
	bh=21sYVdMTS8iQ12JkBhOVaHoN1T0p36zpx+jNJf5WPmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnU1kI+OeXdE/sHeGSTEgA8m8u6CU0KkliAC89uMcLWKNgrze92q/a0uFPPCR6mE7gouoZJzmadWfAl4Ju26V5wrhP3H1vmCoeQK0smgcNhKq9xRdivz4z0mnvhHM+2Df9eqnJ9Lhn7csVyERsfMh83xtfcISS+o5cAOy9wL9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeIfAEjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeIfAEjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD8C1F00A3A;
	Fri,  7 Aug 2026 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115969;
	bh=WT/k8/ylr0r94nqNEQjisFzeSyhRLN5/05VvcwRVaXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HeIfAEjUu+ZS2fhtcbyyda8FVtxhFo22iVs9mVvRGIuxtvVljCHiICJe49rRQx4k1
	 QJrF7pF13TncTRJLaKfGTB4thRpUlAswn0cN+Nso0/Qb5ZEw0kTQf+konXbV3b0SY3
	 b6PwyD13nC/Aq9Sqx4h6eiHF3SnxafJnpWGnONoggNRdSDkwKuXLJeAVqYGY442Xaw
	 xx6A5lKmJP+N3BA0Pdcg0SLwPbc0YnwHKnkNfOF/BNODrzTz1IAaomJZYrMbj+i3FJ
	 uD4aMR3qTQTEfdSWQCdvNGLMEd+0+WM4YmIwYzRsU2j8E8WHd5Dau47+9VC7Ugl862
	 9Ygq6EVje2XcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] ceph: Remove ceph_writepage()
Date: Fri,  7 Aug 2026 11:19:22 -0400
Message-ID: <20260807151926.2227006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072946-idiom-facelift-7c9f@gregkh>
References: <2026072946-idiom-facelift-7c9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 19a288110435408fcf2cb274823f2a17d03caf9b ]

Ceph already has a writepages operation which is preferred over writepage
in all situations except for page migration.  By adding a migrate_folio
operation, there will be no situations in which ->writepage should
be called.  filemap_migrate_folio() is an appropriate operation to use
because the ceph data stored in folio->private does not contain any
reference to the memory address of the folio.

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250217185119.430193-2-willy@infradead.org
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cbf59617cd71 ("ceph: fix writeback_count leak in write_folio_nounlock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8d1a646e229a5..9441344bdced4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -824,32 +824,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int ceph_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int err;
-	struct inode *inode = page->mapping->host;
-	BUG_ON(!inode);
-	ihold(inode);
-
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested) {
-		redirty_page_for_writepage(wbc, page);
-		return AOP_WRITEPAGE_ACTIVATE;
-	}
-
-	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
-
-	err = writepage_nounlock(page, wbc);
-	if (err == -ERESTARTSYS) {
-		/* direct memory reclaimer was killed by SIGKILL. return 0
-		 * to prevent caller from setting mapping/page error */
-		err = 0;
-	}
-	unlock_page(page);
-	iput(inode);
-	return err;
-}
-
 /*
  * async writeback completion handler.
  *
@@ -1598,7 +1572,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
@@ -1606,6 +1579,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = netfs_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
-- 
2.53.0

