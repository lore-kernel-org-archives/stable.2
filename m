Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAE46D554
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711413; cv=none; b=VvgqsJSh9hJU6wj9c4/5Pz/bSdp+t1/vItwUiYiqB5DbW/OAPr0qxWaNeaBgFSxwYFDV3gqP/gS+/vjktfH/irMqmS3vHByhUpHeZBfwXGpKCJMiBfe9rnfr6dKsupyYaWJfezIUQ3HrrapTdQZepxe64SftjspWmh7lYK+UGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711413; c=relaxed/simple;
	bh=P3rumJlFCoxww/XmhSm36HlpRMUjcKpDZh5WTMzYmqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGUChMTiknsBxun6xCziWnNQJ20Szno8mazsDZBJfExbUkhCs+5390pu4WKo3j8Z0hIejMJWwc0ZbUlQpWgVHEamWw6Ivw3Zn2fsFsBNGYKD6Aek0BV9SS3+FruOLquzaCc+GXs2GEvUmAiHOqxgrr0jXAnWt0skBUlw7ZdJ0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQLxcX9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQLxcX9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248DF1F000E9;
	Fri, 14 Aug 2026 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711411;
	bh=tcqpRCUlOOOkdoKx24DFstJm3k55sKr6KeY+oCc/HI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OQLxcX9DUlgEOt6A0IxR/+9P6rIl1Z+YEBPV1WszStv0rA8cCtxpWBGfHqNUo03wf
	 mXcakPMAUMGliCiyyyFwzKA4uMZ2KuSKi4vfv19ZVwL1/WpxoWtnEqJWICEOHVSms4
	 Z/xRwJ5DHvPqSUhYzhZxQjpScsHo7YChPzHJBTBs2VVT1SJ6BzdhtyujtUaJcuFfEP
	 Fbi729TYTZ6GgWKaoTR/l/0HseLq3Nc9q1jbU56He+rw7C/A/RjY2Qraild7+N3w5g
	 B5urAPS00q2F8gPQ0g6wPvqRpB65WrjoP2OtJ7Uhzyyy55x6qIotE2Np70CxUB2hjp
	 HZ+Jq01DjbnTg==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, keno@juliacomputing.com, keno@juliahub.com,
 mingo@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 7.1.y, 6.18.y, 6.12.y] futex: Prevent robust futex exit race
 some more
In-Reply-To: <2026081359-untie-chance-6812@gregkh>
References: <2026081359-untie-chance-6812@gregkh>
Date: Fri, 14 Aug 2026 14:43:28 +0200
Message-ID: <877blsna8f.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Keno Fischer <keno@juliacomputing.com>

commit 6d4514ca9cdf61fec4ec634cf50386f6f7e69748 upstream.

A robust futex unlock stores 0 over the whole futex value - wiping
FUTEX_WAITERS - and wakes a single waiter. That wakeup is a one-shot
notification: the protocol relies on its recipient to either acquire the
futex (and eventually unlock while aware of the remaining contention) or
re-arm FUTEX_WAITERS before sleeping again.  If the woken waiter is killed
before it can do either, the kernel must jump in and wake the next task
down the line.

