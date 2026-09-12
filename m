Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FC3911A2
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242975; cv=none; b=eQ67c0+nnoHvpVoGVZ9ABEYDOVpic1Hevrwp6UVf4d28GcWoMSkMYvBPgzUQUyH6kxMbYUpoE+ktQYwYZduQayPJi+DcPYHkrNf8HessNdO1TN8hR40rX4N0B3JwKFTkBjTMjWOW+32s2xELIL64L3DisjG3CHL6P8YFq5/voQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242975; c=relaxed/simple;
	bh=rN3M/EIKOAXQYOqvo5H5srYi0ltpPT+F1jN5KbTizKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoBkbO5ROFS0EoN4wN3ycMyMpNu+Xykmi608onOmJtkpg+N3vHDdMIWhbBLq0iNnnZ3pSS7AZMpRLGmNCdp7/fr5oVmrbig5U5QcY1a5d20KV1EFAS/ojjGIuRDsyWlQsPSSjs5Xzzp2seQHu8oBLdtaVvdymgwXWaK7jLij6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4uTv9Sp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4uTv9Sp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49e6b280cadso12138305e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242964; x=1789847764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SudqM4dinshG/ga4dKzazwfwaSNRtgAeUisYk5patHw=;
        b=d4uTv9Sp2tahE1qfecaY3kM4f9nFZ4PrLqJzaE8mcfB+JzeiSTzvdAQLCN13FlMveZ
         6v9RAP6etEWzjbawTU8m9/B6K62h16+UMAX0yru1ElZtQGfkJLOhgV5RgpNWxi3HilZD
         dq/tcZGRrcMT0SMw2piauini08RSexDolEP6JEWztAZw7adsYhjQ+plohSl1uminPd5H
         FKwAHljBEz65apY5n+Oaj8iFmDxosrYjeRUYbg1wgu3LvGUTcqBT9Pf8RrLMXKZb53y2
         HvnO+wadvhdXMruHEWrrVuxPVvGrEHv4OZeQ9ncfpzyjtJOzl7Wb1jdah8eJ2AtVZMHw
         JovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242964; x=1789847764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SudqM4dinshG/ga4dKzazwfwaSNRtgAeUisYk5patHw=;
        b=tI6edQiz9gOvUkUALnsMDAOOBjchAH0XYQRcs7cev8P+tExBbqwOP/WKdXeioVDIpM
         c+62XTi3mnCrXbyPblAhGnuSMWDLDtpI8oMJurnkuOUgzuVej8dfX1wTA1igr2ByAGI5
         D56X5xtFyiewoPC3MjaBleZh4zXQTBW3F2HWd32GA3NqxenwjpoT0+6UPTSAPh1aLLYU
         cv5p+Ul9XQAMiV32aPROpI4eM75svzoghotNP6tVV1BkCNjaRG1cJl1l3mRuuTDxMD9Y
         1lhY9y8IxSUhEdZp1IEYyNX3uKyExaPqr2zv4X3nQRWLVmBump5q+X+mN2XjSR8mNRuZ
         Xsjw==
X-Forwarded-Encrypted: i=1; AKwUvBzOZar/5f3xW12Wd3atdM0LgiIxNsewIgFF84EXQCK2P8K8icYJb7sU2ZGTV5EFx1U9haZ2kcs=@vger.kernel.org
X-Gm-Message-State: AFuF++lGbuu8ZQ7Lm3JvkigpCIaGXioR1a32IVKwzUZmAurKJYUQaiMB
	cyv10zY4nLHnf2ELtI2aYKq1g65fSfNEcdSWtBj45AwDvl8TXl4lkXxz
