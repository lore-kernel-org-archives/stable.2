Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34017445AF7
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662116; cv=none; b=qtx34ze1JeKZlPn+B37gtcKi5+KzgVn2FDALysrKpGwDyaZPLaqgZpEQ7t8z2vEi03eu5SordVjS8hYfR7jtLjOy4Z+dWuIXVKWCGn4w2TRJGLfpeloThIVNsSTf8KwjZhFYE0emN1viC0DReim8iRq0CST9Q+NiZpPVAJ2OWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662116; c=relaxed/simple;
	bh=4dkDAseJb9aoVnmF253DrKmfsOBk0ebbIuzd11mi4a0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W004NWQkILO6CxeOoD6O7UYyYpMg4sjveZToaCS5/oiyevhmvkDtwv/2Z3QH7sPy1gD0DfFB0p+gxl4kF/DWWKZoeK2QI2fLPN+46EkjJ+a0nqgn+rx/Jo+C1nBkV2dFitgUZdaadLNcntBVxLxx9CP1mgxGJfcZI7Z3AKK3cbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKS6VWDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKS6VWDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1841F1F00A3A;
	Tue, 25 Aug 2026 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662109;
	bh=xpTKmJVkOI7RiRgknEb83il7zAkAmnYeOdWU5veGn9c=;
	h=Date:From:To:Cc:Subject:References;
	b=ZKS6VWDOuiImNCAjlYaWBff03juj/M1cGI4fLuQEah7IlV3wToNntBYphk6+z8+r0
	 dUXfKfjVJPvUNasw7ASKVrNtIcO6Ox0KVCwXRX7lvhBB9VV6r1rmIIX5is340Dmvm8
	 bG1BLrShk0E/dR+M8Mg0HGElPS9o5dFdZEaxkGslOjaXLqfJR8Bz+d6fwODkeo/G2C
	 mwo47lQhxh6dKbP6NGMtqTOl2xrixqP+1Lp+8slUGlfbRyjwGTWwgFiWdXy2qXIqAy
	 mGSEpJEc/GwvDi/wPZRQB+NAB1ipykRaFlIYY+p36dSV9RThu7gLde8iV2ZcJnoQaI
	 IgsdwFCLQUcXw==
Date: Tue, 25 Aug 2026 14:48:27 +0200
Message-ID: <20260825091708.452448101@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org,
 Kyle Zeng <kylebot@openai.com>
Subject: [patch 7.1.y 1/6] futex/pi: Reject cross-mm private futex owners
References: <2026082446-lumpish-subdivide-9766@gregkh>
 <20260825091624.748852250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kyle Zeng <kylebot@openai.com>

commit 59b3732f95dda1fbd2234514d35f4fb6b5bb6d85 upstream.

A private futex key borrows the waiter's mm without taking an mm_users
reference. Nevertheless, attach_to_pi_owner() currently accepts an owner
from a different address space and copies the private key into the owner's
PI state.

When that owner exits, exit_pi_state_list() uses the saved key to find the
hash bucket and acquires a reference to the waiter's private hash. If the
last user of the waiter's mm exits concurrently, futex_hash_free() frees
the hash while the owner still uses its bucket and reference.

Prevent this by validating in attach_to_pi_owner() that, for private
futexes, the owner mm and waiter mm are the same. Perform the check with
the owner's pi_lock held and after validating owner::futex::state to
serialize against a concurrent PI-state exit cleanup.

[ tglx: Amended comment ]

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Assisted-by: Codex:gpt-5.6-sol
Cc: stable@vger.kernel.org
---
 kernel/futex/core.c  |    9 ---------
 kernel/futex/futex.h |    9 +++++++++
 kernel/futex/pi.c    |   20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 9 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -133,15 +133,6 @@ static bool futex_ref_is_dead(struct fut
 
 enum { FR_PERCPU = 0, FR_ATOMIC };
 
-static inline bool futex_key_is_private(union futex_key *key)
-{
-	/*
-	 * Relies on get_futex_key() to set either bit for shared
-	 * futexes -- see comment with union futex_key.
-	 */
-	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
-}
-
 static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
 	return futex_ref_get(fph);
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -126,6 +126,15 @@ static inline bool should_fail_futex(boo
 }
 #endif
 
+static inline bool futex_key_is_private(union futex_key *key)
+{
+	/*
+	 * Relies on get_futex_key() to set either bit for shared
+	 * futexes -- see comment with union futex_key.
+	 */
+	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
+}
+
 /*
  * Hash buckets are shared by all the futex_keys that hash to the same
  * location.  Each key may have multiple futex_q structures, one for each task
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -465,6 +465,26 @@ static int attach_to_pi_owner(u32 __user
 		return ret;
 	}
 
+	/*
+	 * If the owner is about to exit() or exec() and tries to modify
+	 * p::futex::exit_state it is serialized against this code by
+	 * p::pi_lock.
+	 */
+	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
+		/*
+		 * A private futex key holds a pointer to the waiter's mm
+		 * without holding a reference on it. So it must not be attached
+		 * to an owner in a different address space. Otherwise that
+		 * owner's exit cleanup could access the private hash after the
+		 * key's mm is freed.
+		 */
+		if (unlikely(p->mm != key->private.mm)) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			put_task_struct(p);
+			return -EPERM;
+		}
+	}
+
 	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 

