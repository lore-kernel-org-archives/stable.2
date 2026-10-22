Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679676;
	b=b+r7O9E1ZpXM/BNcuc3BIjtX8YrgemK7uyr8+zCdBDpKm4vkJXpduarrIY9HUyJW/90w
	 G+uKDHttenNQg58daZwCR/rcz7KpD6I51nxLnSiGEGbAhq24SmD/OpuLv4JAyZ2Qw/Uvn
	 3UYBImb4FiqYHGgKkqEJlDVyiXfqdrPCBHjEwp59NcEYa5XdZ0YUJn87HoYt78KiQ6C5h
	 g2LMiQ7uV7sPrsGWvtoCL/qdm7DmjI6NkYmAy4+B6YfAomjXvDGREPST9gZ1rlyrtilnk
	 eUl74YbiYgiKNpqvAJ7he91VMaZw0wuBynet0dDNR88utcWGbsBbC37d68sguNAjYCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KEqj6RtnCJXoFOnDyRLUEOrRr50r/RePaYCk6W5ihZ8=;
	b=UtLx6UBj1N6KFAB8bMDRyB9U4McS8u/DgX8KMApKbcNs76uYqabM8zhb6c8XUxc2GO8Q
	 ABXlEKhzr4EX0GO6GGx/WjOXuUj5z99fQFAcVtpOZF9E2hyS3ajnpc8riRHcnjHTS5Jls
	 hOuk0bXchDTof3ES+wVZMyaMB/pwh8k4pWZddJwIJeYNBZfmHKoaQj9bZZNWZVWXStf8e
	 3Zo5eMN0HOLfHFx6DKM9K2lq1puqNQExrzQ9XBPSpTRVbGhAl32aet4PdghSHwt3Ou7+6
	 Xvf1fI8GgqOKNWSCVsjlVMLX/Wkc2KG5pzpIRey69LxYF+u1tX+fN/o+kh6NRlWhvwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qz3iR/DP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA731606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qz3iR/DP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E964A1F000C1;
	Thu, 22 Oct 2026 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679675;
	bh=KEqj6RtnCJXoFOnDyRLUEOrRr50r/RePaYCk6W5ihZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qz3iR/DP9QxLlSQCtSmvSklPSaGSOegDdEGeVlIvG3HLZbbsaodhVuifHZ5mTSuBP
	 B/1Ai7cLdWRjVdVkZAG+hxzuoAE1YRjRm08lY7+m4+F4hM+OB9j1+xzV/ooDTuhukq
	 5QsnMHDUWez7of45HZ58/gVfcSepxlr37w2Y5yRn2zgTKkW/icDJP0m4EuxcaqO4r3
	 RlutV4ZdoNDwbdy4Ot2cl4AZH2IODpgNucRTIwoMitJ9PD98QuMcgML3x7uD8m2Bks
	 Xk5HKmIbNymEJuwXn38+MOPN2R5I9NU1eZglU//6ecg1w/Qiq2xJ2E80J987pgcXnC
	 RS3KitsHl7HQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yun Zhou <yun.zhou@windriver.com>,
	syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: don't hold buffer locks across sync transaction commit in xfs_sync_sb_buf
Date: Thu, 22 Oct 2026 10:34:33 -0400
Message-ID: <20261022143410.1589179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102120-monogram-unstable-a679@gregkh>
References: <2026102120-monogram-unstable-a679@gregkh>
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
[ sashal: Omitted realtime-superblock changes because the corresponding support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index eb46712e27d9f..de10b1adbf8a5 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1186,26 +1186,23 @@ xfs_sync_sb_buf(
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

