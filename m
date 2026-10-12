Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9EF48987F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808451; cv=none; b=u1HkUhHIKW75EhGXjBAnhG+aQGF8rxkbIuNit6Y+vmyyNdzEueYYVjEYQVSIdpBo7wP5VNMAnzouFMw99CIUCckM9eHmAR3eeM3GA/2o3rOiGX6Ngl8zj8yjY/wDZt56CFcUyzbPgf5iwkj4objIHm540W4SKg+i2m50uVL7JoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808451; c=relaxed/simple;
	bh=j9bhi831oRJgujr7iF3BXwEH4t/8+ZNTV6qsnyuLeDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMpD2Ij1OJnSl3E88kiAAQjt5GQEnAIRULxFFePPuF2jNTpbaQpY7AaAxmcGRzGEhvUQbBHmBUi7wSwArdZOk4akdXf/nvjjeh4nImTA/AnGo1Cck8Ujx9tXBOSS/hSpx4VhVgMKXBMYsp7k08uQ0dWzmsbegDuuCxf4kb4B098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ZVujDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ZVujDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D561F0089B;
	Mon, 12 Oct 2026 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791808449;
	bh=hw9CYmuMzAkcxNSSf3SWulDa+609lEew864wRhf8Tcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/ZVujDBE/cDTURWzRw6LTcrVUdcBPzA002ZTOhj5+XLTK1nn0ZSBhCDVVyx3H8Tv
	 GYKu7LUFuZX5KKJnWxLq1ZJO7UOBG/AFku7w8I2av3ARdSosgGtHDcFKNq7nyDqSbk
	 0XlAP0e8S9Z/Xo3Lkoyfg3fZDr7nybiWLnTH2jRgKxkUQXot/5cPqt7hXGFbhpCipl
	 wDImK3GADoz2xIqCfGPVQYLl8GoJtZYNOtplutGc5CY31HosiOhffxvwO+qkKAwATP
	 0rFVecWErnbWUIXPRp0EuC28apaLV0e33SmJ3QiugG2fb8trGML5YHilt8nmMJzOpe
	 0g+5Tjw+w3Zxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] xfs: stop exchanging reflink flags when exchanging mappings
Date: Mon, 12 Oct 2026 08:34:07 -0400
Message-ID: <20261012123238.4187874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101228-supplier-casket-ceca@gregkh>
References: <2026101228-supplier-casket-ceca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit d84d6c1a7f1e2de9e601703a326a4c1b7b421943 ]

When an exchange covers both files from offset 0 to i_disk_size,
xmi_can_exchange_reflink_flags() assumes every mapping moved and hands
the reflink flag over to the other file.

That assumption is wrong.  A file can still own shared blocks past
i_disk_size, e.g. after EXCHANGE_RANGE_TO_EOF sets a smaller size
without unmapping anything.  The flag is cleared anyway, and the next
write to such a block happens in place instead of CoW, corrupting the
other file that shares it.

