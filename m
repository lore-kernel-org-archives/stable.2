Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577581;
	b=d7oHwb4q+lWHibmaP6q7+Pm33ItAQvd10fB5BAJCLKnsQmqFMSoxvhJTFkounwAq+ZQP
	 uOCPul2Z7LlSxKiQKumtAIbppaVLu5Crj25o6YSzRsy+g2Hc6F0S1LzeeqP42jJ3trbJo
	 ktA7ZGTNr3WNIok0fBxzuO0feDg6O0oRpb835KXtls6hWUzTP7KJmIh1p4lxHjJie8T5X
	 Fj7XblHNwxti2f1RGyBGBaGFsyZt3+IIpnkY94hdaO02HUoM91w9CY39zYj+N82hFe1lk
	 B6JP3mo0Z8lGBovekKPBlYOi0Y3+m8O5QvYHSGVsGp4yvIZfhTSE+4sAN6/qZk6fEmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZX0yljAyQh2rKwlTnsq2vLY0t0iWxamR20oGH75Ns6I=;
	b=tdLk0S76dybBZ16AmCFOkLXaLzVnNyTWOhLPeiiyBneSnj84EqDNI7XBDUCm6MnH/Ney
	 khmb1rHDOhBGZN6kLwnb8C891FIUqwBAvsz3AYm/FFXvV8CTTnRJDhH7i5gh3I6KpUjcc
	 haDWo/ti/4qZpXB/5YdYUCskmrkpLdzT1SCUwbO1CNLbmy6GxS46jwoJx4Q6vS0x5myTG
	 MTGMkSQKenmd1MG5oYgWsDnSXYgDjJg0aRuK3roPNrI3fo1jcO3gllFSkwPZu14gt4dD+
	 Qd1rsy+N1hnLTT8tS9jpBVZdHbHdOfd8IzlSsOzWyIVDXnC4rNS8L/YQGNvac+H040g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="An34/eBO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1D606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=An34/eBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9CD1F000C4;
	Fri, 13 Nov 2026 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577581;
	bh=ZX0yljAyQh2rKwlTnsq2vLY0t0iWxamR20oGH75Ns6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=An34/eBOu0G4r3XP1AZOjgt8dvtW2dpFDb+XRbFlZhPg6uYJHhH10L7zUwlR5z8+S
	 rtROj3HzertIivBKANNTc1mE1OJiLkiAZgnQPVb2Tn0raxp9nRjpyiVj1TKiCAtPW7
	 ALJl9mekjK30pJs9giHGmSU2DapjTF5NLxlRS5Ts/1ZWuKJYmzTECCfUHurK9esPmU
	 zhlHNih6lVNtT0HPwMGVU98ciZT/cTvHLGQdMeb0HLe+Fb8rwdfLP29F5rwXmk+vwT
	 6+ybziCXxpPRpjbUVQuSqgzb52NZFg9dmUGvPsfpdSGZCBCoc/aJPvwyyMAHqqnzsQ
	 4ubT5WoYx7x6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xfs: refuse a pNFS LAYOUTCOMMIT of a range without blocks
Date: Fri, 13 Nov 2026 08:46:19 -0500
Message-ID: <20261113133448.1177701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200443-failed-6.18-bcf0b7f18ad1@kernel.org>
References: <20261109200443-failed-6.18-bcf0b7f18ad1@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit bcf0b7f18ad11e1d410e82ffef678705eff0a317 ]

A client can commit a hole in a LAYOUTCOMMIT, because nfsd does not
check the extents against its layouts. xfs_iomap_write_unwritten() then
allocates written blocks there. A large hole overruns the block
reservation and shuts XFS down. A small one exposes stale data.

Refuse such a range with -EIO, using XFS_BMAPI_CONVERT_ONLY.

Link: https://lore.kernel.org/r/20261014130834.GB15773@lst.de
Fixes: 527851124d10 ("xfs: implement pNFS export operations")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Moved the completion-call change to the existing address-space operations code because ioend handling had not been split into a separate file. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_aops.c  |  2 +-
 fs/xfs/xfs_file.c  |  2 +-
 fs/xfs/xfs_iomap.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iomap.h |  3 ++-
 fs/xfs/xfs_pnfs.c  |  9 ++++++++-
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4c9afca35fefa..03f432a7938c4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -156,7 +156,7 @@ xfs_end_ioend(
 	else if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
-		error = xfs_iomap_write_unwritten(ip, offset, size, false);
+		error = xfs_iomap_write_unwritten(ip, offset, size, false, 0);
 
 	if (!error &&
 	    !(ioend->io_flags & IOMAP_IOEND_DIRECT) &&
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90cd..e00b6c2b7af06 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -584,7 +584,7 @@ xfs_dio_write_end_io(
 	 * they are converted.
 	 */
 	if (flags & IOMAP_DIO_UNWRITTEN) {
-		error = xfs_iomap_write_unwritten(ip, offset, size, true);
+		error = xfs_iomap_write_unwritten(ip, offset, size, true, 0);
 		goto out;
 	}
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index c7dea4242e8bf..b235dac8f79dc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -619,7 +619,8 @@ xfs_iomap_write_unwritten(
 	xfs_inode_t	*ip,
 	xfs_off_t	offset,
 	xfs_off_t	count,
-	bool		update_isize)
+	bool		update_isize,
+	uint32_t	bmapi_flags)
 {
 	xfs_mount_t	*mp = ip->i_mount;
 	xfs_fileoff_t	offset_fsb;
@@ -681,8 +682,21 @@ xfs_iomap_write_unwritten(
 		 */
 		nimaps = 1;
 		error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
-					XFS_BMAPI_CONVERT, resblks, &imap,
-					&nimaps);
+					XFS_BMAPI_CONVERT | bmapi_flags,
+					resblks, &imap, &nimaps);
+		if (error == -ENOSR && (bmapi_flags & XFS_BMAPI_CONVERT_ONLY)) {
+			/*
+			 * Nothing was mapped: the rest of the range starts
+			 * with a hole or a delalloc extent. Nothing was
+			 * changed either, but xfs_iext_count_extend() may
+			 * have logged the inode, and cancelling a dirty
+			 * transaction shuts the filesystem down. Commit it,
+			 * as xfs_alloc_file_space() does on -ENOSR.
+			 */
+			error = xfs_trans_commit(tp);
+			xfs_iunlock(ip, XFS_ILOCK_EXCL);
+			return error ? error : -EIO;
+		}
 		if (error)
 			goto error_on_bmapi_transaction;
 
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index ebcce7d494468..7d9fc86fd5567 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -15,7 +15,8 @@ struct xfs_zone_alloc_ctx;
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
 		struct xfs_bmbt_irec *imap, u64 *sequence);
-int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
+int xfs_iomap_write_unwritten(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count, bool update_isize, uint32_t bmapi_flags);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 298fdc9e9f1c3..1409ef8ce2be9 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -324,7 +324,14 @@ xfs_fs_commit_blocks(
 					(end - 1) >> PAGE_SHIFT);
 		WARN_ON_ONCE(error);
 
-		error = xfs_iomap_write_unwritten(ip, start, length, false);
+		/*
+		 * A client may only write to blocks that a layout handed out,
+		 * and xfs_fs_map_blocks() allocates blocks for any hole in a
+		 * write layout, so refuse to allocate blocks for a hole or a
+		 * delalloc extent in the committed range.
+		 */
+		error = xfs_iomap_write_unwritten(ip, start, length, false,
+				XFS_BMAPI_CONVERT_ONLY);
 		if (error)
 			goto out_drop_iolock;
 	}
-- 
2.53.0

