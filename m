Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925545;
	b=lVMXVjq7cHl7WB4vwnXnjxdoxDzrToZaGna5HY2XrVCe+Qhc3Ar7FOaxNW3nPWaO7WWZ
	 wFyNxofrQFlMyPWFngiqEs+3rVDtJJKNGu8RwFSf3lLA5njLIIu1vUK8/fHtRZBYrgfBC
	 b/eKQyn0eDje7eHCzhHcK/BCkmgWpcKke8MgTw8CZge1KpynIUkjiapnvgKNu47cvUOqy
	 d0cEXN7zCNJk9+SuckxuD/hJ+YPrV5TbY6Z4JDT0tQEGOp3sk9hl/nPx0+acbTDWM+thR
	 9uDz9cVs0OHFqBc7qqZefHDlcZrl4sUXOuv3cObySy2GxWaWLd+k8GG4ZPwKcjzXnnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
	b=fTUA0Z1eeZaWQOrJmQQEqGofpDLPe8XmyaudXA6le7kkG2ckh1c3AaHnRiWgGdvbW4S8
	 5nnLNZ1jbiPKzf3b58HcSF+aVlyqUPReiiKeDWVtF+4R0ee0QhP/rw1H5XY50As7Hbgf5
	 P1FPwaC9oeZMYc1aMYhvMWj866nS6gWKQsvDu0yyQNO76Kijvn/wOT0Pa8uCXzwN8c0jk
	 LAYatStEAGfCO2i3uA6kBjP84slgb2vj4BnjjEa3tURPm5CECWI3kUMo4TtPYXgR0vXkU
	 3V6UZ6sMms7+IqwoNEDZYgjct3Mj5IA11Zhg7kWSwsGwlabhhUUWOb4Vr+y/eYguhpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ziNmk/7F";
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618A606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1618A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ziNmk/7F
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55cc06so3544749a34.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925544; x=1795530344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
        b=ziNmk/7Fj2K6npKDMXlNpJG+DPNkQjx67XtPs78oEXYXe16FTVbzkBLQsy84mPglw+
         svB6LHK/4Hm2ckc2UZToUDqD4991PFt2GtwxqWdTlx9fUOwEi0McMdb58eVFdtkMbB2b
         DIycqQT7h+0bwqJOU1yzcxWEo3LVwSkpFyYyw9jLlBcqdERaTBWCF/bsh6znlLgHOwoc
         6ri63cdtYj9Ky23WH3ITsOTaJQLlS+wQ5b/DHuYzXM471xdR2h7u2i2vCP/Txc7ZC6SC
         RICXR/Sv4/HYqHYy7KUX3ZRpequdRG32zUW/n/LQeo13ZDeXfyqaCngEqBqkKoXmFy0u
         Fiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925544; x=1795530344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjmPFH4B/D4fb22VPFX9Sq3mznItdFyAVWsb2qu0yoE=;
        b=LHVTgPtm0I04Z6BvTMfdXILPEpYePQTvipqZkkTJ/rb7DN9vvDFTMkoE5t21Dw8zRj
         ss5XWlIYk4bgL60679JCwk0ZDCQHItqtSH/9oRGILke1RGFDqW4q5S7XGmQ2CIkBKuo5
         51LuCi+c2S/mgAvUANSvCDlwJ28EiFg7nSi88szvMs2eMKD6cxMe3WtlaU7FA6WS/gq8
         tDSrjXwIuXTEfwZuNn5v2xpELW7ypOZRgvpbGI+PwUid5Khok8FW4HAlq/TGdcvCqbv7
         9nqItsLUAtHWJdMcoa7oJ0PoIvAW7YbImsUM0lq0MWj3XVgV9mH9Zshn7b+cvm/YoaA0
         C04g==
X-Forwarded-Encrypted: i=1; AL+hErHh1vSXMEJrXOzPtfCbHlz/aLJPDkI2b7e7M8rksZEbZJORTnnJ8lr0p/FgRGcHSpbh6B+bFfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z++I2kJkbIYODfINFUjk3ZiLLN0/+draLHFMcneRZhQIHCJ+SWa
	xtExX/MCHlQ9O6Y3wiFTU0TTbPX7+IWCrOCawcqK+EdOusVLPBLfRX6q
X-Gm-Gg: AYBFou14nDeiQN+LGmurXsVkjZw6Ch8g/dJvVv3HRfHmQxjjMKXDW/utSOh/Gojs5P+
	xIfOPdhHI5GvIANNodxlD0+qRCBFsqfSCs71wQwZeBfizE6YwjeCRjPROBxD5Kn+sphCai0+YbO
	vvziFoe22BXGsAIX0IsW9jgdDZ83/fIxE5A5TIDakOiXwMflqqsfzo6F0Y2FeDwgvfzuYSLO6bk
	xomEF0HwbUFAd5fnB7STWee8aUoNOyjCGEAYfQjF0nO/GJEeD4H2IFpXoJucL5nyuwePCHHTGH2
	YDuXVyGMxX2RSphEPIWEHGBxVKVBbJxoi6vZhOq3TNGy7leB3RKZhhIZtZRb6d0WMeTwj7vQQdc
	nK5/juHiDsRrrjN1tkueZf2I7keirSyZo9O5tlXcHwIkjl5Md++R3hwtsGK+9bP6tWw8oMVEsjq
	w5st5FMV9rk2NlEMD8wvkDboLQnmt/XByenQc9bd2VjVYOOXWx5bW2UN1WG8o6ES6obp/VosLtz
	y3xPNqCyZIKuX01SgaOXhUn5xGt77iRw9AeN2DhyTzNYPoSsrH/DsAZjCxaJwb8PDOvB8m0TzcJ
	arIqGr6FsyvBBnEInERCHHzx1STNncxfUJ0=
X-Received: by 2002:a05:6820:3388:20b0:71a:eea9:81b7 with SMTP id 006d021491bc7-71aeea987dfmr3362475eaf.54.1794925543956;
        Tue, 17 Nov 2026 06:25:43 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:42 -0800 (PST)
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
Subject: [PATCHv2 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
Date: Tue, 17 Nov 2026 19:55:18 +0530
Message-Id: <3cb2893bf883be87ea1c3712344ac03f727937d0.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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
index 44f178e07531..32d4e716cb0a 100644
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
+	cpu = raw_smp_processor_id();
+
 	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
 		return;

--
2.39.5

