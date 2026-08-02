Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08042A80;
	Sun,  2 Aug 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785657661; cv=none; b=rfL7GeSb+hjNeo/x8+8cQyQKzXxaYFmIZq/8UB9WgeF6GKlT75czwxetVcaUH35LEkwbCJZ0fgjMMr7S0yBZu//5TWWsGiwmFnyFd/heCpyl7WD7mOMnsx8c68zYxASXSoEFiRrVwPtyeKjXZLnmefuPEPe6y2NOh94lyI9cg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785657661; c=relaxed/simple;
	bh=h2Y318P01d59xwR/WCY//9NEgCWv2F/2Z8GjA9mfyL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UJ9COdCoIP/hP6rGIaoYsPDsD++jeFwN4euAJp00yYFx+94k/LYITjp0j0V1LnWhctVBhjUwPu5B9NsiFFq5T7jtruMd+J2pkgMhzRyVq2/xiIe0Xhg/h94pHsNicqmPJx59B718sIa4uUGGhH6tB2aJcLUJ2TvCTd3COiE5b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4OrSIma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXY6Qdg+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4OrSIma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXY6Qdg+"
Date: Sun, 02 Aug 2026 08:00:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785657652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umbk5J5aCoy4rxd4oT1izA12X0gH0p+mnt5u56sbcwc=;
	b=Z4OrSImaYSGkvE3rNF5yJFj2gj/TrhN2mqqBUt7p+HdJKOGRZOVmZ+3RDTsYx65oVWdMof
	ZuzTfwI31RSQYzJ9QOmdtJc1uLAXxWFwkU2NlmkEL+Zn3Nav8HBq1grvKo5bc4/U1WfXYF
	XRgDi0QWvURgkJ6ZjgZdSfscmSBukFBIKiYgX4fJtsTSsxCO3IH29l6eStnk+CH4o5ydbF
	oaGpouQGs4khq043OZfcWy9jKhCeRxUliuzfXu5xcOzhOJoev6Lajyr8FfPRpZovIopw1Q
	mCLtMppW8cP7D3HTL+AWoxtIbfenNhX2l3A8RBSEEFdVl3vlPjCeZu19q/jpPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785657652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umbk5J5aCoy4rxd4oT1izA12X0gH0p+mnt5u56sbcwc=;
	b=sXY6Qdg+5/eT+w7ttyhnOFoQ7dS3atFGZ8TaqVx8U67KXAQR/NcLzZsvJ2uRsuEhyKf7bS
	8pYDzV7J2RTN81CA==
From: "tip-bot2 for Keno Fischer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Prevent robust futex exit race some more
Cc: Keno Fischer <keno@juliahub.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260730194705.38981-1-keno@juliacomputing.com>
References: <20260730194705.38981-1-keno@juliacomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178565764983.1210945.12829743922221592811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     6d4514ca9cdf61fec4ec634cf50386f6f7e69748
Gitweb:        https://git.kernel.org/tip/6d4514ca9cdf61fec4ec634cf50386f6f7e=
69748
Author:        Keno Fischer <keno@juliacomputing.com>
AuthorDate:    Tue, 21 Jul 2026 00:31:48=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 02 Aug 2026 09:57:35 +02:00

futex: Prevent robust futex exit race some more

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
                                        uval =3D=3D A | FUTEX_WAITERS
  A robust unlock: store 0, FUTEX_WAKE(1) wakes B
                                        uval =3D=3D 0
  D fast path acquire: cmpxchg(0 -> D)
                                        uval =3D=3D D, no FUTEX_WAITERS
  B killed before acting on the wakeup
  B exit walk, pending op: owner D !=3D B -> no action
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
Assisted-by: ClaudeCode:claude-fable-5 tla+
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730194705.38981-1-keno@juliacomputing.com
---
 kernel/futex/core.c | 85 ++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 179b26e..2650d1e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -982,8 +982,11 @@ retry:
 		return -1;
=20
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
@@ -992,42 +995,70 @@ retry:
 	 * 2. A woken up waiter is killed before it can acquire the
 	 *    futex in user space.
 	 *
-	 * In the second case, the wake up notification could be generated
-	 * by the unlock path in user space after setting the futex value
-	 * to zero or by the kernel after setting the OWNER_DIED bit below.
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
 	 *
-	 * In both cases the TID validation below prevents a wakeup of
-	 * potential waiters which can cause these waiters to block
-	 * forever.
+	 * The key issue is that the kernel usually (at least from
+	 * sources ii. and iii. or when so requested by userspace from
+	 * source i.) only ever wakes *one* waiter at a time. If this
+	 * waiter dies before acquiring the futex (or setting the
+	 * FUTEX_WAITERS bit), the kernel *must* still wake the next
+	 * waiter down the line to uphold the futex invariants and
+	 * avoid lost wakeups. Note we do not need to handle state C,
+	 * as it does not matter to us whether *we* successfully set
+	 * the bit or a third thread did so in the meantime.
 	 *
-	 * In both cases the following conditions are met:
+	 * Therefore, in these cases we must issue an additional
+	 * futex_wake(). Note however that we *must not* set OWNER_DIED
+	 * here. Our thread is *not* the owner of the futex.
 	 *
-	 *	1) task->futex.robust_list->list_op_pending !=3D NULL
-	 *	   @pending_op =3D=3D true
-	 *	2) The owner part of user space futex value =3D=3D 0
+	 * Thus to summarize, the conditions for needing the additional
+	 * futex_wake() are:
+	 *
+	 *	1) @pending_op =3D=3D true (the thread has not finished the
+	 *	   mutex operation)
+	 *	2) The futex word is in one of the states A, B or D
 	 *	3) Regular futex: @pi =3D=3D false
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
 	owner =3D uval & FUTEX_TID_MASK;
=20
-	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
-			   FUTEX_BITSET_MATCH_ANY);
+	if (owner !=3D task_pid_vnr(curr)) {
+		if (pending_op && !pi && (!owner || !(uval & FUTEX_WAITERS))) {
+			futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
+				   FUTEX_BITSET_MATCH_ANY);
+		}
 		return 0;
 	}
=20
-	if (owner !=3D task_pid_vnr(curr))
-		return 0;
-
 	/*
 	 * Ok, this dying thread is truly holding a futex
 	 * of interest. Set the OWNER_DIED bit atomically
