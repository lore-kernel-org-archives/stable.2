Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050035;
	b=ycBKFkfDwDkKX6ChWoP9C7hCl82wWnLblr/rulD9fcqe3xTgg4ygEZE0j8uXjq6+HY91
	 m9yGXub3PcMYNgy6dhWYIH5sYgZl6JRczSkMEuYqyKpsNiN0VlaOUaUkWYd/4mtivpH3H
	 Vf8SPcHZ5pOZO6AZtfetiu/0yMEXxALboidX2Ipa3GS0zXFCo1U2wVfG33lZafj1/Qujs
	 HRL+XHIpfqEHAESoSbJhX5NiLJ2NGYdGVqqsidM9mIIeNhWbWG01uhMM1IrAWdLrnwDQ4
	 GCeGf0fEyq8QrnGrPXh7vlAuOMbU0pbLACkRvchjR4ThV3u2Ym0dah1EJ6wrt2bKA/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=exi3tm8qQHtkgZoxaYBLxEgTFqlN3N6+GSeLURQXB9I=;
	b=4hthUdfzgPLvvf8NVozsl5u1fCPtYhoNqsQkw8EiK98YSAALs8OFnNDVDdHRppzEC3He
	 cds1ZK82MdQDNOy94DUAmrm8Fgnu6PFIUG/pcpuz2s/1XJauG+/uJG9KUdLgnYDoi6u54
	 u3SoV7V1TiY3tgIgiRr18VttG5zrQ0tlP2Zf4UI/lDIAP3mVT9eksSObwhDwH7DIdA5Gu
	 N+w91gRuBrLvP/6NugJ5CbBqDWSpJvfAeNLh7rz5DUsMv1bmKpHWmEJsWdIg9siWPzWWS
	 LvC/QhtVnKiKU0ZQ9w/7c8BE1ZXf3yfNJo8vIRZIHe28FGvc66z5JLGoV/o4mj7BtaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lqnsoq/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lqnsoq/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55D11F0089F;
	Sat,  7 Nov 2026 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050035;
	bh=exi3tm8qQHtkgZoxaYBLxEgTFqlN3N6+GSeLURQXB9I=;
	h=From:To:Cc:Subject:Date;
	b=Lqnsoq/9rsyGUUBEnI/0QQsx33dDzSxLtpeaKuFL0LNMByY1wP0DmLSQytN8R/2LD
	 ADxJPhkNKlGFx1tJ0kHbgcwe+nmBoGkm0Bvm+45vqVqJCtp4CJUlGPfduQF4J01Ks3
	 H421SWt8CsCFeosHVyorlBCL03ne+HPzNjuUYoy9MjSHy1pnwBzyCMUGPJF/Zucwj9
	 jOleB2mllzByyjMIo5JP66SWLgNc9mtFajRDzKKAD7aheO0e24KMI+BZ7E8Y0znxdb
	 dcU96SMWx5Ti8F9PjMEgDmYdqcdyU0UMNjVnVeYT9DF7oeQS38irLSmnzjyHKc/dhS
	 mbRJig1gJXFJw==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] aio: fix NULL deref when a fault races ring truncation" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:53 -0500
Message-ID: <20261107061353-failed-5.15-d53b5aa5cfae@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d53b5aa5cfae27e4d236fc0ab9581085d27f7d33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061353-failed-5.15-d53b5aa5cfae@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d53b5aa5cfae27e4d236fc0ab9581085d27f7d33 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Thu, 29 Oct 2026 15:00:20 +0100
Subject: [PATCH] aio: fix NULL deref when a fault races ring truncation

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
---
 fs/aio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 4f32b45cb8a0e..893db6961ad3b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -528,7 +528,18 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 #define aio_migrate_folio NULL
 #endif
 
+/*
+ * filemap_fault() reads a folio that it did not find in the page cache. All
+ * folios of a live ring are there, so the ring was truncated under the fault.
+ */
+static int aio_read_folio(struct file *file, struct folio *folio)
+{
+	folio_unlock(folio);
+	return -EIO;
+}
+
 static const struct address_space_operations aio_ctx_aops = {
+	.read_folio	= aio_read_folio,
 	.dirty_folio	= noop_dirty_folio,
 	.migrate_folio	= aio_migrate_folio,
 };
-- 
2.53.0




