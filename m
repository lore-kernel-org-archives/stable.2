Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89173F822F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662083; cv=none; b=fBGZXY+J1v0kZ6LPjwqf0je1XeoJhKDrlJf4ASZ9ua2qrqVrmDiBB4uwyqUbUMwAdiYZC11yaN3i74+7uIe8sNyMX6/sqCehwnk0mOAfMTtUmsaIbPbUsvMYWTOUY9fI5bzy8VLnqf7N8GrRY47Zh64Q2AVQw0YtSw8StKz1jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662083; c=relaxed/simple;
	bh=24zpsI1gGRsFd9uKNOMsCc5s/sUyXN24CKtJHD9GltY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VCRSq35Vyss6IXgwdVNSZy4SSoPlImFdS7G108dY6wu8+WiWMjKNuainjTQ8Kuxmr50/a4OSqe+9Kj7h/2LfIDY4072tlnrfGp/am1ZOeTnmipavPx02O73wc6WQ5CZX6Bnl2sDey2S3a35HVt9YPO51b6Kaf50FozPqw4WO8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2mzkA1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2mzkA1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541E31F00A3D;
	Tue, 25 Aug 2026 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662080;
	bh=A03kLdEnshyvAiHHmrlhcYEw/2BPAN8li8zKLAOxmP0=;
	h=Date:From:To:Cc:Subject:References;
	b=f2mzkA1jFY2A/gp0sEWiPJg2Jhr8QlFo1bhFlR7FJyAT+dAqbTa7nF57pNjMAHgBZ
	 J11sbQq65yOOaPAl3BAJW5ioIcZf40AgrjbxbLfAGl4tnQw5BQbwjzGGZTCixg6R6h
	 GpQAKYfVo6u5MIFmVqEfUG1gA0EKnjiOpTjTg+8ptzDtnsCVWNYjQo+1zjHCDwXx0D
	 VjzuzazEw+fWk+iJHHt7sggW4Cyc6xBCl6nM2rrZT6uIJLt0iTaxwHVWUtw/umGFwd
	 HN+gAyraUocfkrJPhQZst4OpVXX2GBnPpuz91lL+DBp/Q0Y6Je8Awmv/xWgHAuNnJS
	 Tq2UsKkKaRc/g==
Date: Tue, 25 Aug 2026 14:47:57 +0200
Message-ID: <20260825091134.516981925@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 Kyle Zeng <kylebot@openai.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 6.18.y 1/5] futex/pi: Reject cross-mm private futex owners
References: <2026082450-shoplift-anew-8412@gregkh>
 <20260825091033.136528074@kernel.org>
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
@@ -464,6 +464,26 @@ static int attach_to_pi_owner(u32 __user
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
 

