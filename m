Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351734;
	b=YgtF1M6/cQEGoS/rpXRsKk2xbKryjcTn+LcJEaQZQA4w4WgrELLVMEczK2QpUAQ5wL0M
	 cKQtzlqhVrasBWsvr4uj+9cDUg5CoQ88hyqWZhxAaZ9S6Q+ucLxyMDIgFcDGWOIurN5Vn
	 pAFTL+JU6+Nxc32h4fsRbRLlf5ehvX0wGdyfYP0Atkbt3qaCZ4B5gIAmBqkpv7/B9tq5I
	 CzF6r7wkjO57VCels5dx5nlClox0Zzb0XXYwbMPPPtDOHHpBI/pVsHNKgKrA3Mx8kfujv
	 l+0hCbI5QpNhj9KSskv0kcfL13W7Nf+M96W8sZIXvn/ELzFu81BmAJLCsJlVmuWT2aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351734;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5fOSIvthq/RCXyFDLzVDFVVqiArlVzvTEHqI19l1pRc=;
	b=tHlkKA9E6iRbC9gHS2poNsUEGSkWoNbHQob8MpR7SKVhEebWjr29NvWW4Zsp45rip4wJ
	 g31B3CmbcCvqqmX/osuysZ63nvxjnvo73hpGuzXpuNK6gEQxiu6Szcl3FZIJOeJM9GBze
	 +CZ5LDyaeLHLz0M2TRWn+VmGJYklGjpKYgzqn7JaEyyx/IsnsUmvsgHXV+HdRFjvaBjH1
	 gQgbbzV5t4V8FpriBWrHTZatMFqFl3biVSPBXZCCCbknqd5NyOrkrdr6bM/+UjLU0WuBT
	 b6mbanZ2oE8f8lKdNeoCcVDt81HaYRbHhdMEMYpMSMx4rlB1wJNhFyqBarm6I/+W89w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHAZj6Le;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D244606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHAZj6Le
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC3B1F0093C;
	Tue, 10 Nov 2026 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351734;
	bh=5fOSIvthq/RCXyFDLzVDFVVqiArlVzvTEHqI19l1pRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHAZj6LerevsGsmvV+nHiwxzpKmxG2ib0fhoO0lXyhzSiTD5UQ1zQ1C4xgCIymera
	 6aVP1T9eGeUA54AHwcFF0z0KT7gF//6IIIjJcUdBRVkntuntKHNCu3/hLMjB2ALiV8
	 cHCdAUEIba6NppTLaQAEXat8zPlvrKL6Yp7kS/XQqj4rNcCN9l4H2Xj7Dbri8lhlXe
	 YKN5cTRdqWa4DQptk5bv2Y5BKPvgJXObsgtAdYFKaZcvOicETkG4jwQDOhbJpMBdmr
	 aLVt8uIveojymipr5X/s9W0F6MefXVjsjouqdmoSoeLAAnkEe0dPki24KnmDUp/KwE
	 uEoeNklD+xX/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fuse: don't launder folios of a bad inode
Date: Tue, 10 Nov 2026 18:02:12 -0500
Message-ID: <20261110225940.48340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055031-failed-6.1-01d0f3d294af@kernel.org>
References: <20261107055031-failed-6.1-01d0f3d294af@kernel.org>
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
[ sashal: adapted the bad-inode check to use folio->mapping->host instead of wpc.inode ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 56774b31d5ff6..b1b82e6a72b1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2438,6 +2438,10 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
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

