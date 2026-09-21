Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442164A0139;
	Mon, 21 Sep 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998312; cv=none; b=nm0BPxUQdXMwXZ3fF+PUaVpGHBJfOTHdKKuVhxLH3i/M23KwOzMo7yG8nhtySrztA4x46ey0tcJDtPU2ahXQCDztofXE4ICQcfVsF+pQhWD+he5AYRVGHnhj8lbKNn/rhROGN0qDK3zZg3Gcnl1K8c28yyN8K1N37kkKrZ/hIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998312; c=relaxed/simple;
	bh=ZJZMHEJY0IpIOllGS0I2yC1Zirw7JKTlxyiP3ql65sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXFHeMcXz2opOXEO9pywV20RC3c5UfhTf3sbyCQpZlRYruTYMAt8mtjJOBr+NXo17z5+TXvsOxg+EKdKlLU5SsZs+GO4bkjZWsqxagokkSw85l5eDK4wINUZRjYhF9Lp7EIg9Ene9uwMXdnbOlojEOJODR94vpYlsFZdpgytGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNKeDONj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNKeDONj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D771F00893;
	Mon, 21 Sep 2026 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998310;
	bh=0aaN7myk62sTfR2q3XReSX9QRDUIj2fpxzi/ZnEl5rw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mNKeDONjpAtk5e3ET+hFnG6GZU1Mzh8f+fOKeiaSlVekLuPnMEz4CZmMkTn1ycSty
	 tLKfVE0ttIlGJu00wjgh2ME30EGL4fEgpOmJcQXlKOHo/YLQxcPt23y6hwwzmh/W2y
	 5UpOqh7u5KcNxzojtSy1HNHKFRa+C6uECcARq0gVj6k2AjjCAh1Ok8zuFGM8LKIw6f
	 1xBm7/EJuB60VoXvU5DcMvKoAHALm3r/eTHwLkYsVkmYh61oGYOCRyfn260ZyuPsrY
	 qCjBbla64kBccl3VOjfJU3jzuw6bquPyX0MJwaBr/YJ7ywk2ftPLZysOc9QoCfmQ6u
	 Q1YQdfLz9GC7g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:50 +0200
Subject: [PATCH v3 01/17] coredump: hold RCU while releasing parked threads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-1-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZJZMHEJY0IpIOllGS0I2yC1Zirw7JKTlxyiP3ql65sw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLmTseC4Xplb55Vn4Xb2px9smOhqHNFkUnllxqu8x
 MUpaXydHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5tZiRYeHVWWe4Dv1bvfiv
 SuC/2O/fV3/Wua3JEXnxpu+69wc/eaYw/PfcpaluepkpXn27Gd9aqz/nriQuZbmvX8VqVNF2Trz
 nBDcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 16b331b686fb..6c0c597ec324 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -561,6 +561,8 @@ static void coredump_finish(enum coredump_state state)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -569,6 +571,7 @@ static void coredump_finish(enum coredump_state state)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}

-- 
2.53.0

