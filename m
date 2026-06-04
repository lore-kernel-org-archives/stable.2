Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C23803F8
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597470; cv=none; b=KaKxqyw0R5QYfwzHN+5oYfsSwiWlofGDdpF7S4bLsEzyknkIGw3vYk8W1BeVTs3/CS4mE4rkJZV0Ajqk28goTIZrm3Q/AZ3LVfOTQ/+2xtKe41WZLrvsxsoFJ8IA5MZT+s2GrQawTWvH5OYdxAvdxsVCcZt4x/smBGxBUP1qFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597470; c=relaxed/simple;
	bh=90O4xwaiOrLK9AQmOIsYex+cu6SToyEyb6ORubBfVgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cowy8+47PgzMOGm5cVjZ7E3CT0a/S3c+GLeVGooQQiFWEXnJ0vTaCXZx0PiRslmbpNhlQKP1+n6Oa0SOgMg/Ok6veewn+QIGi7gypC4Hc/SC7vZIgEmbzNMElMe105Vj/h60Jvu+2rajF2+c6NVspVTuNey1cmedtF1h+Is/KMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOew3Jia; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOew3Jia"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso8707525e9.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780597468; x=1781202268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KY7xVSejKqSeN27Js6FROD/NEXBGbGSvmQ/6Y7FcvD0=;
        b=cOew3Jiali9TKED0UdpwQVTABHiMihZLrieGauZRMSt5KnnHLAVAavl3+jXduKUhdp
         pK58SbF1YvVy2fNa1DNUOQ/Or5ANVKSF1QgME8tBf9e8EXQ+xBfqSdpcCQLrNp4RRQLf
         NlH12Pn1WX9Z84OhAsL0CTViSoZLubxvm++rJc42z91UGz7/TqpTQW/Q0Rj08k8p2VrB
         tX73NaPAFAB68yW5mj98PuysdyYkg0Lepj1A6oF4IXANGnDrUM0VHrCevA29CVFqN5Ut
         ES2YJMvJnbtnYF7iMuKkdCF7Fb1gqcpbyjWy6yD5sfLfkJIYi07JMHQ5Rq1bf/UCDuTW
         q7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597468; x=1781202268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY7xVSejKqSeN27Js6FROD/NEXBGbGSvmQ/6Y7FcvD0=;
        b=I6Rgn817NVqrYHYyglGrUmzUNVsM4JK6mo2HMHH8rWZhP3PHxW8V0xIg8lQ4w99Af9
         39bbYePocfMpYxXK5ywOJvayVKudLDsCKKqN84LDE8fbr9Tm1NEiEmeBPyLDui6qe5Hi
         OJhGNhbXiPV40kv1ImLByw3iVTxfniyyzO94OMgoQIex9gBOdqpX69IcHzhwV4xJC2FM
         ZocBxt9o2e/4NfH2c6Pm/FfKPx6LUalMtpTR4rp1PrBSBLF0DRztzEBbngA6DNuieRsi
         bCp5OIcystFx+cJyoyCm37uunvh4ZfnIkAocrKS5/OyyohV0IIm1zsk5fHzTw4h/t1Rn
         x3Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8oI89b10+Mg1jwKut1m5coqp0J+ces3bkYPKMb0eit115SlVx3lu1Aq5+ZvNw5SCAHf4SK7MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOvtU3m7UW7KzVVfdyyD25hd5ieOPd4j3qM73UsI+GBv4fvvS
	/vZMsuZaO+eY4oanLFh/88wY7VXBM8tTrMV5Zz6IWK1Pa5MtjPZQbtdi
X-Gm-Gg: Acq92OE5i+c0VIupbCOcaDZtsgCo6NhHpIQSudny8FCGHHUQxbVEE7UNDhZvQNS6n0Q
	TriYTzByGTwPSuNq5tSfIZn5zZR+VZietvWVprV+/HMRi4KxTm0ykwLMdZP7EeXsEhxkqz7G0ov
	u0kd5EAsrkEzq9HMPpbd65Ozn7jaQ3r/xbExuRWkpeQXA9zvBAF96cGRCy4wWJwhiqTaPd36/nL
	jyMBj70TjqvgihAc169lLqbMbe7Riaro0Jq/UnGNWaB2s1CtkiQ/6lD/ZIQ4NWWiwEDDvHJStnI
	WirLiGzRcNZVGg5A2IHyuO3mAUV5volUQIchLs1x4JAdHwNE99cStieaGvSy6TPnaLnNdReLo91
	5vcH5olyqng7bMklmcZjVP0dDB8nj8LMrMpbtCQkV6YC3sgkLVmSJYXio3z405q5XzYFDyeteQf
	cqKiJ6ExVpjxM1rn6+Wz80EcZnFcInlOxEMWKak1Ev4RvfwVc=
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr143876325e9.3.1780597467554;
        Thu, 04 Jun 2026 11:24:27 -0700 (PDT)
Received: from builder ([2001:9e8:f12d:8916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm100702395e9.10.2026.06.04.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:24:27 -0700 (PDT)
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
Subject: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Thu,  4 Jun 2026 18:24:07 +0000
Message-ID: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
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

This issue popped up during kernel bump downstream in OpenWrt from
6.18.33 to 6.18.34, since the suspected change has been backported to
6.18 stable branch [1].

Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
waiting on the parked CPUs and grace periods can still complete.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=18c0456ea2615b1a743a6db739c74411c3b42bc6

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

