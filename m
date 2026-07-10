Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A82409115
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723920; cv=none; b=kC0/sdlYH+/AhtfJdq15k/orLXewJDiTlBwEan2zo2ahaIUBaxsSloLLH+A3bcvmMm+JJ0g/ZPywOHQiqgm8dSGDAUmz9evr0IYtKDiGohnclzpxMgvo3oRyxfO7fFjGmvZPodxQMU5a16dV2fSx1rIJfG/8DXTYTZRLn0heu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723920; c=relaxed/simple;
	bh=msfYOx+Zqjv92lm+ZFQuv8Qn/QSRo9O+2R4oJIc9aJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cxj0kTqcNfGj3X3XOxbDp9BN95xlYwmWpDmyAv0O0o94EkTkVx3ATHGOcd0/2ReEfbHfZwPgbcaM4jxRBG8eDFj4CXlbXdbTlHag7okJnXFsXLnPX60IxuLL4LK8wdaVEfpLyieDgWvgEd6oBxDs2XQao3mUmGg1XHUZV7OUfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcMiigQW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcMiigQW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c733f15aso13445565e9.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783723915; x=1784328715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIt4xJM7May3OoqONNDUUrvaC6hGrOtKAK/QmIsJm8E=;
        b=AcMiigQW4qWmYbvKwNDxoEQKmT+C7u2BCFkYeZ2QwvVAlP9aG/qQbpYHdCg+6HiGLu
         sE5J4wdIbzk8LCPok/7w+EMya8r2MlX31isXcplZnqpUTdGFC//tU/F3VVwWRjObU9aH
         rEfObKwCFN62u4qBR/Cmj5Ddu3k11Z8n6TdpEXbwvwDWGBOpk5ykNC+q/f29ISTT/lbc
         JU/3EnwuTv4hW/F1+UxveKsZoG8HaI1Y1rS7YbfitppA8/3uErXrG9y0JH0IFmSUSp2A
         /qygPUn9sVPFMqhpa+jk2NdjSAr3sDFlgptkbkuyB9OTg45kFl0q7R7Dd5PHmdoOsEVz
         +zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723915; x=1784328715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIt4xJM7May3OoqONNDUUrvaC6hGrOtKAK/QmIsJm8E=;
        b=OpK4Y0HKhLJHJOyvclrr7HJyK+g2UNhIyZAwLXBOR++Zl3sSUBSZY6ZOBtcJstuEdO
         HFRQrBLaqXCl2jo4obMHRJ1QIB7qDqXBxIvP7mI6prnO/r6U9PJM13b4LaP0upgOZOgJ
         5j1J86wFC+4Y7Zu+rziVUTpSRLC7QnKKK+PgdJyeb9dVd29cGiFFHPZysQaSyE1UgiT+
         grMqxa07PO6JM17Y01NbvU62St0sLLDMG6pArUDmhsvJREl30mv1dEhlAmXg4bPtBEI3
         yV9NnXdn8vSSDmU1a7Y0pSj65Cl2FNQ4V1RMaj4grPruyTHFH8wHr2/lKoppje6PgdBp
         mtLw==
X-Gm-Message-State: AOJu0Yxg2Fv+Df4COwerkcJTllC2NDfD3/qHqW4zDRvW37ARlr34SiqG
	jjBIcY94mFZhURpO9XIgiNJGBtojiB41wF0bbhNIN99PgLoT0oG7T89zxHOiRw==
X-Gm-Gg: AfdE7cnoeQ+6s/cddtx0183OCKTCCR5EY1o0D9VxOerRjeBrsgOfLtE+muZ7Jr1F6Jx
	QoYfVd3+UPEQqwSP0tPTCMR2BHLn76Hc6Bdibqjq04SmhSKU1FiVODD2lKJAy5SPEneACgy8mbz
	iLWS0STCXG2DaUIioqNZGSOidQoRfrpQ0hZdqkE3aHDVqdm0FiLVwn697671/hzmWXb068n3J/6
	4vgDhI0uvyXiX9+p4OlfQh3lmLO3vB4bfLoY1d2keoemD7Utm8wEQP/yPrvVg0OV49CdcvLtDH6
	le6RAjITURK49wLgMWcOpK1TlPxL3VzVzQ1P+kkrgPA2uwtetsbZy10sztvtO34JU/e9A7zU2xi
	r/Qp0FgbslHdbtRgBWJptuZIvfKTLWcM6ic1t8x0towVuvpdzplKwEsKmFii62/q2Jj8Mde8zTJ
	TX1RHgh7a7oEw9LvQ=
X-Received: by 2002:a05:600c:4f8a:b0:493:9cb3:53fc with SMTP id 5b1f17b1804b1-493f87e72cdmr5820095e9.11.1783723914816;
        Fri, 10 Jul 2026 15:51:54 -0700 (PDT)
Received: from builder ([2001:9e8:f113:9116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2a38b19sm68297225e9.0.2026.07.10.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:54 -0700 (PDT)
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
Subject: [PATCH 6.1.y] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Fri, 10 Jul 2026 22:51:47 +0000
Message-ID: <20260710225147.24574-1-jelonek.jonas@gmail.com>
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
index 002c91fcb842..06030533bcfa 100644
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
@@ -392,6 +393,7 @@ static void stop_this_cpu(void *dummy)
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
+	rcu_report_dead(smp_processor_id());
 	while (1);
 }
 

base-commit: 090666d3cc906176fc47363520eb746b94c7d578
-- 
2.53.0

