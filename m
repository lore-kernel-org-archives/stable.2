Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959B37CD3A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723007; cv=none; b=r3YGbJH31NQwZFd7rkLrpYkimm0EJL/9AtZ5KbT4gIx06VTIXjbQgRuJOm1NlS6kessqFAyfshFKKSO6fhmMO9gaHY9xoE6UnxZD8aVmFQCAxd7Em8E7MQDiVLmBXIc61lLwMnIXbXDjZKXi0uCVtwpgJ/+HWQ9i0HSRM2PqQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723007; c=relaxed/simple;
	bh=d5m5+qwZ1g7FSuIF5EIQ39lSOUY3CG0XddPOToipTfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3MIMvHNmPXWS6oI4jUKxdJpphNghmAPsg6EtbYtYpvpNwSbNYhnk+Ghf8/GClEeHMQ/MEB3XhdkNNl1z/kMK5KQ7cUL2TvGDOXMlGqk+E9z/rJKwDZGVf4PJOQmoGGERC7Mz7iCT6+NPwshJF82C6bRNGpxNUXH7/HzeRrSOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQAMCVcv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQAMCVcv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b27c7451so30992995e9.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783723004; x=1784327804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kkegYOMbOm6pINe4Tn2pWBNt+Yl9vdfulmpELD+V/ao=;
        b=nQAMCVcvoTONHoVHexx8OxCMPON/Lek4c84m/Y3Y0mlG3Guh6TIleRPuLUr3nmNLJB
         tc2Jdf5wIrijTYnVJhha0ajRoqrLqD2xLz0cmE8Ng7VNR8fqzf6IWJ4qdPlCiUI4MdB7
         S0Th9oIxxT5M3GJQtq4Kgf35OkU2fhDyTEq9B2AUQKwNeZ94jR0kZgp3y0+UYumPByF8
         dpmO85nStaIJtmcDuY4JyHK5Vde3JzuYmCORhKy7Rzym1Yh8MarUyVFYvgZg8hWOzpVT
         gEK7XBonY2JL7+ZPE4Xg5/sLhXnPjfk/faT5eWnlMY7ilFtUbR7rBXZIPKhN1DgY+HGd
         6ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723004; x=1784327804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkegYOMbOm6pINe4Tn2pWBNt+Yl9vdfulmpELD+V/ao=;
        b=NhV8XM9d/55LW9+iswKKlI2iff8udlAADdRyt7kj2ZhS2ZI3Uk3g2sBvCTHjjnc9DH
         OgB9uRmiASsfTq4VBzsUdpFNonvojU9Aq0LRsf9otM69NHs0DJV09bcwRtCDjMFmAXGC
         ZXYEavKB2YJ/t2AM8ReyByPZQCO20qRSSuG23z6abq1dwoAmkS5uykykzgUzca8l8nmd
         Zs3did08o0Qv6QOangbdgBpF8uQPP8t83MjD3cHivM75nQgGZJg3tD9QUFEd4jO/qEWQ
         +o4fNnoIYVzeTHhOwvbsl/7xwUZCw77ZfqTc91CrwTCxWvieUm99LvMSZy4dVwwGbV/C
         gAqg==
X-Gm-Message-State: AOJu0Yx/UtJLQQyfgm5SQi6xWucyYyrLlkYy0GdZE3UdGRSFsdM2WCis
	fxZjk5FiR2ukrjAa1Rc91LFaukthiTNc1xvIQWh68RZRmUtX8dcbrHUBCibTFw==
X-Gm-Gg: AfdE7clYA2EPNPs5OBJ2nWHwwUHNwtRd9m9rqGqw7pv0+94X+ZVLk3g/nInqHYG+ZtG
	oNQtA4wGAMwTAJHg9bQQkim94IGU715lpP3bt36CGzo6Zx4A6nsgP6S0Bkunpd1+WLOgrNPMx0g
	S/IKTn7KmxX3b5+bxeRIxu2Qw8EU4ZIIJtiWjgebapd5QqdtTP/nDWXtU2+3VjACUkWDaPI3Zaa
	sVnIWDcEw3hOYTfalRBttArc7nZVs6ScEKNMM8QuVarFou6bYjMOG5JxfNnai+OiZedfJ+LTmea
	H9coprh1nAOnVOILdxlpF/a+225fPEjRBopdqyfcvgTBe6qADPdBCDaKje2FcghmmOf+dFnVvKD
	htqJmQKD9dY2Y+9ZLpUd1ENOXlDSG3N6YCOhgPTjglG9m1+CiPMrPK/vM2mVfvF/bebIxvDxB47
	zCLoBhi7CD07wNj8IVNhjrSc8GWw==
X-Received: by 2002:a05:600d:6401:10b0:493:b698:9247 with SMTP id 5b1f17b1804b1-493f88c71fcmr3346825e9.14.1783723004325;
        Fri, 10 Jul 2026 15:36:44 -0700 (PDT)
Received: from builder ([2001:9e8:f113:9116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm110612765e9.10.2026.07.10.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:36:43 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: stable@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH 6.6.y] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Fri, 10 Jul 2026 22:36:27 +0000
Message-ID: <20260710223627.5860-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7 upstream.

smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
marks the CPU offline for the scheduler via set_cpu_online(false) but
never informs RCU, so RCU keeps expecting a quiescent state from CPUs
that are now spinning forever with interrupts disabled.

As long as nothing waits for an RCU grace period after smp_send_stop()
this is harmless, which is why it went unnoticed. Since commit
91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
however, irq_work_sync() calls synchronize_rcu() on architectures without
an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt() returns
false. That is the asm-generic default used by MIPS. Any irq_work_sync()
issued in the reboot/shutdown path after smp_send_stop() then blocks on
a grace period that can never complete, hanging the reboot:

  WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
  ...
  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
  rcu: Offline CPU 1 blocking current GP.
  rcu: Offline CPU 2 blocking current GP.
  rcu: Offline CPU 3 blocking current GP.

This issue was noticed on several Realtek MIPS switch SoCs (MIPS
interAptiv) and came up during kernel bump downstream in OpenWrt from
6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
branch. The patch also has been backported all the way back to 6.1.

Call rcu_report_dead() once interrupts are disabled, mirroring the
generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
and grace periods can still complete. MIPS shuts down all CPUs here
without going through the CPU-hotplug mechanism, so this report is not
otherwise issued. Reporting a dying CPU to RCU outside the regular hotplug
offline path is not unprecedented: arm64 does the same in cpu_die_early().
There it is an exception for a CPU that was coming online and is aborting
bringup, rather than the default shutdown action as on MIPS.

Note: this differs from the upstream commit in that it calls
rcu_report_dead(smp_processor_id()) instead of rcutree_report_cpu_dead().
The latter, along with the rcutree_report_cpu_dead() name, was introduced
by commit 448e9f34d91d ("rcu: Standardize explicit CPU-hotplug calls")
in v6.7; on this kernel the equivalent function is still named
rcu_report_dead() and takes an explicit CPU argument.

Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 arch/mips/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 81f6c4f8fbc1..1a3eb4820eb7 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/sched/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
+#include <linux/rcupdate.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
 #include <linux/irqdomain.h>
@@ -410,6 +411,7 @@ static void stop_this_cpu(void *dummy)
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
+	rcu_report_dead(smp_processor_id());
 	while (1);
 }
 

base-commit: da47cbc254661aa66d61ef061485a7080305c4be
-- 
2.53.0

