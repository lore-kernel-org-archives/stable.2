Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064F483BCF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336469; cv=pass; b=LOW/EF444IeyhMvPRNp2+jY5Gk+TaThEVtTpHZaoOKCdl1i9HHdAOzvDl89RgffZ4nO6cFKqGIWRteZpuB+hvmaObX9UlOaEvQc74v0xaC0vZ+HaSxEWj6vRoxmDT/XO2z87geTrj4KcMU/Zg0Ix5fnQNYhhav/1Pb3MXSjrkV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336469; c=relaxed/simple;
	bh=58hGK+mJBXZeu3NHqzFpFFljr9xHdrXuXMZG1JvAczQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGRZQ7m1+CdaMw49vllWzopT4SAMuKoidwamNWsCXT0cTXr+bJF+TAN/39uWd5CmLszo1jO6GfMg2euKl8RSdAQRtIAFNG/FrUziO4L9DdknHt9cD/ruzEuaVwCgN2BkvREga2KKakNfgqW8Co6FGi6z3x6aggBzK6iBqJqQ9b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=Fkh3Fxj6; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="Fkh3Fxj6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e533aacf2so60975885a.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785336466; cv=none;
        d=google.com; s=arc-20260327;
        b=OWPluOpn/veJBvNrBbg5WXizj4YVeSoTLZbnqZVgh2/4AvQzwBquBgvFM07r5C76Px
         qEs7va21kGBg9DDCqYQRz4h/9p9IQMQJkdKN/11tEKnEX/WSIzEL7GJsgNoEpeEa+uyV
         TTu8mRtMpnouusjwEynKlhkzLEmxxp+wv/YER0tbr2dYz8PmUDtxoFbtT33DcL8qfPc2
         2cQtSpZYb58b3xdNm6gXdZZ2qjNR6tCDNIGxKq7MORdcGiMMhJUZqJu9iu5hHaD+Zt8K
         ll8DZfy65njNZpDs03GqVo4/6/LesG4C3s6E9YGTH+yJFeyBkSgAYG3PToOFkB1511IH
         Twvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=vx57ScZT4MwmakGz35Zm+QwjmP4PhftQRyy1XPC5gZ4=;
        fh=nXzNKlm0eeac+7re0Ym9a8kSePjNw2Y02pcbB7B8e08=;
        b=i697pJOuDz3JlYVdSQZawKfKEDC0WEKejt3vpOsWcrNzylK9Va+PTgII71FGH6Q0NK
         X3z819/sd1TeylJQlyRJsvwKYngHtxL+mxvyJglkLCKui8k+fDBClGtH+0KtYBP9Vm3O
         QJa0Lcp7sEpFwPZspil+vgOH7815pe4DqhIuMBz8wHne+cRyUO4pSn/AZNc0Cp/bwBM3
         cBlAndtj1w2uf/FpHKS2X2dpyA3eVZ+q+jbNMEspA/L0xQMO++VXvN/qRasX1+BlZfBt
         4a7/hLNZr+k1FN1Q3wRj858VsjJORsUbEA+wY+ax9hAkwYOHCM+fFBgPx88IXnMtiFVL
         wk1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1785336466; x=1785941266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vx57ScZT4MwmakGz35Zm+QwjmP4PhftQRyy1XPC5gZ4=;
        b=Fkh3Fxj6CjJa2uZZdbzDWGJ+M3utHEd8Qz1N47hGU/SR+8BaUymp9i+ll3clvxLMnk
         QC73SG4DqUO5OZj5saoQQ+aGF07cZR6CE2edXJb9//an3+t7W4vD+b2fBGvIqRYPRcFV
         Z4CijhHrFJavT75RzsrHuuoL6FzsMBoD4PD0mx6X4tM/o5ZYIe4OILt+8q5YESk22aU4
         IqD33vgbcuwPGI6YlpDb4pH3wFFGMFnwadeHd0pWB8zQ/I9CiZF1VHppYBnfYlHgeKY0
         PuWM7UvVO98qJHd5B6pZkHGZhEyxF/eZkWbQTg9RaAM3BCS5nQK9o0KSDkWb/4NhFDnQ
         XJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336466; x=1785941266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vx57ScZT4MwmakGz35Zm+QwjmP4PhftQRyy1XPC5gZ4=;
        b=QcjPl4dfFcWYbLoXj3mSFx0Lfgz6ZlvflslFFd5bnMXi6h+zupoS/t/leqOtRVr8al
         bIin2gCp1ZKAdNvM2ALPxxRiN5sGK+rQZIbFzQ6Hus6a+1N8zej1augGQm7tibMDhQaX
         RQGjelVpObeQzeWICal0vIgY/eHpQV1p7p9cdySwsAR1YQ7UskBouC4UkBounq5UZYvE
         0Cn7Q+TrZ9p6nEXhxEcH1qI7nKMlfc14K7+cDT3dlSfPrLVAQOGN4SXU1POUOQLFFyzU
         bcR8IoFWAOhqtm3RXJt/5OQrETW5Wq8wlnwA3DuCxnwyZqhvlb+E9s9tyUkc7Jly+ddG
         BGsw==
