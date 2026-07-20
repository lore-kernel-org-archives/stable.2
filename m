Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4D1A4F3C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557956; cv=none; b=DSLitH6HSUmCtBWzfbdIIoDzd8O67hgjIgi4WcOZEv3tsllXZpi8/ly0UnnUFs/9+YHbpq7cqOUrMDBE4LCQ36+/vlAl35qlbuJH14U334QIy3P9TGnktIhUTFpS9lJGtj/CeqHmH5twlI3loMtzupGIgJTE3SAX7dDKqnVm4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557956; c=relaxed/simple;
	bh=Snj3Ct/QXksuR9hpCzQFdEoU8ZddlEnFPKGh9/0BlVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J5a7crqeH9u/1ytwI4evZhA5Ljhvp8QY0oVCDFmlg4vNDddhv+EvKyjKQLhx1BvG78tqHQeFDQFgkv9TOJ99PL5l5av3E4d5IKjzbsmj47xphUGFcHkDUDV5SwnL+P1R3hKYDQe+njZCbnLnmjxuCl4nfTH5UpyguIAYlYYFtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCbTjAL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCbTjAL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381941F000E9;
	Mon, 20 Jul 2026 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557953;
	bh=elWvcS3eIP2sccVuMWKQvYvufg3eIzG7oVukUJa4/fA=;
	h=Subject:To:Cc:From:Date;
	b=RCbTjAL9pHI4p3ub6ZvVgICKxvrsZdubKGZ+uX1OrPVe0r+b1JF3X887c5aVZ8BwT
	 CDrniv7R0LDiPNc1WFabMSAsz7Y693bkqwp7cLL6X0Y4Q5kcj5XTX73turQtyNEXi7
	 9QdBVGOWtJOooB9m/R7QkcvJEyepFyNEzwvdg1Rc=
Subject: FAILED: patch "[PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal signal" failed to apply to 5.10-stable tree
To: kovalev@altlinux.org,asmadeus@codewreck.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:32:24 +0200
Message-ID: <2026072024-extending-list-343c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b4f48728faa8bb514368f7eacda05565dea8696
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-extending-list-343c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b4f48728faa8bb514368f7eacda05565dea8696 Mon Sep 17 00:00:00 2001
From: Vasiliy Kovalev <kovalev@altlinux.org>
Date: Wed, 15 Apr 2026 18:52:37 +0300
Subject: [PATCH] net/9p: fix infinite loop in p9_client_rpc on fatal signal

When p9_client_rpc() is called with type P9_TFLUSH and the transport
has no peer (e.g. fd transport backed by pipes with no 9p server),
a fatal signal causes an infinite loop:

  again:
	err = io_wait_event_killable(req->wq, ...)
	/* SIGKILL wakes the task, returns -ERESTARTSYS */

	if (err == -ERESTARTSYS && c->status == Connected &&
		type == P9_TFLUSH) {
		sigpending = 1;
		clear_thread_flag(TIF_SIGPENDING);
		goto again;
	}

clear_thread_flag() clears TIF_SIGPENDING before jumping back to
io_wait_event_killable(). signal_pending_state() checks TIF_SIGPENDING,
finds it zero, and the task goes to sleep again. The task can only wake
on the next signal delivery that calls signal_wake_up() and sets
TIF_SIGPENDING again. When that happens the loop repeats, clears
TIF_SIGPENDING, and sleeps again indefinitely.

This is triggered in practice by coredump_wait(): when a thread in a
multi-threaded process causes a coredump (e.g. via SIGSYS from Syscall
User Dispatch), coredump_wait() sends SIGKILL to all other threads and
waits for them to call mm_release(). If one of those threads is blocked
in p9_client_rpc() over an fd transport with no peer, it enters the
P9_TFLUSH loop and never calls mm_release(), so coredump_wait() stalls
forever:

INFO: task syz.0.18:676 blocked for more than 143 seconds.
      Not tainted 6.12.77+ #1
task:syz.0.18 state:D stack:27600 pid:676 tgid:673 ppid:630 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5344 [inline]
 __schedule+0xcb4/0x5d50 kernel/sched/core.c:6724
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe5/0x350 kernel/sched/core.c:6816
 schedule_timeout+0x253/0x290 kernel/time/timer.c:2593
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x409/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1d/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:448 [inline]
 do_coredump+0x854/0x4350 fs/coredump.c:629
 get_signal+0x1425/0x2730 kernel/signal.c:2903
 arch_do_signal_or_restart+0x81/0x880 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xf9/0x160 kernel/entry/common.c:218
 do_syscall_64+0x102/0x220 arch/x86/entry/common.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Fix: check fatal_signal_pending() before clearing TIF_SIGPENDING in the
P9_TFLUSH retry loop. At that point TIF_SIGPENDING is still set, so
fatal_signal_pending() works correctly. If a fatal signal is pending,
jump to recalc_sigpending to restore TIF_SIGPENDING and return
-ERESTARTSYS to the caller.

The same defect is present in stable kernels back to 5.4. On those
kernels the infinite loop is broken earlier by a second SIGKILL from
the parent process (e.g. kill_and_wait() retrying after a timeout),
resulting in a zombie process and a shutdown delay rather than a
permanent D-state hang, but the underlying flaw is the same.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 91b8534fa8f5 ("9p: make rpc code common and rework flush code")
Closes: https://syzkaller.appspot.com/bug?extid=3ce7863f8fc836a427e7
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Message-ID: <20260415155237.182891-1-kovalev@altlinux.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/net/9p/client.c b/net/9p/client.c
index b7d947910037..69d3efd340c0 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -600,6 +600,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 
 	if (err == -ERESTARTSYS && c->status == Connected &&
 	    type == P9_TFLUSH) {
+		if (fatal_signal_pending(current))
+			goto recalc_sigpending;
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
 		goto again;

