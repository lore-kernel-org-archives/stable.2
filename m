Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91B478870
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212092; cv=none; b=EKZ6cGDIspsQu8IUb1GK0cqlDiCVwh32q4UpyLiBNUr9iG/oK66He27NmOvYZXhSX2zqkbnZjQPCaOXqR2yJtY51ZIXOIqGQ1fysGXIVxTnukWS5mFr8bnK6ysueDSx+W/nA4OhZkP2qQ5D7yRHdQrTdi1iK7nQYsNfqGng3ks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212092; c=relaxed/simple;
	bh=B1zTjTrlGSAKbsOJArx3tl7R+JKPkG+sZrA+h6OLsq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXW4ia77jFPOip8Vlohutw7JZhej1Xv5Bl1OMiboBfO3hNjBphOamdGILWEyrApAkBlMXzaDzVohmirS+aIMGK1nJhQla+spNE3XdJiJj52NpmBDd0bIIcZbjoLWi7soC9YmAcKlUX6kUXHvyT4wUzF3H5ExfOOtVzgSzeSFAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEvG1FK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEvG1FK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5A41F000FF;
	Sat, 12 Sep 2026 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212091;
	bh=3g0mpgL/i9umFRUvlRgdgq6kYQS/kH0xRIn4ZG28+ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEvG1FK1FFZxa+1RFKKxaL2Q8tOJiu/KxIlguh5/SewVRsfRhkAsoGrzTByQIN4oF
	 kXiXmDLfd2joxWR7VBt+0HcLBk+ew8UzqB+m1qcln/Kg5B4D9kyuHdXYwIcsCWMYzq
	 5UklqhXa6JvjM3Qeie8CTgHKj6fLB9irMteKrAxWZrs7OAQewID0Ib7o+noEnZuXF0
	 QIzVF09q/uBeto+KOcgTLCPFjx+udnA9ZMfXojfDm4QL/VIXXxwmeG9TXIuOb2NOKL
	 f0TJdllrnB4bON20bmhQXoudpK0A3OcnuPq6NgkAXbTCmMdT2SaDW/27B57b9I5hLk
	 ugXSQG4PT58uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/6] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
Date: Sat, 12 Sep 2026 07:21:24 -0400
Message-ID: <20260912112124.2312624-6-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 32296fc08f386..c150e4e78870f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1885,6 +1885,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
+		if (unlikely(!is_node_folio(last_folio))) {
+			f2fs_folio_put(last_folio, true);
+			ret = -EAGAIN;
+			goto out;
+		}
 		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
 		folio_mark_dirty(last_folio);
 		folio_unlock(last_folio);
-- 
2.53.0

