Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272446D2BC
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140613; cv=none; b=nuMZXG0SjHizZMvD+VQL5GcxQd5dlAjz9JdqoYquz1n1PNmWz5/ZBn4p9faUDuzrngV620Y1zwmbBC8XUnC57PeXM4VqfsmexnFSm+yEG1OBAQySRi8PypLoqY7JvTwttZDfE3I2117ToMBmJWGtUSMVHdSyDHnMHhzI6rREBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140613; c=relaxed/simple;
	bh=Ju4+o3nV7l5nkAeRlBbvCyGvdNKrlsZ2RV6sGuCu/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcwDGY+Mg9tTEnnp8osK/iAkegSfEtbbBDY5wHF+fyk2oIylJhdFcuWf/NBqE4eNlm8C4HArs/p5WxqdwEp9hi8WMCDrTfnEWvgCn60RfpDz2TKbaTtdlnUlr5Jf+7B3nAxQyeur5gyWYvCKTxOcTpFeTBbZIevXW9o8xPgNBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BObl/lfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BObl/lfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2F1F000E9;
	Fri,  7 Aug 2026 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140610;
	bh=S4sfD4EdqvkjcaCHWhTkgAaWSLCxzzYcqfKsLTbcrSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BObl/lfQq2KUDl3NTAs/yMNjmktItxcN03iaEBURVKKQ72Ja+QAC7gShhpFRE91wM
	 TGF5brG26dRXrkhYfr5rAelMxOdn20LVeYdxdgA+ewtAd38RnbDydmv9GXP3PtkvQA
	 yAzxiraNVsdUESV2EJj8v5yDPw9fPkeaT4hnsKE+1mbLjlZC9XOy/irup9EFtcpLWA
	 J5om/FskDLS9D/+e0oOuasSo59yFU99yOJ7Mm24JwxGy4gIDzAoJsmcDqtD5BuH0Ul
	 QZfJuVO4G8BFW5/PmSdscX1i5aYpGzgDQEX2+x+MHZ9smGRoRiYeAMLusu782Qrum5
	 AjdnRj+dpWqDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] ceph: Remove ceph_writepage()
Date: Fri,  7 Aug 2026 18:10:04 -0400
Message-ID: <20260807221008.3785418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072947-gulp-passivism-4b27@gregkh>
References: <2026072947-gulp-passivism-4b27@gregkh>
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
index db4d11604e9d5..603adf1d590e3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -799,32 +799,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
-	wait_on_page_fscache(page);
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
@@ -1563,7 +1537,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
@@ -1571,6 +1544,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = ceph_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
-- 
2.53.0

