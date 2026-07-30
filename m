Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025448987E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440836; cv=none; b=c4k0uxbgBQUOpXYHAx+S4VuVrDJYvTzfGquc6AkEe8MXlmK/c+m7uMYw/EL7VKcOUX7vg8cv5wvHfHr0qXtWNqxeC6cu0vG6wpx5RxPIsmtFRc7sURPjwGwvL2LlkE5RDqtnuL7+zcUSgFuAMKXEV8urdB0F1a5yQLKQEEU0b2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440836; c=relaxed/simple;
	bh=nXixH6nt2XfYK/dQ76AFpkMMR6fiDWnJarV9i2ZM8gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzWSEsEOjvCGDeXgZ7A/UY8irrD/pR6L8XNTeFUz2IOCz5fe+oBVxUYg/qzM1qj4piKqPuTOgrgkbBlcb+ETyrfCNhIIvm3luS4GMfUrlGOV+nI0WYzBx5RsdvfJv5qDREUtu6bfQ4w1JGFZWES5Q+TRhW3EBUdk6ajvRdfF1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliacomputing.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliacomputing.com header.i=@juliacomputing.com header.b=iJ5qtCcn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliacomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing.com header.i=@juliacomputing.com header.b="iJ5qtCcn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e55b62640so13992485a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google; t=1785440828; x=1786045628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvFwAwMbzOY7OPPRp93D8W68jJdI4OeP8HTppECTiVE=;
        b=iJ5qtCcnq14NdTLwFvJQs3+2QqS71fvBotdo1dSgfktL/wkCdnCdxkR1FuoMLk1qZQ
         QEDNiRDwoy+hzMPTLY5xNjp/W+mjiahMVqc/kuoOQ0YaPl3x8AVe3lGTGDQ4x7Xuxqfs
         L77dGHV4Ih+5pdu+tC7J2kzqBTfDAXmo9ZvZ08M6RKwnxADeF2GwENq2N3xZJxTnR5Rg
         WfY71gdu87MUrcHtwHgGKFES4ug2kkVaf9VyR0TxezdZNTtesb7rtN+DHIUo5M2FL2OY
         8XKbYeJLiBJFVbxqS5oI23wx7HNzI4l1lbTaO5JE5Kr35WOoRD+2JT6qSQjWQI9CKB23
         eKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440828; x=1786045628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvFwAwMbzOY7OPPRp93D8W68jJdI4OeP8HTppECTiVE=;
        b=L2SzXoed95+MlGzbJWcXJTrVqLBJeVapE3ZdxmvRxkgMYv3yiqlkwJYdj1TVVD/aa0
         kPSMFpEt4X0eT//NBgqVF3dRRIhN3d2V62RSO0z+nPGYPRIxfAKo4se8tpm698HLmqr8
         7AW9iLDG/8wtB/y97eqabwMDRo6pucdHPjMfPzoRW9djKnBRgi6u33EDDryVeCnX/+4A
         SXgDflMR7nURDvnI9c1FZL4ETJ3alRDMUzed0VlXTkfaW2UHI329eHzgV+DktnFQkaRa
         dwL/SO0V+rdMbw0Y6KKFxtKHY6IGmRax43yTM64Oba4ARfGyj+KHQTfSWnxJa2EhZrRo
         jKdQ==
X-Forwarded-Encrypted: i=1; AHgh+RorMP4tEFFW36ruJoateMLtYytCoGge62wG1aEnoMR08C4rRtB3nXMNJ0p5KtBRXo6goGF+RYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4TMowchz81AZ6/cpxozAhnr/h8lbaNSjIZHs55CALlEuSulj
	RXs5kHOE/kPwNWFQNGbKv6S8oyxETSkKgO20Ztu99X9JLKTJIJV6FwAfN8v3WnyhLkk=
