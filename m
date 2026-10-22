Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685763;
	b=Tw7kPYUK9mrMDYoAq7w7EpCKEDtvYqthln5ZTveLFGuGhz/jQq48l/1F5NpRDznODMdj
	 oLFQ6+vhT4RPMBSeS5cCn8RBJ1NAU1Zf1YABzRVr18IdC3OEbFBwmxfOwM65Dw9FnmEMp
	 D8w6eQiUpgyvcAAKqgbSzEjWbMGT5Ho1rK7/wD91pnqCqRCQkCI4UDxeqOdPspj2G1IU7
	 H7MdrW7vj7RwSDQaPklnJkLxCJzBab4NPzUaBmjTb443hvEVXXiBP7pjAxq2cVDNCwkru
	 oXsQwd+ZXW+IIySwinfT0kZckyUjo7XAfm53MuMUPothY3/L4wqsgKkfGUIrp0n9cXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=15w2lgAl32OFNxw2wcnQXe9bFvYV2hprHtzirYcVPkc=;
	b=fBaAWrqAT9ZH8PRfQo0UF9WAks9wO+v5CYuSfgZdUM8mtpKMNXW+XtLDUIEAzzOoxaOc
	 htmAeYkaXlJt8NXdcvMua0XTvTJyo3d9YjLtJ7CP44toZmD4cfoYtwci6Uqhb1eGF91zb
	 aqBM2VYZ12E1zsO9ZCOx6mrulYDzcRzTO9hQyD8+iROetvDcKpA0ABSequIERZDPv/8cP
	 fTuStw6G49EbA3ZEQeLZmuvu59pQYHwzsQbz72OeT20xW0rd2/koEk9/MN41iPS4i9Le0
	 fj1oHH6z9ZK54JCaUt+4muxyTg/VVynoJJTnHxRaFJCnsmpcEkSnKMBUti+k0EUuXQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oALSGmNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFE606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oALSGmNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7610D1F01825;
	Thu, 22 Oct 2026 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685763;
	bh=15w2lgAl32OFNxw2wcnQXe9bFvYV2hprHtzirYcVPkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oALSGmNpIJygB0Utw3g2Z2oETO1qopmveiRp4ZGsOc2RlS7/cI7hbm8A3/qZjqJOs
	 1nHIOJ1dgOH3hsP105b2MJ+QaYipcvGa16izO9Ys7aDFZkqEDhniC3Vdntj5eI46Nz
	 8Zs7Uuw0xshqkXFDgziLEhJoPdwzRqHo4OSg6+95DDhzRPGEjUopZHwX7sqqQO7Kdt
	 cY1+trlQO7o28SoJzh5CnolN7o6gRKi/Vt0EupoMGiTvZKrMhgH/6a+vTMIiq9hsds
	 HkIusr2XBI92luI6ju3A8s7D5L+lUXW4PSNBEJbdCs9AKKTPRO1MZWbP5zPenUdgah
	 d7e/2L0lQHJmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf
Date: Thu, 22 Oct 2026 12:16:00 -0400
Message-ID: <20261022161455.1673987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102121-disloyal-unaware-612c@gregkh>
References: <2026102121-disloyal-unaware-612c@gregkh>
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

From: Yun Zhou <yun.zhou@windriver.com>

[ Upstream commit 41a28c865d1d5843f8cb9e0af17a8f4d9e2961ff ]

xfs_sync_sb_buf() holds sb/rtsb buffer locks across a synchronous
xfs_trans_commit(), which flushes the CIL push workqueue internally.
If shutdown occurs during the CIL push, xfs_buf_item_unpin() needs to
lock these buffers to fail them, causing a deadlock:

  setlabel:          holds buf lock -> flush_workqueue(xfs-cil)
  CIL push worker:   xfs_buf_item_unpin -> xfs_buf_lock(same buf)

Remove the xfs_trans_bhold() calls so that commit releases the buffer
locks normally.  After the sync commit, re-acquire the buffers via
mp->m_sb_bp / mp->m_rtsb_bp for the on-disk writeback.

Fixes: f7664b31975b ("xfs: implement online get/set fs label")
Reported-by: syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: omitted realtime superblock changes because the target code lacks that support ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index b5f081993cd4f..6c5c2b40056d8 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1148,26 +1148,23 @@ xfs_sync_sb_buf(
 	struct xfs_mount	*mp)
 {
 	struct xfs_trans	*tp;
-	struct xfs_buf		*bp;
 	int			error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
-	bp = xfs_trans_getsb(tp);
 	xfs_log_sb(tp);
-	xfs_trans_bhold(tp, bp);
 	xfs_trans_set_sync(tp);
 	error = xfs_trans_commit(tp);
 	if (error)
-		goto out;
-	/*
-	 * write out the sb buffer to get the changes to disk
-	 */
-	error = xfs_bwrite(bp);
-out:
-	xfs_buf_relse(bp);
+		return error;
+
+	/* Re-acquire and write the sb to disk. */
+	xfs_buf_lock(mp->m_sb_bp);
+	error = xfs_bwrite(mp->m_sb_bp);
+	xfs_buf_unlock(mp->m_sb_bp);
+
 	return error;
 }
 
-- 
2.53.0

