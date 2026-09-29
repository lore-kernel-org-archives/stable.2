Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB6516174
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683126; cv=none; b=e7DVuc3ntQfCe1eqruQZTMzVA5KQiLs9m8e1ji+hKQJQGySJ+A9RaJ5F+exOvTdChI6DmMQOAULz9HH5QVQdxJPWOiNLVbatn4C2IDcPOb9CZnU+WtToDpU1viURbw/VlupNkKvsSQZK0RLrKC4W8wMlEzF/FQ0RnXFe3EaRTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683126; c=relaxed/simple;
	bh=Oo3qdVp6IR/TWe5lHuHqwOjFfFZqqo/qEQfvIvpZHjQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BlXXhdvRPEAADhd3r6/0f8EUmCdAxjSQxFQYTydLbEAYJXcb6R1vIHzsY8G3QG6XkXWhmUj3nU4lEK0amkVDkdZVkHZda2jOotoeA+TwzDInLZegY0lB3BEsTHV6EiVZKkRdt6Tuvjoq3k+yHNADt5VdxBIhCpuB4WAQmJmFhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Whs2uSsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Whs2uSsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F71F000FF;
	Tue, 29 Sep 2026 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790683124;
	bh=helD3UfN0dd6FQ3cPinoe8S+W7UiuuUASbHwaYYkHR4=;
	h=Subject:To:Cc:From:Date;
	b=Whs2uSsh9RNkzfKwQnBPqlTCaRpYtAnWFzP8JSyZSUUTjX88JXqGSHeqbjLcrP6P/
	 torYGWwJaX3vXavCsFiCrGJkoXl1QzWilXPoL396Ft+b79ZIzFpLSaxdmux3A3UhqV
	 5cfDksNB7Jt9ek7DsxPzYx81CgucY6Nm/mMiHF2E=
Subject: FAILED: patch "[PATCH] xfs: don't let memory failures leak blocks and kill repairs" failed to apply to 6.18-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:58:28 +0200
Message-ID: <2026092928-daydream-aroma-1dc5@gregkh>
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
git cherry-pick -x ab1c416d2377cdc16123ef521aac4da1c468c3d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092928-daydream-aroma-1dc5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab1c416d2377cdc16123ef521aac4da1c468c3d4 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 14 Sep 2026 22:37:52 -0700
Subject: [PATCH] xfs: don't let memory failures leak blocks and kill repairs

LOLLM complains that a memory allocation failure in
xrep_newbt_add_blocks results in online repair leaking blocks that were
previously allocated to write a new btree, but the problem is worse than
that -- a limitation of the codebase is that the callers cannot undo the
transaction /and/ return the error -- either you undo all changes and
commit the transaction, or you error out and the filesystem goes down.

However, the new btree space reservation object isn't that big (~48
bytes).  Let's just do a NOFAIL allocation and the problem goes away.

Cc: stable@vger.kernel.org # v6.8
Fixes: be408417630427 ("xfs: implement block reservation accounting for btrees we're staging")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index c82f4631fd9c..584076b2a6ee 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -193,9 +193,11 @@ xrep_newbt_add_blocks(
 	struct xrep_newbt_resv		*resv;
 	int				error;
 
-	resv = kmalloc_obj(struct xrep_newbt_resv, XCHK_GFP_FLAGS);
-	if (!resv)
-		return -ENOMEM;
+	/*
+	 * We have no way to clean up the allocated space *and* return an
+	 * ENOMEM if we fail to allocate this control structure.
+	 */
+	resv = kmalloc_obj(struct xrep_newbt_resv, GFP_KERNEL | __GFP_NOFAIL);
 
 	INIT_LIST_HEAD(&resv->list);
 	resv->agbno = XFS_FSB_TO_AGBNO(mp, args->fsbno);

