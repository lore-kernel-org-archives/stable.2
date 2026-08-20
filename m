Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2C42A7BD
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226537; cv=none; b=dByN0hm0jNfbH3K8REpNj+P134YE4XdOtJcNmiEYegWG0X/SW8HjeaSV6H/RoB2szLVHS8VwvOIGza9wdhTQHUYuhKkaM1HmCwZTd48L36n9ra/KjAWuULSkKRgYlVCVDhSb46WWE8YXXsrDN4Cw70Pdb4kcSh8sSCFWadqaz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226537; c=relaxed/simple;
	bh=hZRQ7Qh5jb+QrY0UxejWf3h2M3XfLmjManRvxsOMZAM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FhVb78O9Nb9CW9qhLN3CzZozPwwTblLalUDrlwMbUdAk3Yh508G3urf6wVBSBqzJod3Xh7kXALBf6XOuI5rFs5Tf4odd0vgPCq8ryPTp80M+S4jZadUAZ7pjwj37+osrEQ+ExVxYafjey2YoPV18KviuCweuGHddur2Cjx7zsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfsH5Lc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfsH5Lc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86A01F000E9;
	Thu, 20 Aug 2026 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787226535;
	bh=Sy8xCBK8vgxCSAIgVBSHiu3fU7mCONhv/do6UCuROj4=;
	h=Subject:To:Cc:From:Date;
	b=sfsH5Lc6tOk0IpFrjnFUzE5lIkR6sYn3IRvPaUyPi6DGUnmTj/AReoWn3IRiAU+8C
	 HwneP11LXYVObzeIjMeT7pQCXuVmeUtWV/rxcH+drE1Ms/6nnMc6PrbDAtM4Hb9OVm
	 erRSYAg3ZlpZI/cduMl8mEBYPy0iBpreUjPK6Qzw=
Subject: FAILED: patch "[PATCH] xfs: don't ignore runtime errors in xrep_iunlink_reload_next" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:37:11 +0200
Message-ID: <2026082011-careless-penalize-eae8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 0052633527158b49762ab427e73924e4f8d25e6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082011-careless-penalize-eae8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0052633527158b49762ab427e73924e4f8d25e6c Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Sun, 26 Jul 2026 22:26:52 -0700
Subject: [PATCH] xfs: don't ignore runtime errors in xrep_iunlink_reload_next

LOLLM complained that this function ignores runtime errors being
returned by xrep_iunlink_store_*.  Rework the function signature so that
we can return runtime errors to abort the repair.

Cc: stable@vger.kernel.org # v6.10
Fixes: ab97f4b1c03075 ("xfs: repair AGI unlinked inode bucket lists")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index 4f1f235349c5..2104512f1ee1 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1041,31 +1041,40 @@ xrep_iunlink_next(
  * the chain or if we should stop walking the chain due to corruption; or a
  * per-AG inode number.
  */
-STATIC xfs_agino_t
+STATIC int
 xrep_iunlink_reload_next(
 	struct xrep_agi		*ragi,
 	xfs_agino_t		prev_agino,
-	xfs_agino_t		agino)
+	xfs_agino_t		agino,
+	xfs_agino_t		*next_agino)
 {
 	struct xfs_scrub	*sc = ragi->sc;
 	struct xfs_inode	*ip;
-	xfs_agino_t		ret = NULLAGINO;
 	int			error;
 
+	*next_agino = NULLAGINO;
+
 	error = xchk_iget(ragi->sc, xfs_agino_to_ino(sc->sa.pag, agino), &ip);
 	if (error)
-		return ret;
+		return 0;
 
 	trace_xrep_iunlink_reload_next(ip, prev_agino);
 
 	/* If this is a linked inode, stop processing the chain. */
 	if (VFS_I(ip)->i_nlink != 0) {
-		xrep_iunlink_store_next(ragi, agino, NULLAGINO);
+		error = xrep_iunlink_store_next(ragi, agino, NULLAGINO);
+		if (error)
+			return error;
+
+		error = xrep_iunlink_store_prev(ragi, agino, LINKED_AGINO);
+		if (error)
+			return error;
+
 		goto rele;
 	}
 
 	ip->i_prev_unlinked = prev_agino;
-	ret = ip->i_next_unlinked;
+	*next_agino = ip->i_next_unlinked;
 
 	/*
 	 * Drop the inode reference that we just took.  We hold the AGI, so
@@ -1074,7 +1083,7 @@ xrep_iunlink_reload_next(
 	 */
 rele:
 	xchk_irele(sc, ip);
-	return ret;
+	return 0;
 }
 
 /*
@@ -1114,9 +1123,12 @@ xrep_iunlink_walk_ondisk_bucket(
 			break;
 
 		next_agino = xrep_iunlink_next(sc, agino);
-		if (!next_agino)
-			next_agino = xrep_iunlink_reload_next(ragi, prev_agino,
-					agino);
+		if (!next_agino) {
+			error = xrep_iunlink_reload_next(ragi, prev_agino,
+					agino, &next_agino);
+			if (error)
+				break;
+		}
 
 		error = xagino_bitmap_set(&seen, agino, 1);
 		if (error)

