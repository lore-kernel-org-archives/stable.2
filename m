Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613224;
	b=Kuv4l6bHhrLUqesIxG34kgiYNWBdyjSbeR7eRxM5bOE2ze2mzzzYEPNcRztuah/E1ivQ
	 XgUBC/muMonyYtY3CFDkYMswgW87mawCqCIWbpiLl+U2Y+Tuct0TvnF5bgjhgAB0QVz0V
	 TktxmBcVGZUIQ9hFgvct/pmpOEZxaccUYpPpJxQpxl7ligfcKdFGU7mkayF61V0HAcRgs
	 g3FW/67NixWz0Nl631AxJeyQ7/K0LHHakeSxzRHdS8u6ThaxtC8R19mobF7sIRdEY2XSs
	 cQNAGUEnxTIirZSzdmM6hrvJQH6kzNAFMe6CTbI/cVyJJsVJ1QDZIZzNNduWED5xrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8NBVDhTV1qfvKnsU4Rq3rt4TPOz6d+la/snH88WC83k=;
	b=x+WjWjDBWd/Ty7OHuCqfd2TsnuH2jUM5VcDBgf2oJmJusebuvhxR+QJl9Qlx49Xpy7pw
	 4fCXepZMoN5f3Egi0GKMt8/ohMq32uFIgUDLXcJ+Nv1aIR68I9kZG3w70dfPVCnDQuj0e
	 R+jdKYhvhxxbVoWaPFlHsdI/DGZXIaw7J/cHDi0MfkQPzr0IV/J6VOAyKgnTHlHbWuKh9
	 qyHxbd8S3waW3LPmrCXTzqp8lp4MTOMKhD/r1RVKtH2GdJ+G9UJ4L5zO2qdh/t7bQ+LhI
	 fbUO2DE2TdGKRfubUILeYLF4Q6rD5Abovm662IUfqKc5QywBWsTyG9/Ahpy+Dj0Mh+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4PNnb7w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BC606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4PNnb7w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41581F000E0;
	Wed, 25 Nov 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613224;
	bh=8NBVDhTV1qfvKnsU4Rq3rt4TPOz6d+la/snH88WC83k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F4PNnb7w3hTEmaUBGGct3ccsHx0LkeCHcKmLWEK2SdQHB1ET/jFMBy/GZjez8jSKC
	 XKMRmZomG03QIHNAxHkRq+QfGKha2JJKKcjXdtFEhxEAG8uHtPFjkhiDTkooxbRTgL
	 YPs23pDXeQEzemGbEpF+ER8r5E8k1x1S80GL5uOK3QAasHJTDwqH8os6/0Q4YgBa1N
	 qY4ATGU1pOImr6IXZHCTIWv0ITUKsbKlYnkTIJ3O92M7Vh5G8b4YodvXNX3nt3Ut2n
	 XkrWnHnSGmefwiyHqPUHkOTeXX9t4NIOCfcg2TtDQLwml3Rsh4rYAQ9OPuXrf3WSFt
	 0lOHpQFFVyzng==
From: cem@kernel.org
To: cem@kernel.org
Cc: linux-xfs@vger.kernek.org,
	hch@lst.de,
	sandeen@sandeen.net,
	dgc@kernel.org,
	aalbersh@kernel.org,
	bfoster@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] xfs: force all shared extent swap to use rmap shared path
Date: Wed, 25 Nov 2026 14:26:29 +0100
Message-ID: <20261125132634.113144-3-cem@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125132634.113144-1-cem@kernel.org>
References: <20261125132634.113144-1-cem@kernel.org>
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

From: Carlos Maiolino <cem@kernel.org>

Currently when swapping inodes with shared extents in a rmap enabled FS,
we enforce the rmap updates to use the rmap_shared path only when the
target inode has shared extents, but we should also be using the
rmap_shared path for the case when only the source inode's extent is
shared.

Reported-by: Lauri Gates <lauri.gates@gmail.com>
Fixes: 1f08af52e7c9 ("xfs: implement swapext for rmap filesystems")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 73e7db3203c0..4704222d9544 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1302,17 +1302,6 @@ xfs_swap_extent_rmap(
 	xfs_filblks_t			ilen;
 	xfs_filblks_t			rlen;
 	int				nimaps;
-	uint64_t			tip_flags2;
-
-	/*
-	 * If the source file has shared blocks, we must flag the donor
-	 * file as having shared blocks so that we get the shared-block
-	 * rmap functions when we go to fix up the rmaps.  The flags
-	 * will be switch for reals later.
-	 */
-	tip_flags2 = tip->i_diflags2;
-	if (ip->i_diflags2 & XFS_DIFLAG2_REFLINK)
-		tip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
 
 	offset_fsb = 0;
 	end_fsb = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
@@ -1399,12 +1388,10 @@ xfs_swap_extent_rmap(
 		offset_fsb += ilen;
 	}
 
-	tip->i_diflags2 = tip_flags2;
 	return 0;
 
 out:
 	trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
-	tip->i_diflags2 = tip_flags2;
 	return error;
 }
 
@@ -1705,14 +1692,6 @@ xfs_swap_extents(
 	src_log_flags = XFS_ILOG_CORE;
 	target_log_flags = XFS_ILOG_CORE;
 
-	if (xfs_has_rmapbt(mp))
-		error = xfs_swap_extent_rmap(&tp, ip, tip);
-	else
-		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
-				&target_log_flags);
-	if (error)
-		goto out_trans_cancel;
-
 	/* Either inode may now own shared blocks; flag both, with CoW forks. */
 	if ((ip->i_diflags2 | tip->i_diflags2) & XFS_DIFLAG2_REFLINK) {
 		ip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
@@ -1721,6 +1700,14 @@ xfs_swap_extents(
 		xfs_ifork_init_cow(tip);
 	}
 
+	if (xfs_has_rmapbt(mp))
+		error = xfs_swap_extent_rmap(&tp, ip, tip);
+	else
+		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
+				&target_log_flags);
+	if (error)
+		goto out_trans_cancel;
+
 	/* Swap the cow forks. */
 	if (xfs_has_reflink(mp)) {
 		ASSERT(!ip->i_cowfp ||
-- 
2.56.1

