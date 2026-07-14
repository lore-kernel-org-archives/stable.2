Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DC3BAD99
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044532; cv=none; b=i20/s2Smz9cBxdd8hqt8UiLCcJSTnMk1WzMP1aRKsyQSkl+nuA5wIAy7VerkyLH94S0y0fzBxYfQFBimq9xoYk0mpFqHZsh9+vpIFCj8lc3E3pJEIhmhVEfGxF1CXwMtwv/lVqIl4qzcfKAYFvUUX74E35Uh3EdQdH9V7rCdbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044532; c=relaxed/simple;
	bh=StgjLA/dWZDQJEgNydZYX03ZNdT+UrwpU67uZmUSFyQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j06D4pBgY0KpYaF04N07eOdh8WWu9fwN9il5XvDuxOt0GzZw8fRrQnH6taAVolBXuM811yClOqZ61RtnfguW0aH1wlrclGmFWwQcRTXinfTzAZiJV2Q2MF+7fBqYTsZJ4xLcWumXD5b2jeKaLeVPkMBsGoMk92ajoBWJwi9wFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjvGwuw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjvGwuw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821FE1F000E9;
	Tue, 14 Jul 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044530;
	bh=DSM/jCfEGLG81+aDPWMLfmaTE3OW3l89mXNWmxshO6Y=;
	h=Subject:To:Cc:From:Date;
	b=kjvGwuw9a1X4N484bayOYbf9E/Q+H/HFHZZwHcsbpSYdC44qBxlXzuRbio3mptoXb
	 rCslbAXaEAwnfu1b1smkjecrvAWRQVKxHLkevS/DbWGwUup0iCIvwdUuKwbpBqm13A
	 uJLi0Z9g5BZFm8jPwe6YgTSW8wpGbuHZNsR+J0Tc=
Subject: FAILED: patch "[PATCH] xfs: add newly added RTGs to the free pool in growfs" failed to apply to 6.18-stable tree
To: hch@lst.de,cem@kernel.org,djwong@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:55:16 +0200
Message-ID: <2026071416-estranged-decree-ecfc@gregkh>
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
git cherry-pick -x ae3692c7f440c1ff577aae1a51202415ec4a794b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071416-estranged-decree-ecfc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ae3692c7f440c1ff577aae1a51202415ec4a794b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 10 Jun 2026 07:07:20 +0200
Subject: [PATCH] xfs: add newly added RTGs to the free pool in growfs

When growing a zoned RT section, the newly added RTGs also need to be
tagged as free in the radix tree and add to the nr_free_zones counters.
Call xfs_add_free_zone to do that, otherwise using up the newly added
space will wait for free zones forever.

Fixes: 01b71e64bb87 ("xfs: support growfs on zoned file systems")
Cc: stable@vger.kernel.org # v6.15
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 153f3c378f9f..debbcefdf07f 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -933,6 +933,14 @@ xfs_growfs_rt_zoned(
 	mp->m_features |= XFS_FEAT_REALTIME;
 	xfs_rtrmapbt_compute_maxlevels(mp);
 	xfs_rtrefcountbt_compute_maxlevels(mp);
+
+	/*
+	 * Finally add the newly added zone to the freelist and add the space
+	 * to the available counter.  The order is important here: only add
+	 * the available space after the zones, as available space guarantees
+	 * that zones to back it are available.
+	 */
+	xfs_zone_mark_free(rtg);
 	xfs_zoned_add_available(mp, freed_rtx);
 out_free:
 	kfree(nmp);

