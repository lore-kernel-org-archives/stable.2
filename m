Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30917B50A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474654; cv=none; b=OVyW6pN9HkfIXMOIyIzIDL2DWm2+KaU87xk5IvC9XapUjmuQwQ+X7C1Fn8iPI4e7LLQFj0AaH35RDilqJLhmRLRbfrhkqagZUd16aPxwh8Tgep96puQP4c3L+wFU9//+4+Vr8EdHe+HED9VUXQBVADVfqggXgmgh6n2LPyKGD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474654; c=relaxed/simple;
	bh=siVeDhCzHjJWCfzSU5CqjkQUw3l7kckpFcO50SMXaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6Doj3HGsgkCuRLJ0PaRq3W9mDhKLZYbg2hC1P4xx5wcjtsRhYreP0NLptmtKgtXEiEi1iIJKQ2DW2SJBbXTD/rn7QbBn/+0/nolW7Y4njQemzGX9GsA+TNLIvSXUVkon7QCJyaXmbBdaAJba/eO+1JTZVNozjyIvwyhexpNkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH1vzkeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH1vzkeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B371F00A3D;
	Thu,  3 Sep 2026 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474652;
	bh=MTFPC0pIzvAWYZk4tRuhvOZRmWJe0zO8wbYI+L4KPlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XH1vzkeJ2uI4dmb2uxM3jUA8H/2ROTZjaw9qwzm5mxlGIQ8qIjmX3rwFTiNudJr9/
	 eAjADhKBNwnslDgIlksbzG1aNzTokSO5xIABKwR9Zqe+x/3U3VyePmKy8m/4aw69xY
	 bPEvvla7ldZ4OoCISiYTNiPaMp5pYyZRznw7QfQ/C+b68s+htSjBrAMmX0JR0dlPpU
	 U6Bifer4CKpCyIv17RW6/fciEqubu+Nbqv6gvvl2jXO6YjixjR5O/IKXdyZcfX8H4g
	 EO3aCC1dGz5rPF1R2KzePf+W8c4ZUCAEyC58R1fghgH/wlheq50Q6UjWZC9R/oVujS
	 On3TpuXSBeFOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] mm/kmemleak: skip unlikely objects in kmemleak_scan() without taking lock
Date: Thu,  3 Sep 2026 18:30:44 -0400
Message-ID: <20260903223049.1740340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903223049.1740340-1-sashal@kernel.org>
References: <2026090334-dreamboat-playpen-3c4e@gregkh>
 <20260903223049.1740340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 64977918c2381aaadd544535708294213cc964f6 ]

There are 3 RCU-based object iteration loops in kmemleak_scan().  Because
of the need to take RCU read lock, we can't insert cond_resched() into the
loop like other parts of the function.  As there can be millions of
objects to be scanned, it takes a while to iterate all of them.  The
kmemleak functionality is usually enabled in a debug kernel which is much
slower than a non-debug kernel.  With sufficient number of kmemleak
objects, the time to iterate them all may exceed 22s causing soft lockup.

  watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [kmemleak:625]

In this particular bug report, the soft lockup happen in the 2nd iteration
loop.

In the 2nd and 3rd loops, most of the objects are checked and then skipped
under the object lock.  Only a selected fews are modified.  Those objects
certainly need lock protection.  However, the lock/unlock operation is
slow especially with interrupt disabling and enabling included.

We can actually do some basic check like color_white() without taking the
lock and skip the object accordingly.  Of course, this kind of check is
racy and may miss objects that are being modified concurrently.  The cost
of missed objects, however, is just that they will be discovered in the
next scan instead.  The advantage of doing so is that iteration can be
done much faster especially with LOCKDEP enabled in a debug kernel.

With a debug kernel running on a 2-socket 96-thread x86-64 system
(HZ=1000), the 2nd and 3rd iteration loops speedup with this patch on the
first kmemleak_scan() call after bootup is shown in the table below.

                   Before patch                    After patch
  Loop #    # of objects  Elapsed time     # of objects  Elapsed time
  ------    ------------  ------------     ------------  ------------
    2        2,599,850      2.392s          2,596,364       0.266s
    3        2,600,176      2.171s          2,597,061       0.260s

This patch reduces loop iteration times by about 88%.  This will greatly
reduce the chance of a soft lockup happening in the 2nd or 3rd iteration
loops.

Even though the first loop runs a little bit faster, it can still be
problematic if many kmemleak objects are there.  As the object count has
to be modified in every object, we cannot avoid taking the object lock.
So other way to prevent soft lockup will be needed.

Link: https://lkml.kernel.org/r/20220614220359.59282-3-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 64f1033986e28..1d59667fb24ee 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1502,6 +1502,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * This is racy but we can save the overhead of lock/unlock
+		 * calls. The missed objects, if any, should be caught in
+		 * the next scan.
+		 */
+		if (!color_white(object))
+			continue;
 		raw_spin_lock_irq(&object->lock);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
@@ -1529,6 +1536,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * This is racy but we can save the overhead of lock/unlock
+		 * calls. The missed objects, if any, should be caught in
+		 * the next scan.
+		 */
+		if (!color_white(object))
+			continue;
 		raw_spin_lock_irq(&object->lock);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
-- 
2.53.0

