Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888799;
	b=rJ0fJd7EfmCN+RGakyT+5GA7I1L7TxM8i1S9A+r3chgVzwgeGJi5+vrirDaVHeTewqEg
	 O4TidBk7v5TOREWccITaNiTlg1RziqqmFzojeQU9T+P6kJDd0+ZLjRUfDFt5w11Ml6WcK
	 ist1bjuicPjhANyUPo9RqB+vlqEpqtMIhQuxUgtitteXADsb10kzt9iELkZmrPoCUyYnk
	 nNszArgX+jcYHdRZfLAeNA43v0T/RmuPODZIimPZKWu06OzCktIgzghDlcDPHdyhv/At1
	 wDEj+Y0hU2IPryJ0KRElhZLQrS6Ya0jytyyFSdOht4qmFctQKZ6BvjPYwDtLynup9BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
	b=VDh9dwK+TriVyJIQ2ZbfLvzFZN3xeiEvWRCmCduJFUdwtQ+xV9MLtS9Y2u6iBns/GT3N
	 /+Z+wYhtbWolctLSFyNzSUrvfZD4V2SMNdSkazATIu6/0NK2ofuZY/bDM8CIVTSKlara9
	 wsit3heC6uA3km85NaM+U9tNr8P8bNR5btVFrK4HQkPekQaJsWjspAs/JM17LeD4VWXV1
	 dSkr5EqX/WdXGiE3537zipJSHaMxzrMGcCOF9e6ZP2pg1jdU11eCPJfDQ/owc+UMjHPMw
	 /X2hDvzmhwdO6IZsdMwpZnGFbSsoZ3mjQyCQZqSrCvLfxslDTdsJVgqSDHaWQkMMOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyJfoHnU;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E4606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iyJfoHnU
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3ada81853so3884585c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794888799; x=1795493599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
        b=iyJfoHnUTBykVGNRk/qWghsqblBAOEcjQgETQqN6NXMfhMNtYHZDaTlfcAnGCioN9v
         3HZBUEIZRfGpt3Iuu/d0m9NJmxBgbtWJuDRJ/TSLORhOdxrw9q6Cgp1tlM9Z5SKAyAGD
         VZIxrCVgTH2XbQSfV3oFuvNicN0Tg5qU4GBBrYU7lFS6tUja2Sr5mRlEhpCWvpLjTgyu
         xfvQ8jAXcYOzDSZw3AOZdMWRzMvBcTgCEUBlEOR8si1ex7ik1vDivlVcqbTS2HI02THf
         bKS4X6by9bvwhE9pXV5Cxbf/a6NBmlHCO1TUtDnDobV2u0BypC2pqHAv9JcOa4NUghVd
         93iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794888799; x=1795493599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlsaCHEk58qGFGAb0OAbGJOtQIRxROfDzkwINL2H/Is=;
        b=cqHcGNId8+u+ZNlgD5dkk1y7yaGfN+UUJiogRpzMtsqs3ylLw/BVnyIq1dVB3Etrny
         RmX0C8T6LePiYBPzwBzOs4HDRbfkgmTRs1XqViFM6RZymSWCGWcylL5TTGKNjYks7btc
         7Xxvb+hxRghvliZJ8bwQ2BcMI/2TzyXXLqO3PU6qH+xUNbVcrV5C2+KSpS2O4E0GF7Kf
         PadPcT69Q5MHGAlQi8qj0rNXyjf6NQYFBjsti86t6qCGN1QegZGB1OLGY07mCRyJqUHj
         JBLX7bh+OAMkxIGNGhmVmerZ9ftxQqpb+kTAOpNnmhYQvmuWeGDhwINP+pDX9F5n0OPo
         73Dg==
X-Forwarded-Encrypted: i=1; AL+hErFsp2D3soa1+9F+kEmv3uthq2n6BX10OKJ6uZim6Fbj6IEvkaKwEX6POQ4KfoV/675oNBO8BaM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MY/AyJWCepsrOUEiFakJt6tM49+hrUkMQK8gKkaw6vkq6W2yw
	hDlvwFo4WOpX7fa1hcV1bHqWsXjmb+Pgh9fMaJMgn89mn75EkK91GLfB