X-Gm-Gg: AR+sD12T1UtNUquQbzPgSP7FPczHGVvgxsBkzgHoBeapdwDEUheOV/0VoaoeQ2s/ry0
	xWvhLncoYOXaK/wd/idGvZp+hHLqGcbxN+uD7gyNLnZjqd2JUCwSTByvcsULLLDyr4l/LVcztwi
	t6B9QaCEz1WhJFg/CBC2lKBhJaGQju0NgxB5u3WBrNIpQbd3li4ua137kvRRYv1UuXyOhfN9zPB
	6OW3XSAqPe1y374JZgsvZMWIQJtGkdQI7B7cQZBPQEYork8c77oirqH+qhz08M/yaftxeajjRfo
	ACNVVKsNCzNnHDY/Ws/MTxQ6WmlJsU34oZ50sPCgGl6Nub9BC0H9THkilt8RktJrrhpPWH2PP5E
	Cbx/DiW13nOjBKCFQKIVYmRn4ZHnnempLsbYlFcT1aBM/zSizDRyFZqhxKacEKRPQc7LWxxiMo4
	Ry+3UfkcleRw6T36gIvm4DcTAm/hqev0115RopsL9pM16Mp0VAzPYPaB8dMBbOjPOohw6jQsNXo
	XPds13E5oTMgKfDbAz1okZEthtcECoPy/gJsOfMrViQIjadLbuD
X-Received: by 2002:a05:6214:319f:b0:8e9:f5de:d5be with SMTP id 6a1803df08f44-908347b861cmr42116836d6.53.1785440827807;
        Thu, 30 Jul 2026 12:47:07 -0700 (PDT)
Received: from localhost.localdomain ([66.31.114.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9083231e22asm25416506d6.15.2026.07.30.12.47.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 12:47:06 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
To: kenomfischer@gmail.com,
	Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Yi Wang <wang.yi59@zte.com.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
Date: Thu, 30 Jul 2026 15:46:58 -0400
Message-ID: <20260730194705.38981-1-keno@juliacomputing.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87tsphezff.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com> <87ik5yhisv.ffs@fw13> <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com> <871pclhpqy.ffs@fw13> <CABV8kRy2tQ50sBD-EGbKg-TANbVyE2m29eciCAomGGeZ2FeL3Q@mail.gmail.com> <87tsphezff.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 08:58:44 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
> It's slightly less mangled than the original one, which replaced tabs
> with spaces in some places, but still fails to apply out of the box.
[...]
> Please send the patch to yourself, save the mail and try to apply
> it with git am.

Welp, I learned yet more about all the different ways in which our email
system likes to mangle things. I hope third time is the charm. I've
sent it to my self and `git am --scissors` is clean on the downloaded email.
If anything is still off, please let me know.

-- >8 --
Date: Tue, 21 Jul 2026 00:31:48 +0000
Subject: [PATCH] futex: Prevent robust futex exit race more

A robust futex unlock stores 0 over the whole futex value - wiping
FUTEX_WAITERS - and wakes a single waiter. That wakeup is a one-shot
notification: the protocol relies on its recipient to either acquire
the futex (and eventually unlock while aware of the remaining
contention) or re-arm FUTEX_WAITERS before sleeping again.
If the woken waiter is killed before it can do either, the kernel
must jump in and wake the next task down the line.

This is a known complication of the futex protocol with a previous
partial fix in commit ca16d5bee598 ("futex: Prevent robust futex exit
race"). Unfortunately, that fix is insufficient.

If a third task re-acquired the futex through the uncontended fast
path in the meantime, the notification is lost: Robust exit processing
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

Fix this by augmenting the robust list exit processing to also
perform the extra wakeup if the futex word is owned by another
thread but FUTEX_WAITERS is *NOT* set.

Fixes: ca16d5bee598 ("futex: Prevent robust futex exit race")
Cc: stable@vger.kernel.org
Signed-off-by: Keno Fischer <keno@juliahub.com>
Assisted-by: ClaudeCode:claude-fable-5 tla+
---
 kernel/futex/core.c | 85 +++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 179b26e9c934..74aa6aa87eb9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -982,8 +982,11 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
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
@@ -992,42 +995,70 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
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
-	 *	1) task->futex.robust_list->list_op_pending != NULL
-	 *	   @pending_op == true
-	 *	2) The owner part of user space futex value == 0
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
-		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
-			   FUTEX_BITSET_MATCH_ANY);
+	if (owner != task_pid_vnr(curr)) {
+		if (pending_op && !pi &&
+		    (!owner || !(uval & FUTEX_WAITERS)))
+			futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
+				   FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}
 
-	if (owner != task_pid_vnr(curr))
-		return 0;
-
 	/*
 	 * Ok, this dying thread is truly holding a futex
 	 * of interest. Set the OWNER_DIED bit atomically
-- 
2.54.0

