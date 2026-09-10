Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C5492E38
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050892; cv=none; b=mwq7gGBIaF3I54Sg+iaG4h0/BtXvH/rIumYCT98kc9urO6SPPqvswW+KIEABUTk2Xel9mYWoF0WFiK9agqZox7/wcXQcZ7r36GfweYtq3ZQl2NYnqBD7K3EGv8v9YSKG3dX98wM6A2a3GbWQKq6fmnFwL/K0Qr00/IfTzs2bQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050892; c=relaxed/simple;
	bh=XoYviOluGOh0kAc7Ou8Iyf2cJk4TW8ChouuzVOQrax0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eikvee/t2++xNjci1/DpvwTUQIdhQT5ZganvC8noVTIbl+uYodCJfJeQHZv20uuoYOoJU3lUU5zwtn+XFq6+Z749RpGfeirlqbnX6pWKbvAgHVy9gMBIU6JVXBquHFSJGcF5zy8/v/NMG9um0zOsajeAf5vkjsBZB7MhdDq11Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK/FGm0T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK/FGm0T"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482ea739de2so4870008f8f.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050888; x=1789655688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMHaNRwMVaU/4ShlWKS0ohcj5wLlVwszTrw60OyUR3Y=;
        b=TK/FGm0TnoxfuxAzK7Jk1eTyU4xZelpK/ASmseK2EUKUjgu7OR3+JoiyiuUsh0WBaP
         c1ztFDjYGBTFR3WjPX0+xFLZzi6+XqSuXtf7AdgqMff6AOysWeaaW8bSQke9zZ8p4x0r
         71aUtb7Zor029tilo/1ISFQFjY+q2hYIkaoZedEORm8Dq6DAc5UJf3ZfAKXyUgaunhYx
         U3KjqxQY/9lfZ8g1ib6/eFz1vKtaO2dyCNEkpnv0383GrL4RSb6KB1CE55TaKlN2Y9Ba
         bzegYyTL2ynnrcRi31TccqJn5dqBEcEjkv7Hs+rAyZnMb7S9AoquMMc3WAEkXFzXYsNM
         Gulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050888; x=1789655688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMHaNRwMVaU/4ShlWKS0ohcj5wLlVwszTrw60OyUR3Y=;
        b=jW3p6q+g+cEeoQRQYfEFFU2EmkeEReDVRTMzLB7/t4L5hBm2lh3TNeX6Yh2VbbT/xJ
         zGbFhSzJeDHmKViQ/y/SH0kYVWEzBns1AwEOnC7WZzldNlV4ZKZ1du0J6343EsWIpI/c
         qtVGhWHKmOyF0wIqX6Ztfjq5/18PTHhPZcdmxXHq2JnoUFt4QZiayixILKjnu6+igUeF
         kOXXycP4VgUFHfJQGtjnyh4TKQctawhch5vLoL62XjLbpVUj44o3vcNe4OGLFnnr6kyi
         kRSUZrLpDeAlwoMhEcDTyEttSk6obsyzPNpHXR3TjCz2k/KrQfV+9LCr08WCkXlBK/YS
         jgQA==
X-Forwarded-Encrypted: i=1; AKwUvByfITGfmjDubKrFsfYArA15P0FUrmKQQ4w2aAO1TfmwzBpwlP+DfQwtAhORp9kMgfKO+HPAdPg=@vger.kernel.org
X-Gm-Message-State: AFuF++mn7MfNF0r1EY/ejhpEu4fUGQQFSbvyriasskGblj9lPL26EClp
	8hrNecynxwA/5D/2tcO5ssoaasY4YD8hdvOdA3UMOsncrgB3gL8zK9y9
