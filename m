Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70A360EDC
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863052; cv=none; b=oXJBxynAvR+ALvIfk41Rfkc05oU6I9JY8ZoE1CwSSV4SQ59vlATa7PYmnmDsJkwSaa2mk/SW+/PzIgfict5mGPlozabUPFRABfNQCdAV/ORqW9YvxSTNJib98CALNI9h3kD63C5ajp8maBnlx6hKkmiwMVanbo9SCy44V3YxYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863052; c=relaxed/simple;
	bh=HN5XavKK1xCW43JBlhHw4vxvNHH446KT/Jla66/fgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOBNB1D6RddZ3UyOqk6ub/fpV6BMZdAN622hu0v49/cGra1oiPzySGOjz71N3WWdDfaJMcYmteDQPTgGF8Q6MHwGUNXrTOYohhkYz7shmbJCi11cA7mJJEe0t7qwJHjCWEaQuj1BxQ82mgLUQbppvZyskz3/I5uc5wGC2s7j/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqN067Rv; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqN067Rv"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9179b004b49so21125166d6.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790863045; x=1791467845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DYhRgdXSzDJVurFDLv4PHup3HFD+RVOANjvlBQkYgM=;
        b=oqN067Rvy0IQRkHvTd751o/GJQ1IGGMAb3Umwe2jntRwXoxGlyGOwSDrdJNFfATjag
         zCGP60rcCH4xRhZUCo6/AWArdJ2m8MukLNyspqE0+t4xqxv4RbRpNhvRsuzCNfeTeeJO
         tEHtiXnX50v+sB5t5TWMOgAjHKHnLCJuUsbeFxuEAwzLoUrBypX7SbOnSb5FDqzHtJQx
         xJG5CBOUhb4N4rLIfZ22yoVJ1TxrEieXoEySemNv8uONvO/QAEUyd4+tza7MsuD/+Zka
         8w6BfOm6WQVDPy7SliUAWSKWUkQfJqOuxz2ViNvTBmx7wZiojFsRcMTEeUalGv3uDUDo
         3SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790863045; x=1791467845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DYhRgdXSzDJVurFDLv4PHup3HFD+RVOANjvlBQkYgM=;
        b=GqGeYdl42hPIe46/CLLbav+MpkdnCg/RohmIGNIwDv8ibW81rlgVrFm3j7O7voO0gJ
         flFRyDel/NdmJN0EKg1/t9QP04GLDkpsIJzfGjZ2gq+1tyefPmQMHDjKYVvdElIELJC8
         5b8+5JD7AxIJffkoDn38SI/ceJMSQxPGSmtGecld5Apn1l912Sbf141y7OrRg+Y5FKBq
         AM1iQWdmSAQG9x6lpF1EhsbDIJiMg49UflPDuzLszk3V1Rg8ejL44Oy4EiHOQKU0Eh+f
         Xq5mOC2tOqzHnzid8QX0NdzFueCbVTj9wsrO8rzOeuud6pNVQebIN/acuC7v6HX8USYx
         G8vw==
X-Forwarded-Encrypted: i=1; AKwUvBxsUEi53VW1DZ1Kyms4ARAAiiinoc7WV0XjBtO6abX6IwkYJ4uzxVkiAtIHwtI8V/X6AulXSss=@vger.kernel.org
X-Gm-Message-State: AFuF++kiJRwwkIFnX783pmztt26VUQfQWiFT+a3XyrtIpJLzZ/6VPBLl
	0Z0dsfsC0rhOAWpdAT1+YrvUPsNhrUXgajtdfQBKu0emOj/cHroyei9g
X-Gm-Gg: AYBFou1udW4SGDBU7tQ12UcCs9K9K11c0Gbvn6l+AuBaOmBtRpzflG2FCWu9AXiTFCC
	86tCDnBRcOrA/Ey26Jen7SR2aQgnHKaoAhpaGTSFegiByYRazBiunrLxMASP/jBfyXqelYdZfsE
	YpG8ZDffbQIbsKwDiYK8SXk1V/RZ7YOsqgMR930P03mFvRjimqsQA6eDKNGBmyw/zpBw2klSthn
	IUABysSo5ERLbk/hk4a+zFSyfNCwi7OSXLklFPp9+3PPaGjk+OxYO/pXZy0t30AbEi0uu3pRTLS
	fSwwHCm9l0G4RohUOLgmcsb4rEAqda3b0UVEzhmCYbJoh3fZye+/cYmGSIsXn8+gpWMobcdbrt2
	mxoo4Aj7eqS7uOy0IoQR4krbqdnL2lwGW42i7UgKexdGrAzvy9f8TyQOl54qKAZdcj6IhNxDeVb
	FYjza1cbcxOc4VuoxjKTj3FRqwNtUwhQ/1vPdvgVQ+hXIZUlhxJ5YkwY6wKBQxj3C0alniaY46F
	A/wBTYMtsj6BurmXwi+WTJNPqiujYxZua45NPdVjy/Y/aiYtg12EnWNQehD7BFYN8q6+iLQL7FS
	7VdLWHNM
