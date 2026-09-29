Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6951A751
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683115; cv=none; b=kkXlVrL2uMW3Fd6YMad8cypW4P6c7d3m9Vr0SwDMwCSAMRVbCvtf0/DSkpLcl/OQ++ABJu1aeLyWn2t9nF/BnzhMcrRkvPd1GzL8S/RdOqAqGYdMZJTjIYFfs+/PyS+1uiTboIGGbIXNDE9CQFddWT8feddBRregkz9oYcylzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683115; c=relaxed/simple;
	bh=VWInyPcX7YXhkF8djEM1EhRKabx/NzGcRlhxQjrQsYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UR2dfWR0gDauCdDh70TuGU9QxjqN4rSYbR6/GLU8sGL2VcBXjMt8k68d7qhjUQsI3VSIqh/08kdoLKFIprjTgQfSbETuDF2U2KNWEqHzzC1VLliwT0PIyyw0Iy/pXGFkfa+hov9dfB/Yc9pBOP8Yp9BFM07Hi+xruOYtwXO7hDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjhaH/Ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjhaH/Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E091F00899;
	Tue, 29 Sep 2026 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790683113;
	bh=yKStN1b4e2J07CUpgkNibrpKm0OLmUq7nIwRob9gCPo=;
	h=Subject:To:Cc:From:Date;
	b=HjhaH/Ji6QJpEOAV0zBe+6GE9jCRTRcEQJJwfhglD4jIwtSZ8IFUnuC0BMjItfrV1
	 mHSCDCs+XqbtoyauaQavUXH9PIJFicHSc0bhD/JSQ2boLI1kM7G3uvmLbw5qFD98km
	 qB0nyfunnyFn1CvRVyloDQoty48Y4XDKEohl5iWA=
Subject: FAILED: patch "[PATCH] xfs: fix cursor and pointer handling when recovering iunlink" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:58:20 +0200
Message-ID: <2026092920-approve-latitude-dd24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 65f39d09d73718611cee40399179323b5d4ead00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092920-approve-latitude-dd24@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65f39d09d73718611cee40399179323b5d4ead00 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 14 Sep 2026 22:38:38 -0700
Subject: [PATCH] xfs: fix cursor and pointer handling when recovering iunlink
 buckets

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

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e7e49529658b..cf0d610265fe 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2736,12 +2736,13 @@ xlog_recover_iunlink_bucket(
 {
 	struct xfs_mount	*mp = pag_mount(pag);
 	struct xfs_inode	*prev_ip = NULL;
-	struct xfs_inode	*ip;
 	xfs_agino_t		prev_agino, agino;
 	int			error = 0;
 
 	agino = be32_to_cpu(agi->agi_unlinked[bucket]);
 	while (agino != NULLAGINO) {
+		struct xfs_inode	*ip;
+
 		error = xfs_iget(mp, NULL, xfs_agino_to_ino(pag, agino), 0, 0,
 				&ip);
 		if (error)
@@ -2750,11 +2751,11 @@ xlog_recover_iunlink_bucket(
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
@@ -2766,18 +2767,20 @@ xlog_recover_iunlink_bucket(
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

