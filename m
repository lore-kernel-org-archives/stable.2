Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF23C1084
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170072; cv=none; b=I3IzzxIizFTqPNA06YCrGYVuy7sIzawLbDk1MflYI9xcrlCviku1PN2KhpP2MjkSHMdqlGsgprVoeA8Mv05l42wC04cYlgPyAgySr63MRCYPvsUOlY9uYd4VIw+DlASq33+JBCcfe87oukAgvEzZj5WP3awpV0LwX/9YS6KQNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170072; c=relaxed/simple;
	bh=0YDJjAs/q8qbzFQpict2rWKSc7CxUyZIL5WFDJtDNDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+AjDBwZrLQrWw8p8YWXosQrLPJYGWDWYxFKDaLNJnaI+wonGi2+fG6tzyZcrNtqos6DqfW1ZxwcMjhO582ijj031jrNHTwG0Rits2Ky02K5xGKU42yjz2rYtEL/Ib1mcmFBEzdgmYo5OtrGq3Q3xMulhqHCVGdkZBcYnyCnMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2QLGqWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2QLGqWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1761F000E9;
	Sat,  4 Jul 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170070;
	bh=wfjK36M3WVjXQG3ERQXoTxZiiQdYWBj3kXosIdA6tds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2QLGqWDgQIzcvchuTbJ8s+P5oz06eXS6TcmQTLICZlZdTso1Sk+O6U6ncl3LTKeC
	 mzEqohGLEZ/sPQAzGFXAKK+fmugzAij1qDnna8jYuhLIWKXRc04JKex7zVfiU8udfc
	 vCqrrHx7l/OPGT2+y7g4sBNzC1MAzHJJJlhlHX0QYijU+Zpynw8jBHUmGM29JLDsuR
	 iOTuUs+VNDKnL4JuVj6YPpBibZhKfgNvz3t4xPAcipOk4sUprEYt5V9bi2xdXAbSH1
	 Wi/LJnSxqOGdQK8NDjLC4/Gp3fdbfXCEgIUz+KfN74SoPt3i94Jr9Q8qke2nkCsi0b
	 dpiVaECcTqSyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] f2fs: detect more inconsistent cases in sanity_check_node_footer()
Date: Sat,  4 Jul 2026 09:01:05 -0400
Message-ID: <20260704130106.828918-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704130106.828918-1-sashal@kernel.org>
References: <2026070234-outdated-refutable-f834@gregkh>
 <20260704130106.828918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 93ffb6c28ff180560d2d7313ac106efcd9e012b8 ]

Let's enhance sanity_check_node_footer() to detect more inconsistent
cases as below:

Node Type			Node Footer Info
===================		=============================
NODE_TYPE_REGULAR		inode = true and xnode = true
NODE_TYPE_INODE			inode = false or xnode = true
NODE_TYPE_XATTR			inode = true or xnode = false
NODE_TYPE_NON_INODE		inode = false

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8712353ed80f ("f2fs: fix to do sanity check on f2fs_get_node_folio_ra()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ca3dad7418b268..bf06c9582ae49b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1504,20 +1504,29 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
 					enum node_type ntype, bool in_irq)
 {
+	bool is_inode, is_xnode;
+
 	if (unlikely(nid != nid_of_node(folio)))
 		goto out_err;
 
+	is_inode = IS_INODE(folio);
+	is_xnode = f2fs_has_xattr_block(ofs_of_node(folio));
+
 	switch (ntype) {
+	case NODE_TYPE_REGULAR:
+		if (is_inode && is_xnode)
+			goto out_err;
+		break;
 	case NODE_TYPE_INODE:
-		if (!IS_INODE(folio))
+		if (!is_inode || is_xnode)
 			goto out_err;
 		break;
 	case NODE_TYPE_XATTR:
-		if (!f2fs_has_xattr_block(ofs_of_node(folio)))
+		if (is_inode || !is_xnode)
 			goto out_err;
 		break;
 	case NODE_TYPE_NON_INODE:
-		if (IS_INODE(folio))
+		if (is_inode)
 			goto out_err;
 		break;
 	default:
-- 
2.53.0

