Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403D4968EC;
	Fri,  2 Oct 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973073; cv=none; b=FpjJUu8oXKxCQoRizaa6fErw6yeyEcF1x2O2mkqm3C7OMC33gNXRxpNwK0i+kXDssaN1wNM6t6eC9KEBWe4F2Wc6bc9f4XfshZSWw2dHiisUxwy96CxAePzIU9OdgbgTw2zkYvROB4U9TM61sIl3go2lgmzyadGS5KrtfotinD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973073; c=relaxed/simple;
	bh=Jt//0zORUjqMAZAfskjZ8vmMwU4akzPkIqM/XgZLRrk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PD6EuSxE/lRseh53tBZOLwdrOl/BRtgBnq3uCVYbvUUCHGQapT63pCONbT+nKzGTByQM6MYXWe//+w4rPMOeKs8HVDjVPA727Y8xbr8uL5hgZxJNDplWA7iDHvTOYNJSOBEWXuDYXwWY9hJ6VXRBL8GmdKQ0Hnbdl28EWVkvyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JoWFynLp; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=9yvIpN7M; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JoWFynLp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9yvIpN7M"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790973059; bh=kY9pfHR4BXX5Gd5bWbFhgVK
	EYCasw0neJs/hvnXh3jc=; b=JoWFynLpLzcP399dzDnUtnTW/3fsg4UxYfcbEPz4sLmLH8KSYT
	HPduli38S/mXe1qUjIvrynmJ5LbOm6HxxCx5tgqIGSbYFZRcKb+PZl7h9DKuoXCgIp/RBc1/uEX
	joIZABTwowxWmbhGWgWSjTu8Wxzsz3Au4AGXdW8Z81N0rUYth2di/JRWUky3oQhGnI494uPrIWT
	qi8F3tHA0tD+U8LIwV+QXKd/artSgK5UX2Z8ZOhEOotXpTjz5eriQ+gfcGfIKgpg/FIGp1a3qmQ
	SXFGMe68B09Aizod2cTn8cHjnJdmHYi5NTdw1RjIryLhoJ9qB9kQOB9g5DhZkkVNshA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790973059; bh=kY9pfHR4BXX5Gd5bWbFhgVK
	EYCasw0neJs/hvnXh3jc=; b=9yvIpN7M5F09KohKB4kOG8mFjjlZzx3Na+XFtONxzX7Kdz7pSz
	hz847bQVBwXs1v03tqXvBwsV+VSqh27HnVDQ==;
Date: Fri, 02 Oct 2026 21:30:58 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Aviv Vaknin <vaknins33@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pid_namespace: make zap_pid_ns_processes() freezable
In-Reply-To: <20261002202820.3433318-1-vaknins33@gmail.com>
References: <20261002202820.3433318-1-vaknins33@gmail.com>
Message-ID: <1EEB6D9F-78FB-4E6E-9191-A9452139561C@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 2 October 2026 21:28:20 BST, Aviv Vaknin <vaknins33@gmail.com> wrote:
>When the init of a pid namespace exits, zap_pid_ns_processes() waits
>until all other pids in the namespace are freed. A tracer outside the
>namespace that does not reap its traced zombies keeps those pids
>allocated, so this wait has no upper bound, and while it lasts every
>suspend attempt fails:
>
>  Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):
>
>Neither wait is freezable. The first loop sleeps in do_wait(), which
>returns -ERESTARTSYS on the freezer's fake signal; the loop then clears
>TIF_SIGPENDING and waits again without ever freezing. The final loop
>sleeps in TASK_INTERRUPTIBLE, and since nothing clears TIF_SIGPENDING
>there, schedule() returns immediately after the first freeze attempt
>and the task spins until the wait ends.
>
>Sleep in TASK_INTERRUPTIBLE | TASK_FREEZABLE in do_wait(), so that the
>freezer can freeze tasks waiting there directly, and in TASK_IDLE |
>TASK_FREEZABLE in the final loop, like coredump_task_exit() does.
>
>This was hit with Chromium-based browsers: crashpad ptrace-attaches the
>threads of a crashed renderer, which is a pid namespace init, and does
>not reap those killed during the dump.

Suggestion: We could do a ASCII table of the bug to make it "look" cool, I mean, you certainly don't have to.

My tag stands:

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>
>Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
>Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
>Cc: stable@vger.kernel.org # 6.1+
>Suggested-by: Oleg Nesterov <oleg@redhat.com>
>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
>---
>v2:
>- Make do_wait() freezable instead of calling try_to_freeze() after
>  kernel_wait4() (Oleg).
>- Drop the comments.
>- Drop the acks and the review tag, since the approach changed.
>- Retested on v7.3-rc5 with the reproducer from v1, also unprivileged:
>  freezing completes in 0.001 s, the zap task stays idle, and reaping
>  the zombies still ends the wait.
>
>v1: https://lore.kernel.org/r/20261001121254.883973-1-vaknins33@gmail.com
>
> kernel/exit.c          | 2 +-
> kernel/pid_namespace.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/exit.c b/kernel/exit.c
>index 97686af89..b54cc7b2b 100644
>--- a/kernel/exit.c
>+++ b/kernel/exit.c
>@@ -1751,7 +1751,7 @@ static long do_wait(struct wait_opts *wo)
> 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
> 
> 	do {
>-		set_current_state(TASK_INTERRUPTIBLE);
>+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
> 		retval = __do_wait(wo);
> 		if (retval != -ERESTARTSYS)
> 			break;
>diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>index 8bc9edb40..127a5fd23 100644
>--- a/kernel/pid_namespace.c
>+++ b/kernel/pid_namespace.c
>@@ -269,7 +269,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> 	 * free_pid() will awaken this task.
> 	 */
> 	for (;;) {
>-		set_current_state(TASK_INTERRUPTIBLE);
>+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
> 		if (pid_ns->pid_allocated == init_pids)
> 			break;
> 		schedule();
>
>base-commit: ed14a591175bb5f56c2936b082cffb9e4b935e6d
>


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
