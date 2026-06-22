Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0C3A48D9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122161; cv=none; b=TXU2oZSVBCzaXY4lswxWIKS/ErBk+f71SSFLtpbxIdwFJxp23ho7gyv0c8klOpA1Q1drWrX9BU6MQ7aBzFjB64JsSbTiJJs8nlU7od6SoQrN70kfhUNENNdURR/P+ZMwpzPbRNqwkhbKAqs3pAiWx/6yxLo+cGn6Y4lQraOvjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122161; c=relaxed/simple;
	bh=t3RmKLu6WlSnfGrBNhtRDr3P0EDbChImcBQMHk+OJ3Q=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b/1EQPNNyxbWs434gOIPBmd2tUw+mDGz9AcYEEFmTQlIV0n92uvjTjwXc0/t5iX6gL76MX6QdV1Mx+AQgTkvi8w43DnNuD1dxWhAhtzmtDbvnguUIQNRBzFtREWCIIttACPszJy6rpM2p5qQnRbSEebwm+kRAqEt5vvA5FplxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYdIKLdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYdIKLdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF61F00A3D;
	Mon, 22 Jun 2026 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122156;
	bh=/lpECs0jKX1Uk1XcD8X8zKL0nnlu9miSC07xQUjR2s8=;
	h=Date:From:To:Cc:Subject:References;
	b=hYdIKLdCUjtkAFkkJ8VqbX/f19AFnQhZgRxNybeeIClvnKqmvmXPmf0zanFZSbL12
	 bUgfcOzZTqXVMgnpqTA1nieKOGI9OhYapow6E++siJCrVm/KbsXVETGUh/on0Hli1V
	 Li9BQmJ/VCo6W3+HAkD/6lG38EvdQu8ZJjIqEAMV4LPhb9A1L+pILsRQF531RYSz7B
	 3gi5ut90Ad60PjXxYuJzfqEIZ49vz+7D4zjhLACjaKU9tLeSBrsxb0rx9RhBoW2qG5
	 +r/h81jodwnZclraP97V52UQ9Bvo36/vdXjZ6fWrLs4u5qOXfCLsc/eQ/JcAFb4jAJ
	 6hlBuqCLnetGA==
Date: Mon, 22 Jun 2026 11:55:53 +0200
Message-ID: <20260622094802.154213724@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.1.y 2/5] debugobjects: Allow to refill the pool before
 SYSTEM_SCHEDULING
References: <20260622094345.511524619@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 06e0ae988f6e3499785c407429953ade19c1096b upstream.

The pool of free objects is refilled on several occasions such as object
initialisation. On PREEMPT_RT refilling is limited to preemptible
sections due to sleeping locks used by the memory allocator. The system
boots with disabled interrupts so the pool can not be refilled.

If too many objects are initialized and the pool gets empty then
debugobjects disables itself.

Refiling can also happen early in the boot with disabled interrupts as
long as the scheduler is not operational. If the scheduler can not
preempt a task then a sleeping lock can not be contended.

Allow to additionally refill the pool if the scheduler is not
operational.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-2-bigeasy@linutronix.de
---
 lib/debugobjects.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -605,7 +605,7 @@ static void debug_objects_fill_pool(void
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching

