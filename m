Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69842EC09B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211830; cv=none; b=g5NMB0HRPmBJmIeXCAVBv/oeQnCFfDZn116J08/eRrxGGrw7+n1zli9n+9W5gsERKynAddu7DZgzbd64tBJMW4Mk0dDqoKrU0pIVsrtosWQSQk+7kiPMZSdym7k1x/VIoNTgX4rETXHRYZ4EKh3gqCFVDg0t4rrvQ18AkN5omW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211830; c=relaxed/simple;
	bh=zZNXoMgPOuSjsSkNW/Nsgod4ywdq9nsKrrLhxOWRhM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLRa7OwZPjGLhYTv4bPE6KzHQvQX7nZ9nDZHxZolh5elFWPtaM1vXNFs9uPQAnNJEoPewqYWL6McHE+gjCljS56M3ULDdac5KGSfUW34EnwjQtmf4yIg9ulC3YshKhVvmR6dvmcg5WIKozgR982gdLps4HqxIvzexzbkhT2wEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AROVGoD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AROVGoD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D18A1F000FF;
	Sat, 12 Sep 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211829;
	bh=uB4G6CHbV7okoVLvbjqnebNG/Ii5RrmA1eLE49HAxEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AROVGoD6H+GH+8dGWA5erdBv2RLLK9ISPyd7FUiyKztOnZgKs90lMgco5jMgL0x+1
	 +qXBlsKi0gLHAPY/Fa4WSOhpF88ezC9YR+iz8CnwSzkLb52QvSENmMzjFBA700rjCf
	 3ORLaUKUauDTABtW5CjP6kOyuS8WUnDFBMslQPiXRUu61Ng9I0GjHM9JaJlJaNfYVK
	 IIAm9ackGi6GuCDX494ic4FWXLNTFzwsk6gspDywX43tZJNrTf+XwLsCHuEPouQQ10
	 EYLykFXJCnGRzILyeWfWITcsafIJWRYjhEuzwOxkgkkGd72WyxEJWLZ7d0SYPW5+Es
	 1uTjPnu5ZKT8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] f2fs: Add f2fs_get_node_folio()
Date: Sat, 12 Sep 2026 07:17:02 -0400
Message-ID: <20260912111706.2282608-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111706.2282608-1-sashal@kernel.org>
References: <2026090957-spectacle-juniper-fbdf@gregkh>
 <20260912111706.2282608-1-sashal@kernel.org>
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
index 6bcc60b02bd00..8f6c1079d48f0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3682,6 +3682,7 @@ int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bf4bf31b73416..0aff16c5e1b5d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1524,6 +1524,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
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

