Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814579;
	b=SyucR1I/BEkcanaMriKECOT/ZTXWxq471SCnIFFBsB8Z8OcNdlTV2QfUez1PRz0ZfT9/
	 KzRuumNE4ZYPEgTOAPh8ahhJKvZg6ZlDNKO1tsds4CGlqq28d8HK6HwEIafUf9D4b+Tcs
	 5JrcJy3ufIzj+7/KRt7mS9eD7+fRFCBzCo6mcannoQtn16+TCn2MuRGr5+1CEEUrg6eFQ
	 yezAXrs/BSo5NpyQIV4y4RwSvDkPVKtoCvMNWdyIMkDamF0ELq3xiG/vwzmar76C10o64
	 Q4WhV1LRL5qDu+v4PmjfGitUZlHVdxpm5o4jseHiFSHylleSaAg6bv+TBLLssZfT1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814579;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hWM23aLamj+fIn7xLW6xpdwpDpozU/AEGYHkCWFn2Nw=;
	b=4UNfHVsHD5bkuDInE7VgvI62miMttD5JUNiUcWEHUjhMy7dYkpaYSB0Sh7jOSBVlLxuz
	 f4EHSuwyzNazYA9ocMuChXah4IVeqKbKHB2D7Uk4sDYofOtSleof9I8wds4Y7J2D8FDo7
	 pYFZiz0wNGGajE4FQrhMLuPEgWSw3s38KKdZ5T0ungWRADYF/VBih+JeexPbPw8R70DHx
	 X/Atvih1xCi0k6iC9oUVqndLnkjN1bnYz8aIvMNozpJ4sF/koE6XQYSDsT4GgQ2M/Jb7g
	 uZlrMWlFS+bkoI6jdYL0183FdbgNU5N0ca2S/mQyy81RfXbscuKanovkcSTbA28GpgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="pj/EYRMY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547C6082BE1
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pj/EYRMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54A1F000C1;
	Wed,  4 Nov 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814578;
	bh=hWM23aLamj+fIn7xLW6xpdwpDpozU/AEGYHkCWFn2Nw=;
	h=Subject:To:Cc:From:Date;
	b=pj/EYRMY63DNN6tBGJ13/e5qCF0e5HjT4mbnkK0te8V2LwqpAW/ZkjoU++t3G5p1o
	 jz/Xrdkl+v649bvIjwcHiCvlthVLvFfF6qkrZ1lTfO54I3MG4cNB1+DjpGRN1umYiN
	 PMAsh15RvdynlP0qSeQu0oPk387uyWgbRXaAupuM=
Subject: FAILED: patch "[PATCH] xfs: don't try to repair rtsummary if the summary file isn't" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:49:35 -0500
Message-ID: <2026110435-aptly-equity-6de0@gregkh>
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
git cherry-pick -x 6e82b7641889ad0198f3bf17a5e4c6fe7aab0850
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110435-aptly-equity-6de0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e82b7641889ad0198f3bf17a5e4c6fe7aab0850 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:09:22 -0700
Subject: [PATCH] xfs: don't try to repair rtsummary if the summary file isn't
 computed

LOLLM observed that we can erroneously try to repair the rtsummary file
if we've not yet computed its contents.  That results in a corrupt
summary file, so let's add a flag to track whether or not the incore
data is complete.

Cc: stable@vger.kernel.org # v6.10
Fixes: abf039e2e4afde ("xfs: online repair of realtime summaries")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index 546b335ade13..fa358746beaf 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -212,13 +212,20 @@ xchk_rtsum_compute(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_rtgroup	*rtg = sc->sr.rtg;
+	struct xchk_rtsummary	*rts = sc->buf;
+	int			error;
 
 	/* If the bitmap size doesn't match the computed size, bail. */
 	if (XFS_FSB_TO_B(mp, xfs_rtbitmap_blockcount(mp)) !=
 	    rtg_bitmap(rtg)->i_disk_size)
 		return -EFSCORRUPTED;
 
-	return xfs_rtalloc_query_all(rtg, sc->tp, xchk_rtsum_record_free, sc);
+	error = xfs_rtalloc_query_all(rtg, sc->tp, xchk_rtsum_record_free, sc);
+	if (error)
+		return error;
+
+	rts->summary_computed = true;
+	return 0;
 }
 
 /* Compare the rtsummary file against the one we computed. */
diff --git a/fs/xfs/scrub/rtsummary.h b/fs/xfs/scrub/rtsummary.h
index e44b04cb6e2d..af1ab64c3f21 100644
--- a/fs/xfs/scrub/rtsummary.h
+++ b/fs/xfs/scrub/rtsummary.h
@@ -17,6 +17,7 @@ struct xchk_rtsummary {
 	xfs_filblks_t		rsumblocks;
 	unsigned int		rsumlevels;
 	unsigned int		resblks;
+	bool			summary_computed;
 
 	/* suminfo position of xfile as we write buffers to disk. */
 	xfs_rtsumoff_t		prep_wordoff;
diff --git a/fs/xfs/scrub/rtsummary_repair.c b/fs/xfs/scrub/rtsummary_repair.c
index e91dbad25d6d..1aa5e8162693 100644
--- a/fs/xfs/scrub/rtsummary_repair.c
+++ b/fs/xfs/scrub/rtsummary_repair.c
@@ -109,7 +109,7 @@ xrep_rtsummary(
 		return -EOPNOTSUPP;
 
 	/* Walk away if we disagree on the size of the rt bitmap. */
-	if (rts->rbmblocks != mp->m_sb.sb_rbmblocks)
+	if (rts->rbmblocks != mp->m_sb.sb_rbmblocks || !rts->summary_computed)
 		return 0;
 
 	/* Make sure any problems with the fork are fixed. */

