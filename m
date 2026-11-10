Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273775;
	b=1ONsp3LOt4jHiOuu3eXTDMUP5PPZijzbzufXO5/UcNXL6dIo+VqhJwLELy6c/Lu6tVBB
	 5MhirNTIg9G93/rFw7oLvvFQp88t+VPTdwBXccDIJsD8JWzBYWPW/hzPpSeQsi/lnI8UX
	 rDXbIyeSX2Akc4vwsNCpK45Iluj+woLx45iNRJrhysbdcJ/KSn/QohLUDqgco4prjVjlb
	 IbhxR52V5029eoa4nIi4wovsmCVi7sMSrAI28g+WY1jFqYTpWMLslAmA7uAfaO4G5/mYt
	 dRN2adkGT0KlWIMeI4H5GsBO6Vl4iyQ9qfeSUI8LaFNrzy2OUodpMiqiy2mYirPeCIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273775;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KNj4henBFfwAlmVIW3yenuY7AIOl+/7fYrzVSYvcMq0=;
	b=zNFwbcsmGN4LXj+c9CulNLOOgd/uc8jBJWZ5vQw9rMP3ph28wjmj6QNBXAWv15Y7SIj3
	 Dd8HAemUsq/yH0jn7/6UkTGr5cIKIYYh5jDSQKvSDj5KmkuN4JvEcDurLDeW5cWhiVBt/
	 LZeh7sbKWOHQvKblmhAc064aEDkm+1vZB60AEk2PY248RKbeD+tpWTFNm3V9OY3oqZnLw
	 dMBqWCYQpko3AvrJZoU3Q7Iq+6yYxl1IYxtU7hPuBWt9AJ7Zlb4qA5n95KpBovWJgXXN6
	 0vFQNVzUPAtJHwoD5gsdUFwbtDkBTidN8+uU6idg+SJzYzaYEPpu3ZaneOC3+7Dkc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b5a/Lxp8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149E60A380E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5a/Lxp8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186D41F008A2;
	Tue, 10 Nov 2026 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273774;
	bh=KNj4henBFfwAlmVIW3yenuY7AIOl+/7fYrzVSYvcMq0=;
	h=From:To:Cc:Subject:Date;
	b=b5a/Lxp8tJJgY+aHP0xjZAPkmZXi5cHQHDJenroq+wVsF7yReoDef/T6h8ToYARku
	 XMbz4Zl5TAK6n7BVYBKMSUewk0AiGseM0+z0viRZ5s+/JSl6YyIPDoya70EynSs2PG
	 hlTFrAeDGu7G+POoz+X4JMeZm+mcORROUnx3/awT4ph69TrMdQhH3Njh36waqFJoW/
	 eJkviuY5j3YO1yUHQMZ1muHeVwBbp5tc16sejTPZHWiDgG6DNU7a15rUQ3YaIwfR4i
	 klXf7TEp1uzX85oN6EXEbsJKF1OpzGavfqQlqZoOibXqoQ0w2NGdpNwO5QTXyCrPYg
	 0VYLuiYQHVNrw==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	cel@kernel.org,
	hch@lst.de,
	p.raghav@samsung.com,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: mark the inode preallocated for pNFS write layouts past EOF" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:52 -0500
Message-ID: <20261109202252-failed-5.15-8b8e26599155@kernel.org>
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
git cherry-pick -x 8b8e265991556d99b6d721697f148975a7c68767
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202252-failed-5.15-8b8e26599155@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8b8e265991556d99b6d721697f148975a7c68767 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 11:22:58 +0900
Subject: [PATCH] xfs: mark the inode preallocated for pNFS write layouts past
 EOF

xfs_fs_map_blocks() marks the inode XFS_DIFLAG_PREALLOC only when it
allocates blocks for a write layout. A write layout past EOF can also
hand out allocated blocks, such as speculative preallocation. blockgc
then frees them under the layout, and another file may get them.

Mark the inode whenever a write mapping ends past EOF.

Fixes: 527851124d10 ("xfs: implement pNFS export operations")
Cc: stable@vger.kernel.org
Reported-by: Chuck Lever <cel@kernel.org>
Link: https://lore.kernel.org/r/4de5356f-bc4d-4f1a-9c81-fce09b1b46fd@slotpi15m67
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_pnfs.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index ab385617003a2..a9f0b472f3076 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -110,7 +110,15 @@ xfs_fs_map_update_inode(
 	ip->i_diflags |= XFS_DIFLAG_PREALLOC;
 
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-	return xfs_trans_commit(tp);
+	error = xfs_trans_commit(tp);
+	if (error)
+		return error;
+
+	/*
+	 * Force the log so that the blocks handed out to the client are
+	 * guaranteed to be present even after a server crash.
+	 */
+	return xfs_log_force_inode(ip);
 }
 
 /*
@@ -134,6 +142,7 @@ xfs_fs_map_blocks(
 	uint			lock_flags;
 	int			error = 0;
 	u64			seq;
+	bool			update_inode = false;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -221,20 +230,27 @@ xfs_fs_map_blocks(
 				end_fsb - offset_fsb, 0, &imap, &seq);
 		if (error)
 			goto out_unlock;
+		update_inode = true;
+	} else {
+		xfs_iunlock(ip, lock_flags);
 
 		/*
-		 * Ensure the next transaction is committed synchronously so
-		 * that the blocks allocated and handed out to the client are
-		 * guaranteed to be present even after a server crash.
+		 * Blocks past EOF that were allocated for buffered writes, such
+		 * as speculative preallocation, can be freed by
+		 * xfs_free_eofblocks() without breaking the layout unless the
+		 * inode is marked as preallocated. Mark it before handing them
+		 * out for writing, as for blocks allocated above.
 		 */
+		if (write && !(ip->i_diflags & XFS_DIFLAG_PREALLOC) &&
+		    imap.br_startoff + imap.br_blockcount >
+		    XFS_B_TO_FSB(mp, XFS_ISIZE(ip)))
+			update_inode = true;
+	}
+
+	if (update_inode) {
 		error = xfs_fs_map_update_inode(ip);
-		if (!error)
-			error = xfs_log_force_inode(ip);
 		if (error)
 			goto out_unlock;
-
-	} else {
-		xfs_iunlock(ip, lock_flags);
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-- 
2.53.0




