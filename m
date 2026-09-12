Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59B2F531B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216348; cv=none; b=leH8/43wV0L3qO13JTYEICXW4DEdC1fwFNORpcVpsP4TNcB3Z+qeB+4+ORkyZCMq686SrUUfGrc3oKvTzjvVAOhAP3F4rrQCEqY+UDbXxD2JcPb9Ug1VLP3ZfI+j6+XFL4fl2JVj3uOOHYOkw8qEADntdhfs7FV/DKAlADCn5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216348; c=relaxed/simple;
	bh=7AjZ9kH9Re1kynDJlWKePkLxkDHCt7Rsw0kLTiGVMY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDFvTBmWqvHTOVApCa+7SHDtVoo0BFCezcGW/Br0JF6Q1jF+XGBOvQGVKCSHX1CW0c1hNGu5EJCElrxcK0yc1i7N0MoVernv+G9kGNQqkPW6ptjTgbewdJob8T0UpBMbQb10Zr+Ruo9jY0gJoWaER0X+J6jJl5xw5MycdESoBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG/Nv0s4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG/Nv0s4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0481F00893;
	Sat, 12 Sep 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789216347;
	bh=WWdsuHVLFdjQKKeBCfs4MxhpYgXm95nxTmEeBZ6wmVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZG/Nv0s4SDt/IMr16ldHaBnOjfNSCgJW2rGurvqHsApMbhhkXFGKL3pSgw5mA5dIW
	 9YdmBsyDqZ7fnU8V3rZ6VO1DuMmtnndYn4AMRIFyiAagb2hV6ln4s+bvzZ4Q3mSwmZ
	 dxSBMMJ9U6oLamEwIB4e6yWVuLxwt00VPE8m+sRg6LhFJxhfr2iCRhVJOXaa6YoCtg
	 87QR9FGxuAWpxCYh6eiYTz4jqX9c+StdfWpmWB/ud+c+34lI+ve7XRKSDyNBuVWLVH
	 lwJ+XSuvxRXxU/aA1cz3vnoPO+mEv0hnjKSvG/UTHkQHTsesig4D5KDEsnHpfNNeks
	 L7BUDhfHOv/YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
Date: Sat, 12 Sep 2026 08:32:25 -0400
Message-ID: <20260912123225.2618391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-plastic-payee-9f0a@gregkh>
References: <2026090958-plastic-payee-9f0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit ce366bfa821ec81dd45bde547ee31e659306cc61 ]

There is potential deadloop in race condition:

Thread A				Thread B
- fsync
 - f2fs_do_sync_file
  - f2fs_fsync_node_pages
   - last_fsync_dnode
    - folio_get(last_folio)
					- f2fs_setattr
					 - f2fs_truncate
					  - f2fs_truncate_blocks
					   - f2fs_do_truncate_blocks
					    - f2fs_truncate_inode_blocks
					     - truncate_dnode
					      - truncate_node
					       - invalidate_mapping_pages
					        - folio->mapping = NULL
   - is_node_folio alwasy return false
   - atomic && !marked is always true,
     then goto retry

Cc: stable@kernel.org
Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Adapted folio operations to Linux 5.15’s page-based API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e5a06a65a5398..34a590d500819 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1847,6 +1847,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_page->index);
 		lock_page(last_page);
+		if (unlikely(last_page->mapping != NODE_MAPPING(sbi))) {
+			f2fs_put_page(last_page, 1);
+			ret = -EAGAIN;
+			goto out;
+		}
 		f2fs_wait_on_page_writeback(last_page, NODE, true, true);
 		set_page_dirty(last_page);
 		unlock_page(last_page);
-- 
2.53.0

