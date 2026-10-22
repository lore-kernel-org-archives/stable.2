Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706612;
	b=nwpK4obQlLLqpgbRQ2xPzU8opaGxe5vhLbT6+oUrntvTN8KiZUThfzo45GknfmD7OxrF
	 CIzDZFyMBbdfPRBMjiOfvS9UgmGmrBKNAV+sBN3VkHF09/QPNhXTtep/Uk4GFRT08ars8
	 GjaUj0TlTpOJaxJnbwr0JX+dJhs4jGm+VnwCRnV+fSsMSHMMe4VXrTPiKoC1+ZksLsC+b
	 qAWYZlmf7tBru4qV7EpHzZO64AzkffHXob9McsFhttKWun2Io4Wc7d0Xs9GkPjI1EWEon
	 G0I4PIOv0vX/TG9HgAh5FxiTcfuuB5nyLvT7EhJvhoBiHX691+FzsuG92ENi+6+wrPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nB3f7kL12FAQgMsIR+ldz47T23GddoXXrgM293AAQ0Y=;
	b=sxMUF3eLzX+GFvbhVxho6T8t6r+S/y7ty5s31wL73eE1nvOo3gJ8rgLXxQ7FmfkdWKiK
	 KRTo0dV1+2oI3NZt5NLtRujKDkx4QB4jDixCZkgckNAJlp4yQZ60YSzsdR81euX86ygt0
	 ExhQbu5NKyC2QnSNK9w1LNeG+AJPssBS2XU4v9eIXkihM8eLFDjsrlLgLEcVnk7D87N7Q
	 wtRHmXK2jri3EHrfVsvug762JQQleAqZl6osw02CpUqp9TyWGUIwZJ9GMl4YeII283CMT
	 mKVLCSld3mg6lZhdh2TUc/ziuNgxNqENzDrek5G5noRu5XkjDBaK3RNNKGXkG0YetxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3FrBTPT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71874606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3FrBTPT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED791F01825;
	Thu, 22 Oct 2026 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706612;
	bh=nB3f7kL12FAQgMsIR+ldz47T23GddoXXrgM293AAQ0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3FrBTPTuLultpYI5csuod8Ahkc1nK5ZBYmQWFdb8KC3gqEQ6d3VxV8EYmDHuHsRg
	 5NV/uyExqHX333S0EZaD+mBerzSUrmfE1dy4VTzEy2vR38hLqz1400YVK524+tpX4e
	 sPkUFinQjqacfJqbrCmUa/Gwua7wd/6e/ABpY6dzlx+R3EYQHA2pyU0hpXtDBYHHrZ
	 fzNX+QBZPLwlM6r+JLNjGQKiayzccgueoOC96K13//qSx5JBnPNAA11t2shVfxJ4w+
	 ueSQ/DGRJvz7YnLKC/ySNRDGa5+KC5etc2VNSUatpDXP8p3arsoCjo/6oZiHgDck9n
	 WUTsbCWiCvlPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf
Date: Thu, 22 Oct 2026 18:03:29 -0400
Message-ID: <20261022220226.1913649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102122-mural-modulator-6339@gregkh>
References: <2026102122-mural-modulator-6339@gregkh>
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
[ sashal: Omitted realtime superblock changes because xfs_sync_sb_buf() lacks realtime superblock support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 40b31fa6687b7..2cc8da99a42e4 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1151,26 +1151,23 @@ xfs_sync_sb_buf(
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

