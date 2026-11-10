Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350684;
	b=4LaCiW7cKf8Mcz61hQ8OQXFgMcIz62QFdxgdXYwcvugePyobXd/YzpMAIErAYqNrhzgK
	 noDXQ0EWFEtr307yNBpu29rlvui03brMHOnmHw3vU2MPX/7D6Q9vMiXPcAA5c6Qc6JJ8R
	 x3cXI10I3nL9bKtRu8msZseyg0F4SWI7fyNPC30TBI9BeS8H2fhNV3lCacuFQ/UNQQrEN
	 hCZonEHGYJLJkrn+2KrpdfNu0lvgqD1F8IwwLHVYt85xEI7/v2D8wHg6kTH/dtqiS5rJz
	 +kLUBEODrXLvz1990eG3TU4GToLC4xvIpzy9k8Z2Ag6C5QkqK7iPdqWQoO8LNJBwyeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iGMKQ+exbGlrB3uqwa1JIBXtF/ohDSNycRon18Y6wNA=;
	b=5EwsOm1h3XdzpZSCZhGERjrw+d5feIDy5xBICk557/WydfwLGiQymV7yiYbTg/vbRdeD
	 Y/jRu5TRmHCx06INoTnWuPvK8Pm/J9L1PWUfulNddfDBDMIlSSceR4VZKNj7+ocQQaV9W
	 SQL8x8eVxQV8sKlj1W8EXP0EkXbW9cpRLU88J3TLl21qViggoit6x90ezyLIwSNcjOIvE
	 rZdKDiNkXpsI2WH1NY3j8NFYRyMALjlSiyRyMKLGGcM4ehJzCtbiFMFfHzXn2kyWTix6N
	 Dzuexnq7tIC5eEJ4Vk8rJNnUYUNmulgY0pEsv3Ao6iK23aA8C0kvcCEwOTE9zRLQAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW7zx90X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW7zx90X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF5C1F008A2;
	Tue, 10 Nov 2026 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350683;
	bh=iGMKQ+exbGlrB3uqwa1JIBXtF/ohDSNycRon18Y6wNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZW7zx90X2OmaOtDUe4hMrTB92RnYSG0zzM40cKuVK3DPN7t/sF09sVDoAZRX2wqcT
	 UrXUDfDUVFG0F8vQzhZNFsFxcTu+yzfFUNItvIvPqIZV9oUKkGem0gNgnyOzmWcGTH
	 3Wn4ktxHDnahW9+B15LtDYrrpz/OZXTwZlhoJyYSV4l8706lvH8P6kx0C6liWvUVbS
	 pnwsJHj5YuYvDdY8Xbykx4NY1QWwebhQZHEIs8vQLRKKRit+ckj2nSxPnMD+ZHjtgg
	 LWm/375nigjiLuiiQd6ff33Uz9CUl3fw+L6yiYEBKzGWFRRGmltBqTEM1Namnl7BZk
	 1JKy+sWh5oeqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fuse: don't launder folios of a bad inode
Date: Tue, 10 Nov 2026 17:44:41 -0500
Message-ID: <20261110224256.4062983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052332-failed-6.12-01d0f3d294af@kernel.org>
References: <20261107052332-failed-6.12-01d0f3d294af@kernel.org>
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
[ sashal: Replaced wpc.inode with folio->mapping->host because the writeback implementation has no wpc object. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d242613a1c8a0..97fcc5c136fcc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2538,6 +2538,10 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
+
+	if (fuse_is_bad(folio->mapping->host))
+		return -EIO;
+
 	if (folio_clear_dirty_for_io(folio)) {
 		struct inode *inode = folio->mapping->host;
 
-- 
2.53.0