X-Forwarded-Encrypted: i=1; AHgh+RoFMRIKKNyeDJ0WxG2UX1zJ8lMiAncgKZfK2Nx6VFLtU/AImkPW2JJBb23aGWf/KFD39kyZik0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdUdkNhkBK0Kmqjz3vmPYsLgBjOtBJGx9UfXvEhXr8js1Dxty
	3bIiqT9RHQKGMZMIuSBY4M0HqPipDbxhLdt9e3KbgkelkASSDBxQpNuU9UkJaip19akOn5fLCpM
	SMbS0fPhBi4wMfgi8gGmx2gH+hkFO4J269YBptEFjGw==
X-Gm-Gg: AR+sD1174RM6Iu5x3eE2HHmnT6e+ZiWnOZumAbYGOniQoLlojim+/mecYZ//vI+qvUl
	l8B5/ocIpRCXOF+9s66R1EiCj4BaOXMMAT5bPRmezZQCFLJvilsmGQnONbf3QOHykmnTggbvayL
	WkQlXAyxwXEknD9Ik8b1lBlasSYTxDW5/zERLEaop5955KJFHDrN6Cf8xmsqY1+0XVZ+8meMwvh
	gFxFTUb3PAQyaU1A55iAALlxIrSIiUisM2sn5dFumo9URMYGI/NqAv/JqTWThGbaHBTljauwRMp
	HQPDTiI0ajUWs1PwToFFy3y1xyizraeIk3fZXJE8B9CjqqliNA+DPRQlPXbRKulfLh1aORxcAja
	Q
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:620a:1a17:b0:932:dbf6:6f9 with SMTP id
 af79cd13be357-93302640ea0mr680179385a.9.1785336465547; Wed, 29 Jul 2026
 07:47:45 -0700 (PDT)
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 10:47:44 -0400
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 10:47:44 -0400
In-Reply-To: <871pclhpqy.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
    <87ik5yhisv.ffs@fw13>    <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com>
    <871pclhpqy.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Wed, 29 Jul 2026 10:47:44 -0400
X-Gm-Features: AUfX_mzECQqVJ3W0EKZnvo3E5TbD9loLYwU9NgODHxehS4sIZxbzEfczyBZ7GI0
Message-ID: <CABV8kRy2tQ50sBD-EGbKg-TANbVyE2m29eciCAomGGeZ2FeL3Q@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 15:47:17 +0200, Thomas Gleixner <tglx@kernel.org> wrote=
:
> On Tue, Jul 28 2026 at 18:13, Keno Fischer wrote:
>
>> On Tue, Jul 28, 2026 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@kernel.org=
> wrote:
>>> Seems your mail client mangled the patch. See:
>>
>> Yeah, sorry about that, I've fixed that since. Gmail is a huge pain here=
.
>
> Can you please resend then?
>
Of course - resent below. Sorry again for the hassle.

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
                                        uval =3D=3D A | FUTEX_WAITERS
  A robust unlock: store 0, FUTEX_WAKE(1) wakes B
                                        uval =3D=3D 0
  D fast path acquire: cmpxchg(0 -> D)
                                        uval =3D=3D D, no FUTEX_WAITERS
  B killed before acting on the wakeup
  B exit walk, pending op: owner D !=3D B -> no action
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
@@ -982,8 +982,11 @@ static int handle_futex_death(u32 __user *uaddr,
struct task_struct *curr,
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
@@ -992,42 +995,70 @@ static int handle_futex_death(u32 __user *uaddr,
struct task_struct *curr,
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

-	if (pending_op && !pi && !owner) {
-		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
-			   FUTEX_BITSET_MATCH_ANY);
+	if (owner !=3D task_pid_vnr(curr)) {
+		if (pending_op && !pi &&
+		    (!owner || !(uval & FUTEX_WAITERS)))
+			futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
+				   FUTEX_BITSET_MATCH_ANY);
 		return 0;
 	}

-	if (owner !=3D task_pid_vnr(curr))
-		return 0;
-
 	/*
 	 * Ok, this dying thread is truly holding a futex
 	 * of interest. Set the OWNER_DIED bit atomically
--=20
2.54.0