Commit a23eca88448e ("xfs: fix exchange-range reflink flag clearing
issue with INO1_WRITTEN") fixed one instance of this.  Rather than add
another special case, stop moving the flags.
xfs_exchmaps_ensure_reflink() already sets the flag on both inodes
before the exchange, so both just keep it.

Nothing sets CLEAR_INO{1,2}_REFLINK anymore.  Intents logged by older
kernels may still carry them; recovery already masks them off, so they
stay in the log format mask and are ignored.

XFS_IOC_SWAPEXT has the same problem: it moves the reflink flag from
one inode to the other along with the extents.  Just removing that is
not enough here: the exchange path flags both inodes up front in
xfs_exchmaps_ensure_reflink(), but swapext has no such step, so the
inode receiving the shared extents would be left without the flag.
Set it on both inodes instead, and make sure both have a CoW fork,
since an inode with the reflink flag is expected to have one.

The flag now stays until FALLOC_FL_UNSHARE_RANGE, xfs_scrub, or a
truncate to zero removes it.

Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
Fixes: f0bc4d134b46 ("xfs: swap inode reflink flags when swapping inode extents")
Cc: stable@vger.kernel.org # v6.10
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Removed an extra duplicate INO1_WRITTEN guard when deleting xmi_can_exchange_reflink_flags(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_exchmaps.c   | 90 ++--------------------------------
 fs/xfs/libxfs/xfs_log_format.h |  4 +-
 fs/xfs/xfs_bmap_util.c         | 15 +++---
 3 files changed, 10 insertions(+), 99 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 49eda8d0994de..1e0b418ef7453 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -49,7 +49,7 @@ struct xfs_exchmaps_adjacent {
 	.right2 = { .br_startblock = HOLESTARTBLOCK }, \
 }
 
-/* Information to reset reflink flag / CoW fork state after an exchange. */
+/* Information to reset CoW fork state after an exchange. */
 
 /*
  * If the reflink flag is set on either inode, make sure it has an incore CoW
@@ -127,9 +127,7 @@ xmi_has_more_exchange_work(const struct xfs_exchmaps_intent *xmi)
 static inline bool
 xmi_has_postop_work(const struct xfs_exchmaps_intent *xmi)
 {
-	return xmi->xmi_flags & (XFS_EXCHMAPS_CLEAR_INO1_REFLINK |
-				 XFS_EXCHMAPS_CLEAR_INO2_REFLINK |
-				 __XFS_EXCHMAPS_INO2_SHORTFORM);
+	return xmi->xmi_flags & __XFS_EXCHMAPS_INO2_SHORTFORM;
 }
 
 /* Check all mappings to make sure we can actually exchange them. */
@@ -525,18 +523,6 @@ xfs_exchmaps_link_to_sf(
 	return error;
 }
 
-/* Clear the reflink flag after an exchange. */
-static inline void
-xfs_exchmaps_clear_reflink(
-	struct xfs_trans	*tp,
-	struct xfs_inode	*ip)
-{
-	trace_xfs_reflink_unset_inode_flag(ip);
-
-	ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-}
-
 /* Finish whatever work might come after an exchange operation. */
 static int
 xfs_exchmaps_do_postop_work(
@@ -557,16 +543,6 @@ xfs_exchmaps_do_postop_work(
 			return error;
 	}
 
-	if (xmi->xmi_flags & XFS_EXCHMAPS_CLEAR_INO1_REFLINK) {
-		xfs_exchmaps_clear_reflink(tp, xmi->xmi_ip1);
-		xmi->xmi_flags &= ~XFS_EXCHMAPS_CLEAR_INO1_REFLINK;
-	}
-
-	if (xmi->xmi_flags & XFS_EXCHMAPS_CLEAR_INO2_REFLINK) {
-		xfs_exchmaps_clear_reflink(tp, xmi->xmi_ip2);
-		xmi->xmi_flags &= ~XFS_EXCHMAPS_CLEAR_INO2_REFLINK;
-	}
-
 	return 0;
 }
 
@@ -948,56 +924,13 @@ xfs_exchmaps_intent_destroy_cache(void)
 }
 
 /*
- * Decide if we will exchange the reflink flags between the two files after the
- * exchange.  The only time we want to do this is if we're exchanging all
- * mappings under EOF and the inode reflink flags have different states.
+ * Allocate and initialize a new incore intent item from a request.
  */
-static inline bool
-xmi_can_exchange_reflink_flags(
-	const struct xfs_exchmaps_req	*req,
-	unsigned int			reflink_state)
-{
-	struct xfs_mount		*mp = req->ip1->i_mount;
-
-	/*
-	 * The INO1_WRITTEN optimization can skip exchanging hole and
-	 * unwritten mappings, which means we cannot guarantee that all
-	 * shared extents actually moved to the other file.  Clearing the
-	 * reflink flag of an inode that still holds shared extents breaks
-	 * the CoW write path, so refuse to exchange the flags in that case.
-	 */
-	if (req->flags & XFS_EXCHMAPS_INO1_WRITTEN)
-		return false;
-
-	/*
-	 * The INO1_WRITTEN optimization can skip exchanging hole and
-	 * unwritten mappings, which means we cannot guarantee that all
-	 * shared extents actually moved to the other file.  Clearing the
-	 * reflink flag of an inode that still holds shared extents breaks
-	 * the CoW write path, so refuse to exchange the flags in that case.
-	 */
-	if (req->flags & XFS_EXCHMAPS_INO1_WRITTEN)
-		return false;
-
-	if (hweight32(reflink_state) != 1)
-		return false;
-	if (req->startoff1 != 0 || req->startoff2 != 0)
-		return false;
-	if (req->blockcount != XFS_B_TO_FSB(mp, req->ip1->i_disk_size))
-		return false;
-	if (req->blockcount != XFS_B_TO_FSB(mp, req->ip2->i_disk_size))
-		return false;
-	return true;
-}
-
-
-/* Allocate and initialize a new incore intent item from a request. */
 struct xfs_exchmaps_intent *
 xfs_exchmaps_init_intent(
 	const struct xfs_exchmaps_req	*req)
 {
 	struct xfs_exchmaps_intent	*xmi;
-	unsigned int			rs = 0;
 
 	xmi = kmem_cache_zalloc(xfs_exchmaps_intent_cache,
 			GFP_NOFS | __GFP_NOFAIL);
@@ -1021,23 +954,6 @@ xfs_exchmaps_init_intent(
 		xmi->xmi_isize2 = req->ip1->i_disk_size;
 	}
 
-	/* Record the state of each inode's reflink flag before the op. */
-	if (xfs_is_reflink_inode(req->ip1))
-		rs |= 1;
-	if (xfs_is_reflink_inode(req->ip2))
-		rs |= 2;
-
-	/*
-	 * Figure out if we're clearing the reflink flags (which effectively
-	 * exchanges them) after the operation.
-	 */
-	if (xmi_can_exchange_reflink_flags(req, rs)) {
-		if (rs & 1)
-			xmi->xmi_flags |= XFS_EXCHMAPS_CLEAR_INO1_REFLINK;
-		if (rs & 2)
-			xmi->xmi_flags |= XFS_EXCHMAPS_CLEAR_INO2_REFLINK;
-	}
-
 	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode) ||
 	    S_ISLNK(VFS_I(xmi->xmi_ip2)->i_mode))
 		xmi->xmi_flags |= __XFS_EXCHMAPS_INO2_SHORTFORM;
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index a4e1b3eb425cd..6e620380d5dc8 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -927,10 +927,8 @@ struct xfs_xmi_log_format {
  */
 #define XFS_EXCHMAPS_INO1_WRITTEN	(1ULL << 2)
 
-/* Clear the reflink flag from inode1 after the operation. */
+/* No longer set, but older intents may carry them; keep them valid. */
 #define XFS_EXCHMAPS_CLEAR_INO1_REFLINK	(1ULL << 3)
-
-/* Clear the reflink flag from inode2 after the operation. */
 #define XFS_EXCHMAPS_CLEAR_INO2_REFLINK	(1ULL << 4)
 
 #define XFS_EXCHMAPS_LOGGED_FLAGS	(XFS_EXCHMAPS_ATTR_FORK | \
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index c88b9ade7389d..2ea6507678050 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1514,7 +1514,6 @@ xfs_swap_extents(
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
 	int			src_log_flags, target_log_flags;
 	int			error = 0;
-	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
 	struct timespec64	ctime, mtime;
@@ -1670,14 +1669,12 @@ xfs_swap_extents(
 	if (error)
 		goto out_trans_cancel;
 
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_diflags2 & XFS_DIFLAG2_REFLINK)) {
-		f = ip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 |= tip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 |= f & XFS_DIFLAG2_REFLINK;
+	/* Either inode may now own shared blocks; flag both, with CoW forks. */
+	if ((ip->i_diflags2 | tip->i_diflags2) & XFS_DIFLAG2_REFLINK) {
+		ip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
+		tip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
+		xfs_ifork_init_cow(ip);
+		xfs_ifork_init_cow(tip);
 	}
 
 	/* Swap the cow forks. */
-- 
2.53.0

