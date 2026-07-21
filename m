Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC078F26
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784604443; cv=pass; b=C2ua2XnRPkilxPLaOaHf+BKfv2hmm1KvBEvlB3R3tZ5UwI/Wjwb+oIEHnVGnqtV7oA9jfUigVCUWgo35CgXOwnoBlMgUUmfvUm89xOFdRkADHPvihiWhf0Hwh0BKcEoueCBfx55GvBzaiy9/P8eMzzTwPswgm4KjPoVDID9IPGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784604443; c=relaxed/simple;
	bh=JYBYU+jtSiEue8NdQ7e651hoz99zhi0ALPqBc+1w4ag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wr4nDZtzMsWFo9GYPs34zC5bnnQ2gZZrYg3fg8Ts0iQIs1WX08kkLcRP+XqmKbLDJKSCHrodCTQ8JlAuD5NwiuttZoeXNqC7FqqJu8BBuCNfOxGvkUjsaMZCUbixIcnmxbbYT71sRxaeaBJq7KpSm+vXcA7YDR4GA23DQzGFOwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=Z2kWpdMg; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="Z2kWpdMg"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e7c6ec9dbso567791685a.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 20:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784604441; cv=none;
        d=google.com; s=arc-20260327;
        b=bDfE7fdkRHBy7kIu9kDwYJ3Vbc2oIg/Ndr+FOKv//nRPcvRjSdNa+h4AunrpFZvAkz
         8iC1Ly5RyLhJeow3w7HT6t86KM3g647tv+7it2KIIkMn12O+rg9BOm03xBSOui5PeMGJ
         kjIu1CY5cf3Yv/7G1t2LKiZjrJOtLn2xHYS2Lmw3SPQsUmZL8oL68thj9pNv9emBR1WG
         jYG/YFqoTUrdLAUuziNS5tdioGCXA43hE6AxKrq/XN6mxsBX/6Pk3VkOm1Rpw4FLX0Vh
         wGVs9799zya1v9MXZHFuS1KvSLiZ8VI/OQSI50oILTX1NV0/wcM91rfRqhW3GQ+U1HKv
         ugug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mHQKqY1/BfkLRAsfH7YV0mBC6o6vDQ26SGqSUQmkpgo=;
        fh=du0pflmzstsx1meqfov9lWy+cum6bMP//X+O6GnNaNE=;
        b=OqEs7E1Z4eCW2v3Icgu1t8saQaAfquTO1EQ4BDdC2dE9oS66Bw5OpuUmRbD1EQ564U
         0RSsC3QhU53K4wgv5OW+QT+hcyvliIofEDpFdSwU0PeMDzQl8sBJyVjUjcDp7D+sxXoD
         8d0UPd7o4PAL+/YEzbuH3jrUPZlEvNOwaxlYERHQVCBgkQhV8P5c4tZwy5li/X7oa04Q
         k6gXCVFiuAx3UoVrmXPrvGuXrziSfwz2XROxb8a9TlJy83z11hjax8VnUNzDl39gjX3v
         em8EbcN2L77lZZc/hD/djKBy3b6oCRaWfxKf64Cvt8g2nYIBg5sPMkP+R8neSZCU1CDx
         7z4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1784604441; x=1785209241; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHQKqY1/BfkLRAsfH7YV0mBC6o6vDQ26SGqSUQmkpgo=;
        b=Z2kWpdMg0JUm4rWcx8UjStK20dwvTcZFvKgO83fj82PWfoJwlU0inTpeUc2NaB5rjK
         jVRjqxRFw/kBWe0/aWhHPM1cWllQFhSTQz0y3BXzCrR2DiQAuQ36mCKB2boK3cQExjB4
         blrdEJblSiHVHcdCVhECkGHwMcdHr5ku4/MkPjOJvJCTjL6CCtil9Ej4CfaUUqp1oA12
         oAMc+M1KFNPhCIQ7Vj7QHV6pcZjXBXUasZQ35tWLZL678i0S9OGN+64DB7uoj40Mh/Vm
         ln9QdYBsYcfZjtB0rY3f501oAblJ0hLGqvcny39YpSBeXyCnTzaTc3CycY+B2MeGrKUC
         OEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784604441; x=1785209241;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mHQKqY1/BfkLRAsfH7YV0mBC6o6vDQ26SGqSUQmkpgo=;
        b=nSe2w2w+uuC3YDuLohPBHf4Ysa66DZo8IuOSjY48dat8rQoyDcBk61pH2dE3Oh8vhV
         iVonqyKZEpnbAn4Pp/y8h+dzN4anBiorkGbYPXNDKHeniOyer84NZ+/DSYyi+gxSjhFQ
         PKUBOA3Ehi8nx+VBxDoaTnqxacoVn4XqplQGbXgeoi7TTQQigpawViZfUrqsquRZ0aZf
         GCUpAIxs9JqPHeLqnmAt81HFIbhDAwyNK6S8zbIEh5oCp6eHCK+Ur41/i7x1AAqg0kMb
         c0jGzWAPiBRHUmGxY6Ju6nd+cn6a/wwqxzO4zjeNGU9tKtOOf9eB9O10ewiiVkyXymR2
         XSUA==
