Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B42369D54
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461258; cv=none; b=mdHPbFkYFQxpKG9G77Yyi7VI9lz+SsUyplqHLqGtIgi3ExwQSEXewdIpSVWZLZcTIEKkbYLXKpzi208pwh+DJzEnBxXtKfzk2MtriR606Z+7GZyhO/XI9imGWRWb8c3lqVY5i4ZFN0x3ZhsD7pfjBP7Oa08luSgrOQ6/IjqNcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461258; c=relaxed/simple;
	bh=06luRnJyOJ49JeDeo+odA1GowIm3LEgWD22COAR8gBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG+aY7F5c0mlX+RDGio1W++H5F07uwvEqXSnmunFTTXmDYfbhLdscqwGYWHqE9ljdWsr6V0rJiW66c+PhPie7MTJmMXc6EY/p5Uq90fdABoo0/zL5MbMRibwk2e8FqGdaCxpD0MZqb937Q6vNYFL8nVFzd79PSGGjf+V5nLxYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo/vNe+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo/vNe+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8801F00A3D;
	Thu,  3 Sep 2026 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788461257;
	bh=yUczLQzfXS1qd0awYHdK80Ivc6QuJFNdSytPyj4pdYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oo/vNe+RyphH58zKMOVbTAF/FoPuPwm0pFvUf9LRLOZ/CWjvI+XbjnfSIwqhQwEPf
	 PS9yh1+M7sDxdSbBEpzS+DCPZX/MzJIS/vrHl7Iv6mjQf7Zg0o1xasZw7Aaa4eLKgV
	 EsqnseQ6jTG2bOM9zgGrCVOCKZjzEubIURhbQAacgb7/rpXQSu+2fEDitlN2rhfmpd
	 rG03WsK1/S3t0MQHm0ASH4TSJzDmfDU3ZqfDnjPJE2jd36pEBYMoejOJM9pUVBBHxB
	 nVUpcdt1EJQ+ibwpeHrHqcwiSSbs7PAWMXa+AOfwx2LlLD1Bf3eSWc1j2M++ycCPkQ
	 sUhlanWC6zKBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/7] mm/kmemleak: skip unlikely objects in kmemleak_scan() without taking lock
Date: Thu,  3 Sep 2026 14:47:28 -0400
Message-ID: <20260903184733.1484444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184733.1484444-1-sashal@kernel.org>
References: <2026090333-boney-opium-0272@gregkh>
 <20260903184733.1484444-1-sashal@kernel.org>
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
index 8f7aa881566e5..f7e12d12b5b8e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1504,6 +1504,13 @@ static void kmemleak_scan(void)
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
@@ -1531,6 +1538,13 @@ static void kmemleak_scan(void)
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

