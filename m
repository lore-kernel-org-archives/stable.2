Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696234;
	b=Yt8r6g9b182xJld6P9RdIU4iya3E3AksUfEGdu1b9zIB51YoAG3hCqfz+OIGoOKMjFZ9
	 ljqwqKW/jSf4/+JEh2XCigxppfVzsUSpHZLNXnkUI9n/KnyJQ1R/GOkDlI8s5Ivb3cVXn
	 r56sq2RmMJ68QKHXPbYEG4IMIn8r8jyXoc16EIgHu8bz1/ehdbQYUNKL9jOADiAlZMXo3
	 //B17qg6k5XcSSeUHjqzYWoV5od+7xaLeTJjULAddySrGunHj7Hv5M4plpbiJxX2hYviE
	 XuwNk70q1B7Lhp0xTH9XvVwW8VgDhKvwT1TYCaRYh1sCu89SLuKI0rorE/3GAgUSMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YG8Pl2wFCDZCAzfR/Hns3U1Opcmmpdg+8p5jdj3qcJ0=;
	b=T7bkK5qx09m2pm+cRbxMLSvAwWwyKrJ24z/onzsr3Qj40VNSmd1tM98iGJWtpHFl0cgS
	 aPs7SANt2fZB42AMeZWAVFY3dceEULkfVUMx5sZ32CZyDiaqKDC7XLualiGNo3iru1s4j
	 AQM+ANn/a+S06Myb1xydmhosaPN2lmH9GzpMoOe8j5RvD5X8R995YhZAhlyJAvUik5mBR
	 /fQ2CijcAXja+5zyxr3f7UwL4NpHhF2Ik0GoOQc+zWd5a7cQMOPKtqzcbKsnjp4P2BLEY
	 iRToZtNdx6ygvTweaCRVVXJ8eecsn/VFomR6YtjShzHV22PhRbzkkxSRdejl7oLsFhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG8cdpBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EF606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG8cdpBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DDE1F01825;
	Thu, 22 Oct 2026 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696234;
	bh=YG8Pl2wFCDZCAzfR/Hns3U1Opcmmpdg+8p5jdj3qcJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NG8cdpBRR335KHKqcAuC7+S9notHPc92Qs4vT2l/soyT1Ki2DxSpIEkUblBe4XFjX
	 QpHvlyQbOUDjvkoUXyKl6S51PRwD2vQA65nmhHNExw+HQSR9oafdx2v/GpkWU9i1sM
	 dadaAAeOMk36Wckhzqmgk9tMaODLrHVNAC3xm5FYBRqfFglP7cFwzlQ8LA2qcz2yas
	 tYm665ZAAJLQsMcRlGSCj4KVE6R0vA1wUo1Nkq2fDQ3meJj6F+HMPVLlUCjmcXxWAC
	 stU/oARxn1c12ZFoMlhjq9q4ik0uAgb3405TjeGMmzYere0/sJW9QoROeXAuy8Y9px
	 9Y3C2926BDB3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf
Date: Thu, 22 Oct 2026 15:10:31 -0400
Message-ID: <20261022190939.1748410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102122-lapdog-celibate-e8d8@gregkh>
References: <2026102122-lapdog-celibate-e8d8@gregkh>
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
[ sashal: Omitted realtime superblock handling because xfs_sync_sb_buf() only handles the main superblock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e95a6b2ecded6..ad3b7f6e70ee6 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1081,26 +1081,23 @@ xfs_sync_sb_buf(
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

