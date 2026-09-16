Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1B4C33CA
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579556; cv=none; b=X/IUBBBumuu+jGhnGnGxGoKLof4bvnnNqG7TdJDAdx5hjAHL5q41o7VB40pRE7WRNAmVEfxSP4FIkg6hODD3KGUUikBv9Tm2lVwxfrnh2t8nt5JLTn8FYI/vXLEAM29/PQ1WwdL7XvipEjkFJOZN58pWxb0toVB9tXHN+V6HqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579556; c=relaxed/simple;
	bh=YiqLhzgpg+5/Ow5AKZShWoNX17+t4SF4sateg6to8vA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lc1bK0fLuCMiSopYu8c1FiEUZ7cLmON9qFjbNZI3+EiMoSd4NhzmxQrk2bNYHNBPlynuzRBtKcvvTuv82kaBIswCqXxIhIInxVzjNvuLsMkxjNHEmXNpOWrYxfUsDj9pUf//f0fLt+FUhYrWgWM1Cis1jJ3i0wQ3W9o4swWr4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OzqV6oST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OzqV6oST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2440D1F000FF;
	Wed, 16 Sep 2026 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579554;
	bh=mruKP8ZXvNaFw0zioXXqJ2HZaAIVOhTsCdZsQJOnn+0=;
	h=Subject:To:Cc:From:Date;
	b=OzqV6oSTA92WDcIYOiPlMQA4/n0qCcaFkSaEQLx5mvLjYvUevzbsGcqAeZM52BEdi
	 cZUb6j4ZGgNRU7RJGHD3te6O2Dv9L6FedoxXg+dDejH3gu1NMXD2MK5d+Ho568tmbJ
	 NGoW9k5nMZyQTIK3zMqZUdfwDjLuM1Dxd+Zi9gJ0=
Subject: FAILED: patch "[PATCH] xfs: strengthen the "is cow staging" helpers in scrub" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:21:08 +0100
Message-ID: <2026091608-femur-diaper-50fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0d43368844a75ad13561a1198a3b027940730756
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091608-femur-diaper-50fe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

