Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B147A0CD
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216587; cv=none; b=PQ4V0auDY7V21LcffKwW/ddqnXljZbl7U64eYwqTaSNvCWlIKl6v9blq+/ntkfHvvSmIENpYrElFwOExKlUoJIh5oIMND6ak807BYgyqNyM17gVfhRc0Kb6Xi7nS50AsLinBqgXBIBNVMhEAu8T7NNLIFaT9r2mZ/aAwM3NROSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216587; c=relaxed/simple;
	bh=hnjXOT3fet2QGLALpn724PJVup4JIr8uLtZCxhAS21E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlFxGlH86qj4nriR+07dG1QH0CuuhmzGBZkc9HHKrmtuaagmUoJdO3ftUosUnCE6zQBUhffqZz/mMNoZjKNi61HcdiVSkXktr0pN0WIwuPODRIg4uQVdAjpf83Yb69njw66AarCT24ftptqTe1uPUeL5JJQnVbNH8Ywps/eTBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSKEvSAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSKEvSAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E581F00898;
	Sat, 12 Sep 2026 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789216584;
	bh=wLX2L1+ytYhi2nyghZcU3makab4MCdHflxakEH6P0OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSKEvSAN6iCgmUql1X5clWeUdBkzFQBXDkA4EhiARAq12HKrggxRnlsfT8RqmVBmr
	 rij+rURY0q7iyGyNQ/v/mYb/GJSA2j+NwP2bvzs5bdUcrAfHgyKEJONol2cyEeuDS7
	 FMdZum9VG98/oenrSdgSS/mS0zNQp6Wd6p9izBKeV31MlxGC/ct4lF5tdRAeFlD9To
	 sTeV3WJDIydS89KCfKmEVxh5Mo9AXtnpMhxTZ5kxqSZm/Uf8Li1R1c4wBN9RbrfzNW
	 ILrXUnJP2RbUlZTua2o4UXXJvSwhiV4oThwYdxcVDersga7SVWShAo1SaB/94gTdPF
	 vKr9MPuCeZY2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
Date: Sat, 12 Sep 2026 08:36:22 -0400
Message-ID: <20260912123622.2633797-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-easing-frolic-badd@gregkh>
References: <2026090958-easing-frolic-badd@gregkh>
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
index 1dddb65e249ad..45a3e35ce72ed 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1792,6 +1792,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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

