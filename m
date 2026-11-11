Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361062;
	b=khbMWR9MPcWFMFp6LverDfqJCDkhOgD3a83UtqXPDfq8b5wxojjwZkig2kH45yp6aXNT
	 2Rs0md7tSLClcbOPm1oxESnb5DszuWcYWWqda8yavvDBMsCoXqZDdTH2TlikPCj1ZcCUe
	 xTZkaVO7OagfoDEUe4zdkNQbijNjLj9VkO66nH5HwYb++Hz/eI/4yM08/q0pb9jn/KvEd
	 k9LAAbJNiTeVjOIuXL3dj2Tp3TZPxoyeUCHgghcLezh+a1OJiKnZFGbNkIo7oZgjNqo/R
	 91y6cshClj6bDdgzQKIb1B1GvGwG2PtKbulQLzWXRA8exBK/lvu9Q+rR3ul8ma1QXYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=30XSSS2lPMy9mINEYK3RCpbcok4KBDV6OBtfUdDAgnQ=;
	b=od4XX51NL3xB0SVPSHg6vF+QS6YObqick1vjQi2qop4YGceXJOx/K4UQKELF9wRfriZZ
	 oTTjYk5sZKwjB1YhaXRwfjosfx8lG7OWbFIkneZ6M87cg0EdABF7a3nZVMS0ZaFvJ5pLw
	 a83R2+LYGdVXyHdBcxHoSjJa8ohihXofN534wohJUalXJwfGfBdqMsXk1Ahu6svkHzjei
	 N1+DGRqxQpHSSnmZ0ZwmXHWxQ9aGxQbIFJLQ1jRPozuMM0Z7KAKyesRT2j78ChM92RzON
	 4nywHgQxBF9Zue/Ab0Bm/Sxdr2olFjU6VAsxsDdldXgWfrG0PRN+IU2YcHMstjqA8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9ee9Lpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9ee9Lpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D535F1F0093C;
	Wed, 11 Nov 2026 01:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361061;
	bh=30XSSS2lPMy9mINEYK3RCpbcok4KBDV6OBtfUdDAgnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9ee9LpwHII/8v/VOH8SmYfd7e/c8aiX2UtABIC+uATEdegYhFCcNNb2+XI52xVC9
	 rFYHQfUZhSotiXsvuvxs4U6RrHsLal4bLV1J558HUxb9SxDzhQooGB10ktqtvhoYOs
	 +6ijF8JJWnzpeIDbU6o7cQSKfsLPpN/mjgL/d91yDfBzQIBZvXZl7IISl/rqmyqvK0
	 7P0utxbTu1JEqOl/uDteLVyym8hgGSqmtP+ZGKe/PWD/wwruFhT+cQd0CdxwVQgCk5
	 JPCvcgDDqdJMflj/lGnMZbmFTrIC4bfGiyi8SleHUbTSV4i5R8B4ASkiJn3ZJRr4rw
	 BOYfI1MvnHK1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fuse: don't launder folios of a bad inode
Date: Tue, 10 Nov 2026 20:37:39 -0500
Message-ID: <20261111013618.72434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060744-failed-5.15-01d0f3d294af@kernel.org>
References: <20261107060744-failed-5.15-01d0f3d294af@kernel.org>
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
[ sashal: Adapted the guard from fuse_launder_folio() to fuse_launder_page() using page->mapping->host instead of wpc.inode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b6b06f760162c..b777ec4ec8414 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2383,6 +2383,10 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 static int fuse_launder_page(struct page *page)
 {
 	int err = 0;
+
+	if (fuse_is_bad(page->mapping->host))
+		return -EIO;
+
 	if (clear_page_dirty_for_io(page)) {
 		struct inode *inode = page->mapping->host;
 
-- 
2.53.0

