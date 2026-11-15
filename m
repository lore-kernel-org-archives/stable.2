Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702397;
	b=uOgUeQJmsMicFBQgpOMRobiqsKwIaV8nfQwa3927YbjHFSHdQZJR4xybMYKGt9RsVjq6
	 k/sOybT7tcf7hlUmplO+C9OVGQBTcqlQkvALSh0PaG5zSZ5TzNvC3ikuqHPa6xVSFRWN0
	 zn+q/RcBHIlQld4SR0cVZ3hrfAIAWrDWsJF2GmjriUyxIw8+dEDMBVFzBWENrTwB5v0hc
	 nk+cK4u1KQDL6eJOtmm/bVw4P/AQWbbTM8+aa0R3MhRoVjoQt90DB8578uYFw3XXERx1V
	 1QRyqNkqj457mx4N68AbNSMQX+qCFWgIhTgZ3skofE8FU57jn9YC05zA5I3RvE1YN8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZeLcqBTIlcZabA/3h/tUph9a+5OlhxUdFEGGKNGpziQ=;
	b=RknO1RqqGS4bVcuwozXsyJ0t11cXVLIPKeK81Iwc+aCQa8UITjq++MZFqGsifdJ08fCn
	 LV5ofFm02Z1bkDUcYrQ/+rjqbo2yP4fIJL9OqLh3AUEPrxCoeDUHQ/DrMu9B7uUqjucxz
	 /s3oGHB9wxtR6EnBz2AdVaE8mK/U//o5HRq3px+r3y/0apPKJGU+gUYmL5d0Of6VaI/0G
	 W+Ax4cO9PBknkfwux8u9pE3alYv8kd7yZ58cK7ZXjXf7ys/8LQc7U7IADpFcdB0P2xMj2
	 KvhL98cRppODUceyNfMMk4FtpXokreGkfY/S0R5no3JsyEhHcnyLgaKKkhenOzFc3+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5tEH5dR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1F606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5tEH5dR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FE41F000C4;
	Sun, 15 Nov 2026 00:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702396;
	bh=ZeLcqBTIlcZabA/3h/tUph9a+5OlhxUdFEGGKNGpziQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5tEH5dRlrP8KkJqBPQcCQYPiGfR6gWG2+JSein5sjCc2STg3r0wSU/AHUmySHGhu
	 XvznqpTMrpqBCH+JnM6qL25+B4fkVJiuhLfA2zbODfk19Bg/JashRB5eQNS1An0NXz
	 42aw+IwALYHTX9V4uftayh1Bxy6zNzcJA1EGX8TPlQVufx5gcy27bwWVmZvxCD/b3N
	 nTVRk4Fz/7KU76MrGhP9u3XqWjRo9+t/W6//Y4jVfZbqzSIAlZGcH4SX0mpgyVizbc
	 cUrZEbc2hPhTYcZ4Yp8WS+/rceMVZ2+097ex4ltBVxiZINCg7t10jLc6lw1sGUVOoq
	 MRgymMF2Ew5jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Chuck Lever <cel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: mark the inode preallocated for pNFS write layouts past EOF
Date: Sat, 14 Nov 2026 19:26:34 -0500
Message-ID: <20261115002607.550063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202252-failed-5.15-8b8e26599155@kernel.org>
References: <20261109202252-failed-5.15-8b8e26599155@kernel.org>
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
[ sashal: replaced xfs_fs_map_update_inode() with xfs_update_prealloc_flags(ip, XFS_PREALLOC_SET) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_pnfs.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 0bf547d730990..a8db739dd4166 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -91,6 +91,7 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
+	bool			update_inode = false;
 
 	if (xfs_is_shutdown(mp))
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
+		if (!error && write && !(ip->i_diflags & XFS_DIFLAG_PREALLOC) &&
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

