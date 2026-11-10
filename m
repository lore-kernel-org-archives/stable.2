Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324517;
	b=z9NDTqkSizjNKjCFs5ZyjYWNtYMerh/EhNaniW13xZ2D8+nIn2oVYUhkYORNCwCgkZ9C
	 orf11tBcrmPnKEgGpmgSM7W2tuOUvTnIhhtd5Et212a1pXsDH84OTBTmT6SBOCoTEdtUL
	 cfBl9nnEoPdj/fTrJl+vxz0rulLXKXNVQ6asj9o1QkuHm/Sc7qJVEQVubbohNdUPD8E8b
	 UIMTtv6Nx159Mq8Uqb2SK22GT2NW2RTzP3pafacXF5VSooLQm+gnyVIeIJYuLOOc7Ih3G
	 VJ3Zq70qzUUUyyXIN1j5mtd2+YBdyIEBmgLwNZHl1fwYj9avgF1opap5565lBqSrvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324517;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=6PM7dc9ky7du4QTlvZgvbasvK1Gnn9m7N3fjC8dVD4U=;
	b=VRaXSOWHpyKGLO6arg6mYxa5TI5KiPLZjF2nnk+kfi4Lv/zxSrdXczMAvAccOZpNGzA5
	 HPcUFSp+7oF1piCUOhnxpCXJuM0KU/3InoNdAEQ03eeCBX4Ba7rlgmsg1rA5WxjyfMQDg
	 cahNNA2OPrndNbIb+SOsgi1ylzfFf9H49Oj9AzFUkq6VitESu2iwZa9iDFvg1wczAir5c
	 8yP/RkBwZCG11biqfqO5TbYHXd42F31jZH8rqbZeyGw0dFGDNGfyEH1Wffusd/v9S+8Xo
	 z0cRgmbWc8iR01EpA1r4EhB4tJQ4rPaLB4TQ2s74pWth8PFH01zUa+29gYC5sXtPRMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pV0ZF1ef;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81E606A32A;
	Tue, 10 Nov 2026 15:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B81E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pV0ZF1ef
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=6PM7dc9ky7du4QTlvZgvbasvK1Gnn9m7N3fjC8dVD4U=; b=pV0ZF1efuRrC/FIGPn3u9+LEH7
	+JgJH7g9y4lcv8jEyU/UEEbDiPKtQuSGG6Tn4BjC21YfNT69zGPfv63BUi/GhEJ7cVs6TLd69snKN
	EAfrOm5DKCyIZOI6GyuSQ4N2MDrbVjEikQL/iB3oL/XXAvGthfUrtW2XifcDWpTpGQqGVPKgnZAfB
	PJUjs8ESscBQCzQAoZ09Q5emzngERfoCNV8ZA4ynkcQ927Fj9nAHPSua3tzt1O8hHjOFJXr001WYu
	GvNVTFARMmPLlEgjKM0OBoy6DUz4ABNvej3nVqAgl/6Tb3LgzmRcVEp4jhcBy1Bxx4Jm3TLzBEMNF
	GK3PJc8w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQnlu-00CV18-1w;
	Tue, 10 Nov 2026 15:28:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Nov 2026 07:24:34 -0800
Subject: [PATCH] reboot: halt when power off fails
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
Message-Id: <20261110-reboot-make-task-dead-v1-1-af88a3f37bf7@debian.org>
X-B4-Tracking: v=1; b=H4sIADY382oC/x3MQQrCMBAF0KsMf92BTAS1uYq4SM1Xh2IjSRGh9
 O6C7wBvQ2dzdiTZ0Pjx7nVBEhsEt2deHlQvSIIY4tHMgjZOta76yjN1zX3Wwlz0fAqR4xRHOwQ
 Mgnfj3b//93Ld9x/oGIveZwAAAA==
