Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEC2773F0
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748351; cv=none; b=DV3f0qnh4H3rK0z1eZIovHY461IEukccBQk734gcxWjmZOF6qbqkayM7Z+9TMRZKDExyEHVlQ55akNVYF8w2iazPz+pBdxTwu5IlqHcIokDFbgByIFD42sGM4IuS2Vv5PDxRLLbn3F32yMr2WHqKIufgFihYOKuLS50Ks2SLa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748351; c=relaxed/simple;
	bh=dv1pARTtFjPtVkg/6fqnOmSQke45TNrnl48lRJsdSzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYa/1uJVjiCmmK/kP9a7uW8nm63g3wKGIvF1p1brM+YvbfmPQKFYEfjEFTj3YthprGVoSQyoo0FYI1yY6kbpjg8HffIzB1KrMUly4OZNJmsG2WAmkayj1vv6kSQIiLXzHs8w9XHmDWIwodxh+7n5NIhUc5/yOqr+T4yOVPVhym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1MFtk2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1MFtk2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7458B1F0089A;
	Sat,  6 Jun 2026 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748350;
	bh=ZRXO9zMOmhWnGerK2W3Und+Hl2t4D6xMEy5fO3yMUKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1MFtk2R5W9xgcbwrLr/e8CikR+OUN1vDzwJA37WlkeL/9P3HXScaAvVBhJYvatc2
	 IOeSIaBtwxDO+drLL+1HK46whNHSnx529JBmPtpk7D48quIDXgxEq3VmGCmAsHs2YQ
	 sg548PE/KAS1p/7el0AKfh1DQvL+KOOG96hzAUpQX+UPr85mkUGhiP8hNVJB8XnoOX
	 RiRfSBrimjhQk0B3gNkFUok9bedmDx/3cMVpfiidAgUsoMjMHnjKyxwp5VpIO07SZd
	 vJ02A3JycXSPMsgbjYO+b5hnRmRQkBx0WZ45UDTWb7HLZ755T8fSrT8hcZEkBFOOV+
	 a93Buci6kGz1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9=20=28eBPF=20Foundation=29?= <alexis.lothore@bootlin.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] x86/ftrace: Relocate %rip-relative percpu refs in dynamic trampolines
Date: Sat,  6 Jun 2026 08:19:06 -0400
Message-ID: <20260606121906.2851584-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606121906.2851584-1-sashal@kernel.org>
References: <2026060417-mounting-subarctic-8502@gregkh>
 <20260606121906.2851584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

[ Upstream commit a17dc12bfed8868e6a86f3b45c16065a70641acb ]

With CONFIG_CALL_DEPTH_TRACKING enabled on an x86 retbleed-affected platform
(eg: Skylake), with retbleed=stuff, registering a dynamic ftrace trampoline
crashes on the first call into the traced function:

  BUG: unable to handle page fault for address: ffff88817ae18880
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 4b53067 P4D 4b53067 PUD 0
  Oops: Oops: 0002 [#1] SMP PTI
  CPU: 3 UID: 0 PID: 187 Comm: usleep Not tainted 7.0.10 #243 PREEMPT(full)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
  Code: 24 78 00 00 00 00 48 89 ea 48 89 54 24 20 48 8b b4 24 b8 00 00 00 48 8b bc 24 b0 00 00 00 48 89 bc 24 80 00 00 00 48 83 ef 05 <65> 48 c1 3d 1f a8 b6 02 05 48 8b 15 f6 00 00 00 4c 89 3c 24 4c 89
  Call Trace:
   <TASK>
   ? find_held_lock
   ? exc_page_fault
   ? lock_release
   ? __x64_sys_clock_nanosleep
   ? lockdep_hardirqs_on_prepare
   ? trace_hardirqs_on
   __x64_sys_clock_nanosleep
   do_syscall_64
   ? exc_page_fault
   ? call_depth_return_thunk
   entry_SYSCALL_64_after_hwframe
  ...
  Kernel panic - not syncing: Fatal exception

This small reproducer allows to easily trigger the crash:

  # echo 'p __x64_sys_clock_nanosleep' > /sys/kernel/tracing/kprobe_events
  # echo 1 > /sys/kernel/tracing/events/kprobes/p___x64_sys_clock_nanosleep_0/enable
  # usleep 1

Monitoring the crash under GDB points to the exact instruction in charge of
incrementing the call depth:

  sarq $5, %gs:__x86_call_depth(%rip)

This instruction matches the one inserted by the ftrace_regs_caller from
ftrace_64.S. This emitted code was likely working fine until the introduction
of

  59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()"):

it has made the call depth accounting addressing relative to $rip, instead of
being based on an absolute address.

As this code exact location depends on where the trampoline lives in memory,
the corresponding displacement needs to be adjusted at runtime to actually
correctly find the per-cpu __x86_call_depth value, otherwise the targeted
address is wrong, leading to the page fault seen above.

Fix the %rip-relative displacement of the copied CALL_DEPTH_ACCOUNT
instruction (from ftrace_regs_caller) by calling text_poke_apply_relocation(),
as it is done for example by the x86 BPF JIT compiler through
x86_call_depth_emit_accounting(). This corrects both CALL_DEPTH_ACCOUNT slots,
in ftrace_caller and ftrace_regs_caller.

  [ bp: Massage. ]

Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20260527-fix_call_depth_in_trampoline-v1-1-1c1abc8ae310@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ftrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index d3b14a9ad2edb7..6bcc080f361e36 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -370,6 +370,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 			goto fail;
 	}
 
+	/*
+	 * Generated trampoline may contain rIP-relative addressing which
+	 * displacement needs to be fixed.
+	 */
+	text_poke_apply_relocation(trampoline, trampoline, size,
+				   (void *)start_offset, size);
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
-- 
2.53.0

