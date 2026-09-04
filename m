Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBE3F4835
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517825; cv=none; b=iHgDzl5AYHKexAf3z0FK97EG0PW1He/5IMyDoUJJ+ab+vBiqF3GoUs3dAMjDBHLm35GaUYiMb5IVTiYfu5J4r5xSADNgPxIHNc/dAdI7E4Gi7Kfg9RRO0SFA+nseH2+LSjW0r9ogLBipfLj6rw12FUx4xPbQYJIkW1M8E0i5J1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517825; c=relaxed/simple;
	bh=D0qn81V8cdZSY65AHexxmYJwfvdH7Z/404eH2mvQCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU+oJ6vHHq6QBS7aGHW6AbILR/LYxfP33Mf0jUjfUbVjN8SmRXyMkF+UTaVsKuGZx7/E8k1lHjNjzm+82A0EcB+AS7qjGKXn3PF2VqS5iceB6FQnHkY0cwBucL1NBNJniFvajUqrFf9UAgWefDZ6ULAL1Msf0j1fEU3I1GYv/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdARSRNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdARSRNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164901F00A3D;
	Fri,  4 Sep 2026 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517823;
	bh=XFP/wLObseUB2BDoS84fMg/MfsBteLcN3gXcXA+n1u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdARSRNnOGEg5O+G7dkpt7XWXgjvwOCVJWp4zLZ/4dmQrFDLGIBT0L3MTPLv2NiKJ
	 SAwsb0xAbEtrOYxe7hhN7rtWJ+uQbIEX/YF+ZN+mBXA3VpvIOuOiMDzfWpDmsnReg6
	 qVLBVtnjB06Gzp3wsyMJccmJd5tgLS4YAX38k4ZBJi3/rPOpuNaJBFIJITvjjNJmGP
	 3qdenDNhpuk3nvJ/GDNcBdZLdhbCW78d1fxRdNFceTTzZlhqghp3JEFbAbVBBBtQkc
	 4GNZMTPYjB3l58x8zQpQVFbHc5NPpVGk0ngaArHd1xdTb4KAyS6ceg/yspdF1+zCou
	 tAV+XfqdtOcSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Daniel Borkman <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] locking/local_lock, mm: replace localtry_ helpers with local_trylock_t type
Date: Fri,  4 Sep 2026 06:30:18 -0400
Message-ID: <20260904103020.2502384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-subtract-womanlike-c117@gregkh>
References: <2026090310-subtract-womanlike-c117@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 51339d99c0131bc0d16d378e9b05bc498d2967e2 ]

Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce
localtry_lock_t").  Remove localtry_*() helpers, since localtry_lock()
name might be misinterpreted as "try lock".

Introduce local_trylock[_irqsave]() helpers that only work with newly
introduced local_trylock_t type.  Note that attempt to use
local_trylock[_irqsave]() with local_lock_t will cause compilation
failure.

Usage and behavior in !PREEMPT_RT:

local_lock_t lock;                     // sizeof(lock) == 0
local_lock(&lock);                     // preempt disable
local_lock_irqsave(&lock, ...);        // irq save
if (local_trylock_irqsave(&lock, ...)) // compilation error

local_trylock_t lock;                  // sizeof(lock) == 4
local_lock(&lock);                     // preempt disable, acquired = 1
local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
if (local_trylock(&lock))              // if (!acquired) preempt disable, acquired = 1
if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save, acquired = 1

The existing local_lock_*() macros can be used either with local_lock_t or
local_trylock_t.  With local_trylock_t they set acquired = 1 while
local_unlock_*() clears it.

In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts to
protect critical section, but it doesn't prevent NMI, so the fully
reentrant code cannot use local_lock_irqsave(local_lock_t *) for exclusive
access.

The local_lock_irqsave(local_trylock_t *) helper disables interrupts and
sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from NMI
attempting to acquire the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().  Map
local_trylock_irqsave() to preemptible spin_trylock().  When in hard IRQ
or NMI return false right away, since spin_trylock() is not safe due to
explicit locking in the underneath rt_spin_trylock() implementation.
Removing this explicit locking and attempting only "trylock" is undesired
due to PI implications.

