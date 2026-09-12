Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93F3346B4
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176747; cv=none; b=ssSeWDSLJ5Dq3Q7viLMyoK2bh3HnGbvUK+mVyrFvyVzJNajUSAw1kq9nOY7k426YjBWru1iLf77sZ2dyaoyWMu20lAn1wNmbMRDBU+kBSVaznZlzYX4jZuCAt2EWlwMxGROobPF2A2fopZQqjp6ruz0HWEy+NTJ68qqcpfBSFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176747; c=relaxed/simple;
	bh=qGmda38A1qPUcgOgfTp4ngvMU3sWdNbqnfT5bPFdIt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8h3pIyPKTHdoqEk3u1piQkDwk0RpGYFGPPt3KLvXbTPjUsLjqe7Efo6SDKq76CYfOHtCWyLIuMlXDIZFrztOWRndpFkeI7fBvabW3CshlThDnC5v/tA1VNauz89/FDj6wbDZts5QgZrD2E42FQYUZm2It4rJ8O/y9PUx75iNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtiEwAPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtiEwAPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600081F0089B;
	Sat, 12 Sep 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176746;
	bh=5lFVqQEXEIP8kcC0TsObl2iBvrRtqHmYyv74YhClm4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtiEwAPXAX0pCUMDxUNwIWFhKZJ16FSOjAMfoALYJyOzn85U8+RD9VYShWdOHbKek
	 irEJXhDclRTu4xzDHadNqYQ9rZutcPZi1yHrxjvEiYBMYwhF66GH/PlDlpvrcN43Kt
	 vFWXYjpc6MCd6itFobebhq5e9ZYrz++kbCboIdMuAuAcX5WQTuTFY21+1+wevq7JWR
	 uLIGoYM3xOn+MVAYQhow0sKMknOzq/rnUYqAvI9MVl5hfivbzA0QmZyZ/Ucs3RUhim
	 3ugQoHyLSDRWr5cuOFkbhCsVnDJNTWwRFdpDooHQxxEAe7EtoIwrz7L75o/5puFhQc
	 naX+4HPPsbQTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] f2fs: Add f2fs_get_node_folio()
Date: Fri, 11 Sep 2026 21:32:18 -0400
Message-ID: <20260912013222.1762882-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013222.1762882-1-sashal@kernel.org>
References: <2026090957-stoke-condense-f9b1@gregkh>
 <20260912013222.1762882-1-sashal@kernel.org>
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
index 713d8907859a8..67c5b9cb90ee6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3742,6 +3742,7 @@ int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6989e5afea551..cce67bfbac59d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1535,6 +1535,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
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

