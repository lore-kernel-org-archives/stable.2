Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAC4D6C36
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573303; cv=none; b=G74oRYzeVG5qTqpxQnqtHE14rirRf1PQdtvtDgRumqOk1FFqUBhqHfMx9xfJA0SOoUjLTyoHKqCznsCvn8NDWJLZjW6eBT3Toow7NuQzxnFeV8Y/TfJMU2KR5Cxn6TCb4ts0rHqYtuIIsHZDeFLKewx+QzbcN2t/Um+8g2xkupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573303; c=relaxed/simple;
	bh=oKgg39L4dXJ4rp8fY+iJbtNC9fYtVz23cX8I3tLS5Ow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CXByMwEkPUm6WHgX2kyWogwtCfurDzR6bk02JB9yJJcPfn8WmL0vemVLcTqJCYn0avXyEHz45yXCjDESH0nKYwGp0Tsstw3fYJeQZVeoVnD3VYrnqNGS83HR9+0zPMQaTu4MocyKhl0FQwwgyBHeUFAkHZHq5fpGv2NysnYyAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKRCbseQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKRCbseQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A71F00893;
	Wed, 16 Sep 2026 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789573300;
	bh=/eSIeG6+hucA1WomfHA2yf4SSd8b95HlIgPvUqJHyd8=;
	h=Subject:To:Cc:From:Date;
	b=LKRCbseQ81h/VCetWG6+CAagvA3k/tmFa/gF2vPPUej0Ps/0TjtVcfklDrHmd+XfX
	 IMWNyn8EZ41MtQXy8g0r8t5ZVeYIAP5dIM6ajkzHXrSnlb/t2dONVE7t//+6T0zR/r
	 6BJjE26Vs6F//gP6EB07NdG9nPSPYOE+zsXSNvvI=
Subject: FAILED: patch "[PATCH] ring-buffer: Acquire the lock with irqsave in" failed to apply to 5.15-stable tree
To: bigeasy@linutronix.de,rostedt@goodmis.org,vdonnefort@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:37:40 +0100
Message-ID: <2026091640-capacity-finalize-8fbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 815e07c8fe885a87751c2496a30ae0dcd4118210
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091640-capacity-finalize-8fbc@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 815e07c8fe885a87751c2496a30ae0dcd4118210 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 11 Sep 2026 12:21:52 +0200
Subject: [PATCH] ring-buffer: Acquire the lock with irqsave in
 rb_wake_up_waiters()

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

