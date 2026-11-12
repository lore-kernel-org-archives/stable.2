Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452028;
	b=GU/trdbwZhCTs4l1OfDJ0PotH/KvP89sSNBl+G9bvMdsHAtFrCARZocxSSAAg5Gqosvg
	 JrJKxgZ1KHvVpHyOp9WnJB0e87Xm+dANKl9hHn/P9C9eDrtCYyGsV10DtXF1y5hnKT36z
	 VDm/adfJdRhJJj/nTmOvWeDuqTbvCofOQiQkfIdKhP0TPYxFW2yhN175CFQ0Un8ZUs7cK
	 mElhbKTjutyaE/4/aVoYWfxOMR8I0aqUG6kfOvnqydahOol/++bZBozks/DmsJs7blkBV
	 6+KFmp0oMawJ4d7MoYHxZiVl5yZHq8S1IMvbnzzsqFdy82aBdkKlIDuUUeGAKHs+dOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8yMHCtcZ/1cI9oadvNBaz1GIBWo+u42FQNaRXMLSLbc=;
	b=htq827c6ccwKDzfR6BFqBqqvkMKpJrXtLwE+sv7KCS7/qJ5rIKTELMpO7feMiL/w5HgS
	 TkTNmkqPhFpl3OOSuYC/fvZVVR+/veKGwjNyFKysH0aO/4HUULzXO/JxFoBrTAyhytNqt
	 Y2JtCfC0mZJckJt3tTkqhf62OiAkKvHuh9MkzK9PmClRQCKLjtBpbRL0Jh4EoshViXYU+
	 7MV1g7lvFHIS+2JNrgNgrk+NPXCc1/co506WEEfQrStCm2z+2ns8C0H6HusfpiMd7aJNO
	 H6n/+yp20zyiVMcNrQ/sAr3lqr9gRdL7BPjGZEfSayUQhSzx5D/c2O5MxnKxlIsCwPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoHAKYts;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA872606A885
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA872606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoHAKYts
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2296876a91.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794452027; x=1795056827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8yMHCtcZ/1cI9oadvNBaz1GIBWo+u42FQNaRXMLSLbc=;
        b=SoHAKYts+CYz/wXS2LA4OxGNsSrUcR7FjvkZGOYp9Seetf4436d4GPJtdusZ2ZpaXB
         3VT1FerWekHSaM7hzUwHLmqTpJnnTHthYLMnwpmN+z03OkuyqnCcmQc8BBUUqp8PuscU
         n9osR6uokHoBknm9GTc1ZZwyOzczCObDGQ+RnosXayk9oCR4cs6slma7qZ569Wvj9t7+
         raPDMWMZ9lb2wfPvnSbE3uN/1LP6jqR/TwJp1/qZqk4LY1PRZxXRbfocg9PNELbWNv6u
         3EnIufpL8tTVmUWJVa7KvYRbwENtXVAkMlowGqwHKkcoZ29e4YyILB/uOBENwmKQ076R
         4nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452027; x=1795056827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yMHCtcZ/1cI9oadvNBaz1GIBWo+u42FQNaRXMLSLbc=;
        b=t014ALjx+0lVZ1MV3JkA5afxcFDW0ajxgFNyrl5hoFx4ok6PHfHPrDX6ID6eU+a9dn
         E5S14S/yH4vYz0VJwuudPbogRafPNUxL9hHyKulczs/yMBkzM5no/P9wqlQ3x/pv89mZ
         hhYbxdjg7wvfWCAvWeAPlEUI3hr3vnueIDk1j/56bw2ext8UNEUhNaLeo+QbQv/y90OV
         akhIV5fcWRvLfQt+HUikAsBt2MqDCH87WkG73mFLYEuxSeEKI9PdlJ9Ol1lRldMEzLGB
         Led87EgYZcuVtqKqyiU026qjR3FA49cQ+8y5hLb9CIkXeNCGe+Ax9tnG2/vMKh4Z5EHH
         SOqQ==
X-Forwarded-Encrypted: i=1; AL+hErHuIKUBuKiZc8Dn/2whJSSuc5Trc1/DDltrySQPfG3GKI/FTfDuAVftS+dRm7ONwPwHBSPm5iI=@vger.kernel.org
X-Gm-Message-State: APuU4Z82aHwZLQ6E5R2E/UTOfuANoto7KG7IJLLNicQ8D9Eep2whtgAS
	9hK9ixejsPIGw5EXxk+yf8bLJiVU5EGwX96UYHfJ79BlYRiEyZEFCcUJ
