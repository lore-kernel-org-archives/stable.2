Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674977;
	b=Q7KqjbIWukfE3kr9JtMrodjhqDHf9FSsZZ2kXcA1s6tSvrfuBSkh+VKAm3pHBExGVx0z
	 Gh+smBuXHLvkkGpd4FP7preqOoNtxXYE5aUOceKeAPIB6/2T6MrZIKfLNfI0KZb8abGUP
	 UF7wY8gDi/MKnSuerX3qIZvJ23uBYFVRwmdGbTb8t/+wXFTEKNk8M6eoc3/3+0UA8bzlC
	 YOFBwQ3XWG8FPvjSHXmjEM7ZlgU/wJwAgsKOqju06/EeTcDKUmMAW6IxD4QqJCXwgi80P
	 TzPzkzkMc0XT/AAQYXt0QcXuwDe1oJ+bVDjK+P4yHNS8WMXOZMkHvWHesCLXVM6jFvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674977;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=tvLCjBKmutV5BgeydgV+M5L3jhBbtJIwM5d/ZCkN60Y=;
	b=qzcb0UAXhCAwg5PqRzCFOzuZX297aIMDty4RpfrDeSpmI/0kYJvjAZgbymBABQzmV3+B
	 XTlxmuOUKnhfPaOYIOKVHTpY+FO1JenO5KVh9TIFS26k1gq9enqRe0vTTs4smuxS82Jnl
	 5fJRkmsC2uBjor+PaOFeljK8HSCc7o3YJ+q8ny6QRcvkfFRqdSzi3XF/IytThpbEepcsb
	 SBF1dx4fvcWj8t9FMFSRUoOOTsrbLyKl+SXj8vcZpercQW6i83RGrM8N6xf+jwR4Q2K36
	 BiYyIXpg5aEQ2SzoqdxC6ULDp79E/hkmhlUWBRkFdfxt8TwfxcLO6Ogq4tmqIgZONAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXEBvfC8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36E606A330;
	Thu, 26 Nov 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXEBvfC8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674977;
	b=tL7YEx3MaQqIMoJoTefdN/tXfU31iGIpR5Sm51pvLfvPFKrK0tB5Z6mMQXjyvoDDcfJn
	 TnBujpVeJ1OMjeYwgTS2UN9FEGIuM1I7Xg6N78PeBtqpMKxA4UVcP7fbLuVs++HGA1uL4
	 SLr6nIvTPs53MbbE5rZ7K8nWMMwFhRbqROrUlSLHIXydFDXeW3mt3xY+9tMGE85mXQaDg
	 bDkz8PqaOvcxBhn64dHZ1Q4jkptlulrfN6r6qJ2LfxNaRCo/60Q0lH+q0pmxrlBAUzDXQ
	 1BrbxV4y2xnZYqZRwiGMSsUN4OeXOrE5Edd0pNdq0/+driDqipRZNIMve+2gKSE26Tg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674977;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=tvLCjBKmutV5BgeydgV+M5L3jhBbtJIwM5d/ZCkN60Y=;
	b=cACTLqmq8U18/9LHXhJTTKIFVcKv5Y5+TiwB+aFg7QHVNcWZSl3EVLV/MfwYTP2ebkey
	 DauM/GiJU8YPMC6XCHZFzjnj+lNol38GOF1q295asYErqrRl1609VyfREW/i5qoLJLs7o
	 Hm/aA5hHvNRnVs+t4RKu9obOZX8Cn9g18vGyxNVzsUrz1lIK92Nn3dTWj5QTtBzVkpmfj
	 9mGENeDCatoH8EN+MYGx3TYJw001Hs+nilZSW7Ft8uqvbVIbp6rmaNSEvRDd3OZbWhcCw
	 FBxHbVt1JjTGYVjuWJYfTJDwETJN4oZmr2S1A6VFMROq6lREBfrepDgp4Q3V2Ex4/jQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC5A81F000E0;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674977;
	bh=tvLCjBKmutV5BgeydgV+M5L3jhBbtJIwM5d/ZCkN60Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=RXEBvfC8uGrnW85r1bCmKRUrSZcCMImhLV7DBLLVFJ0KybE3YXPKYGd1qQs9vVE1k
	 pki8vE4CLbo1oIwS8xnw5qjqg4Z4S+sQ3N7ovBzF8XNfOzoVNPWu9lWQIoE86Y6RJi
	 8KM3wCHrXKt5ovrLgNtj+r0Mqe2c1vZRWIKxkAsIRo6/1FLEUEglT9UhMXPXP8YftU
	 HTTlIF9BGnFfPhW38GNUuOwdOlaouj0vY/HRnZBuHTvj4323IdnTFV2w30bchAfG2T
	 UDcsd0OfCXFDLpSVsmQ8KEkKiTsU2oWYeHFH2pFY+55VXkZ7aaE5+DhDofZGZtDYc3
	 O1IHRNNqQ/JJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 68A3B4D26F;
	Thu, 26 Nov 2026 06:35:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Thu, 26 Nov 2026 06:04:58 +0000
