Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6F525A81
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791090; cv=none; b=gOGf8amVkgcbIGe66f7Oal9Qw7qgbyvnObcUca9Um/6U+dgHjX2KUnmyBZZUbSBuczw/mIfI0A0NxF+jG0HBwM+54e3fow8uwITs4s70EFQnq34/+DAcuEnpc1NN1o5b4sU+mCWpXp9Pj6ntI7nQwnqVYI0k9LZ5MvgRcSXRVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791090; c=relaxed/simple;
	bh=qIzVUTETUXWUXvb91y96Jb+ZGhcPV49CTET9/5bznaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfJ59ssrkVakpDdNkI09XK4O1RVqPRO/y9O+63gzr6Od/F36mhc+VCOEn8+/Ikf7sgxnrI3mxvt2UmDm8g60Wkh7xBoVFpPb9jVFGCCeCo9wkYAllFimySHZxdt/d9c5PV6wOwCOQu5ObxAyUyWKFx9qlc/AItxzmA5U/s77o20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMv82AfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMv82AfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077431F0089A;
	Wed, 30 Sep 2026 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791089;
	bh=goaa/ZwtUxuIk/RWSy1i+iXZma34y6gcmmtfoIC/17E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMv82AfVT5VtkVh3xRZCCbNcjDdiK/Spc1o+WqealNtK0Bg4r3YNScRXc76lAHNSH
	 xrBGJjrM5bczXlXiNm2wekhi3hbWH0R+rC4IEhUTO9gxuBH08CXx21+nBbltmpDUtd
	 PbaBhEg4fok8NgpIC41bdtpFJdl8zsBWJUMUycMJmmNW6CfN6yHAyG/VyChGeizShX
	 RcZEHgXnSF2RNWniR3/NkmxJcOyiIcNtbrlK5H9378yfOLCwtFCJ/ckhqwRJ8lus9h
	 Qsq6Vcs3bupAR0RZAjXgL8kBRia+k4oavonRcbWZTUT0KlCZvalfCHMqzu20sarn8K
	 WV05/Djn+ih/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] xfs: fix cursor and pointer handling when recovering iunlink buckets
Date: Wed, 30 Sep 2026 13:58:06 -0400
Message-ID: <20260930175806.3940388-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930175806.3940388-1-sashal@kernel.org>
References: <2026092920-booth-deluge-dbf3@gregkh>
 <20260930175806.3940388-1-sashal@kernel.org>
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
index 38ae42bbf9b5c..f2f7e35c03cc5 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2701,12 +2701,13 @@ xlog_recover_iunlink_bucket(
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
@@ -2716,11 +2717,11 @@ xlog_recover_iunlink_bucket(
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
@@ -2732,18 +2733,20 @@ xlog_recover_iunlink_bucket(
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

