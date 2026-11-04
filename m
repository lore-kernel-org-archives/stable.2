Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814670;
	b=t57KPZYIcYEZWyXeLQJlN0DtmHV0TvDsSaqtk40NDYN4qsqYQe10Vw/k241Uw4L08pXF
	 HjbFmfo4w0xxDalnjsmCkoTZXhgBlXI9WP9STtk9tgVTV/8IJMk1T2mO2WLpuAp6BTA7C
	 Tvn+2CQTf2GxgqyUersMaHRIcStb5H3SY+UrxlPX3PcwSJyCmcZIZ6uPJdN5tRRMDMVQ0
	 rhy5obNEFhrBPdx5113P22th86T2Hd5ZkDWhmW8HqsRVBhCGR9xiOCb3RBadTqRalUos7
	 3g9i4frC6NqhJDawBPZdVIt9fiisED6Ew+TXcSHjfNCEFoEg8xNickV5EXZNHWJsn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814670;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v9EERdz7FeQU5qDvjo2VMSYsswzTNu+LjHkVAyhwpi4=;
	b=DH13jk7HX2EeJ+kYgPKqxr7nZT1qgNi4FuOVdXKgQ9YarumqGiK4XHpkrx5pbNcT22mO
	 /tWufBrA0GHsXUSzUDbnABsPcuG8U/Id6CfWRTX0ZV2BOEwhTYm1y11MECa2rO5UJxXCI
	 wvqmOudYwZFbkCcZ9JC+SE2jofIRG9AutHCK1Ex1rlS/8auTcY4D4H8r7sBXu4aEezomW
	 TkqmS7zG6LIsgvTQnLcqerZZ/diz9kcFkQjEPleXttbkFFZoHJ3WW38+Qv/5RmdU+v3m+
	 xRNJ+6GwxgNfCCM8yRLRk4eG+ljWRD36KNjgNy7pfMSmxmdKt/aVmB7+DS9rzGSL43Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LzwYUTx2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E0606A33B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LzwYUTx2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1611F00A02;
	Wed,  4 Nov 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814670;
	bh=v9EERdz7FeQU5qDvjo2VMSYsswzTNu+LjHkVAyhwpi4=;
	h=Subject:To:Cc:From:Date;
	b=LzwYUTx2APDtUjZjRlYMMA2MWzQVG+Lpzohd6OmiA+KWXomCq7y14nKqwY/5ZQ2fu
	 k9wla9RfSe3TC9iVBcnNTCksoUUSWX7K1Wfq99nc68hWDrnwpgodX+TDA+8O2Q5iB/
	 kYJJalDtMOb0D5PcYZDVGXJrXbUJ2gaxx8OOHaHQ=
Subject: FAILED: patch "[PATCH] xfs: reattach dquots after changing inode ids" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:07 -0500
Message-ID: <2026110407-plot-stainable-802b@gregkh>
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
git cherry-pick -x 2f528e4a8f89daa6d0cc64b044f6f94c018fe9ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110407-plot-stainable-802b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f528e4a8f89daa6d0cc64b044f6f94c018fe9ae Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 08:21:22 -0700
Subject: [PATCH] xfs: reattach dquots after changing inode ids

LOLLM noticed that xrep_inode_ids can change the user, group, or project
id of any given file.  When this happens, we need to detach any existing
incore dquot and attach the correct ones.

Cc: stable@vger.kernel.org # v6.8
Fixes: 2d295fe65776d1 ("xfs: repair inode records")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index e1a7a2729b47..c81dfb0485e2 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -41,6 +41,8 @@
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
+#include "xfs_dquot_item.h"
+#include "xfs_dquot.h"
 #include "scrub/xfs_scrub.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
