Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535D32E6BC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176750; cv=none; b=pkm7fsaz9tFV8aNTgMc9jOzbfHWaQiemebElGux+xUK/CaU6K7lj8iaDb1x1OqM0EpVCWOGvq8vaezRfxsotO0cmnPbDOTM8KcE/6qJicrBqArE5u7WezUylOeXZoqo8RnQsc3SYbZ1TkVUj5HQy2+kJyQ3UXhwqdGgjkuI0b+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176750; c=relaxed/simple;
	bh=HgbYzoW8Y6/6tTbFSNrUDRAke8gzYf25b5L7hD8SjVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nC+Wop9IY1MSNIze8iNcWQ/icuXNc6k6JW8ub3NCCQGIUUjcPUY+OqbGjvQZRHZVFysjTU7Nw/4I1EPa1qdPPIrekDP6kPwBfFdvzLpVh5ezohvOqVOYVpgPWB/DNbJoKffgQSY+AioH9H/oGhVzgPJQOiEUY13KuJcRncMs7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVnu1Ch2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVnu1Ch2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E991F0089A;
	Sat, 12 Sep 2026 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176749;
	bh=Dh/XQtyJ/Rwslk6kj09DnO9imlZjehhc73/7rmcYeTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVnu1Ch2VPlG5yyvsSlNDUJ3dTlpPJQ3SF4J1QUT6MkTwgaxomkX9/5+Ykj15h0+0
	 NIhFWZTUAFS3s9TSW1qhBg4CjvQOZz3+DfN8B/XV/bPRCFiLXh48rflKUPGANDqyIH
	 pQxGHxKBzYHqg6OK4H3Or0+8GyMx/AvTUas1bsW1edASlGG+EKNSduOBw32FCQpclu
	 edz0crH/Wb7uNfLv2DW5c79Q9kcEV8wbg30OPYgVVKBpEXr7haXgY/sYeMNKbbGdBy
	 HJiFwexxG6wE7Q5CcfmaBgxqFWiLMEmf5jjNWetaWxFQQ4D/P29IHTXUY5DL/+RxGV
	 NfrFVXfAOa/sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
Date: Fri, 11 Sep 2026 21:32:22 -0400
Message-ID: <20260912013222.1762882-7-sashal@kernel.org>
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
index ce75669332efc..c04caeccefa98 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1925,6 +1925,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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

