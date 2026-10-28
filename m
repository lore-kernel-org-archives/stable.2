Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207613;
	b=BOb1AsrMOXXj0O/dvtHXvcfuxgeiZMFkUzvG5U76DiKbepYBEcI8Unj1ooXubqhifwet
	 0wxFInxsvh1tGE/P35ayDWi5f99L4OlGg2IEGv7WqVnBYUmjuizskLtv5KeEyS5kfET1r
	 4zxO/drOuwYo3AqL7eoAjcLg80T48/oaElV4SrXjbrEGHitn/PlZKFTZBillCuchn8fLu
	 r+4y73b13Zs24W+2ffD2Hohw7hYQOZP/IvZxIyHdoCeoqRwd3ozou5kW/vpRbn6w5va0W
	 LtXV4toSrlOhxQiQhXpxAfFy6jbiZJDboUBur3CZ5yMW4YiJtAuC9LCBLOvmZSQ3gOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3uzDpQnEgUk9f9Q6auY2qu5QNonDgKtKQNDSlvFi7go=;
	b=mrarwS+cz8am31I2VTRt08juzkBIrYA0vCpWlBCl6YAAVeetKesyywJiCDqcOpmESldf
	 L9WRAs/0OcRGSp/HEZbgGV2BCQFT72H6jq6AREakal5THv5CM7Bh95aX5C3CBVxWBEwRO
	 w6pmtBb6z3dnybeEikliQyflGZjItxXy+hWSXPchZw2KavL4HzGZ/BvLzb1FuLw8jzmVb
	 kBO2MAq0LFFS9CLLpUWnzV/pv7W8y+mRmDquS4PndRsGjFm0M81n3urxvQ4d0S46dXoCN
	 8UL0fwlYK47I35+t6aUkqerevv0S6Hvm9laa9F/lyViul4+F6+PADqt0AyXBMWqfF0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gn25ac8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB30606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gn25ac8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B201F01825;
	Wed, 28 Oct 2026 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207613;
	bh=3uzDpQnEgUk9f9Q6auY2qu5QNonDgKtKQNDSlvFi7go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gn25ac8ADKoo0F4v7ABUjryxqklZOJDHDmsUBIHYl0pBCyIFTeZRkeIom5/nFjCuq
	 l7neuIo3SBJWH6lhgarNRaGuHspiwSXlXPuy9fuaYKSC8uXJLm6mB0SBqippIaI//3
	 /S36nIHoJThVIpqDWVWMV/IkF+RCLHV5hBlVx4dJOytLchHtm4U3sQdSQC66Y5kNdq
	 faVTUhx3Uv/SCocXv1B1NnqeDq/l/9QDNM8urkfWP3Cds1+JNWB7z17cvAL8uMRbMP
	 h47rkRG+aBRXhl86HZDxiPnHy1CafoAuT8LB9FgyNthQs08oalAU1cXiS42buyY03N
	 wVkEp2xbPbGvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] coredump: hold RCU while releasing parked threads
Date: Wed, 28 Oct 2026 13:13:31 -0400
Message-ID: <20261028171306.1530342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102802-parasite-try-a089@gregkh>
References: <2026102802-parasite-try-a089@gregkh>
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
index 7e5ac34112bd5..23afc126d4ea6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -529,6 +529,8 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 	spin_unlock_irq(&current->sighand->siglock);
 
 	next = mm->core_state->dumper.next;
+	/* A released thread may exit and be freed before it is woken. */
+	rcu_read_lock();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -537,9 +539,11 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
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

