Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814850;
	b=06qNlIatxPK/AVFC3M8Nf9Zzru3MpBLanjwomrfhWUPzfXz7R4I1Tl3btoH8pIrZo+3P
	 UwCZazDdimJrYjwp49f3RpT3tefgV1MfYtJrC+I97KBY5gmXGMulmtU7NXtFUKPWRSLQc
	 XLNUxIrJHN8XOZpADJjnwMme6gUyUYqcYtAHYIGnGLOwPtUnng06U65pN9LNUTQq12hJC
	 pf5KDYRxLC5g2OIxZ+V7RUk0J7jZ1IVXxupZUTDlcGwE0LoFJGVaKS1AFPaAz/eHciRnh
	 SB9lqVtbYB+pGFZBGzunfMtdLyvVEssWKJfTbai+ID2GCutD2VF0jooG0/iE9uzrvLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814850;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n/uzHJ91uwLRR1K9o1GWMwetZ4HHoKb/Vg/UPIb5OM0=;
	b=ohfJILZEKZ+6LjnGGd6V2jR3FncxjaWPE65pgWtTFEpDvkkYpxCXL/OMNATzzC6v5+U8
	 adigUT54lFsIHfsY3mmua1vokQx4m1o0HH3kXU2N3wFzMDhnvn8N2Azw/95HjxXzq2uvT
	 ut/IDaQbcqUgMWJtsb1d7VILtbi4pM2vE9xo9I72+ErxuydVy/Pp+KqWO8f39UdnLfQNj
	 6zaLK98gkZ2OxjRDOJv44Ciy1AVa/RkKqcFryLh01fYWNnc+4quQQrEN/rRQbUWSAyICp
	 zRLNeBeZyQtFW35rK/328DepmCvMvz5fPla5tbRfA4fEYOGpjoFAlWMNctVoCO2ujFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CPFVht+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF960756F5
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CPFVht+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D271F000C1;
	Wed,  4 Nov 2026 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814850;
	bh=n/uzHJ91uwLRR1K9o1GWMwetZ4HHoKb/Vg/UPIb5OM0=;
	h=Subject:To:Cc:From:Date;
	b=CPFVht+KnP4lDLp6nAK08Zi6uP3xphpQL1fxidDRthHeUMrBi+3XpRbmaXoZ2kf6F
	 DWUN6+0q8nYlWiF6fa6U45GsgQtsFewFsrfo7xLkVeIC3aVJQTJMqmh0TbO/eg4dzc
	 zFT3O9OfS4D7Rm16+r+Cq34lTI8RGULvAWowEvzM=
Subject: FAILED: patch "[PATCH] xfs: don't rescan ifree and icount when frozen" failed to apply to 5.15-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:53:43 -0500
Message-ID: <2026110443-evolve-chooser-fd21@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 18028768415e3c05ab7edb22d740e2f4dc52836a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-evolve-chooser-fd21@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18028768415e3c05ab7edb22d740e2f4dc52836a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:08:51 -0700
Subject: [PATCH] xfs: don't rescan ifree and icount when frozen

LOLLM points out that it's pointless to rescan the AGs if we've already
frozen the filesystem because there won't be any more perturbations.
Fix this to mark the scan incomplete and exit.

Cc: stable@vger.kernel.org # v5.2
Fixes: 75efa57d0bf5fc ("xfs: add online scrub for superblock counters")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index eb1a095a0fa9..5984fe13a973 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -379,6 +379,11 @@ xchk_fscount_aggregate_agcounts(
 	 * to maintain ifree <= icount before giving up.
 	 */
 	if (fsc->ifree > fsc->icount) {
+		if (fsc->frozen) {
+			xchk_set_incomplete(sc);
+			return -EFSCORRUPTED;
+		}
+
 		if (tries--)
 			goto retry;
 		return -EDEADLOCK;