X-Gm-Gg: AYBFou0kuAEOQfYiWrpJ9dboZGrqIIldlfTGKukgQlbEoXsWGNqMF8exFeM9d89dRkl
	67iI2gDqUwejH6zkhyk0I3LK4ZuyaGxaGfyjp/p+hfLBSsvUF2T+YK82BX7t0RmzuSfnAclYn0D
	yejikjlgoQRNDPzZbzsMNyA4dCkKdeNNpKiIgrC/tOdSk4nATC4zpbYkMj1WFWg8dOi0TAEIVJt
	0OXLwmEss/BjEoeK5fRlilN78wQoT+mutOaTOYjX7PbS6vCWTg+/s1Rb6prWgbLG0Kx0pgM1HWG
	iQ60cBdIku6iEEtRidjB5tBzL6YNNUlGyLHYjZJbTTJeJFmoZeyrenM4LpPMGmZ+RfFdcKxyx/1
	Ub7BwNHXUJ22VKVA6OXAXkrML3zPuxLNRLRqm4qXCv2z0Csiq1xT5WC+SxpFQb5Vz+LdqxxOae4
	6PXOhb4pKOZ62VHoZkWvdfSLFllyTau1xxN1HtPQZDXu+ZeQ3GisoBtXhJtyJuS39zuKZVoiUMt
	F7aa/KKsHgE0dvz/7/7wLPRmTvGbeQjI9S4WY4Ro8ew4FTTELR7E9AGv7/vjilGlTR05f+0XaQT
	5ZfaZ9clfGEmEEbw8LPNa1SnMisIb/T4xj5Ezwp5Fut4dm7ZQemnfiwYI3P4rwyKugqYzaB3b+h
	7F1/lRtAL
X-Received: by 2002:a05:600c:3115:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49e61989e79mr109783245e9.10.1789242963500;
        Sat, 12 Sep 2026 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.56.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ARM: topology: allocate the cacheinfo early on the boot CPU
Date: Sat, 12 Sep 2026 21:55:52 +0200
Message-Id: <20260912195552.76673-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM secondary CPUs allocate cacheinfo in detect_cache_attributes(),
called from secondary_start_kernel() with interrupts disabled. With
PREEMPT_RT, the allocation takes a sleeping lock and triggers
"BUG: sleeping function called from invalid context".

Call fetch_cache_info() for each possible CPU from init_cpu_topology()
on the boot CPU, following commit 5944ce092b97 ("arch_topology: Build
cacheinfo from primary CPU"). This supplies the arrays before secondary
CPUs populate them. Suppress -ENOENT and -EOPNOTSUPP, which leave cache
detection to the existing late path.

The CLIDR fallback uses the boot CPU's cache geometry. A secondary CPU
with more cache leaves can still require late reallocation and trigger
the warning.

Fixes: a9ff94477836 ("ARM: 9433/2: implement cacheinfo support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Full warning on QEMU virt, cortex-a15, 7.3-rc2, PREEMPT_RT:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
  Call trace:
   rt_spin_lock from ___slab_alloc+0x68/0x728
   ...
   __kmalloc_noprof from detect_cache_attributes+0xe4/0x734
   detect_cache_attributes from update_siblings_masks+0x10/0x174
   update_siblings_masks from secondary_start_kernel+0xec/0x120

PREEMPT_RT became selectable on ARM in 7.1 with commit c6e61c06d606
("ARM: 9463/1: Allow to enable RT"). The PREEMPT_RT patch queues carry
that change for 6.18 and later, so 6.18.y is affected as well.

QEMU virt, cortex-a15, PREEMPT_RT, 2 and 4 CPUs: the warning is gone,
the cacheinfo sysfs tree is identical before and after, CPU 1 survives
an offline/online cycle. Same on a non-RT build.

QEMU realview-eb-mpcore, ARM11 MPCore, 4 CPUs, ARMv6 plus ARMv7 SMP
kernel with PREEMPT_RT: fetch_cache_info() returns -EOPNOTSUPP through
the CTR format check, no message, no cacheinfo before or after, CPU
hotplug works, kernel messages otherwise identical.

Raspberry Pi 400, four Cortex-A72 CPUs, 32-bit PREEMPT_RT 7.2.6-rc1,
full series: the boot warning is absent and all 12 cache sysfs entries
match the unpatched baseline and earlier topology-only run. The live
DT describes the shared L2, exercising DT-based early allocation.
CPU hotplug is unavailable on this platform.

 arch/arm/kernel/topology.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 2336ee2aa44a..e6b50cd43ce5 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/arch_topology.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
@@ -238,8 +239,20 @@ void store_cpu_topology(unsigned int cpuid)
  */
 void __init init_cpu_topology(void)
 {
+	int cpu, ret;
+
 	reset_cpu_topology();
 	smp_wmb();
 
 	parse_dt_topology();
+
+	for_each_possible_cpu(cpu) {
+		ret = fetch_cache_info(cpu);
+		if (!ret)
+			continue;
+		/* CPUs without a usable CLIDR return -EOPNOTSUPP. */
+		if (ret != -ENOENT && ret != -EOPNOTSUPP)
+			pr_err("Early cacheinfo failed, ret = %d\n", ret);
+		return;
+	}
 }
-- 
2.53.0