X-Forwarded-Encrypted: i=1; AHgh+RrWypixsqTPmI/ljuRGH6diJ4F55PO1uo4+1Ci3tAF0x/nN2D2AG0aUuVSIVxHbR9lIC0dnN94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSmC1HwXriGf6asCafkikL3GeIZawuLknzS/c4zAIP0etd/uD
	z6SM7Dxc5eSJZmP1ZHavOBV6Yk+9VuwYwGt+NotZ3T0KAf0aOy71Z+HL8ecy5LwR1NiHPSAO6uY
	J0hLU63LYjBTGOLmAladJE8GmcCtWpTvrn+IsQYGz/jxF5rkIkcp/
X-Gm-Gg: AfdE7ckg17njDyAtx+GmQAtAfKrYU/K1y7PwpO6W/04kZ4uCqHLgX4EMsr+so0+hZyy
	YjsKQwaYLVA9byXLRe9nWydbsFCDkUnHM88reWmQpDMnMxn735Wc0FJnA9iXBIZI+IbqiKj3aFg
	1tjutWVmhg1z8ug7K0tpiTkfCuRPdW7kWhDCxTbYjgpPDlYhQJbVFm7Xe0oojL0DRR7am3CmU7k
	zIp4OOXTsPHAkAbaIP9jgxP7uK1cYwOs6WHtP8pE1Fb74EhYhHBi5vEIRYp+XRHoYXlXdgNxxM3
	qokO3HUhsK/Z11JlbA==
X-Received: by 2002:a05:620a:2b98:b0:92e:e29a:8d79 with SMTP id
 af79cd13be357-930b433e248mr1623306685a.82.1784604441007; Mon, 20 Jul 2026
 20:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Keno Fischer <keno@juliahub.com>
Date: Mon, 20 Jul 2026 23:26:45 -0400
X-Gm-Features: AUfX_myzd-JJDENqN6jLIcEo04Ff_IUtTDjZeySo2d1PHDxGHu3sN9guAFKlYAk
Message-ID: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
Subject: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

This issues was discovered as part of a larger attempt to resolve the
long-standing issue that robust futexes are not safely usable across
pid namespaces. I will be submitting an RFC series for that proposal
at some point in the near future. However, as part of an AI-assisted
attempt to formally verify the correctness of that protocol using TLA+,
I obtained the above described counter-example which is also present on
current mainline. A standalone (AI-generated) reproducer showing the
lost-wakeup issue using glibc pthread mutexes is available in my WIP
repository for that effort at:

Link: https://github.com/Keno/robust-futex-cookies/blob/main/repro/robust_lost_wakeup_glibc.c