Subject: [PATCH v2 5.10.y] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-pid-510-v2-1-f528abaf9d3c@certik.com>
X-B4-Tracking: v=1; b=H4sIAAnMB2sC/y2MywrCMBAAf6Xs2dQkkCD+injIY2NXJCnZVpTSf
 zdRjzMMswFjJWQ4DxtUfBJTyQ30YYAwuXxDQbExaKmtUtqKmaIwSgqJyToMKRh3glbPFRO9vqc
 LmFHJ8Q3Xn+fV3zEsfdNL7xiFry6HqSvGHJdSHqL7438P+/4BHb50JpsAAAA=
X-Change-ID: 20261126-pid-510-0ef6aecfc5a8
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795673098; l=3176;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=3NDn9fE75xOZ9wPgLWG/nqyjoyHoMyS/t4NUADphw4s=;
 b=ZuwHO1MkeOvSWFTeov5kOKS7DzuukPs21HVsYnEKy1mke2c8g94OYkC+0c6qsi5EZDIhFn+A1
 ykh8ydyoHNaA/1YIJBLHt85lRc+OPfJOP7DfbwCS9iishvlnEUij49Z
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Christian Brauner <brauner@kernel.org>

commit 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2 upstream.

Since commit 7fea700e04bd ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") zap_pid_ns_processes()
clears TIF_NOTIFY_SIGNAL before every kernel_wait4() call. Otherwise
kernel_wait4() doesn't sleep and returns -ERESTARTSYS if
signal_pending() is true and the reaper busy-waits.

But clearing TIF_NOTIFY_SIGNAL doesn't fix it. It can get raised again.
For example, klp_send_signals() sets it raw against any task that hasn't
transitioned yet. And it keeps sending it until the livepatch finishes.

The sleep loop waiting for pid_allocated to drop has the same problem
and it doesn't even clear anything. So a schedule() in
TASK_INTERRUPTIBLE returns immediately.

Use a no_notify_signal guard. signal_pending() will ignore
TIF_NOTIFY_SIGNAL and the pid namespace reaper sleeps until a child
exits or free_pid() wakes it.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-5-6609e42b3157@kernel.org
Fixes: 7fea700e04bd ("zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adapted to 5.10: explicit save/restore instead of guard() to avoid a declaration-after-statement warning ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
 kernel/pid_namespace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes in v2
v2: resent through a whitespace-safe path; v1 <CAFaZ9ep64RtaNeyK42OVLSCwD_g-E5RqjP4qbK0=45unkG=Zag@mail.gmail.com> was damaged by my mail client and does not apply.
v2: dropped the signal helper patch, Sasha already posted it as <20261028224958.2405498-1-sashal@kernel.org>; this patch depends on it.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index e032b1ce7964..2c525208b6ad 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -174,6 +174,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 {
 	int nr;
 	int rc;
+	unsigned int no_notify_flags;
 	struct task_struct *task, *me = current;
 	int init_pids = thread_group_leader(me) ? 1 : 2;
 	struct pid *pid;
@@ -219,9 +220,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	no_notify_flags = no_notify_signal_save();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
@@ -277,6 +279,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		current->signal->group_exit_code = pid_ns->reboot;
 
 	acct_exit_ns(pid_ns);
+	no_notify_signal_restore(no_notify_flags);
 	return;
 }
 


