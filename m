Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346351E458
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791429; cv=none; b=prtB+jB+I/v3jM5smhRhZfi0PhYbZj9MseDghe0Q0mq3gwSkW/KIjdnzZuYYE2IUviz8XdlLfQ0II60A/oMTw6gabHI2t616REngCSSLj+dPxDAur1nwJZvxzVj1xmAYMmkt/rPir4BYUrvd8Vorpdsduw/S8x+MAVN4TMUqoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791429; c=relaxed/simple;
	bh=tjITZiTwP+o4fW2GeS0tcU04lvXTS4vgJRtwPrKGSIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAgPiRzri6DcYMEGadhMg6l+g6n5og2Gl7WdV7ThSBjdpyemIHrvo078ztI8YKo1IcsNDzVdAmo9nooUR81rvwRkolQeNdb1iSlFu9ux87iFumqSzOhJamL8R21sdUk8AEjMA6wTS5xE6UT0jviVZY9zr/MPCnwpSiXchxd84B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy+Vgsbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy+Vgsbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516C91F0089B;
	Wed, 30 Sep 2026 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791427;
	bh=ppIO4Hgp67/pB21+dPXUX2J5rrCgp6ZGLuONdQ6KlyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gy+VgsbksNXpCWB2vq9IqWsAzZfMkZUk3WmtZPBEICOSPR3hH7QNRS4BqVfau+xaw
	 PsNup6ZUnL42NGzTajLP9GdcM9Y06dDu5vyZb4AOEMa3aAThAUVnFBX9gzp5gc4+jJ
	 tKP2D/fVugwl6kCJWjU7oQdUCCL98T2NKZuJjgcm2UsqxjFO35dSxnP4otXexAyoc2
	 rvl6XNoFXkfienxEXmNoa+yV+Nvai9iXCbh8fAaWB5lqjTpRuFOhF3Rb461rv5bWYi
	 GtCW8UEy8/Ipgkjfy34HR7rRZG6kW/l7jThTASW3GDIJrhA2NWFQySYUdARt8waSnb
	 T8zupbUMe1Z8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] xfs: fix cursor and pointer handling when recovering iunlink buckets
Date: Wed, 30 Sep 2026 14:03:45 -0400
Message-ID: <20260930180345.3983058-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930180345.3983058-1-sashal@kernel.org>
References: <2026092920-approve-latitude-dd24@gregkh>
 <20260930180345.3983058-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 65f39d09d73718611cee40399179323b5d4ead00 ]

LOLLM pointed out a bug in xlog_recover_iunlink_bucket:

1. We don't null out prev_ip after releasing it, which can lead to UAF
   problems if the inodegc flush call in the loop fails.

at which point I noticed even more bugs:

2. If the inodegc flush inside the loop fails, we also leak @ip.

3. We set prev_agino to agino having already advanced agino, which
   results in inodes with i_prev_unlinked set to itself.

4. If we exit the bottom of the loop with prev_ip set, then prev_ip
   aliases ip and we also set its i_prev_unlinked to itself.

Bugs 3 and 4 introduce loops into the unlinked list, though these loops
don't surface because we immediately flush each unlinked inode after
loading it.

Fix all of these issues.

Cc: stable@vger.kernel.org # v6.0
Fixes: 04755d2e5821b3 ("xfs: refactor xlog_recover_process_iunlinks()")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Replaced unavailable xfs_agino_to_ino() with the existing XFS_AGINO_TO_INO() macro. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index ffd52f5a4b897..bf510a6fb92e4 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2694,12 +2694,13 @@ xlog_recover_iunlink_bucket(
 {
 	struct xfs_mount	*mp = pag->pag_mount;
 	struct xfs_inode	*prev_ip = NULL;
-	struct xfs_inode	*ip;
 	xfs_agino_t		prev_agino, agino;
 	int			error = 0;
 
 	agino = be32_to_cpu(agi->agi_unlinked[bucket]);
 	while (agino != NULLAGINO) {
+		struct xfs_inode	*ip;
+
 		error = xfs_iget(mp, NULL,
 				XFS_AGINO_TO_INO(mp, pag->pag_agno, agino),
 				0, 0, &ip);
@@ -2709,11 +2710,11 @@ xlog_recover_iunlink_bucket(
 		ASSERT(VFS_I(ip)->i_nlink == 0);
 		ASSERT(VFS_I(ip)->i_mode != 0);
 		xfs_iflags_clear(ip, XFS_IRECOVERY);
-		agino = ip->i_next_unlinked;
 
 		if (prev_ip) {
 			ip->i_prev_unlinked = prev_agino;
 			xfs_irele(prev_ip);
+			prev_ip = NULL;
 
 			/*
 			 * Ensure the inode is removed from the unlinked list
@@ -2725,18 +2726,20 @@ xlog_recover_iunlink_bucket(
 			 * complete.
 			 */
 			error = xfs_inodegc_flush(mp);
-			if (error)
-				break;
+			if (error) {
+				xfs_irele(ip);
+				return error;
+			}
 		}
 
 		prev_agino = agino;
+		agino = ip->i_next_unlinked;
 		prev_ip = ip;
 	}
 
 	if (prev_ip) {
 		int	error2;
 
-		ip->i_prev_unlinked = prev_agino;
 		xfs_irele(prev_ip);
 
 		error2 = xfs_inodegc_flush(mp);
-- 
2.53.0

