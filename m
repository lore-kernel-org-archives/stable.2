Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814704;
	b=mpy9BOtBrEqm1rE+0mRDR2ym/fLv5CztbShCqaGr/RvqbtFtkp1Txo5cTO086z0o1GpW
	 MoUukNRDYc+NNed1BJPgB/rMaokhJXwE1lESQwFnNj0HCad3oUvpqNFopulMo8mbeOMZ/
	 pbzdboeiNByj2LbTRO/3Lmf4lmGvoNsOFZTQ44S3O798MXvyIqM+lFXdUmpQR1HiFym9k
	 uiL/h8eB3qZyHEXwAza7v26Z/L2aWSdEdgzCo0aHO3l5iwaA1wwFA31VE0r0rDkBIN7Rn
	 R3FoLX4zuGW/v2Cl63V/YXsH1q3hbUMXhgFExle8iwcO6vNTs5yInKgYHqvfvtsuM2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814704;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PKGV7JYSvZQ00q34q1+wYqPGKHrfWBTpCr9icWb6zlM=;
	b=T4UH7mdyfd2TMGN2nKNSmQRG4+rc5eojcLIxn9IXKlDeghor+YAJOjW9q6UJ0u17eR/8
	 iOA6ZDtF6piM4Ba8Gorf1F5XqZJEZc0nPwtFCzJimbK0MWwOCoyh90YyQm2Hf7Ra9kFNs
	 ykiQNfQq6QVjDDhbE2wfRCpgaiynj5OCb9kKY56D4PXDDtkY+rVSbmH8DhsssiQSqv1a1
	 QreTi1/ffxBHfBN74/oi/mbnDdNa/zW1yLbNZ8KStMj8dxSs5NPxjD+9zcqxP0rIKiUS0
	 RAZ7KJZ2C0PQ01PnvP8YDs5L9QPflXy1NFQSxnbBxwjJw2SsD4VsWpCP0QfBzRYmcxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iDQ+Rqp3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1241606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=iDQ+Rqp3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443531F00A02;
	Wed,  4 Nov 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814703;
	bh=PKGV7JYSvZQ00q34q1+wYqPGKHrfWBTpCr9icWb6zlM=;
	h=Subject:To:Cc:From:Date;
	b=iDQ+Rqp36RIvlgpdUizdn8HhHc6jaIUB134Y/252bpdzLh5A9kIKnapYWEWpdWf0c
	 hVO+xxUk8lBmV++ZUFbe4MYcyNG4SSteHUVarKajvrY2VV0/hDGgO+0k+TALUE4FYY
	 DjXrKdZzGZCF5SgswMbOk0IEmOBH4DJWNrVGztjo=
Subject: FAILED: patch "[PATCH] xfs: forcibly reset quota timers when upgrading to bigtime" failed to apply to 7.3-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:33 -0500
Message-ID: <2026110433-diaphragm-obsolete-bbe9@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 780212c8d8105eadb5f56b4c7aafb94937755582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-diaphragm-obsolete-bbe9@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 780212c8d8105eadb5f56b4c7aafb94937755582 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Sun, 4 Oct 2026 22:56:04 -0700
Subject: [PATCH] xfs: forcibly reset quota timers when upgrading to bigtime
 during repair

If we decide to upgrade a dquot to BIGTIME as part of repairing it, we
should zero out the timer fields so that they are re-evaluated and reset
in bigtime format instead of letting through whatever was in there
before.

Cc: stable@vger.kernel.org # v6.8
Fixes: a5b91555403e3a ("xfs: repair quotas")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/quota_repair.c b/fs/xfs/scrub/quota_repair.c
index 6a2b3271264c..fd14d81ee4e9 100644
--- a/fs/xfs/scrub/quota_repair.c
+++ b/fs/xfs/scrub/quota_repair.c
@@ -343,6 +343,8 @@ xrep_quota_block(
 	bp->b_ops = &xfs_dquot_buf_ops;
 	for (i = 0; i < qi->qi_dqperchunk; i++, dqblk++) {
 		struct xfs_disk_dquot	*ddq = &dqblk->dd_diskdq;
+		bool			was_bigtime =
+				!!(ddq->d_type & XFS_DQTYPE_BIGTIME);
 
 		trace_xrep_disk_dquot(sc->mp, dqtype, id + i);
 
@@ -351,8 +353,21 @@ xrep_quota_block(
 		ddq->d_type = dqtype;
 		ddq->d_id = cpu_to_be32(id + i);
 
-		if (xfs_has_bigtime(sc->mp) && ddq->d_id)
+		if (xfs_has_bigtime(sc->mp) && ddq->d_id) {
+			/*
+			 * If something was broken with this dquot and it was a
+			 * non-bigtime dquot, we'll grant everyone a fresh
+			 * grace period by zeroing the timer field rather than
+			 * try to interpret what might be garbage.
+			 */
+			if (!was_bigtime) {
+				ddq->d_btimer = 0;
+				ddq->d_itimer = 0;
+				ddq->d_rtbtimer = 0;
+			}
+
 			ddq->d_type |= XFS_DQTYPE_BIGTIME;
+		}
 
 		xrep_quota_fix_timer(sc->mp, ddq, ddq->d_blk_softlimit,
 				ddq->d_bcount, &ddq->d_btimer,

