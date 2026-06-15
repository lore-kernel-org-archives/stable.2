Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4413F926D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534625; cv=none; b=b0TX/755oEE+AL7Z2hREIASRDWVvJpY0qFfLYMp2gCLzOxsNLWfj3zF88/xrfQtsNdcCP7qsFB+OpZzNiK8SkvJcooM+auxYp22xYCLQsD4zom96MxQFunBkb7Xu6yHXrmzzHk1POUG2CwU87pSPNdQkCBCa2c501lhgBoWHI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534625; c=relaxed/simple;
	bh=UbcWWDUH+MC697yIXYmwChYge8m8IPQtriRFU04qdgQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D7QoG0Vk0dg3QwKhaBZXFKAlWoe57Rs7C1xVUNb6fzHwxZaaihWRRQ58HkU3s8VaiflgHIcnyVE88r3YoaOkcaRkMNybFo8mSAuUsGmX5M4VDLRi9jGScFhSv4T2eVS/B2TzIEU3Sb9P+DOT3A0jsVrk7BS3PvA31gAccrUcIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sy/79eJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sy/79eJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4877E1F000E9;
	Mon, 15 Jun 2026 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534624;
	bh=stZt+V8z1ysnEwMlSy82QQCGSgXpC3Bry8mEm7TbKFo=;
	h=Subject:To:Cc:From:Date;
	b=Sy/79eJAOj3LRk3ifVipsR/sLwZnH6kNRDoQiFEL3phRtE74Ldsp0cA5dcs/Z6sFY
	 3q0sAiJdYuY49wKhI9+D/eBgZrSiaMUr2GRBpalbraqI4N0+JKtqecBmMt3uRTaxKI
	 AMDg6MH0581H7GgxYTYFqgfummof8JM1IerhWUOo=
Subject: FAILED: patch "[PATCH] xfs: fix error returns in CoW fork repair" failed to apply to 6.12-stable tree
To: gaoyingjie@uniontech.com,cem@kernel.org,djwong@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:28:44 +0200
Message-ID: <2026061544-strife-handwork-2622@gregkh>
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
git cherry-pick -x fcf4faba9f986b3bb528da11913c9ec5d6e8f689
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061544-strife-handwork-2622@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcf4faba9f986b3bb528da11913c9ec5d6e8f689 Mon Sep 17 00:00:00 2001
From: Yingjie Gao <gaoyingjie@uniontech.com>
Date: Wed, 27 May 2026 12:31:33 +0800
Subject: [PATCH] xfs: fix error returns in CoW fork repair

xrep_cow_find_bad() returns success after the cleanup labels even if
AG setup, btree queries, or bitmap updates failed. This can make
repair continue with an incomplete bad-file-offset bitmap instead of
stopping at the original error.

The force-rebuild path has a related cleanup problem. If
xrep_cow_mark_file_range() fails, the function returns directly and
skips the scrub AG context and perag cleanup.

Let the force-rebuild path fall through to the existing cleanup code
and return the saved error after cleanup.

Fixes: dbbdbd008632 ("xfs: repair problems in CoW forks")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index bffc4666ce60..a6ff09ace43d 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -300,18 +300,15 @@ xrep_cow_find_bad(
 	 * on the debugging knob, replace everything in the CoW fork.
 	 */
 	if ((sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
-	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR)) {
+	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR))
 		error = xrep_cow_mark_file_range(xc, xc->irec.br_startblock,
 				xc->irec.br_blockcount);
-		if (error)
-			return error;
-	}
 
 out_sa:
 	xchk_ag_free(sc, &sc->sa);
 out_pag:
 	xfs_perag_put(pag);
-	return 0;
+	return error;
 }
 
 /*

