Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805354;
	b=MhB6NCucJ8LSark4IaUAL1yeVXMEADrCXLyndhCBAWLxln/lBBoo6VjwRDU4qTYpDsgC
	 irCYlkUQKec9/LqQVXK/8GhnjLXm0g6aFKbfyjptiuAegnyVy+bJC8ky1oAGJHHS5naRN
	 dHJ3RhKoSF2iuSjFd27IDm69c+PprXYXi2/O2HoYsjfUuLDgEivTf4JwecbA86PL6b4BJ
	 G0+ERmcn3a+zEJxUmWxuzRxR0fF+w2RTSNUjb7fyQYssUJ7ih/t93Aj8NQ45JMSpU1jqi
	 fBG/M2D6Chdq/OKjnFzzx0ZBIEu+LVM5XtMUtcUZ3Pfn+2EzV1gllUU65o6ii5Sl4Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805354;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LAF9hCN464MsXoxOH9DwHpOcmoNxeDcS3SVjcgNqpdM=;
	b=wvUbkbKi1xNfoyEY19wkXuK04G+OfErche+A1sPFYkqJrbUxj/2ZPGCcoS7KPaypBrDx
	 XrZuMJ+bYcujGxtElv3rMNlNUu3U7A4f4dhudXL73Y6datn4f3lF/x4NCi1gmMxRnXkjt
	 O9LTehikPkAdmsnYc3e01ULVHeREphWenwQy0xe+A1bGplMLyl9xIH98Hn/rYFdMJkGL1
	 r8zbKffCwbc4kr2xFLl93x1FQcEyJi6BBdLDpbYW+v6UXEWPPjWLKrA5ubnkwpcp4CWL+
	 75f/sooC8iH6QfKH9moPPqwNg1hBR86F+7537FEL8nK1ocm2ommfcmku4XnB9PyVrRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="UaCh/5tK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5B606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UaCh/5tK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5123D1F00A02;
	Wed,  4 Nov 2026 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805353;
	bh=LAF9hCN464MsXoxOH9DwHpOcmoNxeDcS3SVjcgNqpdM=;
	h=Subject:To:Cc:From:Date;
	b=UaCh/5tKNFFIsO9zSjgD6mGFinTKSXgVHn4z06p/ShLOxRwwudgRcygY4f75Edf2E
	 3sRMi4tpoSLmyAfvZgj0QaaTjGmjvZcUnYv4neu86CYoDq47SxiHvseVjKG8WTI0ia
	 nKHVFLBYMh35Z4hT8psjmvk7oVMgLBlvtXb/d3rc=
Subject: FAILED: patch "[PATCH] xfs: allow softlimit with no hardlimit in quota scrub" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:15:43 +0100
Message-ID: <2026110443-cardiac-untrained-502a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 342c2e00b3a99099a7088f7b8c8f075670c603a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-cardiac-untrained-502a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 342c2e00b3a99099a7088f7b8c8f075670c603a9 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Sun, 27 Sep 2026 23:17:38 -0700
Subject: [PATCH] xfs: allow softlimit with no hardlimit in quota scrub

LOLLM observes that the sysadmin can set a user's soft limit to a
nonzero value and the hard limit to zero, so those aren't corruptions.

Cc: stable@vger.kernel.org # v4.15
Fixes: c2fc338c87a31f ("xfs: scrub quota information")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/quota.c b/fs/xfs/scrub/quota.c
index 8c6ba1240fd5..83092181b30d 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -182,21 +182,21 @@ xchk_quota_item(
 	 * suspect, which is why we flag it for review.
 	 *
 	 * Complain about corruption if the soft limit is greater than
-	 * the hard limit.
+	 * the hard limit and there's a hard limit set.
 	 */
 	if (dq->q_blk.hardlimit > mp->m_sb.sb_dblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_blk.softlimit > dq->q_blk.hardlimit)
+	if (dq->q_blk.hardlimit && dq->q_blk.softlimit > dq->q_blk.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_ino.hardlimit > M_IGEO(mp)->maxicount)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_ino.softlimit > dq->q_ino.hardlimit)
+	if (dq->q_ino.hardlimit && dq->q_ino.softlimit > dq->q_ino.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	if (dq->q_rtb.hardlimit > mp->m_sb.sb_rblocks)
 		xchk_fblock_set_warning(sc, XFS_DATA_FORK, offset);
-	if (dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
+	if (dq->q_rtb.hardlimit && dq->q_rtb.softlimit > dq->q_rtb.hardlimit)
 		xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, offset);
 
 	/* Check the resource counts. */
diff --git a/fs/xfs/scrub/quota_repair.c b/fs/xfs/scrub/quota_repair.c
index 74eb66f9b890..6a2b3271264c 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -193,17 +193,17 @@ xrep_quota_item(
 		goto out_unlock_dquot;
 
 	/* Check the limits. */
-	if (dq->q_blk.softlimit > dq->q_blk.hardlimit) {
+	if (dq->q_blk.hardlimit && dq->q_blk.softlimit > dq->q_blk.hardlimit) {
 		dq->q_blk.softlimit = dq->q_blk.hardlimit;
 		dirty = true;
 	}
 
-	if (dq->q_ino.softlimit > dq->q_ino.hardlimit) {
+	if (dq->q_ino.hardlimit && dq->q_ino.softlimit > dq->q_ino.hardlimit) {
 		dq->q_ino.softlimit = dq->q_ino.hardlimit;
 		dirty = true;
 	}
 
-	if (dq->q_rtb.softlimit > dq->q_rtb.hardlimit) {
+	if (dq->q_rtb.hardlimit && dq->q_rtb.softlimit > dq->q_rtb.hardlimit) {
 		dq->q_rtb.softlimit = dq->q_rtb.hardlimit;
 		dirty = true;
 	}

