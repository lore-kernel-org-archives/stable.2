Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204202;
	b=MhPnjEZ2ILJB4A8UdUjzDckbnQ9HhhhIG3aatRoXRsqQuT/8MmvSRmZ7DgIDZp3Talt3
	 AGlOYkWK4IIjHW8ub+GNZb2rpEAtMpaI+90F17Q2VVUV3P+utEBYB4EJRlrIx8+mi/VXU
	 snWpGzlhXaodbxvkXOyvfjLYj12SROOPhITorY9JJLLX1yl/ZS7J4ZNUrNfTBCyH+/0kG
	 zs5hWKQhaqcRfrwmyam301jAwY0ZMTFSX1kDpFhh0yISEnZ/CLxA2wpLd/9aA86B04iz1
	 pDDOBehaftu3tPMiQsTwpTWXbpBBroWnGHbnb6YUiwJK81sRgBH8lL+L+6rrXh8Osfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z896i9qTYmyMSQUmAyeYbIwULgZv0k7jyQ0XCA30rXg=;
	b=lsJiwbPliWHAuQCpi7WrhETc++uAx2NHPU5QruOpcfl4rnQauY4lAxiuU0B2Xm2MQyBg
	 4y4sfWZd1QV8DqrhW/qASiGFf/X0xt7eu7BP3cWUE7rYdLhkVC/01fVmRJyyP9IAxBAwH
	 /ffKXiM20Tat8sN2/SClR0g16guKSbPEbvfUNwA6OiLM74KeN1oQCIQVoKt7oR80hgu/B
	 InQPi0ArBcAIFc4v2OE1HPN3ubcBPK6fWon9oZL45im2uUyS45YQyZDsWm9NthTMFDifS
	 elguZDQNuygAmy+lea6a3llVH1oTq7T1AD8r3gZ6+gXxQLoD5cTbq5u4atmFjyuyTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3bt4TD8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BC606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3bt4TD8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DB1F01825;
	Wed, 28 Oct 2026 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204201;
	bh=Z896i9qTYmyMSQUmAyeYbIwULgZv0k7jyQ0XCA30rXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3bt4TD8A244v1k7RfvZ6qZ46F2fM5lWmb8dnxdI+XraRW9F29sgT/AQiXjr4LJtx
	 GjEOTBrHeYI2sqaAQRJPUJstfIOof9exK3z0V/TCR+FubHisPAH+WemvkG3BBJslWD
	 kJPSNJBiKfuIn7lspuTZSDRHMnHMw9CqpZYKRSJJGxERWCtBW2ckGwD+Y3RVlTqBEp
	 z1BQhP228bnsDQfYPc/L0KPkJOMswZxD04NvNfj2BukF0R1wFchYbek9c/hsyj9HMO
	 SSYgypExnJWyAj86j7nLjiUqA3rxYnqaV+daOclbnF5blAMCjrHmug6mF+oEdVHPbC
	 Yd5UHRIrzEdFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] coredump: hold RCU while releasing parked threads
Date: Wed, 28 Oct 2026 12:16:39 -0400
Message-ID: <20261028161609.943590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102801-afford-shock-9e90@gregkh>
References: <2026102801-afford-shock-9e90@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 61d58591aa0188bf2463e263962256316ff8b576 ]

coredump_finish() releases the parked threads by clearing ->task in
their core_thread entry and calling wake_up_process() on each of them.
It does that without holding a reference on the task and without being
inside rcu.

But calling wake_up_process(task) without rcu here isn't safe. A parked
thread doesn't need that wakeup to leave. A spurious wakeup or a
preemption after the store is enough for the task to go away.

So if the coredump client is preempted between the store and
wake_up_process() the thread can exit and be freed in the meantime and
try_to_wake_up() takes pi_lock in freed memory.

Hold rcu across the loop.

Fixes: a94e2d408eae ("coredump: kill mm->core_done")
Cc: stable@vger.kernel.org
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-1-8e4adb1619e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Replaced guard(rcu)() with explicit rcu_read_lock() and rcu_read_unlock() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5e5c1d72d63bc..9e97756be4381 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -528,6 +528,8 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 	spin_unlock_irq(&current->sighand->siglock);
 
 	next = mm->core_state->dumper.next;
+	/* A released thread may exit and be freed before it is woken. */
+	rcu_read_lock();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -536,9 +538,11 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}
+	rcu_read_unlock();
 
 	mm->core_state = NULL;
 }
-- 
2.53.0

