Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805358;
	b=4qKB6q4mmL0dzx+38ELPx6mYpuVF+XfLFXmZAGbtjeGUEDqr+Je5ccO9Sos3ccBCY1kB
	 TrTystoTehUoqoqlMyAt/xS9LRC9JgJtXWdZxjb12eXz7pXESXa67RqV9mHWNsd7r7Apm
	 +TJVCP7z6ng/k6845kN8P9w/KKKCQR69aCbfzV/PYK20xb9zBhsV2iRN6D1PQHqr51bCX
	 +wNF4bzr092mf6b5YuZjLaO9AcuunAWK1vUo4vcQ18qm4c95v6caLMbgYDcC/ecABxcr2
	 VCi5HoQvSEVssaLDgrY3vrPISLRqa972MVI0C0msb2T3EUOiZ6ffbzpTRvFhr6aEQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805358;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6ZzMvzjEzRRjv/X8P1TCOBwNx99KN+VemUqebT2db9M=;
	b=zh9+KLAk7lCXTPZSlFOjp0lOy71g5Xx2HcSVdGOjFZ1EJKRPnTGZBbx3eT2+pPrnBVER
	 7x13zEApZaVtNV9jQVtQAYgK7VSrcDZ1BQYn5QfvpNsJGyxyu8/zz9upaCq5IrHQNMvCP
	 vkBwynX8LGu3NjCH9xk9ZIoJ6hFY05tb6JxowPIwHw2TmHuguTz461fMjcZRMopQCotvE
	 iHDLdfkJBs5hEFIUkgpuWZ06d1/8XmDBrzt6n2Fo+DelAApT9v2Ofgqb61eFxbAzPxBwE
	 HQP2AE80oyo0AU6Zbsdo/Dlb9Db+w3ZCKfNK4esHmfkmgMzlv8Kde1F2qN3mSB5s5sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=18z9lqwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D076606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=18z9lqwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E341F000C1;
	Wed,  4 Nov 2026 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805358;
	bh=6ZzMvzjEzRRjv/X8P1TCOBwNx99KN+VemUqebT2db9M=;
	h=Subject:To:Cc:From:Date;
	b=18z9lqwEsPIARbNqRDkqejUhb+nTRclBDr547eWr839w3cBRtHI45tg359r6UjvxT
	 hO76AKYtsFNkgzuvFXaV2+7xui2QirlI0V2o5eoQYekRj29vuL0hht8XmuwyuXuqHm
	 nHSWuV5CcC8nus5Dy/X97Ylk6Qh9l/fmKX1bYnHs=
Subject: FAILED: patch "[PATCH] xfs: allow softlimit with no hardlimit in quota scrub" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:15:43 +0100
Message-ID: <2026110443-mobile-krypton-9fb6@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 342c2e00b3a99099a7088f7b8c8f075670c603a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-mobile-krypton-9fb6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

