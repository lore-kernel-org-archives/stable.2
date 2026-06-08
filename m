Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF593B38AF
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911469; cv=none; b=jkz057Ahhr5Pwk1PPlKBg4zB9AN+PjIVGelW7oupOdWPOpMSHSuagvn9a8k26vPCNXHDdbpn4Z0x1tSGxU/++sBWKPbZqW8glZggL1dupX8M18q7+8jfbnhDN60bexUMepr3Hc02qXbJUWacqTdXdRC/Sl4lo/whOO0gMsLPQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911469; c=relaxed/simple;
	bh=Q5pjoXPRXrR4YAOjANnD4MJe+Rq6borHbdwBTCRM/XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rya/XCvuXKxpF91Ce/ycoDQjZThIMB1mBRSmFriYHKX8Ot+zklnKdUUI+d90BlvuCNWrqjfHO0exsBm73D8KWN4vUCo7mPld66MlF4SvakLhifhcUz0kfVik7oIOhsFnMsZ5XeAv/yex0djTsuZLzQcVaQWStgkjNwPcB2oUWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtABq5Q7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtABq5Q7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac10e337so37497695e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780911466; x=1781516266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbY26Xurtu23jBtBt7MOtdovk/2bF+TdV8T/2baMK9w=;
        b=QtABq5Q7NycJrVYJfKEFN+O42Q6Cj57GwnNLx5vxbcF7kTcjv9PVbFd2QiYicxzrgX
         64tcVriZTTsFM4ynSpX4KsqM+Ou0Em/uMe/pBqaAjEDGiUCkUHasMbqnUaMORNmm0UM6
         34sq6tPyZvteft4csPQCe6UCvvLl6eH9kuKRwpF38CwRydqpzbMYdFAzH1yYEECeM2vj
         3USAwGF+4/Gye/FmgqcWqkKYxsmQg+ONUiVFfKf1Ch6jLHLPqb86/VMTWoYWt0+z/3Im
         /iG7KoE7LEnux9E564af/CKUDB5T2EmBU6K5T6c0kwOAGqjsuI+ENxiIRW2EQ8yZP7H9
         piVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911466; x=1781516266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbY26Xurtu23jBtBt7MOtdovk/2bF+TdV8T/2baMK9w=;
        b=sO4DBdAUAAsxZRB3XYSgJTeC3B5GYKjXoralm2xaYrdxE3BrC3Dls+Rdl5x/o+W8g2
         lEOcsVInqt53mKUr1Nq9YgO19ER9JnPQBtD85rr1EvSiZllE2TYHTMEaxX50jFxIlV4z
         zbpgbiYZZhJiZ8suypiN+1/mEW+Lej7XIkChPHkEp6Cil4jhP3SX41um/oUfWLv1fO4S
         J4zdUBNAMyekTWpZjkqnnmeuhcltmuuqx8IZIOsdljf88ia7oLu7Q8WByYXbr/z/T7Eq
         wp28BqIdEOkqOl1jNtg6bM8oUOiNaj3iPS+DPJdKKAuB2s+8YXNcyFCVGJMTaG+p9Gce
         V/4A==
X-Forwarded-Encrypted: i=1; AFNElJ+uiIu3sX28qP9WtogMoxB9YaWMirZl8PsFcOzjxkRQHFlepfWXMBxZfKokYSNsZmzPP20luhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSz8ezTp3/VOWFGRH4uZ4yopkN+N564J1b5Y7Vw2JxARie6bR
	7TTq2ZRGW9xa0b2hKvL/4B+fEsubx3TdRH6fo/YnyDGiSTCFHRGj5/vD
X-Gm-Gg: Acq92OH/Ms3ojVkS5IhG72M5ybQozkW5uQW7K/2gEvDNWLwpNO2ea7eK07pTWfmCnrS
	GTIljn2edRUeUyL0h6JtWjpjqQpxa4HwkBAHBzEDWysFzFcrhSWv7zzLNfl5fYv978Gch0S6S66
	2o+9kLO0rtVEb9WD+e9tp3HgaCXSVxyNA9OX/45Ay6UY1xaIkggz3rSs2klU33Q6QVr8DgiXdko
	ObEqRd0whSiukgdQwH5kq14HUzdTDK3cmNgKAA8wAQloyljJFN36SZkgjDX8Dj5OER8wiaNGbYd
	6sgaYoERBiiou3OB6qaS3luAvBgGa0WF56M0mtPVLSGug3EXCFtqkafaKJXEDw2/EI8Zt5VKFnU
	IfTyje+8gYP90QpAGrvY3yNKcG2+tH5ni0vVNYOFvztEKmtsinDqAjp+0QwL58cLwlor1OSaeGg
	2zMwZxvU1ltjEMdU+lqHm8kyMIJMJvq28ge8xa
X-Received: by 2002:a05:600c:3f1b:b0:490:c0d8:d517 with SMTP id 5b1f17b1804b1-490c2598543mr239183895e9.3.1780911466302;
        Mon, 08 Jun 2026 02:37:46 -0700 (PDT)
Received: from builder ([2001:9e8:f105:6a16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm55829791f8f.5.2026.06.08.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:37:45 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Mon,  8 Jun 2026 09:37:29 +0000
Message-ID: <20260608093729.12111-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
and grace periods can still complete. MIPS shuts down all CPUs here
without going through the CPU-hotplug mechanism, so this report is not
otherwise issued. Reporting a dying CPU to RCU outside the regular hotplug
offline path is not unprecedented: arm64 does the same in cpu_die_early().
There it is an exception for a CPU that was coming online and is aborting
bringup, rather than the default shutdown action as on MIPS.

Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
CC: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 4868e79f3b30..0f28b4a62e72 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/sched/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
+#include <linux/rcupdate.h>
 #include <linux/err.h>
 #include <linux/ftrace.h>
 #include <linux/irqdomain.h>
@@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
+	rcutree_report_cpu_dead();
 	while (1);
 }
 
-- 
2.51.0

