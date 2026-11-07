Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050678;
	b=bKOhQ9tMtCNy9Mdmv3JPet402btMrPC9Iw9jHhMASIBRaxgurTLj6aH4VgRkkus6x9WL
	 mTD+9DxXp3ttR1PThkFLpvRFXpf9rP2aj9ClapTOxEHN8eIvhF0ibUhj0T33fPKP54ITv
	 ZzAKLGSFvY1vpIKYm4kw1kTdq/yOFMrLpQjmRd4YI5AE2jBUU8lyGjZmy0BnbJRnrrTl4
	 NqAjFLnEfuKykWGH4oJBrVoJBZ/CMneCR0/8+DY9G4k5BOAEB0GE4MILH7yH96Sp5FfnS
	 coLqAMPDvSWQhux3z2o/YFPOTVL8B3ZUFehns92BRatKDzIOngRwb8QWGO2BGomz21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pfUU4U3wd0ZLRUYsaUHMQuZNQwvIyJ8JO4kPF+dVkic=;
	b=cgv841bNTXz/JaMNrF9az6DstfsWacT0/XYAt/+8oD+7VtwQfByHKts20OKLEpcnftSX
	 Adc/vL1Jg8cNvtlD2daejspXzigx/h75B14fNbEZKmOJPGPypAB+EtW9PyV4ohF/5v7qP
	 7YdNteP8qqo8cY0MFQpSqdyDYDcrLFR9RWaPicJPHgwB47INDanRKmybXUpqm/arM6Qbl
	 +YsyKK4cpx9frtli1nIwFob3Qy1aV/Fo7LF5blATbKjVGIs3bSXkY6eS3JfSwrIf7msk3
	 Cx50ZrNcPPz7RxdFHiCW6iU994hvVBaAvmq5Eu9oOQqrT0HUqDu+bLXLbL33qtmtz9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVV4uR4v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139F606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVV4uR4v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3051F0089F;
	Sat,  7 Nov 2026 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050678;
	bh=pfUU4U3wd0ZLRUYsaUHMQuZNQwvIyJ8JO4kPF+dVkic=;
	h=From:To:Cc:Subject:Date;
	b=KVV4uR4vc2An6hAxXnlnj0CEE2eRBCAS+tlTa+XYsWNOT+ydZL2ukbuT/8iZXc8+A
	 oG4vyvRybOH0dCPgnFaglsrbtD+em/dKrVl3+Ao6gyrChuda8ulgKC/fc0UztIPaoH
	 CAASEHu5kqXZyMtGVkSSXH0TZ/UDvwODt7OFxZzWgisfaSQCdH9fcK7x+qpbDyOLiB
	 QFXpgXFGjOY4nIhl+7aHMRFp4OoBV6xWQa5cfWVvyiRCsrOMmThY3g8AsMiZhDCnIw
	 Q/EneRTFv9sZtPvclxHwIc/8kD7xrTC7UOBv4Ac8m0nmJf1D5lzFVgUN4Apzj4ipQ9
	 NVoUNhrOkik7w==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	hbirthelmer@ddn.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't launder folios of a bad inode" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:36 -0500
Message-ID: <20261107062436-failed-5.10-01d0f3d294af@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 01d0f3d294af126f517d92c11e100525537f8be4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062436-failed-5.10-01d0f3d294af@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