X-Gm-Gg: AYBFou3ut5YWvscpbKZu8nas1TPv07WKXG8cKSXuCMFECD9TVYGoKKYH1TKS5gJvWK8
	huDBdNeBnrkiO3affdCTPuSMk3xJd1wMdtlZ6ucrpqdmCJcV3mG38Ey7egysK8NaPWDU2Z8AamW
	2YE/dMvMCKYLMwf1cAk2HyCRP5frkY1l/RGS77JnD0MSZuChnGz4OlfDx8Y1oPve53IhnkPGvRn
	go2pJ4LLra/aGK5QQ/AEoUUdf+WZ+2PlWgt1hmvlVzNDK3WgQzlYcgBTSHdBuNN1ETE64aQPoN+
	92+96IudP523zg5mpvRJlIyx6eRQ6hT/bSoo71QHoVLFX2QZSZthGAdhJQM+dVQiLLQ4iJHDDWl
	JSMRQOFj4OkSkO+O0UqZ9kRtO5mH7tNvHVUGeImmRY64biouUrC0l7sZKwEo4BgbnvobbCP7PWb
	V3huOxuee3v/DfTqOnHgrzeI5mtwArarvvcxHbmh5caLyy3b0l48HE18IMHc8Yua612+tX8fuKB
	x0JyHgXogku1pZs8bPjxqxEWIHzUaaAr/5AM4N5rUkermCjc4O8Ixr3ZoXOkV1VdUoUAe2/pDK6
	d9ro7Fa8PT/KCtXBtpQFHEk4/wnZU92FM1xLEXbb946tAh2ngct25dHTQa9QEUmDzwBbjixlHPD
	9kFMiOlQp05njGHFgggCf13pm9Z8c
X-Received: by 2002:a17:90b:4a43:b0:3b0:a3eb:759e with SMTP id 98e67ed59e1d1-3b182e6f662mr4020514a91.17.1794452027099;
        Wed, 11 Nov 2026 18:53:47 -0800 (PST)
Received: from prox-debian13-dev.listerlab.win (203-96-142-148.dsl-dynamic.connections.net.nz. [203.96.142.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7bf46sm27052045ad.31.2026.11.11.18.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:53:46 -0800 (PST)
From: Patrick Lister <patrick.lister.dev@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linusw@kernel.org>,
	Keith Packard <keithpac@amazon.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Patrick Lister <patrick.lister.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: nwfpe: use task_pt_regs() to find user registers
Date: Thu, 12 Nov 2026 15:51:59 +1300
Message-ID: <20261112025159.473997-1-patrick.lister.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
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

NWFPE locates the trapping process's saved registers relative to
current_thread_info(), assuming thread_info sits at the bottom of the
kernel stack. Since ARM moved thread_info into task_struct, that
expression points past the end of the task_struct instead.

This breaks FPA instruction emulation, as the user registers are
never read or written and causes out-of-bounds reads and writes of
kernel memory beyond the task_struct. Any unprivileged process can
trigger this.

Fix by using task_pt_regs(current), which finds the registers on the
stack.

The bug was found with assistance from Claude Code (Anthropic), model
Claude Opus 5.5 (claude-opus-5-5).

Fixes: 18ed1c01a7dd ("ARM: smp: Enable THREAD_INFO_IN_TASK")
Fixes: 9c46929e7989 ("ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Patrick Lister <patrick.lister.dev@gmail.com>
---
Build tested on Russell King's linux-arm tree with footbridge_defconfig
(CPU_SA110, FPE_NWFPE,THREAD_INFO_IN_TASK), W=1, no new warnings.

Runtime-tested on 6.12.116, where this patch applies unchanged
(arch/arm/nwfpe/fpa11.h is identical to mainline):

 - QEMU versatilepb (ARM926) with OABI_COMPAT, FPE_NWFPE and KASAN:
   a test that executes FLT and FIX gets the wrong result back and
   KASAN reports "slab-out-of-bounds in PerformFLT" without this patch;
   with it the result is correct and KASAN reports nothing.

 - Nokia 770 (OMAP1710, ARM926, OABI userspace): fixes the maemo
   battery daemon's FPA arithmetic which would incorrectly calculate
   the remaining charge of the battery and power off the device.

Not runtime tested on mainline: since 25900bd99d4d ("ARM: limit OABI
support to StrongARM CPUs") NWFPE is StrongARM-only, and QEMU's only
StrongARM machine (collie) currently fails to boot mainline.

A reproducer is available on request.

 arch/arm/nwfpe/fpa11.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/nwfpe/fpa11.h b/arch/arm/nwfpe/fpa11.h
index d51195d41f5b..25c327a73a27 100644
--- a/arch/arm/nwfpe/fpa11.h
+++ b/arch/arm/nwfpe/fpa11.h
@@ -13,13 +13,12 @@
 #define GET_FPA11() ((FPA11 *)(&current_thread_info()->fpstate))
 
 /*
- * The processes registers are always at the very top of the 8K
- * stack+task struct.  Use the same method as 'current' uses to
- * reach them.
+ * The process's registers are saved at the top of its kernel stack.
  */
-#define GET_USERREG() ((struct pt_regs *)(THREAD_START_SP + (unsigned long)current_thread_info()) - 1)
+#define GET_USERREG() task_pt_regs(current)
 
 #include <linux/thread_info.h>
+#include <linux/sched/task_stack.h>
 
 /* includes */
 #include "fpsr.h"		/* FP control and status register definitions */
-- 
2.47.3

