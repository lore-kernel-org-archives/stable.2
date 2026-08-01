Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7FB330B29
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785602136; cv=none; b=QP40lLdVJIUEN1Mjycj5e4Fu58B/H6jgxZTYTdkGI5TJMRWrOEyL9g97JRHTiWC71m2lvIglHWzKoAximYd9coLEZgVeVAPsr2j2quzmVbDlmCOkLK1/RykafyEP1iHr4rsY5gmLHwv3P+dTgynIsv8MMN/yptNRfokkvJHutiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785602136; c=relaxed/simple;
	bh=64VvO8d8INQ3EZrgvb/0fctdpa6TYLY3j8XkRq912js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ny1Js/ga32qQv6XxBm6ZqRS7YAz3i6rTOtDaJuPWEPtuh3vFHWk5VMk6CukkeV7Ns1b1DsBTwWfWCO7zjAz9rm7ZURcZoX1ZTcI90ZTfrD/M0SWYKdvuemV7C470dPGDfemYhP1oLdxgENdpjIajveT9Ew+oobU4FmQdrPGZ49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD2HSQfV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD2HSQfV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2125472f8f.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785602132; x=1786206932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlVco+inngiGEnvknyK5vR66wpHcUHEUtQhbuVIVbBw=;
        b=hD2HSQfVxgJaP7qInf8qgfR3WADClR7Hxuib6WBnEW0Hv5dRRxa+T+vr27nSHoSG1Y
         sQzNQNfB/Af/5f7pd+aHgBxG1SBLXZ0msfS93wNZgdZMn8NEhDLj764I4ltOBE0Mb8Jh
         N8P6wfp9fcPWqKNZ88ynq7IIEF6kQucFHuooPdv6+HThFINnS1H9v3V7JbCxn4HYAEzh
         ulIg/cQRLP7B0yxSQMsWxQoInNl7aF50XM5bU8ulh7LHxID/jB3SHlRaixO/yxfbWOFb
         Y+h/cU7dG2zGizZaFD6oulom36fJXUYo/EHSIRjV/WIptAw9gr6va7GGQ33KHBeL3Ezh
         LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785602132; x=1786206932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlVco+inngiGEnvknyK5vR66wpHcUHEUtQhbuVIVbBw=;
        b=hJb+5ylH/q+DkKyGPbAzB2jbPS1ATHb7zpWQhZVKRbQYar8tOuZ76vtBE/NgfF0xc4
         Kpx95aFxLQXCnsjwYIHCtnNCwU9ExXEmPVvdpIYbnl4cUUFwT4x+KmxK1CsMS+nvIFj7
         vDOuA7BiwFS6j+hCIhwXbNhVZvJzihwZ7NjspQUp4bJZafwBzj7XLCsOT1422Bvf+YYL
         wDSNCnrBAKp1GWEpCuGZZwUULgU4CX1nEwM9DB8OLGlSXBStUnwe/Y3NM13XPEqGOrzW
         FJeCdBoKLOolvyXlszWlZXAl+WuXGsFz4bq72gEUxcVAxj6UL2l747AzVQo032+2d7zI
         IQtQ==
X-Forwarded-Encrypted: i=1; AHgh+RorsKTAOtV7kukFYPkAyTbmvqykqU8k++sP/nOssXtZ2Ojmmmv/dmzT0kTH0Vk1mEI7zHHDCcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNeww3bKHb4RIQcJcZNRbyevFdT9mFFC/GBG0aHJ5Xq7M0yK23
	SNmhCELYFRgrf8qQtSY4EGGcHss6/OMp47g79aCt5UnqKSg1vOojFx4f
X-Gm-Gg: AR+sD10saeOKvDL5bkxTRwY2odPMs12Cdt10RJcZAlefDhuxlyugNAAzP2FuN7TAE7a
	90juQYduSVka1z1hdhRvMKmvBxm4qjw6wsgOIz/uU4usJAoUJw+ht9VZ33blquL7XcMue5Ns2sR
	mkUuePVBNqgbhRjWKXu8CBflgCGcRDn7LeCmmyMWxFeN+CaFukQV/Dm7MrN9ySA2NVhogcTYg9Y
	+yhKLDfqm65/7DrstAPGjWlD/i4N0KFOCCH27bXaMrzvEH7gr7B5usujS8fwjTjTCwjYrQHEb6O
	ndXrnxCzwTIUKRH3/D6u491ZHC20KiHMkCD1oGL5okboCVfcGbLe+UFSRedhxoEhcwbGvo/RoNr
	yvZUrutU3JXtIfC4P8E2ZsjVs1PpbRbbC/D2gSlC9jfhoowGN3Cs0b2kanQ3j2k6LFGQ0+hh+Zo
	/Xz9MASa3tSr+oRL6FfX0j/1jDFQgciPSU0Pjqh805Gx/Pl8r93Fh7k75niLcDwjAXeuuCrHblJ
	s5pFJnCQZHLki7qXS13b0XYlYQ8bLRW7poEjLZ/x/82FIvSQXuJiP72BnnQuanbfEIS1NoE/bG+
	NGYtefL1vbQzPdFhl4C+YIO3203k3mfcineE+h1aiqku4CehgvZwaFpwB5wFNRwIZw==
