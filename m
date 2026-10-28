Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207632;
	b=OIZ0VA07a5ujYCaRPoZZYq/3sz3xupBY+FfaN+GcpoYq3wCw1pRCwT/zLw3CWZOnB4Va
	 FpxzMCCAz73Zifi9zBVB9b9g5YiMu/bPg6bFyI/ByGlaP8xABpp8LZhV8iFVj/4XttWzx
	 ZG1qb5sAf5LoviMhPheA1oL/Stbg5dgfiRZgrgnSGAUygOCjxHX/9fCJORNDoMyiNoZrk
	 zBWG46oWWAPvHYkcrQnIWq3pos5bMFPh9xAS4qMMg8+hpCLI5A7gGaTNUJYvifO5kqFum
	 VHMZx15IdNzug5+AxyMeHzbDVRe3Ps3xHvZ0YvznYF/bNNbrI1Wxq5scqBAUCvhn9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sKuvTwynz/5NWoqcFoJF8Tn3STCBDfJtDK8WvdT4DaE=;
	b=lYVWR98mYKRLaTVz6ec4wbMJ2nx+gJ46LIQ1iGNe6Olc/L+vOP8WN8kNGEZ3WwpVHNxK
	 fZGZH2b5TchCRCXtfKCdu6cIyHsMwFq8YEZvwiwgKSsOB+saPLOJbRzbO+fDi847bluHC
	 XtmdRvuAfx2Q17AUhnqzir2RqV4smY98CZjXQyz89+i+B3OIg9aRYfwDxR5mha9wFZ2Mh
	 tTS0HCrjjtlI0Lj38QKnq4nKrKccDaGgQZ89z372wO0a2IzOdjqKAn2vTwExHdUln8my0
	 EWPdmB8Oy1R3UQXEUTtt+gUpocjkpntAQe0yT6UGfPHjJcyPadVmTX2rj4lIrhBDKUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9sNZo1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450D606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9sNZo1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4935C1F01825;
	Wed, 28 Oct 2026 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207631;
	bh=sKuvTwynz/5NWoqcFoJF8Tn3STCBDfJtDK8WvdT4DaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T9sNZo1xCIPI9AiTzWAaUyOgtEfiLjPrBsTWLrDFkb5cdRrhvwel/mttVCK+RhvXx
	 U8ESOgkCN2aikT+woKRv5fLRWbg8xVYXNZA6OaIlCynN5ttARFlYWTF2+eZN+C3gSe
	 HRPWQub18Iv/TebMcmdXct47OkuGOm4ulkyCF1e9uLAUWkVxR363uUapk8oIzXkMai
	 E4+nXiyNzDoJdFXOLPbiTghcXpuLFAmdXS8Su7vDUCTPAnEK/aC/qGuUMrD/tmioP3
	 csnrpE4N/t/0ZiXeQZLdO63CigdHQ55pz4w6LHkVJunbDXLapb8cKAljewZa/0J+2A
	 u84Z9nO5NLJDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] signal: only SIGKILL and the freezers interrupt a coredumping task
Date: Wed, 28 Oct 2026 13:13:50 -0400
Message-ID: <20261028171307.1531190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102833-percent-budding-a7c4@gregkh>
References: <2026102833-percent-budding-a7c4@gregkh>
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

[ Upstream commit 563d606b93d7a1d23512832fc252d32c68860d87 ]

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
[ sashal: Used signal_group_exit(tsk->signal) instead of explicit SIGNAL_GROUP_EXIT and group_exec_task checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7e5ac34112bd5..78e425839d498 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -410,7 +410,9 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!signal_group_exit(tsk->signal)) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!signal_group_exit(tsk->signal) &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		mm->core_state = core_state;
 		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
@@ -546,13 +548,8 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 
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
-- 
2.53.0

