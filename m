Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97D3DB332
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140613; cv=none; b=LrhnW0J8aCS7Js8H0nNmrOU25/DGDrl4urNhJRL+rFg/vHanY3FtvaGD8Jx0Wv0J+WrTUfbMqqGX6buEbLuccoZG2PZj1k4rKJ5gIHJ5ZluRvgWSY6mrep0a/d1hCCQcPNNcH+AEQtnlHUFXjY2FADXqwE4I0YpF7q6++A7TpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140613; c=relaxed/simple;
	bh=oaSfu4g+64f/htyw90bffqPuKvWNvs8lHtyFdi4MG30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6ymDJWjtVhPCnkb8Zo5IfMZPCUJ6qijfE1RsMeBhclGwvjZfMxP6NBx1wag/6M7uw+NbZyPM1AEhEQVxjYemUXyxwJesYRYSLazlz/8LFEjWQ8y6CIZzPBD8Hc4m+/Mb4kRi+SFFBAqKDmtQYhovBO67LxBlHcxoGhRrSc16bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZd5Xabg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZd5Xabg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F241F00A3A;
	Fri,  7 Aug 2026 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140611;
	bh=fF+gUEbMvWwaX2BnKLzxoRoANODK7dBSZZiQIHZ8DZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZd5XabghEHmEVJ0ohzG+KtsDTZ/sLnim/gZQmYoSIc5GjAlqdliOAmf+96D0zXg+
	 aAcu2Cyw0OeAncw5I8ayJkJ23j/9W2rAgW0F8+xwoZyi5zx9Ni+MfwjNZZz7HQ9kfQ
	 x3Xlkrk5ceXVnmeYsl7LYinSt3h2uLIDOn3vhZcuPka358QZFpMuIvqzkA8tq26JAL
	 VqrQ5ET9YeyZ/tZYfezj54EHCEB3hJLtp74TDp05gyTOcimEIjEvX5HHl+iYNHLaE2
	 LnC2pjXzxIYPfcPfbNwGnP0t0xE69DJicNObcjIaGJvyK1NISS8n3eW6AP+j8lOFEr
	 CA7J9JlJq3f/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ceph: Use a folio in ceph_page_mkwrite()
Date: Fri,  7 Aug 2026 18:10:05 -0400
Message-ID: <20260807221008.3785418-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221008.3785418-1-sashal@kernel.org>
References: <2026072947-gulp-passivism-4b27@gregkh>
 <20260807221008.3785418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 88a59bda3f3786107694a3f5fd7f9df421752c21 ]

Convert the passed page to a folio and use it
throughout ceph_page_mkwrite().  Removes the last call to
page_mkwrite_check_truncate(), the last call to offset_in_thp() and one
of the last calls to thp_size().  Saves a few calls to compound_head().

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250217185119.430193-3-willy@infradead.org
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cbf59617cd71 ("ceph: fix writeback_count leak in write_folio_nounlock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 603adf1d590e3..95b3e6b1c11aa 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1659,8 +1659,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct ceph_cap_flush *prealloc_cf;
-	struct page *page = vmf->page;
-	loff_t off = page_offset(page);
+	struct folio *folio = page_folio(vmf->page);
+	loff_t off = folio_pos(folio);
 	loff_t size = i_size_read(inode);
 	size_t len;
 	int want, got, err;
@@ -1677,10 +1677,10 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
 
-	if (off + thp_size(page) <= size)
-		len = thp_size(page);
+	if (off + folio_size(folio) <= size)
+		len = folio_size(folio);
 	else
-		len = offset_in_thp(page, size);
+		len = offset_in_folio(folio, size);
 
 	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
 	     inode, ceph_vinop(inode), off, len, size);
@@ -1697,30 +1697,30 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
 	     inode, off, len, ceph_cap_string(got));
 
-	/* Update time before taking page lock */
+	/* Update time before taking folio lock */
 	file_update_time(vma->vm_file);
 	inode_inc_iversion_raw(inode);
 
 	do {
 		struct ceph_snap_context *snapc;
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (page_mkwrite_check_truncate(page, inode) < 0) {
-			unlock_page(page);
+		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
+			folio_unlock(folio);
 			ret = VM_FAULT_NOPAGE;
 			break;
 		}
 
-		snapc = ceph_find_incompatible(page);
+		snapc = ceph_find_incompatible(&folio->page);
 		if (!snapc) {
-			/* success.  we'll keep the page locked. */
-			set_page_dirty(page);
+			/* success.  we'll keep the folio locked. */
+			folio_mark_dirty(folio);
 			ret = VM_FAULT_LOCKED;
 			break;
 		}
 
-		unlock_page(page);
+		folio_unlock(folio);
 
 		if (IS_ERR(snapc)) {
 			ret = VM_FAULT_SIGBUS;
-- 
2.53.0

