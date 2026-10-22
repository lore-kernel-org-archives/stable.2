Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792650342;
	b=EYgQirlJfPUpOzYymruomn1a5aUqz8pDOvTrSbOL9VnjoYJq4PevTbsUch6Cf495ZLFR
	 VupY15tsCH/zhEy3oPkjbEAOo+i++gdiDcDGnEUGlHmCqbQsSsMiFUpGbYJIdEtE81OZR
	 SoYT/JeXpG2pTwD40krHHb0v8ADwAy7RLeOqaT6jn+l16CL7g0IOc5MFsqhh4jwZeS5NH
	 z+J3wl7zBaUvTNZdDXdsXatooITv73zRBTWjEPVn8lLE+OV9e4zMzqUypFuCB7qKg01/U
	 Hf8NvJquVcuro5UzWcFWvmnu347v3noxEJEhj+vCpqld77S7hOCSJnqUuzx1bON5pog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792650342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sR/bd0HSOYC2pLXMNReGoBvqOpk6rZoUDvcX0fCnmN0=;
	b=hDkDf9lPepObrc451BJ3wxExF04GWb0WZSxJjoa4Edwd0bijo1AQWip97/rqBHsoiGZT
	 k8ndR5Ba0x91DN4aQWNt3GbWnfn9qp2rs8LFFsLqp8/eBkmu4C5a7spUOjjCyOZBYxj8c
	 2UXYP4bLn1u5JR8Am6nceHIIO96uItaPHXek8VZpLH5LfJJNeZHBaUuEYfDoSl1Fgpg88
	 4OUlMnXLfkOb1p+ZsVKkzPNkWvzqYoErvw/FCyBdUdeJG3avMS9Lt8bCkt/WPLunjrs3Z
	 PqlwfS9Weo0qQJS/Y4eFNsrw+BuvjLpnovX2J0ikdJl3FRbARaNP+4YTJapzLRjGUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PlRHh6FU;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245C606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3245C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PlRHh6FU
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso13107665e9.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792650339; x=1793255139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sR/bd0HSOYC2pLXMNReGoBvqOpk6rZoUDvcX0fCnmN0=;
        b=PlRHh6FUA/8dGcmD3MPn1yA6R9W9Fw9E+8rGO/9WOXXpJRId9LgJ2xqAMSm+aEETxX
         9KsoQMUgFHy+4N5yKBwrSAPffDE91P7UWGS9o9D6Hdtn30XkR5dDc0brdlBqfSE5BeRB
         skfWke4bs6Vv+UGCz9QoI4VhruNMgZ0wOl4ACBW7XwB1L+R/qdaCBetrDdOs0DTCGX8E
         jEIKYZCRjon6OwsJl2a6wyoxOiG2URE5t7WZFVlM9OiVdKUQb1J0rh/XzwDOk1RbiR+g
         tYqqQ5kstr2HLP+L0CpgsucrTKIMtGWdBuyQVrOkVNXubQumv9Ldk/SL5QtmfSkn7a5I
         vkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792650339; x=1793255139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sR/bd0HSOYC2pLXMNReGoBvqOpk6rZoUDvcX0fCnmN0=;
        b=sTx2EnDQb3mPVflVdFjRXxUH2Q3DAIUe31oi2YSpc1DP5EBwNSua0rLKgJmbcRynrU
         2JvXZ86ZQFgI4RqTt13ziMah2TFQCRcGVPSzKgNjd0Pk80adnkHKFPh4Kz+Nc9pk9OiO
         Yn2L4Q5OkX22to1Q/G5rcqy7DC7T/BX8aDGVjb3QbxOEQoQqaLh9jdQNkrLQein5TUNR
         m4+3CY874dXa6KvAhLMVYR92qN+2B8wMpwuNdYJcjwfKV228H7sYXIqqKP+0NvNhH0En
         0QwNnbsIcFAbvxWi5Ys+mzsubipRNQq6DqS9MNLIoyxvVOYEuAUUrCpaAtgqSQjHtN3+
         vBZw==
X-Forwarded-Encrypted: i=1; AKwUvBwk55yGXidvW4WLdxjACRgpAnFdFdj9Y8vG4qwbAVdSBa+4zQSj+uTgYi0TqxscsGVrczhuGuE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrdomYml/ULoklPz0nlzA0hB17TF+Z0cZKiWhmo9JSPhIWoYG+
	JbezLDsfAJ1jGdEWRM9FzN4HrCm1BeOn+l18C+qX3+D6K4AZykrvw/LZ