X-Gm-Gg: AYBFou1uE1rwKbInHQg9JQltmL+Tu1fjs21nO6bKXY3a11fdImnldZ4P5ILS20FRTQc
	d4gqyrz18N4EBXy9UIdliI1VVHaZaGbeu4qKknZic/APy2TYi06hldit+uuL6pKAVMyyi6Ao9GM
	CWBP49joJ96y72qUyx1wgOFqzCxLyH7s+Ud2z8iouXxCjjMT4OW0duc5A9ZOyHjpJYxpdpFQLIs
	TgpOvf4Wx/dQda0e7/Grv3dUxj6h+MikOzRa2udBpHKvl5dxjnBI0W1CWI+elqICLwhc/yuTyqo
	sunKWaSjqs9u9X3DFH8WoOROfD9SdX4WjUfv8xRT/8A/f8Q6MCHTm/SGY6iF0IDACToUeqBeCjP
	tXWycep1c3lrzlVMKt5XtpMJztm3VGNiQMvhbM17Ej42Sb93KEel8zktZdChMyhIPYY5Rvcq3dE
	bMGouA8h8lNPY/IT6AyhEhx56rQazmxkLmOGldq4xKAk29MuFJL1ZsHptKzOhMoBdoaDfb1YcB1
	hNDknMQvKdUsufJZIU3IgPdOiSJQ4vViWSUCSnlJj0rZDD5Fa5V1LyJVcpBwk32S9l0YW4HTzuf
	P9AU8zopQS310o2nwdb7M1/OGoYuiT9iiQ==
X-Received: by 2002:a05:701a:cccc:10b0:1b5:3616:599d with SMTP id a92af1059eb24-1b536165bffmr2485931c88.35.1794888798411;
        Mon, 16 Nov 2026 20:13:18 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm40433851c88.14.2026.11.16.20.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:13:17 -0800 (PST)
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
Subject: [PATCH 3/3] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Tue, 17 Nov 2026 09:42:53 +0530
Message-Id: <a2ce5073c33127d04aed012e586b2ba708d7ff26.1794887659.git.ritesh.list@gmail.com>
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

touch_nmi_watchdog() can be called from preemptible context, e.g.
sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
smp_processor_id(), so with DEBUG_PREEMPT we get:

  root@buildroot:/# echo w > /proc/sysrq-trigger
  sysrq: Show Blocked State
  BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
  caller is arch_touch_nmi_watchdog+0x3c/0xd4
  CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
  Call Trace:
   dump_stack_lvl+0x138/0x150 (unreliable)
   check_preemption_disabled+0x120/0x158
   arch_touch_nmi_watchdog+0x3c/0xd4
   show_state_filter+0xf0/0x338
   sysrq_handle_showstate_blocked+0x24/0x38
   __handle_sysrq+0x134/0x3a8
   write_sysrq_trigger+0x178/0x22c
   proc_reg_write+0xf4/0x150
   vfs_write+0xfc/0x71c
   ksys_write+0x8c/0x150
   system_call_exception+0x310/0x590
   system_call_vectored_common+0x15c/0x2ec
  ---- interrupt: 3000 at 0x7ffd01755b98

Unlike the generic version, which only sets a flag, we update the CPU's
timebase stamp and its SMP watchdog pending bit, so a migration in
between touches the state of a CPU we are no longer on.

Disable preemption across the update. While at it, let's also mark the
function as notrace (since we might be within a tracer when this
function gets called).

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 44f178e07531..61b67dde04f2 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }

-void arch_touch_nmi_watchdog(void)
+notrace void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu;
 	u64 tb;

+	/* Callers may be preemptible. Stay on this CPU for the update. */
+	guard(preempt_notrace)();
+	cpu = smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;

--
2.39.5

