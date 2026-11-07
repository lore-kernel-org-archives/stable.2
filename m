Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047767;
	b=ELM1STzXLa3sXbvAQ7QrQPP9BtB5X70YeKwkpyoSaIGWqh/r+kMxLjGUFcs8RSGxOEr/
	 2tV3oNq0DY6/jZe8Dpu8wLvS/YZeJ5WPTf6y3dcjJyPoX9RNSEgwF/dDtINFe64yAA7fg
	 /T/j9VYhaneUeWE2adEYgHRSteKIsnVrjNlCmo3RiI/u3wmiBA4dRH7KA8zSDa6F+L/Nh
	 np6PC4F4QaYGO2IQQZ5W2oi26FkF04aNlmwLmHERTkb7WsP7DlqKs4mmA71MDjIPMm/Lp
	 7TJ/hHeD3ihjm+Jg46tIys0urZHrx0RtBna2+Xw8WBXJKLYO2zVAJPpVIDh4NvDdFCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yqIc5z3GcwyPeyqxL3F2XhUnZT7aIz7wFZb8gQ7bdfI=;
	b=nV55I8LahWUbUx7zBPve6qvyMLSKOo155ElbdzPr92hv4lKrZRqYOQappVPyYLCqex/1
	 /qZUUqf0Gd2KNLFGJSztHCMbEKQRh38n5lDDAznYUrGktUnWCpN7miViHC80kxtKVEEzD
	 vZOXX0Ao1Z3WDTmorU8aptUoGu9tWeaqW18NwnBSZ3o8Y+OVcJP7Gl0Xm7/z1Ql+2rwAL
	 kbHF99ZDKHE+80QYsssR9u2qWV+lrYRgOgihTSVs1MlKcQmf3XfaFFHnRSVJzOwAtWBdu
	 Duu3WXaw6gVSJUPpn8jIuAvJMeUpoY2Kw9N9C87dTaCwa9OljOQFtywlkhc0YDOXnrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kevxtDZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED42606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kevxtDZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5911F0089F;
	Sat,  7 Nov 2026 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047767;
	bh=yqIc5z3GcwyPeyqxL3F2XhUnZT7aIz7wFZb8gQ7bdfI=;
	h=From:To:Cc:Subject:Date;
	b=kevxtDZTPL6kMND4Z2TXo+0u1a+k56UQg3TjycrrXcArKoVaM3F1z2QrNNtwfcA8k
	 3OKQTEq+JwL0c5e1sZTw8X8bTLs+rRraTzg8Ea/t5Bg3ltGNro+xiHhxDGGu23VbbS
	 ni3/A9hmJFRP7ktTxMbOqd2XAWL3hzYDqNm4O0ybVQ79nchfwjtlGB1l2+4JqtVBI/
	 7BE7tfVVnS7imF8BIX/TvDTC92D1U6IgnR/LzFoPUeX3947+fTWuvx+VDfd4bMeMqh
	 J9rp+OdmrW4T8gMMWvc0Cyl426OF+sQ9s4FoVDChFJaywQdtlMhuPxJtaBg2/wBSqT
	 l+nhaEnvj01dA==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	hbirthelmer@ddn.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't launder folios of a bad inode" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:05 -0500
Message-ID: <20261107053605-failed-6.6-01d0f3d294af@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 01d0f3d294af126f517d92c11e100525537f8be4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053605-failed-6.6-01d0f3d294af@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 01d0f3d294af126f517d92c11e100525537f8be4 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Oct 2026 03:51:36 -0700
Subject: [PATCH] fuse: don't launder folios of a bad inode

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
---
 fs/fuse/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6d707f2b3bff8..0ef46f6e0267f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2351,6 +2351,9 @@ static int fuse_launder_folio(struct folio *folio)
 		.wb_ctx	= &data,
 	};
 
+	if (fuse_is_bad(wpc.inode))
+		return -EIO;
+
 	if (folio_clear_dirty_for_io(folio)) {
 		err = iomap_writeback_folio(&wpc, folio);
 		err = fuse_iomap_writeback_submit(&wpc, err);
-- 
2.53.0




