Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048634;
	b=g1Ue70ebwW7CQv2AKSVxeroSqmPtXSV72GFNcw76gDyL2whxHoc8497Cm1YrSso3rtXT
	 Q9TboxZIACVboZojwbE3wT8yhecW8pNBFcnf6FGLPNYYQa6aWPzOyix2l7cP9Np3gPSPO
	 2zDNqoG3nlEvQnQNfUnVioXarC+M5RZPjzxjtRPFWF2aYp5dA/rq57lxjaK/erAd/LoxO
	 +FVWTC+7qgFs9W39+JKxMcL7kNJaPMziinIBFsCqq7idK8iZBc0aW8398h230XTy7ZArR
	 jdT5TTbYbH2Gq4lz3Gb9H0uVxUkp63OlMyubuB8rUGqmsMYjA96Ig9fVqa9vocelBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IQgna8G9HWMCXEV3FEry/Lp6POFsz2a3LyekWwlUAO4=;
	b=Wa1dT2jBWazZm0C8sOJdVyJVJ597mUDAy34NQm5kA2FQq27nGLHGfCF82X2xPdsfJjBd
	 oIbGpl5AWDJ6mMhEg19tbr6e4UyaDVhepgUh+GURBOGnGPe5LcWzAjN5+689zwgbjhcYS
	 rpgs0zssLRI1CClQeRgMaVps/rEaRWiOtJlwf0Sd+5m/4kcsfa3XRAz6ARhJbDiMHZVig
	 AZHV/810bjyksg6BYBS3qLYzv6P7Hi0a4aUG7K7lWgCQRRbG4Z4J9bvDeyEyUybSsmO5P
	 07WWBFy8M5CLq4JAKGoHswoVnyV5OcC+9P5Q++VOs7bPVbpB1XuT3FrHqw+CoITNhew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwGfoHch;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580F606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwGfoHch
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85721F0089F;
	Sat,  7 Nov 2026 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048633;
	bh=IQgna8G9HWMCXEV3FEry/Lp6POFsz2a3LyekWwlUAO4=;
	h=From:To:Cc:Subject:Date;
	b=LwGfoHch4fbty2yapW4m2kRpu/cbO1PiYvtztKK3MEUrbe1OPU94gk9eJmCCyM/Va
	 eAqWSXQGKcbNgDGYBvJUHvMv/L1Jyce2wuxbeCwLQ2T131pk444sNE8EZRdl4ixCKM
	 aHEL0BPm+znRP7D3AGAfGaW9qB8eqhEBCfw4a+Un1N0D8XczrVgcEFY2rVbtN0UUgk
	 Fw/23DjrZ4J9ePcvsx+x6zuhoXTQ8oHzP/xAUlLUJT/X3v6j75atf8fWbWk4PILfjP
	 wZWsFQSnXYIzHaxO/PO4+A9ShPGBP/YbGg7Cjn8YIMcvAeVftfJcfPo5ty63VMz+0L
	 M/MpCAhSjQ1Cw==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com,
	hbirthelmer@ddn.com,
	mszeredi@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fuse: don't launder folios of a bad inode" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:31 -0500
Message-ID: <20261107055031-failed-6.1-01d0f3d294af@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 01d0f3d294af126f517d92c11e100525537f8be4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055031-failed-6.1-01d0f3d294af@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




