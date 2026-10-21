Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596578;
	b=ffk06posX1ns2MUjy9PZyeIH/ZSlfIV7vzh83yYBUnRQOq9iJ/OXNEXYES2WwzGkPkbM
	 ytn7yjXINM9dlHyAtxzvbGd33ahkXTSEdJ1uh/vb2GchZVghs667VUTd5vOF8+EhmW1aD
	 43zNjQFge7/CosvLwTLgjqAaAt3bn2HJ3yuYIRM852Q2Ta7bhoucuZf9KOes+8iyPjM3M
	 TBqJaWIq9/zznttdqDoZUXn7exLTGJHF5cV2BtEaMy84m0x5lzZRhBInkISylQtxSFwA1
	 fhxPuwnRcGd7C/V0cBQ2APf4idbj/HGkjM0wBBPGFrrKwmKTX6NEIdxANh/8vyIOVQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xYkc6xvAvPmM1EIpabb6mx140fCNDJvXa/qh5xrtnEU=;
	b=wUNormRa3EhUva2xsb/vyAVXUJuA07fxlXJY2YcJNv2W5pSE7dkgwEEmV/bUd2obZzE0
	 ot78VcvWdTN2l0uzwqsLWLx6J97OJokptwgnr5Avr7uf4yGuGbDeZHTuEgus0KAs7IyLX
	 2CIrw8guEQKkc5/uMhxSegRv3nrV/lbAa67YifyOVJJJU3pR96zFdKgH72pXDo2nxbOE3
	 Jg0PRdqBzEn8w+jcA6eA4fi9yRPQDgBWJ71mbMRb/TMnm+I7XiOckdxs6xYwPYnwSsh3T
	 39yIIHEHLkl8z0Uhy4CpTWM0jrkgc6/i5lawWZ8kuEuvduOTj+GyeryVegHdTiVZKeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQViE9Aa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE265606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQViE9Aa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143741F000C3;
	Wed, 21 Oct 2026 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596577;
	bh=xYkc6xvAvPmM1EIpabb6mx140fCNDJvXa/qh5xrtnEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQViE9Aaa2aXWkZkdBxyXGO79+bbISbjhncXADE7oQA90unXHNkfxmcXfhjS6sYwC
	 EmyNRvogakdEGlVsu99gCwxavmkagyuckyW4EMhHkujsrqBFqhuzFcrhtiLWbWDEtS
	 Wtf4JXDaN4a3kPWrntn/SAiAV2P+l1V97K4lorh7p/8DahV31NqUPX3quBeFLeFBbv
	 JitBhcVnfA1jkJf665B9YU1K7yVBVSisMuJnYvSZ3FPCLU+0Z9P3H3VNXLqc1KnCcb
	 mC17QGTAPuNAto4NoSLo0aNk65KFUFRpT5U/RsQCxuVEIxjH2y24a7TCXI0YWaUcq4
	 TE1jfix76qubw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aviv Vaknin <vaknins33@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] pid_namespace: make zap_pid_ns_processes() freezable
Date: Wed, 21 Oct 2026 11:29:35 -0400
Message-ID: <20261021152921.291520-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021152921.291520-1-sashal@kernel.org>
References: <2026102159-hunchback-poppy-cf49@gregkh>
 <20261021152921.291520-1-sashal@kernel.org>
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
index 07a17f0916107..e2dae48578d96 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1648,7 +1648,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index e9b2bb260ee6c..eea15232f6690 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -245,7 +245,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
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