X-Received: by 2002:a5d:5f48:0:b0:46a:8fab:eb44 with SMTP id ffacd0b85a97d-47fd729e7b8mr8907476f8f.1.1785602132433;
        Sat, 01 Aug 2026 09:35:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b118-f401-004d-3df1-8834-8499.310.pool.telefonica.de. [2a02:3100:b118:f401:4d:3df1:8834:8499])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1956sm17607243f8f.6.2026.08.01.09.35.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Aug 2026 09:35:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ARM: smp: set current pointer in assembly before jumping into C
Date: Sat,  1 Aug 2026 18:35:20 +0200
Message-Id: <20260801163520.74751-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_KCOV_INSTRUMENT_ALL=y, secondary CPUs fail to come online
on ARMv6K/ARMv7 SMP:

  CPU1: failed to boot: -38

The compiler inserts a call to __sanitizer_cov_trace_pc() at the entry
of secondary_start_kernel(), before set_current(task). The KCOV hook
dereferences current while TPIDRURO is still uninitialized, causing a
data abort before cpu_init() has installed the exception stacks. The
secondary CPU consequently never completes startup.

Initialize current in the secondary assembly handoff, as
__mmap_switched already does for the boot CPU.

With current set in assembly, the set_current() call in
secondary_start_kernel() is redundant. Drop it together with the
function and the task argument. The hotplug resuscitate path in
arch_cpu_idle_dead() needs no hand-off either, as smp_ops.cpu_die()
can only return if the CPU kept its register state, TPIDRURO included.

Fixes: 50596b7559bf ("ARM: smp: Store current pointer in TPIDRURO register if available")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: drop the redundant set_current() call and helper (Ard), along with
the now-unused task argument to secondary_start_kernel()
v1: https://lore.kernel.org/r/20260718091600.92021-1-kmehltretter@gmail.com/

Tested on QEMU vexpress-a15 (v6.16) with CONFIG_KCOV_INSTRUMENT_ALL=y,
covering SMP bringup and 10 CPU1 offline/online cycles through the
arch_cpu_idle_dead() resuscitate path.

The head-nommu.S change is untested because no currently reachable
Kconfig combination enables non-MMU SMP.

 arch/arm/include/asm/smp.h   |  2 +-
 arch/arm/kernel/head-nommu.S |  1 +
 arch/arm/kernel/head.S       |  1 +
 arch/arm/kernel/smp.c        | 15 ++-------------
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 8c05a7f374d8..84aa6a663e81 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -43,7 +43,7 @@ extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.
  */
-asmlinkage void secondary_start_kernel(struct task_struct *task);
+asmlinkage void secondary_start_kernel(void);
 
 
 /*
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index b9d6818f1ee1..f80bbfbd3a6f 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -116,6 +116,7 @@ ENTRY(secondary_startup)
 	ldr	r7, __secondary_data		@ reload r7
 	ldr	sp, [r7, #12]			@ set up the stack pointer
 	ldr	r0, [r7, #16]			@ set up task pointer
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(secondary_startup)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f22c50d4bd41..a22403a629ef 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -442,6 +442,7 @@ ENTRY(__secondary_switched)
 	adr_l	r7, secondary_data + 12		@ get secondary_data.stack
 	ldr	sp, [r7]
 	ldr	r0, [r7, #4]			@ get secondary_data.task
+	set_current r0, r1
 	mov	fp, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 50999886a8b5..e30206365877 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -371,12 +371,9 @@ void __noreturn arch_cpu_idle_dead(void)
 	 */
 	__asm__("mov	sp, %0\n"
 	"	mov	fp, #0\n"
-	"	mov	r0, %1\n"
 	"	b	secondary_start_kernel"
 		:
-		: "r" (task_stack_page(current) + THREAD_SIZE - 8),
-		  "r" (current)
-		: "r0");
+		: "r" (task_stack_page(current) + THREAD_SIZE - 8));
 
 	unreachable();
 }
@@ -397,23 +394,15 @@ static void smp_store_cpu_info(unsigned int cpuid)
 	check_cpu_icache_size(cpuid);
 }
 
-static void set_current(struct task_struct *cur)
-{
-	/* Set TPIDRURO */
-	asm("mcr p15, 0, %0, c13, c0, 3" :: "r"(cur) : "memory");
-}
-
 /*
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void secondary_start_kernel(struct task_struct *task)
+asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
-	set_current(task);
-
 	secondary_biglittle_init();
 
 	/*
-- 
2.43.0
