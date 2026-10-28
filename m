Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197484;
	b=IAjkjI51EMOF2D3SHKlQLzVbUUVBgE8K2NRjVdimH/erd7VKtIkAVNXkyBxC4tDpUkZV
	 o10QJ+s0RvmGJs8Q92cjErU3xSRBl+86qiHY2uwVsGKbsmmGfpZbUbmxv4DpHYAapoQNj
	 eoxJSo0e/5owsiyiIKkJudi+TAo/PnzX8eeEt5WGaYDe25URN27wRZKZ+iKpEM15EFEne
	 1u3qog14PRL9SAQ3XusU9m3Pe00QduyGeN40SlsRP0eeFujFVoVyLinM0RKe5cx6trjuC
	 lqKcPAViCCsoN6Y/E9O3Ym9fdhlEWTexRoLj7hi6rlwYB32Yj/Zy7coxqhw52C4Xvug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197484;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MiDrFC6mnZF5bnBbKUAKK+UKoAEzHqW9UEVNKgS3muU=;
	b=u124T9asXsjO5gvunzRohB0AN5fN0w1kf566XHgQv/z2+a7UYfdlXEoy8VclgyvbKEbx
	 3WdloCh+EcM1q8p3rLRJslsVZ0J2ziXeslf9Z2qjpiraLbU1tiCmCVY6SxLUrts5nONgB
	 F27za0j/ZiVObQG7tOYjzGHdFpHuuV4x8WphPh7V3wEQc4nkjN+B5zylruUakUhHJA6yA
	 +76llMwzq+AYilAdQqxh9Zk/8iejhyZWdSFvo3gx6Zj16sOQ/S2rsvq6ej+3quwpZegwK
	 JvpY+HVa+eH26vvrSymuCYEJL+C8kI78QvbUZhGpO+5JDlUtasH7YxoXfZi0Keo4EBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dcIYbDxh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D1606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dcIYbDxh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE291F01825;
	Wed, 28 Oct 2026 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793197483;
	bh=MiDrFC6mnZF5bnBbKUAKK+UKoAEzHqW9UEVNKgS3muU=;
	h=Subject:To:Cc:From:Date;
	b=dcIYbDxhBqchmZB3cSsZyGaBgKTgmT41lgwbQkU7FwQyW1IskgmCs64a/Hoh4wBzP
	 7mz8nYi8TvyjcvsHwrRMzIvFRpJNC0bh/9H1yS/WKryIct/cra1ETygkegmodLuITZ
	 xGfN4+zethsxye+FCDcNvGT21GHCPz8PAmzI3oXk=
Subject: FAILED: patch "[PATCH] signal: only SIGKILL and the freezers interrupt a coredumping" failed to apply to 5.10-stable tree
To: brauner@kernel.org,oleg@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:24:33 +0100
Message-ID: <2026102833-percent-budding-a7c4@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 563d606b93d7a1d23512832fc252d32c68860d87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102833-percent-budding-a7c4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 563d606b93d7a1d23512832fc252d32c68860d87 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 22 Sep 2026 15:26:16 +0200
Subject: [PATCH] signal: only SIGKILL and the freezers interrupt a coredumping
 task

For quite a while now coredump has allowed either SIGKILL or freezing to
interrupt an ongoing coredump. Since we seem to like it complicated
"freezing" can mean a lot of things:

(1) Power Management induced freezing
(2) cgroup v1 freezer controller induced freezing
(3) cgroup v2 freezer controller induced freezing

So (1) and (2) are handled by checking freezing() but (3) isn't.
(3) uses cgroup_freeze_task() which sets JOBCTL_TRAP_FREEZE and calls
signal_wake_up() on every task in the cgroup. The trap isn't handled by
the coredump code.

Which means the current logic is inconsistent. Power and cgroup v1
freeze and abort the coredump. With cgroup v2 it depends on where the
core goes. A dump to a file completes and the cgroup v2 freeze has to
wait for it to finish. When dumping to a pipe or socket the dump is
interrupted at the next write because of trap's TIF_SIGPENDING. Which is
it? Let's be consistent and align (1)-(3): freezing interrupts an
ongoing coredump and doesn't make it wait until the dump is done.

All three freezers go through signal_wake_up() and so set
TIF_SIGPENDING on the dumper. And once zap_threads() has set core_state
that flag can't mean anything else anymore. prepare_signal() drops every
signal but SIGKILL for the group, the dying threads don't retarget
shared signals to the dumper, and zap_process() cleared the pending job
control traps. So the flag is the thing to check. Let dump_interrupted()
test task_sigpending() and nothing else. That is also what the pipe and
socket writes already fail on. TIF_NOTIFY_SIGNAL is left out on
purpose, task work must not cut a dump short.

A seized tracee that gets PTRACE_INTERRUPT during the dump is cut short
the same way. It already was for pipes and sockets.

The one freeze that check can miss is one requested before the dump
started. zap_threads() clears TIF_SIGPENDING and the cgroup v2 freezer
only wakes a task once while its JOBCTL_TRAP_FREEZE isn't part of
JOBCTL_PENDING_MASK and survives zap_process(). So refuse to start the
dump when freezing() is true or the trap is pending. The task then exits
without dumping, which is what happens today when the freeze interrupts
the dump at the first write.

Fixes: 403bad72b67d ("coredump: only SIGKILL should interrupt the coredumping task")
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/arJ6zZuI59BJnXpl@redhat.com
Link: https://patch.msgid.link/20260921-work-coredump-fixes-v3-2-8e4adb1619e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/coredump.c b/fs/coredump.c
index d88a65e37ee1..af09a4660341 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -508,7 +508,9 @@ static int zap_threads(struct task_struct *tsk,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		/* Allow SIGKILL, see prepare_signal() */
 		signal->core_state = core_state;
 		nr = zap_process(signal, exit_code);
@@ -580,13 +582,8 @@ static void coredump_finish(bool core_dumped)
 
 static bool dump_interrupted(void)
 {
-	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
-	 * can do try_to_freeze() and check __fatal_signal_pending(),
-	 * but then we need to teach dump_write() to restart and clear
-	 * TIF_SIGPENDING.
-	 */
-	return fatal_signal_pending(current) || freezing(current);
+	/* Only SIGKILL and the freezers set it after zap_threads(). */
+	return task_sigpending(current);
 }
 
 static void wait_for_dump_helpers(struct file *file)