X-Received: by 2002:a05:620a:2550:b0:93c:3d7e:6e90 with SMTP id af79cd13be357-93ca96e9ddemr839989885a.32.1790863043915;
        Thu, 01 Oct 2026 06:57:23 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a89a52d2sm26940176d6.14.2026.10.01.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:57:23 -0700 (PDT)
From: Ziyi Guo <guoziyi114@gmail.com>
To: palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	samitolvanen@google.com
Cc: wangruikang@iscas.ac.cn,
	debug@rivosinc.com,
	conor.dooley@microchip.com,
	namcao@linutronix.de,
	zong.li@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ziyi Guo <guoziyi114@gmail.com>
Subject: [PATCH] riscv: entry: gate shadow call stack reload on sstatus.SPP, not tp
Date: Thu,  1 Oct 2026 13:57:11 +0000
Message-Id: <20261001135711.934152-1-guoziyi114@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under CONFIG_SHADOW_CALL_STACK, handle_exception() reloads the kernel
shadow call stack pointer (gp) only when the trap came from userspace.
It made that decision with scs_load_current_if_task_changed, which
compares the trap-time tp (read back from sscratch into s5) against the
current tp:

	beq	\prev, tp, _skip_scs
	scs_load_current
_skip_scs:

tp is a user-writable register.  A user task that sets tp to the
linear-map address of its own task_struct (&current) before trapping
makes the comparison succeed (can achieve by brute force with KASLR 
enable under our test), so the kernel skips scs_load_current and
keeps running with the gp that userspace left in place.  Under
CONFIG_SHADOW_CALL_STACK gp is the shadow call stack pointer and
load_global_pointer is a no-op, so the compiler-emitted
"sd ra, -8(gp)" / "ld ra, -8(gp)" in every non-leaf function then write
to, and return through, an attacker-controlled address -- an
unprivileged kernel arbitrary-write and control-flow-hijack primitive.
The poisoned gp is saved to task_struct.scs_sp on return, so the reload
is skipped on every subsequent entry as well.

Decide "came from userspace" from the hardware sstatus.SPP bit (already
in s1 at this point) instead of from tp, mirroring the check that
ret_from_exception already uses a few instructions later.  SPP is
written by hardware on trap entry and cannot be forged from U-mode.
Legitimate behaviour is unchanged: user entries (SPP=0) reload the task
shadow call stack, nested kernel entries (SPP=1) skip it.

Fixes: d1584d791a29 ("riscv: Implement Shadow Call Stack")
Signed-off-by: Ziyi Guo <guoziyi114@gmail.com>
---
 arch/riscv/include/asm/scs.h | 17 +++++++++++++----
 arch/riscv/kernel/entry.S    |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
index 023a412fe38d..49e40eef4ed7 100644
--- a/arch/riscv/include/asm/scs.h
+++ b/arch/riscv/include/asm/scs.h
@@ -4,6 +4,7 @@
 
 #ifdef __ASSEMBLER__
 #include <asm/asm-offsets.h>
+#include <asm/csr.h>
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
@@ -22,9 +23,17 @@
 	REG_L	gp, TASK_TI_SCS_SP(tp)
 .endm
 
-/* Load task_scs_sp(current) to gp, but only if tp has changed. */
-.macro scs_load_current_if_task_changed prev
-	beq	\prev, tp, _skip_scs
+/*
+ * Load task_scs_sp(current) to gp, but only when the trap came from U-mode.
+ * The source privilege level is taken from the saved sstatus.SPP bit (written
+ * by hardware on trap entry), not by comparing tp.  tp is a user-writable
+ * register, so gating the shadow call stack reload on it let a user task that
+ * set tp == &current skip the reload and run the kernel with an attacker
+ * controlled gp (the shadow call stack pointer).
+ */
+.macro scs_load_current_if_from_user status, tmp
+	andi	\tmp, \status, SR_SPP
+	bnez	\tmp, _skip_scs
 	scs_load_current
 _skip_scs:
 .endm
@@ -42,7 +51,7 @@
 .endm
 .macro scs_load_current
 .endm
-.macro scs_load_current_if_task_changed prev
+.macro scs_load_current_if_from_user status, tmp
 .endm
 .macro scs_save_current
 .endm
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d799c4e56f80..61b7a7716697 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -208,7 +208,7 @@ SYM_CODE_START(handle_exception)
 	load_global_pointer
 
 	/* Load the kernel shadow call stack pointer if coming from userspace */
-	scs_load_current_if_task_changed s5
+	scs_load_current_if_from_user s1, s5
 
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp
-- 
2.34.1

