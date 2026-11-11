Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361591;
	b=n8Xz7xxJBmWilkrrnEaKtdLY/IS7TbFSKi6GBIjIpnzaWXW9iVLlkzSk+X4fm0gIwhRT
	 m340PnBMc1Jo0b+qYGDBtOCaEkjeTl8MUi9uHv1p4HVCznq+woIoxBu381/rslCpXUoQg
	 /VOQQeI+mtjRXl7y5MboRTaopdiULOstVxokxt1XmtLdUr7keP63zQgQVxymo1Jg6H2Oe
	 8AhX1LfhAFMaFLT978fPS3jnjxkXH4u1vntmph4z1W6RbXPi4Wch06FQ1SiZYyqM073Jf
	 c/f8hGMZMnBwc4bDq6uhQXCtcSYEU/GRmpHkO0g4puHX0x3+bnuT/IJc6aWsZB6buBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/1BZo122naZf5SDh5W892yAvH4q2yW7c0ih2MygHUPM=;
	b=lPJt2rOrv3n3Cr2WxniIUcO8L6EqW9yy7fPdeBPphTgO6RxmY6Q2rPBmKpL6rRVtVvB9
	 FP4bRmsJzgSc/aJyczlniyUltINSuyBg3gDWhRmxn7jHk5+pkdkgsmbYBB5qjrK6MV/nR
	 l6cr0nv35inbNfE4SZoj/6LMP5Af2aWerd50wf00+ct5vfHOB3Wzt6gvMTosiMmyvKypn
	 VCiTH/hRVr620G30Pfd71QEqq8EEE5mXi/apph7rApX8Dl2PM+2WNyBRz9+U8HPFkuPes
	 rv3ZbKVOZVqdKMPoyFxV65VOtIthFQJDemmgih50X8zKx/g80HvKlOyvNh+BWvqqn5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7pAJScw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFA606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7pAJScw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FBF1F0089F;
	Wed, 11 Nov 2026 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361591;
	bh=/1BZo122naZf5SDh5W892yAvH4q2yW7c0ih2MygHUPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7pAJScw2Mt624P2VYQGYdqUnaDwEVryJQLzzbXVHBXVRxfEx0kyPhN6jfaswjeoX
	 G6ty93INAKot0HTkgeq59BlBtejKk3pXHWf1E1lU6zkYSm6Af5ZYo4c4VadmoC7e73
	 fHMkHFg9LFbufTfDipXe9PgDLo4Ru0VgXlGcU5IzOWBivBnoW6q7WJx8Y8rk7ySjiU
	 JHCyDAfX+hu3TwZ2ntoNxR4S4AVShONOBpMmSo0jACte9z34Gp6h9TGENW4Taqjk0H
	 XbM0jZVPXrcC3ZEAQ8I11vFueYXxdesmFvZiwnaZAYxTEpPfE/KP8sgT/prYPER6hw
	 97IvYANDEHf+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fuse: don't launder folios of a bad inode
Date: Tue, 10 Nov 2026 20:46:29 -0500
Message-ID: <20261111014257.413120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062436-failed-5.10-01d0f3d294af@kernel.org>
References: <20261107062436-failed-5.10-01d0f3d294af@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 01d0f3d294af126f517d92c11e100525537f8be4 ]

fuse_flush() and fuse_writepages() reject writing back dirty data for
any inode that has been marked bad, but fuse_launder_folio() doesn't.

This can cause the following warning in fuse_write_file_get() to
trigger, as reported by syzbot:

WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [inline]
WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
Call Trace:
    iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
    fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
    folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
    invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
    fuse_open+0x5a6/0x770 fs/fuse/file.c:297

This can be hit on a writeback cache mount:
1) a writeable file is open and a buffered write dirties some pages
2) another thread opens the same file read-only. fuse_open() passes the
   bad inode check and sends OPEN to the server.
3) a SETATTR reply with the wrong file type marks the inode bad
4) the writeable file is closed. Flush and release skip writeback
   because the inode is bad. The pages stay dirty but the file gets
   removed from write_files.
5) server replies to the OPEN. The reply has no FOPEN_KEEP_CACHE, so
   fuse_open() calls invalidate_inode_pages2().
6) the invalidation finds the dirty pages and calls
   fuse_launder_folio(), which finds no wriable file and hits the
   WARN_ON in fuse_write_file_get().

Instead of trying to write back dirty data for the bad inode,
fuse_launder_folio() should return -EIO.

Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Tested-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ sashal: adapted the check to fuse_launder_page() using page->mapping->host instead of wpc.inode ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9b40d5f067abb..4a940f3e78914 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2345,6 +2345,10 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 static int fuse_launder_page(struct page *page)
 {
 	int err = 0;
+
+	if (fuse_is_bad(page->mapping->host))
+		return -EIO;
+
 	if (clear_page_dirty_for_io(page)) {
 		struct inode *inode = page->mapping->host;
 		err = fuse_writepage_locked(page);
-- 
2.53.0

