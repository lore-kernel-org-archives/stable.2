Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204214;
	b=Ws6E4gSWCuFORGD0n6QVJRTGCVZr9foCvWZWAOdXclGEYWcQ2yMnSJu3TGCisTzKqaTc
	 GVJEUQW6SQJ+0M95wba/j4CT0hlO4jicNziku9ZCX8mjHn1ozkRiOfjfW2+t6xb4+286Q
	 csgzTWpcjIdFnfz9u8vd4NRYbDFCopIIWMWUQXo2F1907QnbRFNB8wD9GyXp0Mgm6imby
	 VxK78nWwSt+CKlN0AUKZix3mxHVKKcKoZ+h/qikAyeEdz92Vk7R5JEI8l7R+IIFvF83oN
	 C9wHH2T6SCpo6ca/zVT9ms3en5/qjgcigRwlvcZ7UCfbOMauDLdz/o/edB7kXsFgB+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vzSDzaqLtoQpH5hPmKBpMnFxkjPzBkToLEpKpuoggjY=;
	b=X+2gvyjb1Ma3K20uyrUr8B1fzNTEz/hmpHVb5fHL0mtxRhJuU6cOt1kb6FbPt04uHWrz
	 2/aWzCiw1Q6pFApf66DzbfCSoZhSid26Due6wgsKfR9rkX3Ib1H+SstUNgeChsxdtWJwh
	 +XJrAXAyZzZk0S859TB8XSVjmxofrBxDrCSVjoqIpKO0JHeDNDGDdzHd0biVzsUrt8O0w
	 Ym9yEiNw6DUT9RwIOGqWP6jbGhM6dzHzkUJItmcrhyW0qoqWA8zaR1s1saQtLscE84l9A
	 EMmtAedT3jWpLW9GA6mV3yGisf/QPLHbu+zzfL6iLBpgIGYktglo33tEqA0/h9orx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhJipt0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD882606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhJipt0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB8B1F01829;
	Wed, 28 Oct 2026 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204213;
	bh=vzSDzaqLtoQpH5hPmKBpMnFxkjPzBkToLEpKpuoggjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhJipt0WnZ4HzV04EFpVCiiRCauPeUmtcQ3G7hWcTIOddXMTCs8a6cqoMSXQuj8Vf
	 DCAmtM2zbQ8fAAeBYR0w+JiOJT6vP05ALe6A5ItfzkGUV/BWJ0U0I7864ljwLGvvCh
	 xBo7j86rbxCOgPkGVe6EoqovU6FICP8r4toccKdFQ6jTaPJjDTHkPC5CUYKUAWb285
	 n8QQXeq5MRjC/p3UmivOVhn3HlA3B+SuWBHseyH6r9HPuuVViteXtN+Z2Hf/Byp+O4
	 TTeM9BV9lDTt+qBbhMak8wjo597cQaL/NgF+hDt3N/dqhDAjviXy15mv/miwrQPKXg
	 G+rfl5fbTnjUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] signal: only SIGKILL and the freezers interrupt a coredumping task
Date: Wed, 28 Oct 2026 12:16:51 -0400
Message-ID: <20261028161611.944223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102833-anagram-laundry-e618@gregkh>
References: <2026102833-anagram-laundry-e618@gregkh>
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
[ sashal: Adapted the coredump startup check to use the existing signal_group_exit() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5e5c1d72d63bc..0f0aab402a37a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -409,7 +409,9 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!signal_group_exit(tsk->signal)) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!signal_group_exit(tsk->signal) &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		mm->core_state = core_state;
 		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
@@ -545,13 +547,8 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 
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

