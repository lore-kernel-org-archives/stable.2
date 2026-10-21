Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597700;
	b=vJDLH7pV5VRCQZtILe+89jfYuxHiuEiAq+kqRQqi6nR33WLyFIMJlM1IgVBJkoL7o2cr
	 ZO7N4jY+KKB2lzqh0abfP6uP98YD8l9eYLsulcCLjmPFxLv9Ny07QLmkmV6N7ITPxP7Cb
	 Kz2CPTqGDXj/DugxoFfPWthAISHGTCcyuaB9L0Meo0dfe4VUfnoJBe+HUJzK3df9WVpvn
	 +h5kK8u9+wi4Gscv6ea2F0Ii5Vrfgffe1+pBHgWXxtVcfQ8gWcqORipX6+be11b6/TKil
	 qAGbGhG5suny/+ikVR5xZKG1oxzFM9ltZCCs7HCCzAQMgD2goZSn2xOQeXJyWuJTG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Xh+U7WPlH5Wuw6i8c9IA/XbP3vmA07p//c9V/0TkTPU=;
	b=yP1gibpK0CFARvX7SWAVFvU8MEIsTIBy4cZreTsjrgSvggmKfkJGPFAK0Wegjt8wThOX
	 jsBPu90Vie2X8ACrdbJf3XAvxS2+Fy1s9Ph3T9l9u3/wkF747waF4U8W8/Ah7cy2thbJv
	 2dJOGP04KBP/aO8BaZ7aN1RG1DgNV83Qfdx9aknBjJVC10UA02k1GnqUcj2+DkiuYvanH
	 GzObr/nsF0EDuVzCc6eTUS1s5CB/E5WOTttYRXu8tOhxo086gBFBAffi4J+S9tLFaSVEj
	 xhkvABzSR6SI8mSVWuUNE6KPDrvEq1guPetb+hiawSxLo4ajbhbzCMC9srqAWWt9c5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T8j/ZQWP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D6606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8j/ZQWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4201F000C5;
	Wed, 21 Oct 2026 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597700;
	bh=Xh+U7WPlH5Wuw6i8c9IA/XbP3vmA07p//c9V/0TkTPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8j/ZQWP35t6CWWwz6xqZ36zrf8O9sUDgT9r2Ow2WgV0qsNIHzeoiWT/HuO/xDCHo
	 yshmWXo5kBHmV2TCeeFy2Wpv4ktRa2Ql1W1HIxC+WprimjCPoUJe2YuTwbCzozzUly
	 gaxiqnvnTNpsGeGUrr++lfVXyA9OzWVGp/PCF6rrfw3iKUJa67S3JnTvTP/yVqzP6i
	 Fi5ckSglWfITjElJOk7jrSsulcd5krYk+FM3jBceNWPTpt1gvvFYTj3RDZtkUaeIQ5
	 1bwjck9c2lvEYT5vrpOMiAZtAuymKj3zwY4WzW5fefaYyQtDA2EEa3Jqgd9sxNoELJ
	 S/bnljsqtvPEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aviv Vaknin <vaknins33@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] pid_namespace: make zap_pid_ns_processes() freezable
Date: Wed, 21 Oct 2026 11:48:17 -0400
Message-ID: <20261021154744.363841-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021154744.363841-1-sashal@kernel.org>
References: <2026102100-lifter-velcro-2a2c@gregkh>
 <20261021154744.363841-1-sashal@kernel.org>
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

From: Aviv Vaknin <vaknins33@gmail.com>

[ Upstream commit 81933038f5e273d17ed22792f906889393b204c5 ]

When the init of a pid namespace exits, zap_pid_ns_processes() waits
until all other pids in the namespace are freed. A tracer outside the
namespace that does not reap its traced zombies keeps those pids
allocated, so this wait has no upper bound, and while it lasts every
suspend attempt fails:

  Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):

Neither wait is freezable. The first loop sleeps in do_wait(), which
returns -ERESTARTSYS on the freezer's fake signal; the loop then clears
TIF_SIGPENDING and waits again without ever freezing. The final loop
sleeps in TASK_INTERRUPTIBLE, and since nothing clears TIF_SIGPENDING
there, schedule() returns immediately after the first freeze attempt
and the task spins until the wait ends.

Sleep in TASK_INTERRUPTIBLE | TASK_FREEZABLE in do_wait(), so that the
freezer can freeze tasks waiting there directly, and in TASK_IDLE |
TASK_FREEZABLE in the final loop, like coredump_task_exit() does.

This was hit with Chromium-based browsers: crashpad ptrace-attaches the
threads of a crashed renderer, which is a pid namespace init, and does
not reap those killed during the dump.

Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
Cc: stable@vger.kernel.org # 6.1+
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
Link: https://patch.msgid.link/20261002202820.3433318-1-vaknins33@gmail.com
Acked-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c          | 2 +-
 kernel/pid_namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d4addbc7aff20..b3cfeba72dc02 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1646,7 +1646,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a575fabf697eb..cd3ee747649db 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -242,7 +242,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * free_pid() will awaken this task.
 	 */
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
 		/*
-- 
2.53.0

