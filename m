Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895853;
	b=yXDrF2ZYgHtFV8VC/QQKFCfpr3EcjupHCiTe7SZ8pLGIbD1rmap0wTIepBBRJ/CAmq4d
	 pxuMezACE6AWVxei3lNm8X05xYpbEW3GvEBj44Ba4RGtXOwKAURNEFPMYjN35aTjb/fyJ
	 YVLc8LXHcwhv6WySH/BVF6MniWdC3qCGx5OqQ9Uut+YgCcB56OuNqMDfzkukZzMU4hS1y
	 RVbgp4JuDKpPjDMeyIWXeh+PA0wffPgDnUT9d5vdjxUQ8WM9Uc9fs5nmOFmRU8A20Nycy
	 hcD56Z8N4QOoRQ0TL9izcCcgVS0eqfBUL5bYZbgFSrP3UawSQJ1eDZxTJdeug/djsAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rtCxNm0BvJF0nq9UQsE53Lx7HVPXgjd4T0CyCl07cqo=;
	b=rExgTCtLQBy0pf81vDJgg1j0CTwHhILbVT7miL6Qhtx1kmHcRZ5WEl0Zq3cIeXDl2ia6
	 nBDfHDi/gyZZzJKLNAkdO0oZfK7SSrC6riBJdZLK5iwrkNEtJFYim8QAfu6gD3XfogUvf
	 3JDlH8mwi2b8TlSLrQdmZNKlvq+jby5NaC0CBKjFKI5XqJJTdoQkfsPBIsR6HWiHmFoO8
	 aIOW4wNb4o7/O6EEQtrBWxHxbQftIjbQGRz+nsAu+mfXutDJdePNZzhhAaliAQpiNzvPe
	 wZsuPyi4VNvy0KZJ9ZhdjImALfu03q6nKijnzdJtB4TkUnNdsgExdJ60y4ZODPT/ADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PS93amG6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF1606A332
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PS93amG6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874F61F00919;
	Thu,  5 Nov 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895853;
	bh=rtCxNm0BvJF0nq9UQsE53Lx7HVPXgjd4T0CyCl07cqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PS93amG6ThdlR+595l59CFjN/e3t5iIEDmtbqQrZKT5bkWbkOKaeVt6spy+HfXL8R
	 RRbpd1efIU+XJRiwwYxkHfJrYGK3w26dwBygoxMqfAGA937PzN5CaSvvqBr2vqEl4u
	 86COYYZR+OA5DPQ2nW1i5j07BR288nHroT/9f0Wlv+IPXQMoQFH6R4xDGnL4T3t9gc
	 WDet51MhPDCcl8Kc1OZOXwnLeRgrS29FJoda+/snh3Tf0g2pT0T2zHvIJjPFaIWHPZ
	 klxyr8NjmASdXNkBsNTYBvLTxtG/xZeiPWB8+UG3CFqh89xnCjCvbE5ymhmluA4M+D
	 gPqajR3jhV3zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: reattach dquots after changing inode ids
Date: Thu,  5 Nov 2026 11:24:11 -0500
Message-ID: <20261105162315.2070764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-plot-stainable-802b@gregkh>
References: <2026110407-plot-stainable-802b@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 2f528e4a8f89daa6d0cc64b044f6f94c018fe9ae ]

LOLLM noticed that xrep_inode_ids can change the user, group, or project
id of any given file.  When this happens, we need to detach any existing
incore dquot and attach the correct ones.

Cc: stable@vger.kernel.org # v6.8
Fixes: 2d295fe65776d1 ("xfs: repair inode records")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted quota attachment for missing metadata-directory support and xfs_qm_dqget_inode() returning locked dquots ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/inode_repair.c | 132 +++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 6be4551bffbd3..fa84a2efee431 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -38,6 +38,8 @@
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
 #include "xfs_symlink_remote.h"
+#include "xfs_dquot_item.h"
+#include "xfs_dquot.h"
 #include "scrub/xfs_scrub.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
@@ -1570,6 +1572,20 @@ xrep_inode_ids(
 
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
@@ -1876,6 +1892,112 @@ xrep_inode_unlinked(
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
+		if (!xfs_qm_dqget_inode(sc->ip, type, true, dqp))
+			xfs_dqunlock(*dqp);
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
@@ -1930,5 +2052,13 @@ xrep_inode(
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
-- 
2.53.0