@@ -1757,6 +1759,20 @@ xrep_inode_ids(
 
 	trace_xrep_inode_ids(sc);
 
+	/*
+	 * We changed one of the file IDs, so we must detach the dquots to
+	 * prevent further changes from being accounted to them, and try to
+	 * attach the dquot for the new id to absorb any other block usage
+	 * changes.  We can't do that right now because the existing dquots
+	 * might be attached to the scrub transaction and we're in the middle
+	 * of fixing the inode, so we'll switch the incore dquot pointers
+	 * later.
+	 *
+	 * Schedule a quotacheck so the accounting discrepancies will get fixed
+	 * eventually.  We'll have to repeat this later when we do the actual
+	 * switch.
+	 */
+
 	if (!uid_valid(VFS_I(sc->ip)->i_uid)) {
 		i_uid_write(VFS_I(sc->ip), 0);
 		dirty = true;
@@ -2066,6 +2082,113 @@ xrep_inode_unlinked(
 	return 0;
 }
 
+#ifdef CONFIG_XFS_QUOTA
+static inline bool
+xrep_inode_need_reset_dquots(
+	struct xfs_scrub	*sc)
+{
+	struct xfs_mount	*mp = sc->mp;
+	struct xfs_inode	*ip = sc->ip;
+
+	if (!XFS_IS_QUOTA_ON(mp))
+		return false;
+	if (xfs_is_quota_inode(&mp->m_sb, I_INO(ip)))
+		return false;
+	if (xfs_is_metadir_inode(ip))
+		return false;
+
+	if (XFS_IS_UQUOTA_ON(sc->mp) &&
+	    (!ip->i_udquot || ip->i_udquot->q_id != i_uid_read(VFS_I(ip))))
+		return true;
+	if (XFS_IS_GQUOTA_ON(sc->mp) &&
+	    (!ip->i_gdquot || ip->i_gdquot->q_id != i_gid_read(VFS_I(ip))))
+		return true;
+	if (XFS_IS_PQUOTA_ON(sc->mp) &&
+	    (!ip->i_pdquot || ip->i_pdquot->q_id != ip->i_projid))
+		return true;
+
+	return false;
+}
+
+/* Switch dquot, return dqtype if we need quotacheck */
+static xfs_dqtype_t
+xrep_inode_switch_dquot(
+	struct xfs_scrub	*sc,
+	xfs_dqtype_t		type,
+	struct xfs_dquot	**dqp)
+{
+	xfs_dqtype_t		ret = 0;
+	xfs_dqid_t		id = xfs_qm_id_for_quotatype(sc->ip, type);
+
+	if (*dqp != NULL && (*dqp)->q_id != id) {
+		xfs_qm_dqrele(*dqp);
+		*dqp = NULL;
+	}
+
+	if (!*dqp) {
+		xfs_qm_dqget_inode(sc->ip, type, true, dqp);
+		ret = type;
+	}
+	return ret;
+}
+
+static int
+xrep_inode_reset_dquots(
+	struct xfs_scrub	*sc)
+{
+	xfs_dqtype_t		need = 0;
+	int			error;
+
+	/*
+	 * If we changed the file IDs, then we need to drop the transaction so
+	 * that we can detach the dquots and attach new ones.
+	 *
+	 * Commit the scrub transaction so that there are no dangling
+	 * references to any dquots that might get detached, and retain the
+	 * ILOCK, as required by the dqattach code.
+	 *
+	 * Note that dqattach can cycle the ILOCK when creating a new dquot, so
+	 * this must be the very last thing that the repair function does.
+	 */
+	error = xrep_trans_commit(sc);
+	if (error)
+		return error;
+
+	if (XFS_IS_UQUOTA_ON(sc->mp))
+		need |= xrep_inode_switch_dquot(sc, XFS_DQTYPE_USER,
+				&sc->ip->i_udquot);
+	if (XFS_IS_GQUOTA_ON(sc->mp))
+		need |= xrep_inode_switch_dquot(sc, XFS_DQTYPE_GROUP,
+				&sc->ip->i_gdquot);
+	if (XFS_IS_PQUOTA_ON(sc->mp))
+		need |= xrep_inode_switch_dquot(sc, XFS_DQTYPE_PROJ,
+				&sc->ip->i_pdquot);
+
+	xchk_iunlock(sc, XFS_ILOCK_EXCL);
+
+	/*
+	 * Now that we've updated the dquots, force quotacheck once again.
+	 * In theory we could be racing against a concurrent quotacheck.
+	 * Note that we can't hold the ILOCK when allocating a transaction.
+	 */
+	error = xchk_trans_alloc(sc, 0);
+	if (error)
+		return error;
+
+	if (need & XFS_DQTYPE_USER)
+		xrep_force_quotacheck(sc, XFS_DQTYPE_USER);
+	if (need & XFS_DQTYPE_GROUP)
+		xrep_force_quotacheck(sc, XFS_DQTYPE_GROUP);
+	if (need & XFS_DQTYPE_PROJ)
+		xrep_force_quotacheck(sc, XFS_DQTYPE_PROJ);
+
+	return 0;
+}
+#else
+# define xrep_inode_need_reset_dquots(sc)	(false)
+# define xrep_inode_reset_dquots(sc)		(0)
+#endif
+
 /* Repair an inode's fields. */
 int
 xrep_inode(
@@ -2120,5 +2243,13 @@ xrep_inode(
 	if (error)
 		return error;
 
-	return xrep_defer_finish(sc);
+	error = xrep_defer_finish(sc);
+	if (error)
+		return error;
+
+	/* Must come last */
+	if (xrep_inode_need_reset_dquots(sc))
+		return xrep_inode_reset_dquots(sc);
+
+	return 0;
 }