---
 kernel/futex/core.c | 85 +++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 179b26e9c934..74aa6aa87eb9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -982,8 +982,11 @@ static int handle_futex_death(u32 __user *uaddr,
struct task_struct *curr,
                return -1;

        /*
-        * Special case for regular (non PI) futexes. The unlock path in
-        * user space has two race scenarios:
+        * Special case for regular (non PI) futexes. Ordinarily, we do
+        * not perform any processing here unless the current thread was
+        * the owner of the futex (by the TID check below).
+        *
+        * However, the unlock path has three race scenarios:
         *
         * 1. The unlock path releases the user space futex value and
         *    before it can execute the futex() syscall to wake up
@@ -992,42 +995,70 @@ static int handle_futex_death(u32 __user *uaddr,
struct task_struct *curr,
         * 2. A woken up waiter is killed before it can acquire the
         *    futex in user space.
         *
-        * In the second case, the wake up notification could be generated
-        * by the unlock path in user space after setting the futex value
-        * to zero or by the kernel after setting the OWNER_DIED bit below.
+        * 3. A woken up waiter is killed in user space after another
+        *    thread has acquired the futex, but before it can set
+        *    FUTEX_WAITERS.
+        *
+        * Note that, if userspace uses the FUTEX_ROBUST_UNLOCK flag, we
+        * will not see case 1 here.
+        *
+        * In the second and third case, the wake up notification could
+        * be generated from any of:
+        *
+        *    i.   An ordinary futex wakeup after unlock (with or
+        *         without FUTEX_ROBUST_UNLOCK)
+        *    ii.  A robust wakeup from another thread's death
+        *    iii. A previous round through this special case
+        *
+        * As a result, the futex world will be in one of four states:
+        *
+        *    A. The futex word is 0 (unlocked)
+        *    B. The futex word is owned by another thread
+        *       (FUTEX_WAITERS is not set)
+        *    C. The futex word is owned by another thread
+        *       (FUTEX_WAITERS set)
+        *    D. The futex's owner died and OWNER_DIED is set
+        *       (the owner part of the word is 0)
         *
-        * In both cases the TID validation below prevents a wakeup of
-        * potential waiters which can cause these waiters to block
-        * forever.
+        * The key issue is that the kernel usually (at least from
+        * sources ii. and iii. or when so requested by userspace from
+        * source i.) only ever wakes *one* waiter at a time. If this
+        * waiter dies before acquiring the futex (or setting the
+        * FUTEX_WAITERS bit), the kernel *must* still wake the next
+        * waiter down the line to uphold the futex invariants and
+        * avoid lost wakeups. Note we do not need to handle state C,
+        * as it does not matter to us whether *we* successfully set
+        * the bit or a third thread did so in the meantime.
         *
-        * In both cases the following conditions are met:
+        * Therefore, in these cases we must issue an additional
+        * futex_wake(). Note however that we *must not* set OWNER_DIED
+        * here. Our thread is *not* the owner of the futex.
         *
-        *      1) task->futex.robust_list->list_op_pending != NULL
-        *         @pending_op == true
-        *      2) The owner part of user space futex value == 0
+        * Thus to summarize, the conditions for needing the additional
+        * futex_wake() are:
+        *
+        *      1) @pending_op == true (the thread has not finished the
+        *         mutex operation)
+        *      2) The futex word is in one of the states A, B or D
         *      3) Regular futex: @pi == false
         *
-        * If these conditions are met, it is safe to attempt waking up a
-        * potential waiter without touching the user space futex value and
-        * trying to set the OWNER_DIED bit. If the futex value is zero,
-        * the rest of the user space mutex state is consistent, so a woken
-        * waiter will just take over the uncontended futex. Setting the
-        * OWNER_DIED bit would create inconsistent state and malfunction
-        * of the user space owner died handling. Otherwise, the OWNER_DIED
-        * bit is already set, and the woken waiter is expected to deal with
-        * this.
+        * Note in particular that in all of the states A-D the owner
+        * portion of the futex word differs from our thread's TID
+        * (unless the actual owner has the same TID in another PID
+        * namespace, but we cannot currently distinguish that
+        * scenario), so this can be a special-case wakeup in the bail
+        * path of the ordinary TID check.
         */
        owner = uval & FUTEX_TID_MASK;

-       if (pending_op && !pi && !owner) {
-               futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
-                          FUTEX_BITSET_MATCH_ANY);
+       if (owner != task_pid_vnr(curr)) {
+               if (pending_op && !pi &&
+                   (!owner || !(uval & FUTEX_WAITERS)))
+                       futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
+                                  FUTEX_BITSET_MATCH_ANY);
                return 0;
        }

-       if (owner != task_pid_vnr(curr))
-               return 0;
-
        /*
         * Ok, this dying thread is truly holding a futex
         * of interest. Set the OWNER_DIED bit atomically
--
2.54.0
