Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703047;
	b=hDHQcbicNeulSwAa/YwCOURec1m+2nSvPRYtSYip1AECdM/pCTKJCfcV3xaRSR4qgmCX
	 VZvenvGRePVLV18QuPdzjL6qPgqhv6qwe4pRWmtbbDzrJrTeA+RlT5d6rt1RXE3RIIYBO
	 XoLZOd57Tgk02Ge+XaRI/I7axkJfE2T9Lvsz4aErdAP5nZmQTtJyRkJQ62qPWBjMkxfSV
	 noomEYOdCdySGsm8CnK9Ii1d6quFNzxpOyAZ+gXcwls9O82sRkInH9/fpu8EJIhZ+lIL+
	 saA2ST4C3TeAO/OAa8yak4PRaufwkgCbMsXqYYPwkubSVGZMLkWnYr9yhkYRXBY6xzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XU+HB6VWKnT4l2qMGWJzHZAqDowhE8VPfkmuhPL/+tI=;
	b=PHF4dR5o4mgsBJZNAG+9JZcA9BlIenbKExPOzipZVE5T2/X41o0vZWEEocRBEjIrgXit
	 qsXdQk3n9ZWaUJ7h4ZyT4U/m68iKY2KQnQ/vsgiOmmsPOPC4p2Jwi5SDZ80f+Ia3wl58c
	 xcT6Yzcmw9uMIoZI4+24uzHz5nxUNLCc7XqAGNe14X3KStWkZAJ3cJ1I8dH/aJ3u0QZGy
	 qAdaeg8tpJdOzGbp/KTBGTcz5F7pkvTNnXv5FwulioIAEd9f1Pgd0kn/4XFiIjhHZjDgw
	 loDP2uBNsjUE7wO1h9/Dyn6SvB0GVWS6biH8V/kZIrWObc6YFcuvxH/u5jeti1axa9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQETRgwg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF5606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQETRgwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9F1F000C4;
	Sun, 15 Nov 2026 00:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703047;
	bh=XU+HB6VWKnT4l2qMGWJzHZAqDowhE8VPfkmuhPL/+tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQETRgwgvX1+gSOtH5EqEaSZJ0FArWrxLUQ5jWSQ7uuMryexBLNpX70N6njyBuAjm
	 zY4jS/SFRUCy1gAE8njgddZGd+witT8bHC1o/dfRJ33TiObrEaQOEc7AZlIXugSLl2
	 7aawJQokezCWhBe2mgC6eYJLqzaZclzvlI9Rwu4SCaNKhc2frcLIrCW5HXydoud3SO
	 rcxtHbRQ71kpk1Fryz1gdImKRHqxHAlPjnx3fc0AwtGvS4VcimsXkG9aNi/HwMYxxl
	 9tz0CQeyyMV4wagFPjAl6JLjgiZj9250sylEQxqtWprIqsHl3VQIBHTT8EEY7mAcXQ
	 Kr51EX4CQZ+UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Chuck Lever <cel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: mark the inode preallocated for pNFS write layouts past EOF
Date: Sat, 14 Nov 2026 19:37:24 -0500
Message-ID: <20261115003700.571334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202724-failed-5.10-8b8e26599155@kernel.org>
References: <20261109202724-failed-5.10-8b8e26599155@kernel.org>
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

[ Upstream commit 8b8e265991556d99b6d721697f148975a7c68767 ]

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
[ sashal: replaced xfs_fs_map_update_inode() with the existing xfs_update_prealloc_flags() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_pnfs.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index e02a6b84c609c..931080dc64d3c 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -91,6 +91,7 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
+	bool			update_inode = false;
 
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
@@ -157,7 +158,24 @@ xfs_fs_map_blocks(
 				end_fsb - offset_fsb, &imap);
 		if (error)
 			goto out_unlock;
+		update_inode = true;
+	} else {
+		xfs_iunlock(ip, lock_flags);
 
+		/*
+		 * Blocks past EOF that were allocated for buffered writes, such
+		 * as speculative preallocation, can be freed by
+		 * xfs_free_eofblocks() without breaking the layout unless the
+		 * inode is marked as preallocated. Mark it before handing them
+		 * out for writing, as for blocks allocated above.
+		 */
+		if (!error && write && !(ip->i_d.di_flags & XFS_DIFLAG_PREALLOC) &&
+		    imap.br_startoff + imap.br_blockcount >
+		    XFS_B_TO_FSB(mp, XFS_ISIZE(ip)))
+			update_inode = true;
+	}
+
+	if (update_inode) {
 		/*
 		 * Ensure the next transaction is committed synchronously so
 		 * that the blocks allocated and handed out to the client are
@@ -168,9 +186,6 @@ xfs_fs_map_blocks(
 			error = xfs_log_force_inode(ip);
 		if (error)
 			goto out_unlock;
-
-	} else {
-		xfs_iunlock(ip, lock_flags);
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-- 
2.53.0

