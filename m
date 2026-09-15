Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599A395240;
	Tue, 15 Sep 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467768; cv=none; b=n0/BufOn5Tbn34a6wTl7qKNd2IcywkNxgjCrLGgA1jz9KVA9SXC5CDILe/7/TXUKcMHwIQEhZ2ckSZF1f1DkD+wOCjX9nGHxhvxOvy/p0UtmZZ/C0pI/qX/9tuvOJcUuzFGb86a13q5Kp2eDXLqn1tQTh+e+3+xRjz1z7gxI+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467768; c=relaxed/simple;
	bh=4ZTB5yNEhzFeYRPm7RO+Hv5mIE3RCIsFcZAFiThZ+rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnXQw04af+6FnyVVqGg+mvhqF4jRr/j/48SUUdYG5TsIjZJElu0Nl1uPTMyHhx6+0lY93VNbzdJom5ttlV2fCQ5oRdJVxitiZHRLl9Yc/QIUU90g9FD9kR3AOcescSFPkKYHX5fBbsOhOjFCLOyRN44YZ5hIbytiEijsHCJfClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQejdY96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQejdY96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E0C1F00893;
	Tue, 15 Sep 2026 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467766;
	bh=FD0usaDv/+Lu82oshcV7j/hEpSlA+eSeMjmlzM+oZoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oQejdY96kS0xDsfpwi0u/8CNcZshfIEcghMbq5EHuhdKdZOZd5dm8x5NoCxMA4QJ8
	 1tVhOQNfcGdgzFkcb7ICrok85RIer0HXOnjE+ZozSow/Ote97fP1TOdja1mH1yvyBS
	 RSgIK9/EgtyJqDr/CqhxB+w5HUgoNiKCwwk/N9Xil0sAHDAY33meJquZzcN/izHJJC
	 WjbKqynoKiDnHI07kaNPPaDLHXlW/dGUxJQioKFp7J7OZWE3w2CDAdfVcivicABUYa
	 gWiWpQZFDZRKpn3GL4ByTn3Fdh1zP+EIu4R5zms3xAr/T1svYeZ8aQCnqumZjkOd+m
	 PGOU/L+HP2+2Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 12:22:18 +0200
Subject: [PATCH 3/6] coredump: hold RCU while releasing parked threads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-coredump-fixes-v1-3-f354ca41780c@kernel.org>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4ZTB5yNEhzFeYRPm7RO+Hv5mIE3RCIsFcZAFiThZ+rg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStlMm4We52yWHKuhsh1+4en2LDcv2Rs99O4xW/JD/P0
 P2XHBG2vqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAihn2MDE2Fnw1CM1z0uIN3
 2JqtOFIfLr/rx8G48ws5TV3vtrV/YmNkuOw6Z5HCZO7cfUHz173WlpTR2auVcfpOl5tRt42LfmQ
 XKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When coredump_finish() releases the threads the wakeup neither holds a
reference on the task nor is it inside rcu.

The threads don't necessarily need a wakeup to exit. If it gets
preempted or was woken for other reasons it sees ->task cleared and
exits. So only rcu keeps such a task_struct alive.

If the coredump client is preempted between the store and
wake_up_process() for longer then try_to_wake_up() takes pi_lock() in
freed memory.

Hold the rcu across the loop.

Fixes: a94e2d408eae ("coredump: kill mm->core_done")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 791a9268ed96..78ab6cb78be8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -602,6 +602,8 @@ static void coredump_finish(enum coredump_state state)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;

-- 
2.53.0

