Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215122A4E9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605448; cv=none; b=dj2lAGmB6JsoODD0aj/my3OH1bgx8iNVXkZLaFSncnW94BPs1zMKcDPTwSiHpOuscyaUpM1HFfXeVNLqh0t4fG4sOnjOMzIIVIra456VaxqIvHrCz8ZsaknTiCh6nG6CPvMiUb2xq1rAGVT52kWoqOYCstnqraklJv8hKzoetJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605448; c=relaxed/simple;
	bh=L9KWRXNQWBB6dAAE9kERSC+EFEYeLxOlaCos9u7lJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCutekfwxquc+bd1I1e4BOVMLXHnXf8UT3DjUzOuhN4kdSnG5B7TuJUyIPpX7DvSRuH6tAbop6EQTapS35qC52zif0pnvusmMrdjDm4WsPUVL3KCWQiOsECHF9HCzFnXUGdFbCrBVaChCqdIz/PEuCC6baBvzL1R+QWYJvTjY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJZ4vMXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJZ4vMXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272F91F000FF;
	Thu, 17 Sep 2026 00:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605446;
	bh=otuDLhE1lgU3jW936gD8thQ2qazFnOEFEzRjPRBsoO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJZ4vMXgsrRyngZ6+as0KdecUxpmILmJspxg8CoFai1o0j4ks2F+15GvF/pl4eE23
	 JCBNVHguL1nmi0lU9IwJVL941mcrTS2uKvY/pRXwNxLqCFF5nbiNU8EgskVF6iCWeh
	 mHvST84tGa1LxTuYg3W5an5WDo8mRGxLDWAPlMGa2fjsxNetNrTbASybmgFVTmhapj
	 EmjDkDUEwoKmfIxHlarwJ7KbY4fHTpR8i8A6N6lB6QT2yv/D+YtQG41nD9NP9dNVm4
	 LUCzFo6dWaavujbHvmTcLy5TW7i/nKbLgSc7navVA0rfpexDoCr/7aQXTseGDCQihd
	 RftwvPUSAUtlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ring-buffer: Acquire the lock with irqsave in rb_wake_up_waiters()
Date: Wed, 16 Sep 2026 20:37:24 -0400
Message-ID: <20260917003724.3443633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091640-capacity-finalize-8fbc@gregkh>
References: <2026091640-capacity-finalize-8fbc@gregkh>
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
index 84f3b0d0bc887..9c43f01fa2c2a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -877,15 +877,15 @@ static void rb_wake_up_waiters(struct irq_work *work)
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

