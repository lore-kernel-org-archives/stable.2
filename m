Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049666;
	b=h8vWyCnx0S6+wydboA9aekXyIM3vDv6CQl/8NjiX+vo0z3cJuSglcrvqIA8fJWhjo+db
	 Q3QhdDkWX/BJ/3ynAQV9h5VIdJjWuyGMOFM6avJKFY248Uge4GHdvHzdKBAKjtY7ThmPY
	 ceGMeW/rqSEnbqhRfwz7OUwOknE64hrciO2e4/aw8OJVRfVUaUNXLeadwesKL0gAm2+Wr
	 uWYMkpDeubno7mb65hpLzKwapuVj0gohBeoizblU7yF/X7arn1SzzGNbJH9oGG0uoLRuO
	 2gJjF2m7k+BTsfOEQveLA4MQtG8E3NFQ+ESLTWevPyOed9TDB18HV5uYXFzqbmFLFXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O6xMFRy4rK8FdZdwavQ6ygbja6wsVwlvwmhd5A8F3Zk=;
	b=VMszY+v+cDaLQlXD+P/O2e7Cx9zu9V5CJHnc6F7/Z4WtUZTjmo9pklrL+9W2nKXnP3xS
	 Zvx/9GqbYfHkTHLWYIQFAL0/5GgZvIgh3uhyasNVPmj0xiO9wRYW5CWywr9+3bc8NWRzK
	 6jZIauTP7nU4SLsa0w+9TCoTY54V4B9SdsEcmNvK0iHJTvn3K0q2+LNwz8KFNliEW6KQg
	 ZSHnsNJHLZKfnK5JvkLQWwob9qzz2Ymaf2szhyOJOuAN+FzKD6T/Mft16XU9oFmngJUnh
	 uFBXU5Y7FC6/KUWN/pJVK1TFIpz1ZPUhnaPjGLn4YQGW8xCmULK0c6EU+Vvo79nP8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZtMNJQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZtMNJQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCE1F0089F;
	Sat,  7 Nov 2026 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049666;
	bh=O6xMFRy4rK8FdZdwavQ6ygbja6wsVwlvwmhd5A8F3Zk=;
	h=From:To:Cc:Subject:Date;
	b=LZtMNJQXOH2MLcUA5368WX/POSCNgXp3BKL4djlPY+AgeXtC5pQEX85MBia1HMlHo
	 PgANVCFsxVFVS+iYUAw39ptygsbLkmVJ36bkW867VwYvEozN8tv394/Ewf31ayGmb3
	 oPZUlxc5dHYEMAfmfpabLEkGwELrWgz1kIelydCoPO8Xx6d2uEKVK84SVQQ5QiMo9i
	 RUATDkBnEhZDt6q6ogQ/9jY784B7WDtw6gwfF2G6eABDIuplkIAqqn64FZ3Dgro8cY
	 jkxC58VN7b7QtzGGrnLHo+BIAwm1lSDQViOEV5Hq05env18cgt4jARUcM4ul2cZe4x
	 qgDlSZlh/Y91Q==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	hbirthelmer@ddn.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't launder folios of a bad inode" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:44 -0500
Message-ID: <20261107060744-failed-5.15-01d0f3d294af@kernel.org>
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
git cherry-pick -x 01d0f3d294af126f517d92c11e100525537f8be4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060744-failed-5.15-01d0f3d294af@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




