Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1C367B7E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753299; cv=none; b=BdvgGI9YbPxTdxbDPgNj3jBuJoDBbGiu1h7U6vMw5ksITM0fiTsLx76QNJ6SFUyYWTFhPKUzahRHHuzIAIvG9H6AaY5Z5GqiQ6GubC8a8ny6Y2ppKDKhKJzaS2xbhU+dd/9rpM8fstQPeWmDDnmj4jWW6NCS+grE5dYznf3Oe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753299; c=relaxed/simple;
	bh=1DRyjPP6PthxNAowhOQK5oEsTIb6+8VD8sdlDmfY9Ao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TU+lB3z6dtk4NYUOMdsqq/0hx4cs2a5WaZh0rd4NNvPmsAYHuG4q6Cr5yRJZzD7wyR8XEEgdkEXEYUucS86JyF4fDSswOKD67TcTXP1PkqbKbr41tNRDfo4+utPBltGCgil39nboHoVWT3lGVVlO0F0VJ8UNrsrCxz91waEp6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZS8pQ2YQ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZS8pQ2YQ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso3655269a12.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784753297; x=1785358097; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MBj0yg8xeI9MNjX7AgATIvJE+XRBQGTQwqcnQ4/pcDw=;
        b=ZS8pQ2YQ2qig43dep1MIE6DAQh8u95DSGPXcbG+VrDDNgcLdoRLLZSTUy41QEuvMti
         PAZm8dSXfVvdb3aMA38QtBNv/FnoLXTKP7KNmxYexvwdi/GQWLwqTz2UB2fgg7NgUAoA
         56Uum5eX7jP8vtaGtsUjsIl7vCoYSD3DjhESlU/dSrfPDwLN560z7Ofuy0vG2TmcrHmE
         Ipq5pjhyIsy5WyDLh3SdLklHStSSsOPizPeaAkzaUx7dyp1rDCJCKLxaqGWCW/DFvyK6
         7Wy9Cd1FQAOnL2qP+bnwyOdbNszid9q7GZ3JQYHoGL9xsAYlFOrP15q2ipmoJDCmaoRI
         7ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753297; x=1785358097;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBj0yg8xeI9MNjX7AgATIvJE+XRBQGTQwqcnQ4/pcDw=;
        b=d0Ot5QPq/Ot/abAV7A6rfMi+WWOxhwMIUw0Csk4mdji5kMZo6dOuJPcWHdQNR9L7jW
         r/JFmDkLiGkavdbMIOxpZsBxLeyCvsScvLdyix2z9S8gpdYYsQpSUxPhY+cnr+ZbvY0N
         BGETO2s/aHey8A+5iPOP4TR8eufMwfHcH5ihgJg9GBTj9lkL21E9AKqmVETnGsZkBP3T
         Dr7SVXOgoWlxXlXxtAdD3KYRtlEpGgL67AuaGJmKF0eMy88wnNkr0O/LO/NU5pOhniBK
         qjF6nwpgfVKB9jnrBYm3DXm5mxixQT8SWuOGdVN++xYXvIW5bNCe9JfysanmECrernK/
         OKDg==
X-Gm-Message-State: AOJu0YwBGHFzSvfbb8kWCXIw8B6oGwfw86A6/CkmiveS8eiP0zhYi3a5
	wYhSvsvEdJZExYZvFugzNYeGYmL+3jMtLsZ72xyCMSWHsZMknvts8GRkKeXjkWBIBbLN+fn2LIZ
	1ZG7na7ZeiUTfy3HiU7YrJ5oVAtU5lTUc+iDPyJGQAoLPUYjPloFS+RTLyQVS/Ah2HscpGSskY9
	VmniwQdvgSjkL7qqX0qwgAN905MZXBURplgYXoG89pnYAtcco=
X-Received: from dygg9.prod.google.com ([2002:a05:693c:80c9:b0:313:eef3:e9b5])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4313:b0:3c0:9c19:b271 with SMTP id adf61e73a8af0-3c44b2616efmr95077637.63.1784753296898;
 Wed, 22 Jul 2026 13:48:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 20:47:48 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722204748.104836-1-cmllamas@google.com>
Subject: [PATCH 5.15.y] futex: Prevent lockup in requeue-PI during signal/
 timeout wakeup
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Moritz Klammler <Moritz.Klammler@ferchau.com>, Thomas Gleixner <tglx@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit bc7304f3ae20972d11db6e0b1b541c63feda5f05 ]

During wait-requeue-pi (task A) and requeue-PI (task B) the following
race can happen:

     Task A                             Task B
  futex_wait_requeue_pi()
    futex_setup_timer()
    futex_do_wait()
                                   futex_requeue()
                                        CLASS(hb, hb1)(&key1);
                                        CLASS(hb, hb2)(&key2);
        *timeout*
    futex_requeue_pi_wakeup_sync()
        requeue_state = Q_REQUEUE_PI_IGNORE

    *blocks on hb->lock*

                                        futex_proxy_trylock_atomic()
                                          futex_requeue_pi_prepare()
                                            Q_REQUEUE_PI_IGNORE => -EAGAIN
                                        double_unlock_hb(hb1, hb2)
                                         *retry*

Task B acquires both hb locks and attempts to acquire the PI-lock of the
top most waiter (task B). Task A is leaving early due to a signal/
timeout and started removing itself from the queue. It updates its
requeue_state but can not remove it from the list because this requires
the hb lock which is owned by task B.

Usually task A is able to swoop the lock after task B unlocked it.
However if task B is of higher priority then task A may not be able to
wake up in time and acquire the lock before task B gets it again.
Especially on a UP system where A is never scheduled.

As a result task A blocks on the lock and task B busy loops, trying to
make progress but live locks the system instead. Tragic.

This can be fixed by removing the top most waiter from the list in this
case. This allows task B to grab the next top waiter (if any) in the
next iteration and make progress.

Remove the top most waiter if futex_requeue_pi_prepare() fails.
Let the waiter conditionally remove itself from the list in
handle_early_requeue_pi_wakeup().

Fixes: 07d91ef510fb1 ("futex: Prevent requeue_pi() lock nesting issue on RT")
Reported-by: Moritz Klammler <Moritz.Klammler@ferchau.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260428103425.dywXyPd3@linutronix.de
Closes: https://lore.kernel.org/all/VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com
[cmllamas: adapt to 5.15, apply hunk to kernel/futex/core.c prior to the
 requeue code split and use hb_waiters_dec() before the helper rename]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/futex/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 42cd8f2b6da8..8b4af13b8d26 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2078,8 +2078,11 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 		return -EINVAL;
 
 	/* Ensure that this does not race against an early wakeup */
-	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+	if (!futex_requeue_pi_prepare(top_waiter, NULL)) {
+		plist_del(&top_waiter->list, &hb1->chain);
+		hb_waiters_dec(hb1);
 		return -EAGAIN;
+	}
 
 	/*
 	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
@@ -3360,10 +3363,12 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
 
 	/*
 	 * We were woken prior to requeue by a timeout or a signal.
-	 * Unqueue the futex_q and determine which it was.
+	 * Conditionally unqueue the futex_q and determine which it was.
 	 */
-	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	if (!plist_node_empty(&q->list)) {
+		plist_del(&q->list, &hb->chain);
+		hb_waiters_dec(hb);
+	}
 
 	/* Handle spurious wakeups gracefully */
 	ret = -EWOULDBLOCK;
-- 
2.55.0.229.g6434b31f56-goog

