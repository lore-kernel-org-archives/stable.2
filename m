Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C83955C9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118710; cv=none; b=Y82DR3XuCqEK1+ZTmzC52YrWIeF0TAw35QequqfK3b9NnuF53wRP7qdZ75rgJsSux9Jj3bbkOFa8ky7+FGzbwBUl1N8MnyRy8Iw1yLk1FS2ZqMMRM9NtQ0pwhyahnrOcktvRnvsaQXG0oXouDlLSzh8r/QLDMMRLGNDUa3UsR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118710; c=relaxed/simple;
	bh=XWamjMWq4bCiyRmDx5mTxnsTzc8Js/1PI+rWRsrqj/Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qAt4+KJ/0IrZuMwYouceWe9cu6A3FNRx4EbZEoiF/yCjMRykH2G8Zodtm2xXx8WHAg3wPe7ZZmv4tclWUgUcsBUS8Bw8psy2eIIzRcOB3nH11Q6c5akusTJgk2E7h29MyhzFuTPxMQbSL9UmTcea3yfwWT7bylVfigDvTRLwn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNbGyfkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNbGyfkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D01F000E9;
	Mon, 22 Jun 2026 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782118709;
	bh=1MvXxH0uMZnaoKAMqpJmdAieUJ7AvVaXmP4/icb4FvU=;
	h=Subject:To:Cc:From:Date;
	b=sNbGyfkW/X2YJNQq/bdE+etaUr12hV/wgP6u7pokPY7ispmwj5qw6H/OBg10vE/p5
	 tlmshhlp12aGujqFS8UdGlHjJhaLYJT9jaiq/OwIDQnDnZARyPCbpV1Sjp/oAnAFaf
	 hJcyjPu7jeU3WIRuQ99LNcUwIuPkupXgKZiqCIsI=
Subject: FAILED: patch "[PATCH] fuse: re-lock request before replacing page cache folio" failed to apply to 5.10-stable tree
To: joannelkoong@gmail.com,llfamsec@gmail.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jun 2026 10:58:32 +0200
Message-ID: <2026062232-saga-pyramid-4c00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a078484921052d0badd827fcc2770b5cfc1d4120
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062232-saga-pyramid-4c00@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a078484921052d0badd827fcc2770b5cfc1d4120 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 18 May 2026 22:28:06 -0700
Subject: [PATCH] fuse: re-lock request before replacing page cache folio

fuse_try_move_folio() unlocks the request on entry but does not
re-lock it on the success path. This means fuse_chan_abort() can end the
request and free the fuse_io_args (eg fuse_readpages_end()) while the
subsequent copy chain logic after fuse_try_move_folio() accesses the
fuse_io_args, leading to use-after-free issues.

Fix this by calling lock_request() before replace_page_cache_folio().
This ensures the request is locked on the success path which will
prevent the fuse_io_args from being freed while the later copying logic
runs, and also ensures that the ap->folios[i]->mapping is never null
since ap->folios[i] will always point to the newfolio after
replace_page_cache_folio().

Fixes: ce534fb05292 ("fuse: allow splice to move pages")
Cc: stable@vger.kernel.org
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 05b6d15afe61..86b62a1d3746 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1037,6 +1037,10 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_folio(oldfolio, newfolio);
 
 	folio_get(newfolio);
@@ -1050,20 +1054,7 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*foliop = newfolio;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		folio_unlock(newfolio);
-		folio_put(newfolio);
-		goto out_put_old;
-	}
-
+	*foliop = newfolio;
 	folio_unlock(oldfolio);
 	/* Drop ref for ap->pages[] array */
 	folio_put(oldfolio);