X-Gm-Gg: AYBFou3hd+Pym7OIYQ46kEiGQJXXQzFLy4bfeTQdZ9GIiAeQ7k0zglTqWAwGA8LtPeX
	ABCOlBxT3XgBafv/B7OvmGW6pb59vs/zMjv7Jy3Y1gq8wJIbG76ebmkT8z8dY8CvrXFXmX8U0/l
	EzKnQkn+erlCkkL/WvJsD0jUPAXeizdv0YyI1Otl+y+WvIX+Jy7pIkNrdw69efNdtl0LGZqMGxi
	6nAvQnKhDCDDVaHWNkB7KFg2hyFCOZxIo2OrFtDseC6YWmZovslFBPGlNBQ/5ZbUmY4KZdiT0YA
	5lGiTpgXHZ0t5tp7cJFtr1vuKkdwiQC821+nn1bpYHXmUtayGghQhH31SKodWS3Zml2qDCnHoua
	zDOCrfbmozdMz7/UNyBP+abcMJ6kvOgQI7Muac2A+KLfsN+RprTII6ii+UUfLaIqft+Gj3hFslo
	c5m88QINSvX0KJAm66pPB2QtEJGOv5uYjQirEjcqn44FZD40DnT8HBQbyFTnR64PsAsNBNJ1kwC
	nLbHYT0BYrfZf5zcvhjdxjfLk3TMYA//CrI36GK7PrXYi02SjMdMbyvTWFJ+vuECzb/myGz5ire
	WCSq0KBkmoRtuAL42N6PPZidXjXAHTsgqMtB966oKBvcPneIZR++m71aD6At/NRZBb3A6j12aIK
	XBoz7VI9Mvuuy8fRtekGFXWiJ6qNEJHdG+Hqtx3ZoOJ0CWmJjKBTicgA4eRIEkFWx
X-Received: by 2002:a05:600c:4685:b0:4a2:a1b:dc6f with SMTP id 5b1f17b1804b1-4a20a1bdcc7mr6610985e9.4.1792650339278;
        Wed, 21 Oct 2026 23:25:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a447c8sm45301155e9.12.2026.10.21.23.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 23:25:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: fix shuffling and reporting for no-lock frees
Date: Thu, 22 Oct 2026 08:25:23 +0200
Message-Id: <20261022062523.97082-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages_nolock() may run from NMI context. The BPF arena also calls
it while holding arena->spinlock through raw_res_spin_lock_irqsave().
When the zone trylock succeeds, __free_one_page() still reaches page
shuffling and page reporting.

When shuffle_pick_tail() exhausts its random-bit cache, it calls
get_random_u64(). Once the CRNG is ready, this takes an rtmutex-backed
local lock on PREEMPT_RT, which cannot be acquired while a raw spinlock
is held. A test-only forced refill under a raw spinlock reported an
invalid wait context at batched_entropy_u64.lock.

page_reporting_notify_free() may call queue_delayed_work(), which is not
NMI-safe.

Pass the no-lock constraint to shuffle_pick_tail(). For no-lock frees,
use a pre-seeded per-CPU prandom state, following the slab allocator.
Keep the cached get_random_u64() path for ordinary frees. Seed all
possible CPUs before memblock memory is released to the buddy allocator.

Skip page reporting for no-lock frees. The page remains on the buddy
list for a later reporting pass.

For stable backports, FPI_NOLOCK was named FPI_TRYLOCK through v7.2.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: stable@vger.kernel.org # needs FPI_TRYLOCK through v7.2
Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Preserve shuffling for no-lock frees with a pre-seeded per-CPU prandom
  state, following the slab allocator.
- Keep the cached get_random_u64() path for ordinary frees.
- Keep the page-reporting guard and explain its NMI constraint.
- Check is_shuffle_order() before the no-lock flag.

v1: https://lore.kernel.org/r/20261005063515.6312-1-kmehltretter@gmail.com/

Testing:

A temporary caller freed 65 maximum-order pages under a raw spinlock,
then repeated the workload through __free_pages(). SMP=1 and SMP=4 QEMU
TCG guests produced the same path counts:

                                  no-lock  ordinary
  shuffle decisions                    65        65
  prandom_u32_state() decisions        65         0
  cached random-bit decisions           0        65
  get_random_u64() calls                0         2
  reporting notifications               0        65

