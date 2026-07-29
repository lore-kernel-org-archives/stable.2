Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC748D87B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333643; cv=none; b=F2h4vLsR6R0RV9NPCjx9UXJSqhjmcQ5w3QodevHwhzirZVQjURwTNHa1JUWqhdd3tW3WqBsmaw9fp8SW1/zOfk24FIrFutILnF2UxnUfUD46YYpiBhqMJwO0qVStwlIjPvIBqchZXkGAlawPs7JWDGHbKdQEj1wxjzw89jLZmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333643; c=relaxed/simple;
	bh=9kryRx+1KyEVgMAxP3StnW+MpvrzuTSQF7jCHjdCjUo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GG++bELaaWEb/1EQhhytIwfOFY63JxFPtwx91oKClqgHEtJxqRRLOYmwZTYNxyVMaGeBT9a46Af9vSYHLct1S1OJXd+wDDi732NbdZnzbO0n2NH6/LEZQpku0kLEhuQbQVLLENpGigzdilQn7r47/6CALQH3ELuVnebdWx+kGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8sBgRn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8sBgRn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1732F1F000E9;
	Wed, 29 Jul 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333636;
	bh=hiwcOioZAU1vi7xW19m1jqUNDLaGNDbPBWrD6neMSv8=;
	h=Subject:To:Cc:From:Date;
	b=y8sBgRn3Zkg4Sv1PIPMpu8eLksooT/V4sNFdYyugU6MH9Hy0Ygl3XBEM62NWBivrt
	 7e0WovuE/7bo2M5lGXzMg5CYBil96UHz3cEM+ak11UAcU+df3TOU0h+evhmbWDRFaS
	 7cd6dbBDm89EzG+ne5g7fIY1MLblPfTS3tbczSvU=
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow overlapping input ranges for" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:58:45 +0200
Message-ID: <2026072945-freezable-opossum-1bd2@gregkh>
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
git cherry-pick -x 954157679ec34661c2e87e7eb796104a797c32db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-freezable-opossum-1bd2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 954157679ec34661c2e87e7eb796104a797c32db Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 3 Jul 2026 09:56:08 -0700
Subject: [PATCH] mm/damon/core: disallow overlapping input ranges for
 damon_set_regions()

damon_set_regions() assumes the input ranges are sorted by the address and
don't overlap each other.  Hence the assumption was initially to be
explicitly validated.  But commit 97d482f4592f ("mm/damon/sysfs: reuse
damon_set_regions() for regions setting") has mistakenly removed the
validation.

This can make DAMON behave in unexpected ways.  At the best, the
monitoring results snapshot will just look weird since there will be
overlapping regions.  DAMOS will also work weirdly, applying the same
action multiple times for overlapping regions, and make DAMOS quota weird.
More seriously, depending on the setup and regions updates sequence,
negative size regions can be made.  It will trigger WARN_ONCE() if the
kernel is built with CONFIG_DAMON_DEBUG_SANITY=y.  Depending on the
monitoring results, the negative size region can further trigger division
by zero in damon_merge_two_regions().

Note that some of the consequences including the WARN_ONCE() and the
divide by zero depend on commits that were introduced after the root cause
commit 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for
regions setting").

Fix the problems by checking the assumption and returning an error if
the input ranges don't meet the assumption.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260703165610.92894-1-sj@kernel.org
Link: https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org [1]
Fixes: 97d482f4592f ("mm/damon/sysfs: reuse damon_set_regions() for regions setting")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 949d5309d54d..cff932b3317d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -354,12 +354,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 {
 	struct damon_region *r, *next;
 	unsigned int i;
+	unsigned long last_end;
 	int err;
 
 	for (i = 0; i < nr_ranges; i++) {
-		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
-				ALIGN(ranges[i].end, min_region_sz))
+		unsigned long start, end;
+
+		start = ALIGN_DOWN(ranges[i].start, min_region_sz);
+		end = ALIGN(ranges[i].end, min_region_sz);
+		if (start >= end)
 			return -EINVAL;
+		if (i > 0 && last_end > start)
+			return -EINVAL;
+		last_end = end;
 	}
 
 	/* Remove regions which are not in the new ranges */

