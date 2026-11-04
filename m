Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814854;
	b=hASFtwhvhFZytRgeiz1QLrSlDV5MVVdRHK0smYNELrcIM7eqORRPCuIbpgfzGYH7e//k
	 We2aWBNzAy8i/maQcy5bV8pjtpzig1l2v43D+FdKe6clnAplE6owLm9r716Lk+rmeb9m7
	 oFO2nS1PjV+ym44WiYOllNwE+Wdp/Xzn9rVU162QQiz2QlMtPZRfQKn5rqZAeEvfobXQK
	 eH48zk/FfI0picQ41mYB0C+1CW2mzhzkc5WlbnN/YWzpZLXYysoovYr+Y8F/3hiZyGa9H
	 BKC0GiqON1ixOn5OULFUy2mx+azz005Pz2Ead59Czqj35a+bYtTCZjtNQqyrnSIbkkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814854;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0jN3/oz2ig7ab0cLg1DMR3PtzI8i1I6QCOhgHGc/CYQ=;
	b=aVJNB62aqgXH6PGIvVGeDsdsZ1hgL+d6ciyxTqU4addEk2BXgA5XKWcVLmIWQbUv5bK6
	 Y4RC9u6COuwy/PEUL4+5joXHw4pe2jA/3ueWfdd8KGDYkeqZjBPJZmzgnTYyJzOM6DdBv
	 UqCHmGdTk/XJSGP5XK69y/Ed6QD8+uY5sOniBI7CCWd5LCbQJlWV423hsJBxN1Z6fy8yG
	 /2MKGDiRVzULtzmTzXx9VJtkDUy9lt4koZVi1We5EUPafTVeQ9MBt+k8QUSwJ1i1f1r3b
	 vwz6TP79cOLlYA6+hgUrt0nBUwfutQycNnWlJlfFISFCkKNf5OYJXqoM/CQhtfje+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wDsF9PVi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987B60A2607
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wDsF9PVi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9A1F00A15;
	Wed,  4 Nov 2026 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814853;
	bh=0jN3/oz2ig7ab0cLg1DMR3PtzI8i1I6QCOhgHGc/CYQ=;
	h=Subject:To:Cc:From:Date;
	b=wDsF9PViRHi42Oo/d8lhYn71e5DnUGoez+v06sBBok8Sqq3tVJKgjwLleEMa9jsKd
	 yjUNdEvGNaRJ3EDnWy77z2m5JT0wT7qdz4eKmujUfd6bbBXQHBAUmUed02DSg4FNPo
	 8l6GHBG6BEWizBbqsvl9dNvtsqt+WJIF/OfTtdQU=
Subject: FAILED: patch "[PATCH] xfs: don't rescan ifree and icount when frozen" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:53:43 -0500
Message-ID: <2026110443-freebie-pamphlet-583e@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18028768415e3c05ab7edb22d740e2f4dc52836a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-freebie-pamphlet-583e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

