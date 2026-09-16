Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B0442B38
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579559; cv=none; b=b8OxlE/M/M2Za9qXoDvsUfESw4UaYyu513x8JE1iKeAFqQO42JIJp3qYvuB7kWsmdpGpiM1WpQhDHEdD8GtfMd/W543DSkHgRKh7CNwbyXyPCBu2Tj5Z7sZrTXd2mzZ8kwYijGQH1Fs776v7Kk3/EzMQVZODkEWjxV+BJpHi2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579559; c=relaxed/simple;
	bh=D0Ii1ent1y9KN6vMaG1eXsWc4CQ2NpyB5YTaHrJmFnM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B34rARDf41aEMzmJqY+vHima+LLAqQRZV2xGxP96MeSxSgkSe+fXHRaKlSXP1sWRL/FA7JfKiZX0PQ0evTxqEAFh+L2RiNXjBpy/AXXBlc/jkr+GF389+dEGcsp2kaQTNviRXX+CsPJ96+C8s5zOyZZXLpnsY8FswCb6mPThzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sr1R75cI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sr1R75cI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B601F000FF;
	Wed, 16 Sep 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579557;
	bh=1rgTQk9j1GzgMsOhw5+0iqbqUgVvvSMYPHkA/YXrBuc=;
	h=Subject:To:Cc:From:Date;
	b=sr1R75cI2Z89sKyukqacOzhz6OIbhqdH/1nUhSUyGdRjwM3TTpt+XLSuO+Bq1gbHB
	 gzhcOpitYhO34tGASroB8UYNcPtScJAFaLGkaammPogO01O4DyiQh/6nsBbV7FSzKD
	 hLYBUUnUwvUiyQjuhbo1reowrwCkVBXRM0lzJgSY=
Subject: FAILED: patch "[PATCH] xfs: strengthen the "is cow staging" helpers in scrub" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:21:09 +0100
Message-ID: <2026091609-tables-doodle-600b@gregkh>
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
git cherry-pick -x 0d43368844a75ad13561a1198a3b027940730756
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091609-tables-doodle-600b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d43368844a75ad13561a1198a3b027940730756 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Wed, 2 Sep 2026 22:51:36 -0700
Subject: [PATCH] xfs: strengthen the "is cow staging" helpers in scrub

LOLLM pointed out a bug in both of the refcount scrub predicates that
determine if a range of blocks is marked as CoW staging in the btree.
While it compares blockcount < len, this isn't enough to determine that
the CoW staging record is at least as large as the range passed into the
helper.  Fix both of them.

Cc: stable@vger.kernel.org # v4.16
Fixes: f6d5fc21fdc713 ("xfs: cross-reference refcount btree during scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index f2addaf13c58..f8c51d8fbb3d 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -581,8 +581,12 @@ xchk_xref_is_cow_staging(
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 
+	/* Can't start after bno */
+	if (rc.rc_startblock > agbno)
+		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
+
 	/* Must be at least as long as what was passed in */
-	if (rc.rc_blockcount < len)
+	if (rc.rc_startblock + rc.rc_blockcount < agbno + len)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 }
 
diff --git a/fs/xfs/scrub/rtrefcount.c b/fs/xfs/scrub/rtrefcount.c
index a024d50cf9d2..652d6b78b7a0 100644
--- a/fs/xfs/scrub/rtrefcount.c
+++ b/fs/xfs/scrub/rtrefcount.c
@@ -609,8 +609,12 @@ xchk_xref_is_rt_cow_staging(
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
 		xchk_btree_xref_set_corrupt(sc, sc->sr.refc_cur, 0);
 
+	/* Can't start after bno */
+	if (rc.rc_startblock > bno)
+		xchk_btree_xref_set_corrupt(sc, sc->sr.refc_cur, 0);
+
 	/* Must be at least as long as what was passed in */
-	if (rc.rc_blockcount < len)
+	if (rc.rc_startblock + rc.rc_blockcount < bno + len)
 		xchk_btree_xref_set_corrupt(sc, sc->sr.refc_cur, 0);
 }
 

