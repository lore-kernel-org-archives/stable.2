Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888790;
	b=MR8dthK0Cr761IiY3Y5fVIogB9xYN8skbqxG198UMHLCWb29QvoEjJypo1G5zs42diH1
	 0udfDo+dT45rrt8FtTDZaLra+89IU/N0qme1Y/9LMxxOf99TnwdNHnv++Jog6FFFWpxPD
	 zY7aE5h9FsINx+xnfO/l7Gqg3xB3l7KKSiD+QuWFDSny3pf0ZGrRh5Dj9TplEbjDbnpEC
	 uv+Rwd1be2PXCB2MQlDLXmgrkL3J/udan+EnEUp0Qq+9FIv7Schg+wcu/g8WCGBSfsCSH
	 KALuXJWSWCXISoBpsFPm6rN2es/u02j6ks6HUvA9+STgqBtDVHopauyIG6x0+nIKfHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
	b=nj9SMbegwHIvODtg7k1AEdOZ8EUsC3Mxz/SoU6q6cuQWaetWyYPhzW7XDEYmlrHG0JlS
	 hOYF/JU6K8wXZA4GvMRtk1J7SXaVRhNxRSkY+gb3QbQgC3D5U1WMTCdeBg/P6SpOZ2tBs
	 FGDPQR8K7MLZ2JK82suymO5REGzR5TPTqSu/+fwNRnmbpcRVpJ4QjfUfxXnrSawtjkwTR
	 MjnyvpxCLLyJPddU/PDuzYbacWPt3F/h1rzqsavo+9xZ+c0q/lB4ABacT/JRWf9zY78AX
	 XjeuKa52DqhmlwpqsetPNVpR3Jbgu/4PoTUTsJDy0uK4gtgSrIt4yPZjDH4RtbUPkaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=praFIrZX;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E8606A330
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A5E8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=praFIrZX
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4381755c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888789; x=1795493589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
        b=praFIrZXQF3gxt8vqNqYCgOugfn4c2TglDs4KZdUlt4bEZYNEMSpF0BEGCtWAR0Dzs
         0vm1GkKotKcfjiqOfKXtQHi0J2/p7LacHcRvImC3eI37vc0wrjvujxVoCoAsHcaxaD1r
         ALpEELwOfpsijfhZXW2aaA9iYS8cmcj7rSe5DjA8smFEjqVPxAXWjIQa9tkR5H0e1ZHv
         5cLgiBvXiEbfcMXaRimVrLARfr8CEpyzfhaHU28j5n+BgypjE83mohqDzoga/mEZaoYL
         S4Pmh9eWBTN6yCoh+BIkMRIu0m0uDtNBOjueJjDwaIyeOw81g+g3VEcKwcBl+qiLZRfD
         VTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888789; x=1795493589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTauZOvqzx7s2w5gv0I/DUrDh7UL+cPWSypHV4mRB4Q=;
        b=W52VXGGNkES/1yajBne9ESKYE8/YZUQdCzVnaaj3nip/63L1SXVMl1dhVIsYAtIUJz
         UI/cFqHcOuJgCBmPJiDK0EmOgzBsTHlEQnfvs8I0S622TSYE1YQMsWiA0nk4Rm/2zToz
         qFLNRf41OZ4YN2aMi1XAQXUFDOXbYPFB/7fq9XRJboZO5NTt+zWXGCjP1eKY/OKLFngf
         l+aDCkxL3MgY162gLHQRGhYjHXuYCZP7ndmJk5E14TCf/nLkemRJKSmofOdUz8icvoTJ
         QO10/SLeZ0tJHn6GWtwsTro7uSAaqlPIxvc3UYAq4w0A3psbdKWedgPNZ7xq3tcn9YD3
         thkw==
X-Forwarded-Encrypted: i=1; AL+hErEZpOTC40muzeLDkfc5q4OEkdvv5lLHrOm8FZHwk6U4ICEJ/dzzC8br9glr6Dv9HjWdkWe4+sY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/v9HYOFKiOTzbDlH7dnUrbIqe3+5Ixoa767MbhSr9ySVquLM0d
	CkPDbN2DflFkUhH3aZSQnrSeINg1G1ps2gDSA78m7nZlFWTkXjDAWgiZ
X-Gm-Gg: AYBFou1xt2eYUZadWUVAcEAu2/GceYVXAkrMOSpDWDxNqAhzcyBoYAM12P2cv1Kr1xW
	4DBUYsL01Fqc8q+lO0vl0/bd+LafabLe0rjZNiFl9GN5f1+sUoVWund9PPMYpoqWkluUtmZfV9f
	nhOgd4J78pk4vC7AtIqtAq92W1Z4nG1wsvkqdNAcfQU98DZy1a7PX+PLxAm98OuIG5V+WvcMFw1
	nIyqhBcrMZFZQ6b4BSxc4lVfIQkpFMBRxDv/PPMj79Ng0IY0HuMvRxVtZQqAZauHK+8QA4BjB2j
	rtZPiYNgamGlV4bGErjhSoOnCJ96ykgPk4KYluvsCyYP2Hrpwnf9SaIV6SB5vdZzMVnGjRF/a2U
	oMu/ojfGdX4txmjFHMNMgdx9Xa5T3lnIlQx1sWgL84aPwjRaWwlYCbhth12DJIFLAfSZlUQpuxH
	KcweLB8OHFNdN/bUI89lTBkonaWRLgO8ztqxPaF3vlwxmZRZgRhI6b6DLQYNOL48pJHJZhpW4WI
	z7kHETryi1Hr9cSBFh6wBRgNQF/qbBL4s3DgnRalm6hQFoV7tmgQzHIX52hFZfSNA0BRuT+2r+8
	d6eyDXDIDKSY9tGDU/884N+B2Vczuy5j4g==
