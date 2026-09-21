Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDF343883
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970432; cv=none; b=Z2GjWtypLaVrYOV7zu4pOXOWlmgLJDGSyo9V9BajcPhp3l23EDMVUdNf8MVkx176nqspG9AzY4xlzvf4a9WzAkhA+4kRFbHX0CqE8zAmh1Ji4Yyx+seaKmxzEx5YYJEYmhRGexVQeqgMPvyZ+4JKZBZlVeEJbqJnFp1ywjqxVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970432; c=relaxed/simple;
	bh=8fGm4QsbqboQ4X+kQYJy2qxs1YmyCSH63xzjYCEY+NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWyDUJqDPIucBPqui1Q1iUhK0XFfHJVQn/hs/PfL92C4x1mFghl5zBZA6JfOFM04wr2V9PbNxJLGuRUrDKRntSbkXH38/t8gOUfcqeHvb9kCfK0w+5ttWMkWIZZMPpnYaYMZPgZxgWrGWRXVfhLnJanbZ2x16UHArr8e9WFegWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKbPifHN; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKbPifHN"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso13881325e9.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970429; x=1790575229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSUm2BvGMfGtlmppCZN9JChh915ltc85tdW86S+ilyw=;
        b=lKbPifHNNxsfsa2mJXt812jYITn4yk9jlViIcCHiqrXNWQBnbZ6DxaEkKtLMc01O39
         ErVxP4RYb/jRbD/2wuyPlUxOVvoIbWrzpkItnptRzo+xv1VogQShtXq45EBUysmeNwre
         IqzBggZOr02+chHGZQGJuYQ+H1fpIp8QjEIuWp329OQuJ+s6pETdB4OYG+zvXfeFz7kN
         Rl47EEdiN7Bm0DVYUbKBuvlpDCpgAkbbj0ZewMN6Uf+ZFfJIOVQf8lAzE/oTPekNMcRo
         JdtlWqi1qS14F8EMdZKhhUUOMfTX+xVtpe2wGh29ZK74BcnwkfjW1C2eRp4TcE3MyML8
         EObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970429; x=1790575229;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSUm2BvGMfGtlmppCZN9JChh915ltc85tdW86S+ilyw=;
        b=vTrgNpmREPmWQtNWrHsfUrUnpInWEDhnI4EJUsVmDtP8TQYP6LLyrtFrQYDIrKPCZw
         P1e2QsAtSocxmOpzIdLBURMiZdjO3aEP+vyo8szS5wcq12XhKyoJwK0/UQ1zmcsGP3hh
         kUFhlzQC0/KPss6VC6bWKwHCsWZJ6o9P9qhLYZByf7woe6+0uEM0zo+hH+GDYqanW0jv
         SEYxZp3gK6fhQtMsnq5YB1RdRdjP/qbQ64/6iKHm+nrpiDmBwshH9bOHYBX61iMTWn8q
         lx71l7+XHUGBv/GpBDtBvzdXQ8kxz9eEnbePCiqnyhCSb0oWuZdEuU2aMLGJQKm9T7bc
         2k8w==
X-Forwarded-Encrypted: i=1; AKwUvBwXi5Xi1Htg31rSB4QTpi/eTlB5x0DW90/UFjUAcIkbNuaLhj2FCueV/IeFO+wp+rop2/Ui2WI=@vger.kernel.org
X-Gm-Message-State: AFuF++lyGdg3Kr0LIPUOIatUVV29UFRcWwOE1+pxAGZMwj4VrsvaS2/7
	s8TuLH0WdCTPxDmLzE5+zCIseszjpf5odIMKgVSkM1drVQj9edcUuSV0
X-Gm-Gg: AYBFou2iueRIX7d2roBhijimqhMmWNUeCGlo9888yL1pFjKULXGS+rBNf8RYkBmpHdP
	Vmi087j9YsXS3TvS5QUB3VZUpIwWVrGvYRYCEM9MFp8831GfjVSyS6XEBXoYSrkHMXmPSMVwHc+
	2sg6Vm1BL3Hb5x00MYLOEQoSKRXmAQybW8/GP/XcQsiG0PvazC3dJoouDEsaeu2MbKtA5rBDZXw
	dZloUnoEvccNET7WC5+WbVz0ISjRzjsNk7Rx+6jJBNAFZ070yOnC9bX4zqoO6gswJ5GhYM4pGun
	JykCIB+kf77bNV/v5ml4/VITXxMIhJXG+Hf30h+Vr5yndY2AQ7Ymxp65rZ/dIiPyyKrlK+GiG1U
	jFxPoDZ41unqnwqlUtG5VQZymj+u8EkGBlIIHzZnw2gmnEUsY8ffKylGj1Xr7n3CTpSFK2ogxic
	3DxKN5DnXqmtGzFV7FQeoaHU8LCFgRkygUOLO5xALOjDDWw3WsyPOooaBukh56HK/vy4Rvo1Byu
	RyhVfuaK6nZkArjp/rTv1SUfEuVq5cR2D4mg15XkifDV0RxGHsR+wlE2iM45UGp6zwq+tIsqGfX
	bQntlnGH/s0f8fwsPzPsLDZNdhHA7nPJwDFkrim4dyA5dXhQ6A6JuZhUZgSjx3By4vF3Ns2sEvf
	V2A==
X-Received: by 2002:a05:600c:19cb:b0:49e:8184:f619 with SMTP id 5b1f17b1804b1-49fc57410f2mr132387185e9.22.1789970428604;
        Sun, 20 Sep 2026 23:00:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:28 -0700 (PDT)
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
Subject: [PATCH v2 4/4] ARM: topology: allocate the cacheinfo early on the boot CPU
Date: Mon, 21 Sep 2026 08:00:13 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-4@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com> <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
Content-Type: text/plain; charset="utf-8"
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
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20260912195552.76673-5-kmehltretter@gmail.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Fresh full-series rc1 retest: three builds and seven QEMU boot/CPU
hotplug checks passed; see the v2 cover for the matrix.

The detailed testing below was performed for v1, before this rebase.

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
