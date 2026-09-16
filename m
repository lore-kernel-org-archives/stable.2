Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE03C3F51
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579805; cv=none; b=NQ8Gmu6GROBOy4igGrRnEYQIy+EmnUoODuxVFHRroLuo8aL70OaVuvPKW0zY6whUmY4PqagU8T3VM56pmG93LeteKsVuea1aqO2RieB3Irawt4D3uxSgXO3HmDOj8BPnmPPZhrmFZgCsmYT0eio3x5h8SFgJDI4yr1QpPz0lzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579805; c=relaxed/simple;
	bh=8yJeNyJ2PAHoy2VmBzv2OSI8ujyGZmTdAx95C/e2+9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EBoh1U1Kg+hsLjih5SPTzHr33oZ66fUi6rVhNqtoa7AqsC1+/j5RrOx8pRdKtaWW5HS5024nDNPNrtHTVHSnTGrbicIqV0/w4NhXuK3+Cmjyrr9y7pvxfWuXFdUqcOvg5kRLhqBUAPv0h7EhUUpY6D4dWEzup7hqAD1enxrD680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3gCgSct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3gCgSct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAEC1F00893;
	Wed, 16 Sep 2026 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579802;
	bh=NUEfQOxbpIZ7p621XIYxLI5GfA2ZqpPClO3s+ggUSMk=;
	h=Subject:To:Cc:From:Date;
	b=d3gCgSct7uhuWXa5i3EF7BcZQCMKR6kePZrwhag3n+6Bp58+t/nXZwRB6262jOXWB
	 RhTTfxtdtp6szBhE125IpmdNAKoU4dbC3d50WiAifaKKJMZaGXG2R/PmvHO6ZJno0P
	 zgUc3mK0ni0kEo2+izdjbzzJ7KVwBVCflzRzlEmw=
Subject: FAILED: patch "[PATCH] xfs: fix backwards mergeability logic in refcount scrubber" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:26:15 +0100
Message-ID: <2026091615-operating-mutt-0936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e8b01aaafffe6b852325debdf1ef4b13ccea1cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091615-operating-mutt-0936@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8b01aaafffe6b852325debdf1ef4b13ccea1cd7 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 1 Sep 2026 22:49:47 -0700
Subject: [PATCH] xfs: fix backwards mergeability logic in refcount scrubber

When we start the refcount or rtrefcount btree scanners, prev_rec is
initialized to all zeroes.  This is done so that the record mergeability
checks skip the first record because you must have two records to
compare.  Unfortunately, I got the logic backwards, so scrub has never
complained about mergeable refcountbt records.  Fix this bug that LOLLM
noticed.

Cc: stable@vger.kernel.org # v6.4
Fixes: db0502b39c21d1 ("xfs: flag refcount btree records that could be merged")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index 4e1bf23e5b89..f2addaf13c58 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -410,7 +410,7 @@ xchk_refcount_mergeable(
 	const struct xfs_refcount_irec	*r1 = &rrc->prev_rec;
 
 	/* Ignore if prev_rec is not yet initialized. */
-	if (r1->rc_blockcount > 0)
+	if (r1->rc_blockcount == 0)
 		return false;
 
 	if (r1->rc_domain != r2->rc_domain)
diff --git a/fs/xfs/scrub/rtrefcount.c b/fs/xfs/scrub/rtrefcount.c
index 4e7c540c8d23..de100178f41c 100644
--- a/fs/xfs/scrub/rtrefcount.c
+++ b/fs/xfs/scrub/rtrefcount.c
@@ -375,7 +375,7 @@ xchk_rtrefcount_mergeable(
 	const struct xfs_refcount_irec	*r1 = &rrc->prev_rec;
 
 	/* Ignore if prev_rec is not yet initialized. */
-	if (r1->rc_blockcount > 0)
+	if (r1->rc_blockcount == 0)
 		return false;
 
 	if (r1->rc_startblock + r1->rc_blockcount != r2->rc_startblock)

