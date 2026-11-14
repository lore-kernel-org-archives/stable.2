Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629591;
	b=nLYNca4tkSWoHOg/zArB8wjymnsxmpoTopx1cssCNCLRXfaaAF5FBdZzdcbeuBTtczMI
	 kErhEkHol+tl2N/idGp+yAbxdUAutUg9TEZfKz8QUJt7vshneeKPB3a4aY6fWToQWV4ov
	 /bRf9w0OQSOf6dHhTuoOjHmCMAhrBcQsauZjQRj+pI0F2ZYTZA1AEzrPfL0q3IBGJB/XA
	 FxuQttGqHBCIa4rZeq09BKGaPENJR/anok0X3Ai9hh9zx520DKxFbP0Xc8lgCR0/AL0sZ
	 6bab14Z9WtGzh2bJhr4SMdvHdmunOUeHGyoTltDDg2wymBmQGXmAUlu/zTHOow7W/Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lqe7hbJV5E53Olt8WaKe0FQPMqYPl3D+GVBmRmPiFc4=;
	b=IHalUtCL8XI78949/h1NLWk+V+mHroqpubLV185UI6Kd9EKVDTkEYPXCYIZ+2J4I3Jfk
	 VepTWg/LBXslXeXmcfEJNy78hoU3PF183kBSoS5ivRfsPvEhvswrxALurmvAQ5TAuXsiJ
	 MZNjj2F0I8INPStjghSgP1Yy1eRZuyHka3mvKiLvWY8AlLzFjqJWeNvQg3D1XdO/vZSpS
	 txMIdHsFAs1ZPrEz3eWA5ActnP9rGp+RMQ4xLRJAsLrVKN+0IpRz9jy49jTHBOvuL2P+9
	 4mLwTK+cMIUEmGAnZbwadVbEJ3zS+Xs4CqzzX0VfDnGqxYzRot6idWnt67H3Fz31Abg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuXz24Yq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF9606A332
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuXz24Yq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1868D1F000C4;
	Sat, 14 Nov 2026 04:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629590;
	bh=Lqe7hbJV5E53Olt8WaKe0FQPMqYPl3D+GVBmRmPiFc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuXz24Yq83E2q0yy1kIp09oOcYZh29AUHGI+DEzcCkVd8hJs8KJ33D53epxE/Sgbf
	 UvY56I047z4PSi6e4hMAZWuNVc1fEI6/LLTXQdWpf8p8JbqJTQWTJndiugThGmrp5j
	 cVwOFoT0tyfRV9A9+SLxSmtDRBVo057oX01BR1/XOHlij5wRIzMjqnKjBwvDrMcbbc
	 4PK1JXfvptGvKVlEbNJxbd9Gsre4jRiukfUUFsneQ/g7lEiUEjjIKK4WYndeMGOlc6
	 +NAXm7JggcTW6LZN15ZSLH4hCgsXrzDAsjnA8M8o26/HeWr+yMaopORS6mleG0xIjS
	 BiRbIk4AnUXiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] aio: fix NULL deref when a fault races ring truncation
Date: Fri, 13 Nov 2026 23:13:08 -0500
Message-ID: <20261114035330.2692105-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061353-failed-5.15-d53b5aa5cfae@kernel.org>
References: <20261107061353-failed-5.15-d53b5aa5cfae@kernel.org>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit d53b5aa5cfae27e4d236fc0ab9581085d27f7d33 ]

The aio ring lives in a file on the aio pseudo filesystem and the ring
VMA uses filemap_fault(). aio_ctx_aops doesn't have a ->read_folio
because aio_setup_ring() puts all folios of the ring into the page
cache. So a fault on the ring only works as long as it finds its folio
in the page cache. If it doesn't, filemap_fault() calls ->read_folio
without checking and we jump to NULL.

We already fixed this twice this year. A forked child could inherit the
ring mapping, fixed by commit c03ce4173c7b ("fs: aio: set
VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error"). And a
partial mremap() could leave part of the ring mapped, fixed by
commit 3adf7ae18bf4 ("fs: aio: reject partial mremap to avoid
Null-pointer-dereference error"). Both times a VMA outlived the ring and
the ring file was truncated under it.

There's a third way to get there. kill_ioctx() and the error path of
ioctx_alloc() unmap the ring with vm_munmap() and ignore the return
value. If vm_munmap() has to wait for mmap_lock and a fatal signal is
pending it returns -EINTR and the VMA stays. free_ioctx() then calls
put_aio_ring_file() which truncates the ring file to zero. A fault that
passed the i_size check in filemap_fault() before that doesn't find its
folio anymore, allocates a new one and calls ->read_folio:

    fault on the ring                 io_destroy() with SIGKILL pending
    =================                 =================================
                                      vm_munmap() returns -EINTR
    filemap_fault()
      i_size check passes
                                      free_ioctx()
                                        put_aio_ring_file()
                                          truncate_setsize(inode, 0)
      no folio, allocate a new one
      filemap_read_folio()
        ->read_folio == NULL

All that's needed is a second process that shares the mm. If a CLONE_VM
child calls io_destroy() and gets SIGKILLed while it waits for mmap_lock
the ring stays mapped for the threads of the parent. Any user can do
that.

Instead of plugging the routes one by one give the ring a ->read_folio
that unlocks the folio and returns -EIO. All folios of a live ring are
in the page cache so a fault can only end up there if the ring was
truncated. The fault now gets SIGBUS. Nothing else reads the ring file
and the aio filesystem uses noop_backing_dev_info so there's no
readahead either.

Making vm_munmap() unkillable in those two places would only close this
one route and bring back what commit ae7987835643 ("mm: make vm_munmap
killable") fixed.

Fixes: 36bc08cc0170 ("fs/aio: Add support to aio ring pages migration")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Link: https://patch.msgid.link/20261029-work-fs-ai-fixes-v1-1-88f22792f6f7@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Adapted the folio-based read callback to the page-based readpage API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 865c94fe4a0c8..86532d483a8ea 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -454,7 +454,18 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 }
 #endif
 
+/*
+ * filemap_fault() reads a page that it did not find in the page cache. All
+ * pages of a live ring are there, so the ring was truncated under the fault.
+ */
+static int aio_readpage(struct file *file, struct page *page)
+{
+	unlock_page(page);
+	return -EIO;
+}
+
 static const struct address_space_operations aio_ctx_aops = {
+	.readpage	= aio_readpage,
 	.set_page_dirty = __set_page_dirty_no_writeback,
 #if IS_ENABLED(CONFIG_MIGRATION)
 	.migratepage	= aio_migratepage,
-- 
2.53.0