X-Change-ID: 20261110-reboot-make-task-dead-8702e9b29130
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel-team@meta.com, 
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com, 
 Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3891; i=leitao@debian.org;
 h=from:subject:message-id; bh=a8Z6bBQP7KM9Q5t/M4tExBaQEE62leoxfyQqdfsXka0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8zgawRH9/kLkf5RWr8QkrLuhwWZcPFYLaIVD4
 QxJTlPMskiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavM4GgAKCRA1o5Of/Hh3
 bQrLD/9BHtznr1ZOsNPcDyKV39CtBJpiAZ5NBpwNdXNOkjTZL4Nj54jxHQ4o5QzpfJzhG5Eg3Fa
 nLDuKWPm7DEkfal+9zzBvim41vXwX0ad+3vYNYlqs2WpNMxR/lC0DzpGf67yWA1KaUcLmISITDc
 l5jkVdghaghSqGt6yCDSLq/ZrRTDWu7s1xfwROb+8bldShOypYGp+9bYFvtCLUvQ8m3Gi+sB6wr
 3N6pGR+imSH5odard30MbG69e8ZO/s6lbAAXsXwGiqjeKEegJekQ4wRidPDT1mF9NUfKVed6f1C
 Q3EkWlal56O9CcEUo9fMKt03ZQnDCK/D8KxmQN0UUQ2M1LFmNB1UjpXS8lBviVubQplN1S8mCAb
 4TD+QCt7lYij9hMtq+d9fr3ZaS8gHFUCLz9jf5ubH2A2fMfG5pPxEEXtNNT+CcStdY28/UgMRv6
 ZBl7qEGzb0jbRoH/J20OfV/+VtnNSPSnXbIbu9apezI16tHfYMNGnKjLdJ9bWd/PhVNQ9MTaNMf
 ThGfYQs/ofQZIO37YNvZVOHRJZ54Pa+hZ2vSvX9WuUs49aROksNKfk2xhjobdxhFhSpjYhO+CQJ
 RrcmOI/n3l1e2lf9FM06xDYsm775lUHAQPdzSgUp2FrZ3KZchiC8EP2BMCzwCipqHQT2dodZlNp
 AOgFkrE1yHotPzA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The reboot syscall calls do_exit(0) when kernel_power_off() returns.
That happens when no power off handler takes the machine down, since
machine_power_off() returns to its caller on x86, arm, arm64 and sh.

For example, an x86 kernel built with CONFIG_ACPI_REDUCED_HARDWARE_ONLY
cannot power off QEMU's pc and q35 machines. Their FADT is not
hardware-reduced, so acpi_power_off() is still registered. But the
legacy sleep code is compiled out and the FADT has no sleep control
register, so acpi_enter_sleep_state() returns AE_NOT_EXIST.

On x86, arm and arm64, interrupts are disabled by then, and do_exit()
warns. syzbot hit this on a GCE VM:

  ACPI: PM: Preparing to enter system sleep state S5
  kvm: exiting hardware virtualization
  reboot: Power down
  ------------[ cut here ]------------
  irqs_disabled()
  WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930, CPU#0: init/6193
  CPU: 0 UID: 0 PID: 6193 Comm: init Tainted: G             L      syzkaller #0 PREEMPT(full)
  Call Trace:
   <TASK>
   __do_sys_reboot+0x36e/0x400 kernel/reboot.c:784
   do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

If the caller is init, do_exit() then panics. Exiting does not help
the other callers either: the devices are already shut down, and the
task still holds system_transition_mutex.

Halt instead, as the syscall already does when no power off handler is
registered, and as most other architectures do in machine_power_off().

Use machine_halt() rather than kernel_halt(). kernel_power_off() has
already run the shutdown sequence, and kernel_halt() would call the
reboot notifiers again with interrupts disabled.

Keep the fallback in the syscall. hw_failure_emergency_action_func()
relies on kernel_power_off() returning, so that it can try an
emergency restart.

Fixes: 001c28e57187 ("exit: Detect and fix irq disabled state in oops")
Reported-by: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8fdf0d8e10bdde1c2e88
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/all/20250404152006.GF3720@redhat.com/
Link: https://lore.kernel.org/all/20260713062332.21131-1-include@grrlz.net/
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
This is my second attempt at fixing this. The first one silenced the
warning in do_exit() pre LLMs:
https://lore.kernel.org/all/20250403-exit-v1-1-8e9266bfc4b7@debian.org/

Bradley Morgan tried twice, first enabling interrupts before do_exit(),
then calling make_task_dead():
https://lore.kernel.org/all/20260712125300.31501-1-include@grrlz.net/
https://lore.kernel.org/all/20260713062332.21131-1-include@grrlz.net/

Tze-nan Wu hit a related init panic during power off:
https://lore.kernel.org/all/20250410143937.1829272-1-Tze-nan.Wu@mediatek.com/

All of these still let the task exit. In those threads Oleg and
Christian said init should not exit on power off at all, so this
version halts instead.
---
 kernel/reboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 9a84401adde5a0..bc71183d4ad870 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -791,6 +791,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		kernel_power_off();
+		pr_emerg("Power off failed: System halted instead\n");
+		/* kernel_power_off() already ran the shutdown, only halt. */
+		machine_halt();
 		do_exit(0);
 		break;
 

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261110-reboot-make-task-dead-8702e9b29130

Best regards,
--  
Breno Leitao <leitao@debian.org>

