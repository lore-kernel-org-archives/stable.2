Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B2359A70
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182128; cv=none; b=LJwjJH1fe4yfAes88WeY5YaJns6pUrB7hAXKAkuhNT43FMtZLCdkhoQCABeg5nUvmD4iZjPn2ybWSTKN7GVi9hY8rVoRNLT4zuBPvj/E/dqsSXiRvf0GLFmSMHcEqAFBK7sZMs9tXvhmPIpu1Irb0PC1Rm9BBobSeocK6cAbUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182128; c=relaxed/simple;
	bh=ISjg7QB4MTmSfDNhKTcMpY2Rl2PEZH2Jd914ryrm0VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKpGzb1bvyKNQ437aol4jNeRg3HyHumMjeTI/leNpjaAjS3swQbfzYQ2BeMQJNAmACXGfu+FsdsDGtkgzOqpwJjnUvtPUWOf2adFOT6pHC651a3/Rw10MBOPfXM3xs6dtqWEJRRlGymqlrJLLk1s35XIzmHohYLmVjvpHw9vtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXD9wNpb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXD9wNpb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so8323245e9.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791182125; x=1791786925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uk4knJvNCd2gZ59g/hSQzEEij2193g8fgyNRYXAesqs=;
        b=IXD9wNpbiWQrFt01Gi7DbLQMUnYUAfz7b1nkQWpDNACLcANI51Ew3TgxUgcav8/KM2
         76oBJyPynUAfJs/JbwxCUyFKbYM1Xzl3fC7f9z/kwX2qHBM+Txjd7WLDocdxvGzdAX2M
         otDTdcDTUbL3fS71fW2oer7Eg91mpawf9BOjSUrQvN/l3Ga5K7u5KzcA/2xWVeHI8icH
         S56MIbntJPhpJ6VioBsX3/UDUB6IoFeqI+UMa7ceDRvabAnweh07Vfobe09VObld0xzA
         oTMqH/pbysv4t26uTTkVL2xhUMLCAvdnh7oeAC5rNCbug7MDUW5G1EnW3rYpfL57IA2s
         OPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791182125; x=1791786925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uk4knJvNCd2gZ59g/hSQzEEij2193g8fgyNRYXAesqs=;
        b=M0ls/eokDOKk75tIBLrp03W2nGBDAMnu7yLnWJk1zr+M0hVNllq70xZIplki+IXIqM
         o0yDY8jd+KpiacgQ9QzmNeinnYWd+JpentXpZZugMI3QleyzBrrQnYy4v2G9liC7jCVX
         uHxxVkcSJjpm1NhYRFm2SgqScK3g96YmUvyb9YDA7f2MS7ri3vI1Dn3oYZ5lW/hMvJYJ
         Rzxqoju3p45M/DZcjzxwPdN2F6DO+WfMpllsVlk4DsaMXE3Vv60TL8P0sVS1Kbi4Gb1G
         57OrarRmIyuz7A+Tq+0/l2dJhGSaJDoMLv4vmwlHG6Y3cw8uvXUjsf4glTJwCez0pY5f
         bKVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRJVjTw6iP0B+ZG82DU4vTSDom0VmK6ftBmU1F6zb5psgqvXlLrpBZHDPI8RSFB9bEos+PUZM=@vger.kernel.org
X-Gm-Message-State: AFuF++msZEL/6ljZg824yR+P55mItenhmHVqytavL0x6np78DIO7wu/p
	OQ799hOr3WJ2xHSfBTlQtfczrPp+rchfeIj3PJwI4FRQqpL+loEFfWXx
X-Gm-Gg: AYBFou3OqUfu9MJ7A4GF1U0AvstdL+vgnnK8/5jNBlJaczOiEvD9d2FyTBDaIrX7A2A
	ycPoZZcEnhUqX6b5iDcW0jW8i4UpnfQGwWKKTyZzn6apnZKb2Gx8exsu8zrKI2lUwrfDonYwTO8
	Yz5y3aASaI7ArgouPSvpX1vxe21loknHccZC736xbnQyY8va1J8kGt7LzK43BRKey70HnETsuyu
	l8TII2CTl81e5PofZwCZLW2/AMGaSfca8f4luVeQdKtAjSMo9Bj1APpsFVFBt1hqV9Mcj1iCKAq
	Ymaehr0SlJFGlq8xLPLvHsiyDNcVI5+IBJT7cofTvbaCC/WBNZgLlct6Ot+bfka6oyfVRy3U6XR
	5z2BHqoeF1r3Z3catklWUiM5ZJgc6jgu48lRyCgSj/EZwdr7da9J5vVSpvQ6caswCu97XxPRRVU
	BpYZX/zpPXEDtytM4l67uICcWQhWNxFSsObXKIHOiJHuKAmFvV0qQFpUFwxQHqT4JAuvi6tpM+3
	vdaBw2pPDRmHyILzTuJa+NDJRAvfZt8qAwQmy4GZ2tjITpMcqPEnVLl2hjUD70d61sKrkUozv++
	45RjzfPosxI4at614SZq5WylWBrRW1xWNJR5y049oJ0h5hrhfMs8zSKcSDtNz511jwtFgocB4Lq
	sfg==