This is a known complication of the futex protocol with a previous
partial fix in commit ca16d5bee598 ("futex: Prevent robust futex exit
race"). Unfortunately, that fix is insufficient.

If a third task re-acquired the futex through the uncontended fast
path in the meantime, the notification is lost: robust exit processing
sees that it is owned by another task and does nothing, while the new
owner sees no FUTEX_WAITERS when it unlocks and wakes nobody.
The remaining waiters sleep forever behind a free futex:

  A owns the futex, B and C sleep in FUTEX_WAIT
                                        uval == A | FUTEX_WAITERS
  A robust unlock: store 0, FUTEX_WAKE(1) wakes B
                                        uval == 0
  D fast path acquire: cmpxchg(0 -> D)
                                        uval == D, no FUTEX_WAITERS
  B killed before acting on the wakeup
  B exit walk, pending op: owner D != B -> no action
  D unlock: no FUTEX_WAITERS -> no wake
                                        C sleeps forever

This is clearly a shortcoming in the implementation, which fails to keep
the FUTEX_WAITERS bit consistent.

Work around this by augmenting the robust list exit processing to also
perform the extra wakeup if the futex word is owned by another thread but
FUTEX_WAITERS is not set.

This does not fix the problem of a non-contended take over/release and free
sequence, which has been discussed for years and has been addressed by
commit 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes") and
subsequent changes, but failed to take the problem described above into
account.

A more complete solution which is based on the in kernel unlock of
contended robust futexes has been discussed in the context of this change
and should show up in mainline sooner than later.

[ tglx: Amend change log slightly and fixup coding style ]

Fixes: ca16d5bee598 ("futex: Prevent robust futex exit race")
Signed-off-by: Keno Fischer <keno@juliahub.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: ClaudeCode:claude-fable-5 tla+
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730194705.38981-1-keno@juliacomputing.com
---
 kernel/futex/core.c |   91 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 30 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1027,8 +1027,11 @@ static int handle_futex_death(u32 __user
 		return -1;
 
 	/*
-	 * Special case for regular (non PI) futexes. The unlock path in
-	 * user space has two race scenarios:
+	 * Special case for regular (non PI) futexes. Ordinarily, we do
+	 * not perform any processing here unless the current thread was
+	 * the owner of the futex (by the TID check below).
+	 *
+	 * However, the unlock path has three race scenarios:
 	 *
 	 * 1. The unlock path releases the user space futex value and
 	 *    before it can execute the futex() syscall to wake up
@@ -1037,42 +1040,70 @@ static int handle_futex_death(u32 __user
 	 * 2. A woken up waiter is killed before it can acquire the
 	 *    futex in user space.
 	 *
-	 * In the second case, the wake up notification could be generated
-	 * by the unlock path in user space after setting the futex value
-	 * to zero or by the kernel after setting the OWNER_DIED bit below.
-	 *
-	 * In both cases the TID validation below prevents a wakeup of
-	 * potential waiters which can cause these waiters to block
-	 * forever.
-	 *
-	 * In both cases the following conditions are met:
-	 *
-	 *	1) task->robust_list->list_op_pending != NULL
-	 *	   @pending_op == true
-	 *	2) The owner part of user space futex value == 0
+	 * 3. A woken up waiter is killed in user space after another
+	 *    thread has acquired the futex, but before it can set
+	 *    FUTEX_WAITERS.
+	 *
+	 * Note that, if userspace uses the FUTEX_ROBUST_UNLOCK flag, we
+	 * will not see case 1 here.
+	 *
+	 * In the second and third case, the wake up notification could
+	 * be generated from any of:
+	 *
+	 *    i.   An ordinary futex wakeup after unlock (with or
+	 *         without FUTEX_ROBUST_UNLOCK)
+	 *    ii.  A robust wakeup from another thread's death
+	 *    iii. A previous round through this special case
+	 *
+	 * As a result, the futex world will be in one of four states:
+	 *
+	 *    A. The futex word is 0 (unlocked)
+	 *    B. The futex word is owned by another thread
+	 *       (FUTEX_WAITERS is not set)
+	 *    C. The futex word is owned by another thread
+	 *       (FUTEX_WAITERS set)
+	 *    D. The futex's owner died and OWNER_DIED is set
+	 *       (the owner part of the word is 0)
+	 *
+	 * The key issue is that the kernel usually (at least from
+	 * sources ii. and iii. or when so requested by userspace from
+	 * source i.) only ever wakes *one* waiter at a time. If this
+	 * waiter dies before acquiring the futex (or setting the
+	 * FUTEX_WAITERS bit), the kernel *must* still wake the next
+	 * waiter down the line to uphold the futex invariants and
+	 * avoid lost wakeups. Note we do not need to handle state C,
+	 * as it does not matter to us whether *we* successfully set
+	 * the bit or a third thread did so in the meantime.
+	 *
+	 * Therefore, in these cases we must issue an additional
+	 * futex_wake(). Note however that we *must not* set OWNER_DIED
+	 * here. Our thread is *not* the owner of the futex.
+	 *
+	 * Thus to summarize, the conditions for needing the additional
+	 * futex_wake() are:
+	 *
+	 *	1) @pending_op == true (the thread has not finished the
+	 *	   mutex operation)
+	 *	2) The futex word is in one of the states A, B or D
 	 *	3) Regular futex: @pi == false
 	 *
-	 * If these conditions are met, it is safe to attempt waking up a
-	 * potential waiter without touching the user space futex value and
-	 * trying to set the OWNER_DIED bit. If the futex value is zero,
-	 * the rest of the user space mutex state is consistent, so a woken
-	 * waiter will just take over the uncontended futex. Setting the
-	 * OWNER_DIED bit would create inconsistent state and malfunction
-	 * of the user space owner died handling. Otherwise, the OWNER_DIED
-	 * bit is already set, and the woken waiter is expected to deal with
-	 * this.
+	 * Note in particular that in all of the states A-D the owner
+	 * portion of the futex word differs from our thread's TID
+	 * (unless the actual owner has the same TID in another PID
+	 * namespace, but we cannot currently distinguish that
+	 * scenario), so this can be a special-case wakeup in the bail
+	 * path of the ordinary TID check.
 	 */
 	owner = uval & FUTEX_TID_MASK;
 
-	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, 1,
-			   FUTEX_BITSET_MATCH_ANY);
+	if (owner != task_pid_vnr(curr)) {
+		if (pending_op && !pi && (!owner || !(uval & FUTEX_WAITERS))) {
+			futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, 1,
+				   FUTEX_BITSET_MATCH_ANY);
+		}
 		return 0;
 	}
 
-	if (owner != task_pid_vnr(curr))
-		return 0;
-
 	/*
 	 * Ok, this dying thread is truly holding a futex
 	 * of interest. Set the OWNER_DIED bit atomically
