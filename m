Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D463DB96F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579811; cv=none; b=ozzR4dUGt8wuJ1VKS8R6lrqr/VgsLBXV4yJuVnOC/4Wu6MnwygZn/SfgaJy8iTfuLCkaOeEh8aoxCv9KKa1SpxK86+HjuVvPTjFidkTdQ2Cr3TaHyDEvB+7dUnPPOw5BASecl9chjHvOOIsxUk1YI0NDrzZDtfEqrDJF8Az7v/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579811; c=relaxed/simple;
	bh=MaJDMP65VSr2sgrQQj+S4a/wZCAV5KfswJv38nn0Ib8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LSV4bJiVNQdybfwt4EKrz44svkShqoydVa4K4NfpFA+49/+MR0IWx+nho6AL5kn40u7vNUEI5rmclykS0caeoRkbvIigb660rfxTPC1hezCr0aplkXpCU414bs1a/WqwiSfAuIWKoFBne0/YvTLNcBrVDL4ktjDRfdSZq/Hm+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFOZhTVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFOZhTVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694081F00893;
	Wed, 16 Sep 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579808;
	bh=c96uyAJ3QTSL5FeZl+HEsReyJ7XHyVZ81lnF+p3yK8Y=;
	h=Subject:To:Cc:From:Date;
	b=PFOZhTVfKmCROd4dgnKDrnd2DMkiVdpHAJWKFhfY54ZmRU5ifjzCi+5MBs10TNnx8
	 IRwTChsZjIEaBwPV0QLAmRq/m08LGTZQbYtlRwT1Vu0E0o0iO2YC/gteVZxy5ZhZUP
	 rslLSXhVeFVVnC6QEiBtyA8/HII83vzOqC8n1zoA=
Subject: FAILED: patch "[PATCH] xfs: don't stash removename operations with unknown ftype" failed to apply to 6.18-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:26:52 +0100
Message-ID: <2026091651-freedom-anger-bd4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 865b751e75039fc07838b3200f9740256653da9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091651-freedom-anger-bd4d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 865b751e75039fc07838b3200f9740256653da9a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Wed, 26 Aug 2026 22:31:25 -0700
Subject: [PATCH] xfs: don't stash removename operations with unknown ftype

LOLLM notices that the behavior of xrep_dir_replay_update changes based
on the ftype recorded in the stashed removename information.  It also
notices that the unlink iops sometimes set that ftype to FT_UNKNOWN
because the regular directory tree update code paths don't need to know
the ftype of the child.

Unfortunately, this results in incorrect link counts, which eventually
trips link count errors in later phases of xfs_scrub, or in xfs_repair.
Fix this by creating a second xfs_name with the type set correctly.

Cc: stable@vger.kernel.org # v6.10
Fixes: 8559b21a64d983 ("xfs: implement live updates for directory repairs")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 0c1224d05d57..31a23c5f386a 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1381,9 +1381,24 @@ xrep_dir_live_update(
 		if (p->delta > 0)
 			error = xrep_dir_stash_createname(rd, p->name,
 					I_INO(p->ip));
-		else
-			error = xrep_dir_stash_removename(rd, p->name,
+		else {
+			/*
+			 * xfs_dentry_to_name in unlink or rename-exchange can
+			 * pass us names with ftype FT_UNKNOWN, but we really
+			 * must know the ftype of the child that is being
+			 * removed so that we can do nlink updates correctly
+			 * without holding inode references.
+			 */
+			struct xfs_name	name = {
+				.name	= p->name->name,
+				.len	= p->name->len,
+				.type	= xfs_mode_to_ftype(
+						VFS_IC(p->ip)->i_mode),
+			};
+
+			error = xrep_dir_stash_removename(rd, &name,
 					I_INO(p->ip));
+		}
 		mutex_unlock(&rd->pscan.lock);
 		if (error)
 			goto out_abort;

