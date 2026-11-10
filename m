Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325815;
	b=s6vZKuUKfVgkbKlVXjTWXDtebiMxMAKuZkTth9EoP/DKzcamWddqs1Kfr3xmfBf7t0pO
	 V/irYPDC2G7SQFERvCom92hGBjr+ys26uEBX5Xu+kHK95SYxdJmLSdj7X0zG01JMfr6hp
	 4bkp624NMCDoIevA3cfIOAwXXDP83df05B4yfsaleDiIExX7fYkERCozYhv91SF/rfR3U
	 Yb1rVXF0GkQl/J68niGdIjAVwF9rdoGiK3S5ujzQYjXrjUgXmwQcyQtwmMA5JXLag1NoL
	 fvLJHH0TQbit+/1RpVRAWpfvX/Xy52bMl/sTdxXmFd3PBZhhuLfBMaVxZDY2CKJnbXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325815;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W5VFT6r2Y6eLDidBiMP68rdRUtzolvh9ZqNnQTEK/Ro=;
	b=1XqBSqGTQnJrgXeVR6ABaSL3X3ISwcRhQvo+dCYd3dXCvtQR4ZQBJTE/LDlCu95xdgbT
	 bnPRfhDxPXsfGbbXlaLjQHZH3QSUJ1IuRHBJLQmTc1EPSbVRxfx4LAMuOrCQEcmIByzqK
	 z45Gn6n3P31QfB/a/2inPBy4TOxs4KmaD/YWglHVYqnOKJJGc4cmAgO+7Cua7zgrtHgZA
	 gpolmng5KD4jp6TOwZUwtpwWwfXRZQ+yHKJBWi3+NFult149gvfIDk5HdkF3gNk5A7MLZ
	 kT6O5ooqTDTHPRzADhidVZ4CH3GCmSIN8BAWOXaAp3zLlZrfiz02WWApdCW/CoWx96g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UD+xWoNa;
	arc=none smtp.remote-ip=91.218.175.96
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4498606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4498606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UD+xWoNa
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2Mtu3r90e3i3e1eCCswxBpmz1VV1JltP8voYP2HAqiQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794325811; v=1; x=1794930611;
 b=UD+xWoNa2Y+VN8qwc/WrLIE9ITOL+Ik2z7MzcOBudOE21frl/HXA8u58ZogsZ3jE0R07C3R4
 s8iasIpIyJctDr3Uwt/mG4X6U0gVMRVdpMdzXUlGxHInre2IhkIRt6jhQBliyMoamARTvW60tjP
 wjAd3MA3KRKUImRbxc9fm1r4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66c915b9da646c84;
	Tue, 10 Nov 2026 15:50:09 +0000
X-Mizu-Trace-ID: 66c915b9da646c84
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:50:04 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: leitao@debian.org
CC: angelogioacchino.delregno@collabora.com, ebiederm@xmission.com,
 kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, npiggin@gmail.com, oleg@redhat.com,
 peterz@infradead.org, stable@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: Re: [PATCH] reboot: halt when power off fails
In-Reply-To: <20261110-reboot-make-task-dead-v1-1-af88a3f37bf7@debian.org>
Message-ID: <1DE3FCD9-C973-4B83-AD64-CB6130CDF39D@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 November 2026 15:24:34 GMT, Breno Leitao <leitao@debian.org> wrote:
>The reboot syscall calls do_exit(0) when kernel_power_off() returns.
>That happens when no power off handler takes the machine down, since
>machine_power_off() returns to its caller on x86, arm, arm64 and sh.
>
>For example, an x86 kernel built with CONFIG_ACPI_REDUCED_HARDWARE_ONLY
>cannot power off QEMU's pc and q35 machines. Their FADT is not
>hardware-reduced, so acpi_power_off() is still registered. But the
>legacy sleep code is compiled out and the FADT has no sleep control
>register, so acpi_enter_sleep_state() returns AE_NOT_EXIST.
>
>On x86, arm and arm64, interrupts are disabled by then, and do_exit()
>warns. syzbot hit this on a GCE VM:
>
>  ACPI: PM: Preparing to enter system sleep state S5
>  kvm: exiting hardware virtualization
>  reboot: Power down
>  ------------[ cut here ]------------
>  irqs_disabled()
>  WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930, CPU#0: init/6193
>  CPU: 0 UID: 0 PID: 6193 Comm: init Tainted: G             L      syzkaller #0 PREEMPT(full)
>  Call Trace:
>   <TASK>
>   __do_sys_reboot+0x36e/0x400 kernel/reboot.c:784
>   do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
>
>If the caller is init, do_exit() then panics. Exiting does not help
>the other callers either: the devices are already shut down, and the
>task still holds system_transition_mutex.
>
>Halt instead, as the syscall already does when no power off handler is
>registered, and as most other architectures do in machine_power_off().
>
>Use machine_halt() rather than kernel_halt(). kernel_power_off() has
>already run the shutdown sequence, and kernel_halt() would call the
>reboot notifiers again with interrupts disabled.
>
>Keep the fallback in the syscall. hw_failure_emergency_action_func()
>relies on kernel_power_off() returning, so that it can try an
>emergency restart.
>
>Fixes: 001c28e57187 ("exit: Detect and fix irq disabled state in oops")
>Reported-by: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=8fdf0d8e10bdde1c2e88
>Suggested-by: Oleg Nesterov <oleg@redhat.com>
>Link: https://lore.kernel.org/all/20250404152006.GF3720@redhat.com/
>Link: https://lore.kernel.org/all/20260713062332.21131-1-include@grrlz.net/
>Cc: stable@vger.kernel.org
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
>This is my second attempt at fixing this. The first one silenced the
>warning in do_exit() pre LLMs:
>https://lore.kernel.org/all/20250403-exit-v1-1-8e9266bfc4b7@debian.org/
>
>Bradley Morgan tried twice, first enabling interrupts before do_exit(),
>then calling make_task_dead():
>https://lore.kernel.org/all/20260712125300.31501-1-include@grrlz.net/
>https://lore.kernel.org/all/20260713062332.21131-1-include@grrlz.net/
>
>Tze-nan Wu hit a related init panic during power off:
>https://lore.kernel.org/all/20250410143937.1829272-1-Tze-nan.Wu@mediatek.com/
>
>All of these still let the task exit. In those threads Oleg and
>Christian said init should not exit on power off at all, so this
>version halts instead.
>---
> kernel/reboot.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/kernel/reboot.c b/kernel/reboot.c
>index 9a84401adde5a0..bc71183d4ad870 100644
>--- a/kernel/reboot.c
>+++ b/kernel/reboot.c
>@@ -791,6 +791,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
> 
> 	case LINUX_REBOOT_CMD_POWER_OFF:
> 		kernel_power_off();
>+		pr_emerg("Power off failed: System halted instead\n");
>+		/* kernel_power_off() already ran the shutdown, only halt. */
>+		machine_halt();

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

Id reckon this would fix it, go test syzbot if you'd wanna be confident :)

> 		do_exit(0);
> 		break;
> 
>
>---
>base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
>base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>change-id: 20261110-reboot-make-task-dead-8702e9b29130
>
>Best regards,
>--  
>Breno Leitao <leitao@debian.org>
>
>
>

--- Thanks!