Both guests ran PREEMPT_RT with lockdep, raw-lock nesting checks, page
reporting, and page shuffling enabled. Both lanes selected the list head
and tail. Neither guest reported an invalid wait context, lockdep splat,
atomic-sleep warning, BUG, oops, or panic.

The test does not inject an NMI. The in-tree BPF arena caller establishes
the raw-lock path, while the forced refill checks the previously failing
transition.


 mm/mm_init.c    |  1 +
 mm/page_alloc.c |  6 +++---
 mm/shuffle.c    | 24 +++++++++++++++++++++++-
 mm/shuffle.h    |  9 +++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1533aebafb688..01bccb23a89c2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2643,6 +2643,7 @@ void __init mm_core_init_early(void)
 void __init mm_core_init(void)
 {
 	arch_mm_preinit();
+	shuffle_init();
 	init_zero_page_pfn();
 
 	/* Initializations relying on SMP setup */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c483..f13993bda67e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1014,14 +1014,14 @@ static inline void __free_one_page(struct page *page,
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
 	else if (is_shuffle_order(order))
-		to_tail = shuffle_pick_tail();
+		to_tail = shuffle_pick_tail(!(fpi_flags & FPI_NOLOCK));
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
 	__add_to_free_list(page, zone, order, migratetype, to_tail);
 
-	/* Notify page reporting subsystem of freed page */
-	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
+	/* No-lock frees may run from NMI, where delayed work cannot be queued. */
+	if (!(fpi_flags & (FPI_SKIP_REPORT_NOTIFY | FPI_NOLOCK)))
 		page_reporting_notify_free(order);
 }
 
diff --git a/mm/shuffle.c b/mm/shuffle.c
index 82a2c7725a08a..2e1f76d6bf92b 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/mmzone.h>
 #include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/moduleparam.h>
 #include "internal.h"
 #include "page_alloc.h"
@@ -13,6 +14,7 @@
 DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
 
 static bool shuffle_param;
+static DEFINE_PER_CPU(struct rnd_state, shuffle_rnd_state);
 
 static __meminit int shuffle_param_set(const char *val,
 		const struct kernel_param *kp)
@@ -30,6 +32,12 @@ static const struct kernel_param_ops shuffle_param_ops = {
 };
 module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
 
+void __init shuffle_init(void)
+{
+	if (static_branch_unlikely(&page_alloc_shuffle_key))
+		prandom_seed_full_state(&shuffle_rnd_state);
+}
+
 /*
  * For two pages to be swapped in the shuffle, they must be free (on a
  * 'free_area' lru), have the same order, and have the same migratetype.
@@ -159,12 +167,26 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
 		shuffle_zone(z);
 }
 
-bool shuffle_pick_tail(void)
+bool shuffle_pick_tail(bool allow_spin)
 {
 	static u64 rand;
 	static u8 rand_bits;
 	bool ret;
 
+	if (!allow_spin) {
+		struct rnd_state *state;
+
+		/*
+		 * An interrupt or NMI handler might interrupt and change
+		 * the state in the middle, but that's safe.
+		 */
+		state = &get_cpu_var(shuffle_rnd_state);
+		ret = prandom_u32_state(state) & 1;
+		put_cpu_var(shuffle_rnd_state);
+
+		return ret;
+	}
+
 	/*
 	 * The lack of locking is deliberate. If 2 threads race to
 	 * update the rand state it just adds to the entropy.
diff --git a/mm/shuffle.h b/mm/shuffle.h
index 11bec7521ab89..92f5e758388d9 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -11,7 +11,8 @@
 #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
 DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
 extern void __shuffle_free_memory(pg_data_t *pgdat);
-extern bool shuffle_pick_tail(void);
+void __init shuffle_init(void);
+bool shuffle_pick_tail(bool allow_spin);
 static inline void __meminit shuffle_free_memory(pg_data_t *pgdat)
 {
 	if (!static_branch_unlikely(&page_alloc_shuffle_key))
@@ -34,7 +35,11 @@ static inline bool is_shuffle_order(int order)
 	return order >= SHUFFLE_ORDER;
 }
 #else
-static inline bool shuffle_pick_tail(void)
+static inline void __init shuffle_init(void)
+{
+}
+
+static inline bool shuffle_pick_tail(bool allow_spin)
 {
 	return false;
 }
-- 
2.39.5 (Apple Git-154)

