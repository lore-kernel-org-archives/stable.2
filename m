Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814516;
	b=OB1sWngZ6UVAO8vnSnDo7jdFKh5z0G3Zv7M9B9KfdOCyIDaGEZDFXdW0fMoFGUy4JLS0
	 JjUX1Chf5tZiRkLcEiryi9Ez9WVcKAkDfKDiGRJ2KHrpZslxR8QUbuJ1gRMtElx3QBd+U
	 mcT/N+67bzGpD/64zEOOYHUX8Gl6J0UahNBxrrDx2iC089zSvOVxSr/Xe1XlP19TrffHc
	 LSU+cTulCDp38dykgITihjDVnFgWsIOs/yMo2Qb5F5MHyxktlaV3x531Xk3wSwOmHNGqg
	 5CpC7tVZzmyaGOxE4BaveWL1XNtU/zTFCvj043S0j3Es43lTtRHgoNxGX6r5Hxjk8Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814516;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gK3inmwJ9F6roorlw+kYsEDsGpAT0aLo9lWTOTF0Tmw=;
	b=B1Z+niYTldhgA8bgPMRfmtnQZU1n19p20UuF5XclRTHxVyeEW4Se8zuegPbuz1ZfJeSF
	 d2vWvqlMyp+/0fL2yiBtVdMy/rTpx1DJd6PRCbwNVHsPMGhKMBFwXvintLI66y9Oz9aj7
	 Y+rpeK1gP/vzJrxh47Np/ilKCCOYAf3eHjZMJwwpF1JywqGbTY7thnEkTi8DsAFY3GrR5
	 AXiyDe6aULi1xzVDu1WM+Xt6FTaQR1j7+LpMOYZ0e4M5z5S2a+FSHSDZL9wMbfV9KTumd
	 JHCuXkVvp5uoKQtdCzmcPv+XZFHB7tVByTq6J5SSQWok2+S4kTEIq6JmCATOoS3P4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HibFf8sp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77F6082BFC
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HibFf8sp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D51F00A02;
	Wed,  4 Nov 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814515;
	bh=gK3inmwJ9F6roorlw+kYsEDsGpAT0aLo9lWTOTF0Tmw=;
	h=Subject:To:Cc:From:Date;
	b=HibFf8spUvDBr2xWXJEjIlxOJM69O51wqr/JAFqxRwOGssHKoz02bN+ueXnUggBEQ
	 efOeBrP513osuX/UA+zV97H95U9X+rUGlA43/fAEywH+cIJPXt6Mc3VwtGK0hFPoce
	 lYNprCJKsR5Xo0wK0GpNIENihA/fM49wS9FNT6W4=
Subject: FAILED: patch "[PATCH] xfs: complain loudly when dirtree checker finds broken links" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:48:33 -0500
Message-ID: <2026110432-statue-level-5b8e@gregkh>
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
git cherry-pick -x e09438cab72c2c6a32665829d4186155346bfee8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-statue-level-5b8e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e09438cab72c2c6a32665829d4186155346bfee8 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 08:23:43 -0700
Subject: [PATCH] xfs: complain loudly when dirtree checker finds broken links

LOLLM observed that the directory tree walk code bails out if it finds
broken parent pointers along the way.  However, it flattens the return
code to zero, which means that we can end up in the repair code having
not completed the scan.  We should never proceed with a repair in this
state, so let's mark the scrub incomplete and exit.

Cc: stable@vger.kernel.org # v6.10
Fixes: 928b721a11789a ("xfs: teach online scrub to find directory tree structure problems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index 887383d2e941..11a9dea03d87 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -860,7 +860,8 @@ xchk_dirtree_find_paths_to_root(
 				 * A parent pointer of @sc->ip is bad, don't
 				 * bother continuing.
 				 */
-				break;
+				xchk_set_incomplete(sc);
+				return error;
 			}
 			if (error == -ESTALE) {
 				/* This had better be an invalidation. */
@@ -981,6 +982,7 @@ xchk_dirtree(
 		 * parent pointers are corrupt; this scan cannot be completed
 		 * without full information.
 		 */
+		xchk_set_incomplete(sc);
 		xchk_ip_xref_set_corrupt(sc, sc->ip);
 		error = 0;
 		goto out_scanlock;

