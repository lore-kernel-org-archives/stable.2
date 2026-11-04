Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814705;
	b=ZEgcRDID/8wZR8GFtHNmc9jbU2zLa/Mi7JTymVdTmHzfBbcNQCF5jeGWZqwHVa7oDgwZ
	 ACSl1D89G8LTOmiGPmbBnGkk49uOSn1bfc/gjBeXIzBGfddTrOExh4xW4+JOM/NWQhjT3
	 LT3x8tknsrgcnMwuf1It+lZ//mQOs21DPiq+4yEJwhTSxGKMLIBWNLLZcgATr5aRuQNub
	 Fz0lTeed4kJTnzNVDfOy+hmURdSr6z/C6XPO3WOWSOPlh0Hax91/pQenMEmmWX5/ODb+C
	 KJgKWkO4/8gWJc/NtaqzaPPnjrccQ4AEzYoGUMlSDiK6AOvx/b7wCVXEs33VrSC7HPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814705;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KYSFuaQhWwBpG5yQBV1A4M+0u0IBmq5muTUFmQAzlBo=;
	b=Av6mss4OaiInjsoZDRT+zQzf0DjM0TFOMbx+iV2Teidj8VjO5n5VEb37OfWo3UZWnf8h
	 ke20BeYq3McFlQGWVo4Y6M3+fQrYVZFFAl0xUNS0IxFRqM7hPKTjTgS8WFgQgEcECg+cR
	 ZUrR7TAC+OWFxY/2WjVBaHvFvJqbMuHJ38OIVqs+Umw3vT2QPDuRnqgmlxzfzDwEUbCbj
	 3y4C30H44YysrCFeA0Tcjoq7TJJwPpy2b0lBKWFygngaveN8ndD7EfPJ+bpv16yz63s7n
	 kShuDuaZlcH5ow4ptov2y7Ozv+sS4VS1I5C2liwQAbRe+Q+iXjl58+/0jCSoU7Rb8QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fxbFxJu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1E60A6F4F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fxbFxJu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EA1F000C1;
	Wed,  4 Nov 2026 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814705;
	bh=KYSFuaQhWwBpG5yQBV1A4M+0u0IBmq5muTUFmQAzlBo=;
	h=Subject:To:Cc:From:Date;
	b=fxbFxJu6BLrvgilKIcYByPdHllTFZ3CtBviYUglEeTNd0wMBtHikV5SqO2UC5QG8g
	 0LnioC4Ex/obRAOYwEkVJQVdu2fexmzLVpoL9awM1u+DU3b1WipAX3W42njT+Y6v9+
	 kPO+VcAt8sSVu2HEzCub4He0up/x84Sar4wn5pGE=
Subject: FAILED: patch "[PATCH] xfs: forcibly reset quota timers when upgrading to bigtime" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:34 -0500
Message-ID: <2026110434-purist-sureness-e19b@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 780212c8d8105eadb5f56b4c7aafb94937755582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110434-purist-sureness-e19b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