X-Gm-Gg: AYBFou3nY13HLHqE5/c5g94NtmUb0rxpTMTe8Lpw/+/ZzacNbpV/sbO5FEvCwrrREEA
	3gfse2W+dnpIrzSxOlrEk/awvGDI0eH9hNfwcNEshNzuz1UrbplpTQoaKTV/Bjm2jaRaJIs1Tcc
	mZUH3jBymY5Vr3VC4/952tcgYzz/STj31h98rcWk8uX0PQkl6D1Og4W8cPyCU61NrbFzlb8886y
	bgRflYwppSN0+lse8sgh8PK9gVkijBDkKOyhH2K4Qletqr9L7v+xxL4TU/mS//D3H79hzBMe+de
	VBXAy2CqSzgv11JUnILN7F1vEKlVcU0YB4EYIgkKMwDMItj58Z/CXR0v0oIhYw2iPJbJdUT3eqx
	rjQiGG3yb529M1hKtbFqINtCPPvm38Y88gdkds7FZ+Q6NlwRktYglWFUtdgdksy+I/B/12nkU4M
	OtwpTjDxkQYcjvceD6X4PQD+ZxN8WX3Kxk8VMFFR6ZhRpXviXUB+ncuNxV+7kIkQa8PR1qhD4zJ
	oo6RemI/MOSm/7E1Oezl+8=
X-Received: by 2002:a05:600c:1d0d:b0:49d:99c:3bd9 with SMTP id 5b1f17b1804b1-49d099c3fc9mr271461415e9.33.1789050887625;
        Thu, 10 Sep 2026 07:34:47 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.90.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fb02bffsm94977835e9.0.2026.09.10.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:34:47 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] hrtimer: Use hard expiry when updating timers on the same base
Date: Thu, 10 Sep 2026 16:34:42 +0200
Message-ID: <20260910143442.2018-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearming a queued timer with nonzero slack can leave the timerqueue out
of order. remove_and_enqueue_same_base() checks the new soft expiry
against its neighbours' hard expiries, then stores the new hard expiry
in the node without requeueing it.

For example, with A at 10 and B at 20, rearming A at 11 with slack 30
passes the neighbour check but leaves A's hard expiry of 41 before B's
20. The same function also caches the soft expiry in base->expires_next
when updating or inserting the first timer, giving next-event selection
an earlier deadline than the queue head's hard expiry.

Set the timer expiry before handling the queue. Use its stored hard
expiry for the in-place ordering check and both updates to
base->expires_next.

The early update is safe because remove_and_enqueue_same_base() runs
with base->cpu_base->lock held. The lock keeps the queue stable while
hrtimer_can_update_in_place() checks the new expiry against both
neighbours. If the check fails, timerqueue_linked_del() removes the node
without comparing expiry values before it is reinserted.

Fixes: eddffab8282e3 ("hrtimer: Keep track of first expiring timer per clock base")
Fixes: 343f2f4dc5425 ("hrtimer: Try to modify timers in place")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes in v3:
- Explain why updating the expiry before handling the queue is safe, as
  requested by Thomas Gleixner.

Changes in v2:
- Set the timer expiry before handling the queue and use the resulting hard
  expiry for the in-place update check, as suggested by Peter Zijlstra.

v2: https://lore.kernel.org/r/20260909102749.7677-1-parri.andrea@gmail.com/
v1: https://lore.kernel.org/r/20260907211134.3854-1-parri.andrea@gmail.com/

 kernel/time/hrtimer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 530d61257b9a0..cbf1693c86b38 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1263,13 +1263,23 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 {
 	bool was_first = false;
 
+	/*
+	 * Updating the sort key while @timer is queued can temporarily
+	 * make the tree inconsistent. This is safe under cpu_base->lock:
+	 * no other queue operation can observe that state.
+	 * hrtimer_can_update_in_place() either confirms that the new expiry
+	 * fits between the neighbours or timerqueue_linked_del() removes the
+	 * timer without consulting the expiry.
+	 */
+	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+	expires = hrtimer_get_expires(timer);
+
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		was_first = !timerqueue_linked_prev(&timer->node);
 
 		/* Try to update in place to avoid the de/enqueue dance */
 		if (hrtimer_can_update_in_place(timer, base, expires)) {
-			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
 			trace_hrtimer_start(timer, mode, true);
 			if (was_first)
 				base->expires_next = expires;
@@ -1280,9 +1290,6 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 		timerqueue_linked_del(&base->active, &timer->node);
 	}
 
-	/* Set the new expiry time */
-	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
-
 	debug_activate(timer, mode, timer->is_queued);
 	base->cpu_base->active_bases |= 1 << base->index;
 
-- 
2.53.0
