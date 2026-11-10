Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351368;
	b=y2KvLWpJs2MrHoy7gWgwoQKtGbW9MnKYuc1061LPPAuhkTC/V0Y6VWISteCu5CUkFaj3
	 Kzr6mUqRguyJ09YCU1VXhRDeuqd2V5GiOwC7eyqY1NoRJ9yiVXu+ljlOg9rK/8P8ULmd7
	 ueOn8JBJIJ+4Yu4RCL9mnMeI+1jZBAnvNtbv6BFkGW0RUSJuNaUZQyd2ywhTUgKZejcZB
	 7w75FH2ZlUDPZih9NijjX8RDpA5l/hfGUMvKfOwvH9ekddVioJxN51rcnrtrAEanIkkof
	 lYrwgprquMVKyoOAsNBzAwGeHDfAIqI6DSpFV1OlNDNMzA4GJ/VapGZs+kA/UK0xflQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zzKQFokzJBOFZqaAPShO8YURV3hDxFlJ7m9hEAnzTsU=;
	b=GC9cX+WiZw17zeAgxS9FWBBV5UTbFk0p2G+1Kbl67p+OntjRKXo+OvlAfnknFXQEJiLq
	 Fdz2wtxBHnmyOBKjBn3KnYXwiDjYy46jTpXZp5P6K0fpRchY1jvn8on83k5EhENKNS6KX
	 +IeyOKTIKWdPPYSG2T3NkikvocWtuPlOvJFdhh+rOb12sJBkr9tTJPtE2D4bnLOI1A9OU
	 9jDM99MbXPFc9qM8sI0mhQMvg+/yoj8ZxaNdbiuNl0a2q7XESuCXKXOu/VNzkXptnu2z0
	 OqeGzZDpr3wBHq9nm4bMlBAqb/b7QEvNr1a0EY8Wi+sLbYbKze2TDVO6uCw0qu8cZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+Ztc6Tl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+Ztc6Tl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434C1F0093C;
	Tue, 10 Nov 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351367;
	bh=zzKQFokzJBOFZqaAPShO8YURV3hDxFlJ7m9hEAnzTsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+Ztc6Tl0m4HEhl6xKyZcHa5ZlVLTPF9p6ODoTpKy7W5+NcO7fyiL5uDPvC+VM0Xt
	 x6vpCC7Z3NH9p7RUmeFzgqBXbwPTOk1C9bRiGfWZawzHbB5R3BbwxKmF9ekm1dqoZs
	 NoAHWvE8cRop+AsvFhAFt/4ttim+VDDvGOcPwc7K4zB5e9Poexde2MRJGqTqQyzer6
	 bGk1HUp2yWGH7KuKMZVwehn90V/OmqYrAtNMAnZ8z9Jzqd+WvMd9LRu1tuWvlZSfwo
	 fuDuU0AEa19ZhMAM0LuC3w7r540hdkWaSG4XpyOPqSKolE9pWUl7g3zgS84AmP3io1
	 9EzxVoQqok9Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fuse: don't launder folios of a bad inode
Date: Tue, 10 Nov 2026 17:56:05 -0500
Message-ID: <20261110225533.4163752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053605-failed-6.6-01d0f3d294af@kernel.org>
References: <20261107053605-failed-6.6-01d0f3d294af@kernel.org>
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
[ sashal: replaced wpc.inode with folio->mapping->host in the bad-inode check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index aa8c93b38601c..791824a4273a0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2476,6 +2476,10 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
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

