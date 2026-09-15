Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E37265621;
	Tue, 15 Sep 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467764; cv=none; b=jMJTJQUZ6xwFH+DR6IWYKe1ExhMsNvP7EsqEdG1VGYutyEeju4q4Lwa8orYiwk1r2oRthWOcaKpWJWoyIg9jY0d5XywlnkvdlrJSPWXeCE3oNuPWvkoNpxt6+03W9waR1XvCNh31GZEsj3++gS906hBvI+AfOVdcn569FKUjSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467764; c=relaxed/simple;
	bh=0nhmnE3MPCAqDO8OmaNk6DjHrGuxEq925OsDr2QuZ50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIfbs21f5XkLjxXpUjm6rCDe5suxM8W5UXQpFsVeXcDxX8tualMARLqNIPwscmub5ly3pWpubbZdQk2zHD/YQT/bzBsVOzGNUDbQ9ilDUiC4hSR/kCqzisdtLCb73C7HEMUbzxpWTYcFwHq/CJs3VUHuGMcDCJEzPC+90mJHlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMY7TSfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMY7TSfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D11F000FF;
	Tue, 15 Sep 2026 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467763;
	bh=PBKg7LMufS9h1DDpU8LEKELjTVcUgWSpF559w+ek458=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZMY7TSfwxPX6+XSJWE5fNaiAdImONMSHR4JKIBL9dbXG4+Tvc2LMW3F5zDJ0MfGfX
	 VNrNXXwcg0lSAO5YKig0GrnNBoUgFnfaZhimWL6gIdSUMXt5T9GKPPrAYsSJ8pb0NH
	 6IPKGwzqetVi9M530y+Y84bK0ov21BxOT/RkB1Ni6fH15COtBeGCwvyWXlHcJOFcAH
	 9N9eLKQztQ2SWOlE70fhb8sCMygtpKZZoKg0O0GWHSTrEJBLdYGUfzWqi0bQffkEp9
	 DKMB6H7x+QWAstvZU6S/cHAQ8mLzNcKngyxtNCWZicirDj1MYUP+vF5eNBV/1yXyU1
	 UuYev70ct89ZQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 12:22:17 +0200
Subject: [PATCH 2/6] fork: refuse new threads while a coredump is in
 progress
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-coredump-fixes-v1-2-f354ca41780c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0nhmnE3MPCAqDO8OmaNk6DjHrGuxEq925OsDr2QuZ50=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStlMkQXnC5/zjzWkZfr9+1i9cEmr1+rpId8bt23f9ww
 T0Nc2v3d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkaiwjw7du/ydccQujotYe
 sZgb4pfA1GlaYnxNeV3ihw6z2H+CTQx/5QJPevocMbnNssx55u/KzBxdQ9kbIXOrvzAvjZcyujO
 DAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Say a SQPOLL thread is a member of a thread-group that coredumps.
The coredump code uses zap_process() and sends SIGKILL. The SQPOLL
thread uses io_sqd_handle_event() and calls get_signal(). It removes
SIGKILL from the pending set and returns. The SQPOLL thread breaks out
of the loop and drains its own task work.

Any pending io_req_task_submit() with REQ_F_FORCE_ASYNC creates a new
worker when no other worker is free. So it ends up calling
create_io_thread() from a thread whose fatal signal is gone. That means
copy_process() allows the creation. It's also possible for an exiting
io-wq worker to push new work onto the SQPOLL thread.

zap_threads() counts the number of coredumping threads. The coredump
client waits in coredump_wait_inactive() untill all threads in the
thread-group are parked. The new thread that was created via SQPOLL
exits immediately since it got PF_SIGNALED from the parent. The problem
is that it sees signal->core_state, links itself onto core_state->tasks
and decrements "threads_remaining".

But zap_process() never actually counted the new thread. So the count
goes to zero too early. So either the coredump misses the thread or it
dumps a thread that is still alive.

Close that gap and refuse creating a thread while signal->core_state is
set. Both sides protect it via siglock so copy_process() and
zap_processes() are sure to see each otehr.

Fixes: 3bfe6106693b ("io-wq: fork worker threads from original task")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10be4a0ecb3f..bd97fc7b885b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2491,8 +2491,8 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_core_free;
 	}
 
-	/* Let kill terminate clone/fork in the middle */
-	if (fatal_signal_pending(current)) {
+	/* Let kill or a coredump in progress terminate clone/fork */
+	if (fatal_signal_pending(current) || current->signal->core_state) {
 		retval = -EINTR;
 		goto bad_fork_core_free;
 	}

-- 
2.53.0

