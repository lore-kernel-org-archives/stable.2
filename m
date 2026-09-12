Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A04766BB
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212089; cv=none; b=iMExOn5qdBCsL+QH+GKBF5ZFdpSWQOQ1lCVZq+/nHIo6x/9dhptaWLwgv/wYRc4kC6oH3I5zGPQ6A/hQJ0At9NInK3DM8FH4fxnzk5FC+LFBOLRvhl1SCOMu7cFxpQr43Ulov50U0kVILz0wONxoL8Qk2jZeTAmOVyhwd+7wO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212089; c=relaxed/simple;
	bh=KB7o9ijvKqoau+aU41M+RYLsnm4KgF4QzU/S+GyFHfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4pAZ0CSk3mUknorH6weP5IF37x32mgSD4/lI5EuKR63T6cyMqH7CP5FD/zU5sxHcsR4ffZNFy8yNVx2L/c58uw/LQUvQ6wScj1H4kewKsFFegB7PZB030pE+Cr0LWfeSfvc+COcpJV/d13w85qOkea/OE68j6561rb9OEtvurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqNagkFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqNagkFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4349F1F0089C;
	Sat, 12 Sep 2026 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212087;
	bh=D/so0diuHrFBdy4nX3/3cWI89KTR4rsn9nhaweMSPvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GqNagkFDl/d4gn0snlDeOir/5ldT7frhHsqJVJTNjcvWjov9QJ7bTcPNx2xoxhbI8
	 +UOf0JMLd5Twd2r5kFq1kfItMg4ms8X1iR3Sp52wMd+U41cVOaECGmGPEYplSQxhWo
	 MBDDxBW4sqQpVfYMX+yuaxx2wFvnNqKp3KPxgybrgXbYreWMIZw8rYGGbSy+XnFspR
	 RqoTGWKNXjisdRrCgpDjF7BQGWn4FWJSa6Og65pKx0iV7esmsA6ybCUvIU2c6+W59h
	 VcxA9zwgNnxFuUtfmbFGnNnVzU/qijE7qAe2v6MZhvUTIYg8H2istlJD3bn69vKksr
	 7QdRLJHOzskFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] f2fs: Add f2fs_get_node_folio()
Date: Sat, 12 Sep 2026 07:21:20 -0400
Message-ID: <20260912112124.2312624-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112124.2312624-1-sashal@kernel.org>
References: <2026090958-headband-sturdy-0f93@gregkh>
 <20260912112124.2312624-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit aa220cede54ed671f7be413d8dacb91263a9d218 ]

The folio equivalent of f2fs_get_node_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4afc0cc6e588d..93b0bafcb0888 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3597,6 +3597,7 @@ int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3f003cfe055a6..c7696b7ad4dce 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1497,6 +1497,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	return ERR_PTR(err);
 }
 
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
+{
+	return __get_node_folio(sbi, nid, NULL, 0, NODE_TYPE_REGULAR);
+}
+
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
 	return __get_node_page(sbi, nid, NULL, 0);
-- 
2.53.0