The local_trylock() without _irqsave can be used to avoid the cost of
disabling/enabling interrupts by only disabling preemption, so
local_trylock() in an interrupt attempting to acquire the same lock will
return false.

Note there is no need to use local_inc for acquired variable, since it's a
percpu variable with strict nesting scopes.

Note that guard(local_lock)(&lock) works only for "local_lock_t lock".

The patch also makes sure that local_lock_release(l) is called before
WRITE_ONCE(l->acquired, 0).  Though IRQs are disabled at this point the
local_trylock() from NMI will succeed and local_lock_acquire(l) will warn.

Link: https://lkml.kernel.org/r/20250403025514.41186-1-alexei.starovoitov@gmail.com
Fixes: 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Stable backport note: The localtry_lock_t API introduced by prerequisite
  0aaddfb06882 is not present in this tree, so omit the upstream local-lock
  conversion.  Move the existing sysfs_slab_alias() declaration and !sysfs
  stub next to their first use to avoid a context conflict in the follow-up
  SLUB fix. ]

Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce
localtry_lock_t").  Remove localtry_*() helpers, since localtry_lock()
name might be misinterpreted as "try lock".

Introduce local_trylock[_irqsave]() helpers that only work with newly
introduced local_trylock_t type.  Note that attempt to use
local_trylock[_irqsave]() with local_lock_t will cause compilation
failure.

Usage and behavior in !PREEMPT_RT:

local_lock_t lock;                     // sizeof(lock) == 0
local_lock(&lock);                     // preempt disable
local_lock_irqsave(&lock, ...);        // irq save
if (local_trylock_irqsave(&lock, ...)) // compilation error

local_trylock_t lock;                  // sizeof(lock) == 4
local_lock(&lock);                     // preempt disable, acquired = 1
local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
if (local_trylock(&lock))              // if (!acquired) preempt disable, acquired = 1
if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save, acquired = 1

The existing local_lock_*() macros can be used either with local_lock_t or
local_trylock_t.  With local_trylock_t they set acquired = 1 while
local_unlock_*() clears it.

In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts to
protect critical section, but it doesn't prevent NMI, so the fully
reentrant code cannot use local_lock_irqsave(local_lock_t *) for exclusive
access.

The local_lock_irqsave(local_trylock_t *) helper disables interrupts and
sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from NMI
attempting to acquire the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().  Map
local_trylock_irqsave() to preemptible spin_trylock().  When in hard IRQ
or NMI return false right away, since spin_trylock() is not safe due to
explicit locking in the underneath rt_spin_trylock() implementation.
Removing this explicit locking and attempting only "trylock" is undesired
due to PI implications.

The local_trylock() without _irqsave can be used to avoid the cost of
disabling/enabling interrupts by only disabling preemption, so
local_trylock() in an interrupt attempting to acquire the same lock will
return false.

Note there is no need to use local_inc for acquired variable, since it's a
percpu variable with strict nesting scopes.

Note that guard(local_lock)(&lock) works only for "local_lock_t lock".

The patch also makes sure that local_lock_release(l) is called before
WRITE_ONCE(l->acquired, 0).  Though IRQs are disabled at this point the
local_trylock() from NMI will succeed and local_lock_acquire(l) will warn.

[ sashal: Reduced backport -- upstream 51339d99c0131 touches 3 file(s), this
  backport carries 1. Not backported here:
  include/linux/local_lock.h
  include/linux/local_lock_internal.h
  mm/memcontrol.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 7e98f8563956 ("mm/slub: fix missing debugfs entries for caches created before sysfs init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 400563c45266e..42d75afaa7020 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -317,11 +317,8 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 
 #ifdef SLAB_SUPPORTS_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
-static int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
-static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
-							{ return 0; }
 #endif
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
@@ -5103,6 +5100,13 @@ void __init kmem_cache_init_late(void)
 #endif
 }
 
+#ifdef SLAB_SUPPORTS_SYSFS
+static int sysfs_slab_alias(struct kmem_cache *, const char *);
+#else
+static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
+							{ return 0; }
+#endif
+
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		   slab_flags_t flags, void (*ctor)(void *))
-- 
2.53.0

