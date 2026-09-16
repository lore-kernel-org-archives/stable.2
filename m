Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE314EBAFF;
	Wed, 16 Sep 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557983; cv=none; b=XKICEMclR+wFaslCPyS1ift9BBp39FKgJEE2Ldh0C/8Gm0aOL8lb6Huj+excn1+hbnZcKGz3Q7bfYm8vZBDvCgdYZ8A59GhXziCfRqLTdzJvkNf8qCLMp4xUUYzVpAQPCZXHAqOsZv70byFdTnCAGHJqNolO+JiQjUdmAkSL2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557983; c=relaxed/simple;
	bh=SYcAl8YhKiqM9taPbxgVevkFHqhBMLFsYSCEgRxPwEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYrDZ8I7/MMgUNKp/mMNGV5bRw/M4l6KzmBwZpi9/VsHBKjyn96o7LlRugWwtD9mNYJrkpmMOdlLmlnC2ZvimN0urCS9Az+gTy04mT2yC3QPqfQoqbSUn8z+5FsyrbyiSeEsrTbaCMrUOK+PF1wSElmHkiNZloEd7+TZrzj84Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wJc4sgJv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wJc4sgJv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789557959; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qkFbwJ3DbJzS5ny24JTrLqbzgteYgwCCQYHKn5yzPro=;
	b=wJc4sgJvrG9MoD/kC+rbS6YwR8A8SYvPzVTyk3CEqDM0m7+poT0lEbuh8Wy33/w+IFo9p+PkpBCXCzhFKXo/apWee7n+Oxl/Yg8of49f+wG877iO3FCIXU2OGCRfgAEZ0LdpzubYyQTmqTUxoyj12sQSjMDddDLjqWN2JIT2ZFY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XB4nUJy_1789557948;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XB4nUJy_1789557948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:25:57 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: akpm@linux-foundation.org,
	vbabka@kernel.org,
	mgorman@techsingularity.net,
	linux-mm@kvack.org
Cc: surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	henry.willard@oracle.com,
	david@kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH v2] mm/page_alloc: do not boost watermarks in kdump capture kernels
Date: Wed, 16 Sep 2026 19:25:45 +0800
Message-ID: <20260916112545.3707893-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A watermark boost is not confined to one watermark: wmark_pages() adds
it to min, low and high alike, so every watermark check sees it,
including should_reclaim_retry() and the last ditch ALLOC_WMARK_HIGH
attempt in __alloc_pages_may_oom().  Once the boost exceeds the memory
still free the allocator gives up and invokes the OOM killer, and a
capture kernel that is still booting has nothing to kill: the boot
panics and the vmcore is lost.

Seen on an arm64 machine with 64K pages, CONFIG_PAGE_BLOCK_MAX_ORDER=10
(pageblock = 64M) and crashkernel=512M, running a distribution kernel
based on 7.0.14.  A high order UNMOVABLE allocation fell back to a
MOVABLE pageblock while the capture kernel was still in do_initcalls():

  Node 0 DMA free:68096kB boost:65536kB min:68160kB
  low:68800kB high:69440kB managed:479168kB
  Out of memory and no killable processes...
  Kernel panic - not syncing: System is deadlocked on memory

The zone was not short of memory.  Subtracting the boost gives
min:2624kB low:3264kB high:3904kB, so the 68096kB still free sat 17
times above the high watermark and the allocator would not even have
entered its slow path.  The boost supplied 65536kB of the 68160kB min
and by itself put the zone 64kB under water.  It is that large because
boost_watermark() clamps it with max(pageblock_nr_pages, max_boost);
watermark_boost_factor alone would have allowed 5824kB.

Commit 14f69140ff9c ("mm: limit boost_watermark on small zones") already
tried to protect capture kernels, but it infers them from the zone size
and skips the boost only below four pageblocks.  arm64 64K pageblocks
were 512M then, so the guard reached zones up to 2G;
CONFIG_PAGE_BLOCK_MAX_ORDER can cap them at 64M, which shrinks the guard
to zones under 256M and lets this 468M zone through.

kdump is a property of the kernel, not of the zone, so test for it
directly.  A capture kernel exits within seconds and never uses the
fragmentation avoidance the boost buys.  Normal kernels are unaffected:
the size based check still covers their genuinely tiny zones.

Passing sysctl.vm.watermark_boost_factor=0 to the capture kernel does
not cover this window: sysctl.* parameters are written through procfs
by do_sysctl_args(), which runs after do_initcalls() where the panic
above happened, and watermark_boost_factor has no early_param of its
own.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Cc: stable@vger.kernel.org # v5.0
Cc: Henry Willard <henry.willard@oracle.com>
Cc: David Hildenbrand <david@kernel.org>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
Changes in v2:
- Drop the stale kdump capture kernel mention from the small-zone
  comment in boost_watermark(): capture kernels now return earlier.
  (Vlastimil Babka)

v1: https://lore.kernel.org/r/20260914131142.2984623-1-xiangzao@linux.alibaba.com

Build tested with CONFIG_CRASH_DUMP=y and =n.

Tested on the affected machine with the original crashkernel=512M and
capture kernel command line.  Without this patch both capture boots
panicked at 7.9s inside do_initcalls() with a 64M boost in place.  With
it, and with boost_watermark() instrumented, every call was suppressed -
including those inside do_initcalls(), where the panics happened - free
memory came down to within 64kB of the min watermark, where a single
boost would have put it 65472kB under, and the dump completed.
---
 mm/page_alloc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..f52ed7d2cd34 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -37,6 +37,7 @@
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
 #include <linux/compaction.h>
+#include <linux/crash_dump.h>
 #include <trace/events/kmem.h>
 #include <trace/events/oom.h>
 #include <linux/prefetch.h>
@@ -2178,10 +2179,17 @@ static inline bool boost_watermark(struct zone *zone)
 
 	if (!watermark_boost_factor)
 		return false;
+
+	/*
+	 * A kdump capture kernel exits before a boost can pay off, while
+	 * the raised watermark can exceed the memory left for the dump.
+	 */
+	if (is_kdump_kernel())
+		return false;
+
 	/*
 	 * Don't bother in zones that are unlikely to produce results.
-	 * On small machines, including kdump capture kernels running
-	 * in a small area, boosting the watermark can cause an out of
+	 * On small machines, boosting the watermark can cause an out of
 	 * memory situation immediately.
 	 */
 	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
-- 
2.43.7