X-Received: by 2002:a05:701b:4191:10b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b5030f8bd1mr13178220c88.19.1794888788801;
        Mon, 16 Nov 2026 20:13:08 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:07 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Tue, 17 Nov 2026 09:42:51 +0530
Message-Id: <b0bad13ee4a9222a62f1bceb50215c3719e764a7.1794887659.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794887659.git.ritesh.list@gmail.com>
References: <cover.1794887659.git.ritesh.list@gmail.com>
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

With PROVE_LOCKING, boot warns once and lockdep turns itself off:
  DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
  WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
  NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
  REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
  MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
  NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
  LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
  Call Trace:
    lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
    trace_hardirqs_on+0x98/0x11c
    irqentry_exit+0x64c/0x1064
    timer_interrupt+0x274/0x6bc
    __replay_soft_interrupts+0x158/0x380
    arch_local_irq_restore+0x1cc/0x244
    console_flush_one_record+0x438/0x654
    console_unlock+0xb8/0x1e0
    vprintk_emit+0x300/0x56c
    vprintk+0x20/0x34
    _printk+0x40/0x54
    lockdep_init+0xdc/0x104
    start_kernel+0xa24/0xc68
    start_here_common+0x1c/0x20

Since commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") a
replayed handler always returns via irqentry_exit(), which traces hardirqs
on while the replay is still inside irq_enter() (w/o fix):
  arch_local_irq_restore()
    irq_enter()                        hardirq_context = 1
    __replay_soft_interrupts()
      timer_interrupt(&regs)
        irq_enter_rcu()                hardirq_context = 2
        irq_exit_rcu()                 hardirq_context = 1
        irqentry_exit()
          trace_hardirqs_on()          hardirq_context != 0 -> WARN
      next_interrupt()
        lockdep_hardirq_exit()         too late

Leave the hardirq context before each replayed handler instead of
after it (with the fix):
  arch_local_irq_restore()
    irq_enter()                        hardirq_context = 1
    __replay_soft_interrupts()
      lockdep_hardirq_exit()           hardirq_context = 0 // fix
      timer_interrupt(&regs)
        irq_enter_rcu()                hardirq_context = 1
        irq_exit_rcu()                 hardirq_context = 0
        irqentry_exit()
          trace_hardirqs_on()          ok
      next_interrupt()
        trace_hardirqs_off()
        lockdep_hardirq_enter()        hardirq_context = 1
    irq_exit()                         hardirq_context = 0

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/irq_64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..b189e796eb34 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -75,12 +75,6 @@ static inline void next_interrupt(struct pt_regs *regs)
 		WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
 	}

-	/*
-	 * We are responding to the next interrupt, so interrupt-off
-	 * latencies should be reset here.
-	 */
-	lockdep_hardirq_exit();
-	trace_hardirqs_on();
 	trace_hardirqs_off();
 	lockdep_hardirq_enter();
 }
@@ -137,18 +131,21 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
 	    irq_happened_test_and_clear(PACA_IRQ_HMI)) {
 		regs.trap = INTERRUPT_HMI;
+		lockdep_hardirq_exit();
 		handle_hmi_exception(&regs);
 		next_interrupt(&regs);
 	}

 	if (irq_happened_test_and_clear(PACA_IRQ_DEC)) {
 		regs.trap = INTERRUPT_DECREMENTER;
+		lockdep_hardirq_exit();
 		timer_interrupt(&regs);
 		next_interrupt(&regs);
 	}

 	if (irq_happened_test_and_clear(PACA_IRQ_EE)) {
 		regs.trap = INTERRUPT_EXTERNAL;
+		lockdep_hardirq_exit();
 		do_IRQ(&regs);
 		next_interrupt(&regs);
 	}
@@ -156,6 +153,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_DOORBELL) &&
 	    irq_happened_test_and_clear(PACA_IRQ_DBELL)) {
 		regs.trap = INTERRUPT_DOORBELL;
+		lockdep_hardirq_exit();
 		doorbell_exception(&regs);
 		next_interrupt(&regs);
 	}
@@ -164,6 +162,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
 	    irq_happened_test_and_clear(PACA_IRQ_PMI)) {
 		regs.trap = INTERRUPT_PERFMON;
+		lockdep_hardirq_exit();
 		performance_monitor_exception(&regs);
 		next_interrupt(&regs);
 	}
--
2.39.5

