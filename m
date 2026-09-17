Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998F31328E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607620; cv=none; b=DcCPp2rpZfZzvjno6wbByurLqG4qMaqoBjt1Xy8aP3hEjdmCN3GkRBv+G1Wpd/dbYSXwTMYdslczuwh6wmQGGYB0ni4BDp0ienlOIsrQZPHOSp4AE60H621IL07cZeUdVLHBHreRUwcrc+QJ551zaP7PpiIWU/lFolKW2A+1otU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607620; c=relaxed/simple;
	bh=uBX0fVaY8cQxp2SwkbvUoy5rYBIpxIrMGJvZaRLjbWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvK6uU1y4jiv534SAZsIVLfZSUWbMe3XZwHXBV6+/Qkch9AF77bqtviAqLFXcOVe1O+o+Ha6R6NkVc4T98YRFTv84p8BB26yk8ORWJwGjna8rQTj7XpzHwzL5yEhNzg+DIN4+jALdazFMXQwDwHI5ll9RtNzsC11qNHg9LBUX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsNOI9Hb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsNOI9Hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2DA1F00893;
	Thu, 17 Sep 2026 01:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789607616;
	bh=zfpP67kuQIXFFV3ANKjoUDyRdoMaDTdRh+2QqCAbDpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsNOI9Hb8co4U6MFNhH0Y3BkDo86gjREG7X3TgjZRzKLHJuWBWobCjtm7ZmZ7LjHz
	 MVWlmno5mcJMIfzM7DBk5pvBgo7Fm6P51Nt1bhmuZbXzs2fW2RavYWhzCNGqU3TJNm
	 CxFj9ts0f68mTRHFUn6H9xPKZLRH3BSVGZE6x9Iujtm589PahculP1/n/fClsOBuz+
	 g069RULe94QqCdEc/BBs6PNS3Z1Q390tcM/2Dh7LSM89sbr9ZHmb8vuFGgoHBEZFKS
	 DxkxpN2H43SFCKkIcuahW+fAZM3em+yitTGMujDFEntNpJhCepVjEhbUN0CO6a4ifT
	 T3t1IabG/Vizw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()
Date: Wed, 16 Sep 2026 21:13:34 -0400
Message-ID: <20260917011334.3531866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091641-backlash-shrank-66b6@gregkh>
References: <2026091641-backlash-shrank-66b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 815e07c8fe885a87751c2496a30ae0dcd4118210 ]

rb_wake_up_waiters() is a irq_work callback which is initialized with
init_irq_work(). As such it will be invoked in thread context on
PREEMPT_RT. Invoking the callback in IRQ context on PREEMPT_RT is not an
option due its usage of wake_up_all().  Since this callback may run in
thread context, it needs to acquire ring_buffer_per_cpu::reader_lock with
disabling interrupts and may not assume that they are disabled.

Use raw_spinlock_irqsave() to acquire ring_buffer_per_cpu::reader_lock.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260911102152.YEtwkBj9@linutronix.de
Fixes: 68282dd930ea3 ("ring-buffer: Fix resetting of shortest_full")
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Replaced scoped_guard() with explicit raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() calls for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1c1b4139c4726..0612ef61bf973 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -835,15 +835,15 @@ static void rb_wake_up_waiters(struct irq_work *work)
 		/* Only cpu_buffer sets the above flags */
 		struct ring_buffer_per_cpu *cpu_buffer =
 			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+		unsigned long flags;
 
-		/* Called from interrupt context */
-		raw_spin_lock(&cpu_buffer->reader_lock);
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
 
 		/* Waking up all waiters, they will reset the shortest full */
 		cpu_buffer->shortest_full = 0;
-		raw_spin_unlock(&cpu_buffer->reader_lock);
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 		wake_up_all(&rbwork->full_waiters);
 	}
-- 
2.53.0