X-Received: by 2002:a05:600c:4e8e:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-4a02759b360mr175379885e9.18.1791182125208;
        Sun, 04 Oct 2026 23:35:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff106d8sm219456545e9.3.2026.10.04.23.35.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 23:35:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: skip shuffling and reporting for no-lock frees
Date: Mon,  5 Oct 2026 08:35:14 +0200
Message-Id: <20261005063515.6312-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages_nolock() may run in NMI context or while a raw spinlock is
held. When its zone trylock succeeds, __free_one_page() still reaches
optional work written for ordinary frees.

shuffle_pick_tail() can refill its random-bit cache through
get_random_u64(), which takes a per-CPU local lock.
page_reporting_notify_free() can queue delayed work. Both operations can
enter locking outside the trylock-or-defer mechanism used by no-lock
frees.

An instrumented PREEMPT_RT lockdep run forced a random-bit cache refill
while calling free_pages_nolock() under a raw spinlock. The unpatched
allocator reported:

    BUG: Invalid wait context

The attempted lock was batched_entropy_u64.lock in get_random_u64().
Lockdep showed the raw test lock and zone->lock both held.

Skip allocator shuffling and page-reporting notification for FPI_NOLOCK.
The freed page remains on the buddy list and can be collected by a later
reporting pass.

Trees from v6.15 through v7.2 call this flag FPI_TRYLOCK. Use
FPI_TRYLOCK in place of FPI_NOLOCK when backporting this change.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 7.2
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This was found while auditing the no-lock paths discussed at:
https://lore.kernel.org/r/20260919171443.90512-1-kmehltretter@gmail.com

Tested on base e767a4ea70a3 in four-vCPU x86-64 QEMU TCG with
PREEMPT_RT, PROVE_LOCKING, PROVE_RAW_LOCK_NESTING,
SHUFFLE_PAGE_ALLOCATOR, PAGE_REPORTING and page_alloc.shuffle=1.

A temporary initcall registered page reporting and freed 65 maximum-order
allocations with free_pages_nolock() under a raw spinlock. This exhausts
shuffle_pick_tail()'s cache and forces a refill.

                                             unpatched  patched
  free_pages_nolock() calls                          65       65
  __free_one_page() calls                           130      130
  shuffle_pick_tail() calls                          65        0
  page_reporting_notify_free() calls                130        0
  reporting work pending                              1        0
  invalid-wait-context reports                        1        0

Maximum-order splitting accounts for the 130 __free_one_page() calls.
Both guests powered off. The patched guest emitted no diagnostics. This
forced test does not measure normal frequency.

A second A/B used no test-only MM caller. A BPF arena program attached to
mm_page_free_batched requested 2,048 pages from a memcg-limited map. Partial
failures rolled allocated pages back through free_pages_nolock() while the
tracepoint held the per-CPU page-list lock. A virtio-balloon device provided
page reporting.

                                      unpatched  patched
  arena allocation attempts                  70       70
  arena allocation failures                  70       70
  shuffle calls from rollback                 9        0
  get_random_u64() calls from shuffle         1        0
  reporting notifications                    12        0
  delayed-work queues                         5        0

Both guests powered off without a diagnostic. This confirms that an in-tree
caller reaches the optional operations. It did not reproduce a deadlock or
lockdep warning.

The upstream form applies to v7.3-rc1, mainline and next-20261002. The
FPI_TRYLOCK backport applies to v6.15 through v7.2. mm/page_alloc.o builds
on v6.18 and v7.2.7. Stable backports were not runtime tested.

 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..3e21dc90b858 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -89,7 +89,10 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
-/* Free the page without taking locks. Rely on trylock only. */
+/*
+ * Request the no-lock free path. Use trylocks and skip optional operations
+ * which can take other locks or queue work.
+ */
 #define FPI_NOLOCK		((__force fpi_t)BIT(2))
 
 /* free_pages_prepare() has already been called for page(s) being freed. */
@@ -1013,7 +1016,7 @@ static inline void __free_one_page(struct page *page,
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
-	else if (is_shuffle_order(order))
+	else if (!(fpi_flags & FPI_NOLOCK) && is_shuffle_order(order))
 		to_tail = shuffle_pick_tail();
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
@@ -1021,7 +1024,7 @@ static inline void __free_one_page(struct page *page,
 	__add_to_free_list(page, zone, order, migratetype, to_tail);
 
 	/* Notify page reporting subsystem of freed page */
-	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
+	if (!(fpi_flags & (FPI_SKIP_REPORT_NOTIFY | FPI_NOLOCK)))
 		page_reporting_notify_free(order);
 }
 
-- 
2.53.0

