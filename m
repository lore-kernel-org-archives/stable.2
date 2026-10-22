Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680572;
	b=G3gY1r/8NRgD7TGKduyO2Ce+yCo6Mmq11ZLhFehtx+4dBtjWS1soc7Gzad3UNz/MOsj0
	 ++swa/QtHu/Pe6w5DKw/N3qeN7p+UfTsvPwj52gCDQWYl10AFmSQ5e0LeHzBSKLDFjIcg
	 M/qL7zErFt89DrTTL5ESjka6uY3WJ2DLbVw8J0icNBeY1Kdv/H/f2EBKvK90eq5v7p7ON
	 tBfiYuElD62R6hIGtTKJRozw8csSYUW/Jwjz8pehl5Y7cCQtlgMxprWKRxpKjblA4X5nr
	 Vcs/RNx9JWtJvN0bE+3TUEif5th5jUmdAf9OTpNvYxaYZHpwr8ot2tNF8OBl1BVFkpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0aGDuZUxKpoClzz6d4lSZ2bW+2WDlBNYNEmjPRhlvjk=;
	b=CWW4+oxNwdBrYGK91eL4BKzL3uc5wNEvtSHwTdDAbvCcqovFw8wGWYtVfjNv9gIb8Fa0
	 s3BIlXERuXTe9bP3W0hPfc2LldGkUMcICWyYlSlTVxz6A8Ehczmn+WrcgXBLfRTL6+iZj
	 Ow7hQcH7m1KmYgI0n3+v971HiaocV2Ef+Nhmtn7Q0Ix8XK5W0kSHaAZ6jHLmA+2D2oOu4
	 meXJM7McibQ6a5vwYEi4WNxE8T1FoMcbvS5QjLt/g7vVI5q3sfhmj7Rh6mx+CrAJkWEQ2
	 B9T6VyEUtY1I9DAX4BgOty1BmFNkim872iO1fsF2rBtT+OZ7VMT6t2ANL28lvuV/Vrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOh4RsER;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F974606A328
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOh4RsER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4594F1F000C3;
	Thu, 22 Oct 2026 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680572;
	bh=0aGDuZUxKpoClzz6d4lSZ2bW+2WDlBNYNEmjPRhlvjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOh4RsERkUWEo8JNrx/QdWiT6GYL5t0VwrVF9S4rbxnNB5EWlo+0GH22+4ciUT6av
	 HrbkHcFEpadIPA5Px8D/Od4aHE8trpbCADRZ63606HD2lgeGaIB2w2sQFCrg5ET+wW
	 77tLl78+Be8ehTu67Rv4ippeZtqJcOsCn7wcMvz6mZ5JuZ1LsD9NwJw0n3gHLKA0Y2
	 SPxVi274VcOzzAy/w771AXCXlz+W/wjdlJuSwzooHAvzeimGfW4EISTH6T2cpAr2iV
	 hzOef8fUK85INTHUq8TFdlRHwPZocePu+XiMaRpfUzE3gsX3AKwcWhiSaYr6pQBN0h
	 XtmVosFc/04Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf
Date: Thu, 22 Oct 2026 10:49:30 -0400
Message-ID: <20261022144858.1630581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102121-jacket-unbridle-f8af@gregkh>
References: <2026102121-jacket-unbridle-f8af@gregkh>
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
[ sashal: Omitted realtime superblock changes because the existing code lacks realtime superblock support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index f4656d17121eb..279e174fba8ac 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1150,26 +1150,23 @@ xfs_sync_sb_buf(
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

