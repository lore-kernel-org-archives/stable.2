Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814702;
	b=Iw/trJpNgS/T/BF/uzcJ+Votlt7rADqoqNdcnM0iwVAWWEMAWw79OUwMbMcFcNfyCELF
	 s2sB5pvDoJ/Tt22ECJZWvXcJGiCAj6DTx5pdMoMv302Pf6t24pAgSrfiD82C3+ce3MAec
	 NkljW91kO+eD5Xxip+bLgqBJVILpRq7ttxi7IRuqEVsPPMJhXkkBLIsC6bVYlx2ZviePU
	 h+wntM+BpdJgJb70ELEAkE0QbqCjI8QoE4NFhg77EwPv5zfZQJlKk8qdkR4z1okj8lS7B
	 NYBFNHw5DUl2RurnZ9n37UYmtq1gILFiSdC/F+7erage8IrY4DaFALo++ESPuI/g2cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814702;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bNITLFL+RJcpipymN89bGf/LSKlTMyMNDfQCH1u+Agg=;
	b=bGQIYnOqatbqFAY9ckTXQie1pKA9bLkj6coZsdkKd6qBa96H4mqQUOvWr7XUIRmb7UOC
	 a4bZcwvkpUWUjpgMwC6J7TOu8Ppmk/rl6RpwhLoE1+M7fJ1wHJkQ8lgqHVsnZ+awyAK3Q
	 nAhz5G3INzedobWTGfiTuBghyz+0o+oKXxju8vCVAyo0yRNA+4/6y5jFCOrJMTH825QV3
	 QCXJkvAfw15bWdD9xj6rOfSMRYY0flDRBeeSPUyOWRb/g+LbIPnPTZ1N1avcZl+NZkkRe
	 M5qX1/qtar3cuGmjBVAHpmxHP9wxYaBGjeQvsfuRM9KlxJeeYAbsoGxgT1XCBLxrYAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hs3qoKVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E75606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hs3qoKVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC41F000C1;
	Wed,  4 Nov 2026 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814701;
	bh=bNITLFL+RJcpipymN89bGf/LSKlTMyMNDfQCH1u+Agg=;
	h=Subject:To:Cc:From:Date;
	b=hs3qoKVEqMmbe8icuVMqZZi/UYFjFqhWeW1AQTC7oXFTfyf+K3lsBMoZFvkK5rCfj
	 x2uQy+jyL3iEfaEXFubdAd2ll+f51rcMxBdSO+BH4aVonN8DuSaWdqtR20BQJ4OJ2k
	 T2afVktIHq2DfVu9XFWGZOThCnWgJY+jyZplUzLI=
Subject: FAILED: patch "[PATCH] xfs: forcibly reset quota timers when upgrading to bigtime" failed to apply to 6.18-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:33 -0500
Message-ID: <2026110433-tingling-faculty-9098@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 780212c8d8105eadb5f56b4c7aafb94937755582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-tingling-faculty-9098@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

