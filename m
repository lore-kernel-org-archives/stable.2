Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7114AF168;
	Fri, 11 Sep 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150583; cv=none; b=O8mqv3flSk9bZ6cALKdGAiM7wXnCmbROgnxHtwdN0TQ7av3WWJw6Ic7ioIVK3zOM8fpgX0Gd7cDSb5HrbCvztut9zNQNYmXrlhfSo9MDFEfVM/wdn7Meh+63bXV+dICKgcW55m6V3/q3855Nrl8JQ8Hhzq31VjpaEv0oipWCf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150583; c=relaxed/simple;
	bh=ZNK7lfuT09qSARdbt1/cZs7gniyWCRs5j7azukBwUOg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gMh4tX8leXC/cZl+2SS71r/lnFJnKHs7CF2hWdvjaViVFXX9BCE2L/1gZ2WpWArl5AfUDaPtCUzQeWZ6tyW0+hTGmwaq0tm6bZmHCdZiuXdA2ktIJNiO2H42YiXC4u7UG5euB1lkwc52M4mWkr7NevaIDJC0mfsSxY2RCGx7Dt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1hkwYvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1hkwYvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDCE1F008BC;
	Fri, 11 Sep 2026 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150570;
	bh=BW1arZP/jeW3t4WrRP5pr3VhcnT2T+SZnRTRC8idGJU=;
	h=Date:From:To:Cc:Subject:References;
	b=b1hkwYvrOmimg5y9V1j7so/Lrw/XPUACCW4TWvX9q2Z8X8Xo3B6MuUTi55Ah+HbGZ
	 Pn/ExFu9U6tBSd+tPqY28cxJMy7JmHSHNijc/3c2zG0iDT7HaaMnZuXmzxdViaYSef
	 spq6mZ3CIG3cbpIFR/o4rDzObTkv0nkr3i1Lk758rd3h8XE7VjQ7sK93rd149RE1B7
	 bY+esHnR1/d3TCWMZ+sOtaQBCZJMdpCLIj9F5gcNa8na+I2018fSPEywLm22ECiLNb
	 op+GvTNdvTuxstafSwtdaj8WfAnBn1bZi8fDeP5Z+//idLNmz4HCflcI5qLrleTm6U
	 V490Hv268vN/w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oa-0000000955h-1lP9;
	Fri, 11 Sep 2026 14:17:32 -0400
Message-ID: <20260911181732.227965353@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-linus][PATCH 20/20] ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
---
 kernel/trace/ring_buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0e30c7bd6045..9bc8ce8c5676 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -904,14 +904,13 @@ static void rb_wake_up_waiters(struct irq_work *work)
 		struct ring_buffer_per_cpu *cpu_buffer =
 			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
 
-		/* Called from interrupt context */
-		raw_spin_lock(&cpu_buffer->reader_lock);
-		rbwork->wakeup_full = false;
-		rbwork->full_waiters_pending = false;
+		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
+			rbwork->wakeup_full = false;
+			rbwork->full_waiters_pending = false;
 
-		/* Waking up all waiters, they will reset the shortest full */
-		cpu_buffer->shortest_full = 0;
-		raw_spin_unlock(&cpu_buffer->reader_lock);
+			/* Waking up all waiters, they will reset the shortest full */
+			cpu_buffer->shortest_full = 0;
+		}
 
 		wake_up_all(&rbwork->full_waiters);
 	}
-- 
2.53.0
