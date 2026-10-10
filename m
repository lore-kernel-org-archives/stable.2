Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44837CD4E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643589; cv=none; b=Gl9Hp4dBbnvFVsIUYhFU9xREY6ZyfG0QQrfiAvk3aHMCFIjMEQBVADNztAhyUIXCHU2tTaApScNVg5wOSah5qxxC1hkRxCwcRqCj90vjWj3tbVcHct7D1+To+IqRAcR2e1hU+EU5SFGy0D1cjN1/iri/3cg/hkjXNoBjrbQAJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643589; c=relaxed/simple;
	bh=Wvi//AU9aUa0xv2xAKbaSl8hbCy/X/0aBofKQo00tnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA+D2jzDU1OTLs1zRBZyGmnUVf6vHSm0wV7vVgmpVwXNOM+zgRCBlq1l1I6IUs+G9DkYxExpsZEnnu6Ir3KlpRZGq3AowAR2V8beqauUslVC0UOydhZ+rHMEDj5JMNyva/ylfMyy8kv7+CJhUajHfD13CBh2cTsz/gZpv6ifwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rz7lt6pJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz7lt6pJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2533d83e3bso105251566b.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791643586; x=1792248386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOzUK8aXNK95MikIEjp1tQfOk1H/IJqCnHMejxcL9r4=;
        b=rz7lt6pJmvAN5eaZKH43tNAKlFYOYBP07WBMlV/D+kLzvp0ySCRg4cqqwd/rufv8QB
         VFro7YP9CNKzeUCzyTDf9GWKHPLh8bzBa/E0WVfeJ+ECY4AsQ3jsBfASS1+mzxdugqaC
         mWzkR7yASVEwELV6/dk8+2pIOBtgUFI8LDa6XszVamO8YxuVIB/vIsBP4KHJtDts6ix1
         Czf63XTKbVBYg9QJXHwO7I1pBx2lL2sUOS+MStYDiGq7LVxc2EX7/wgkYUrY57K1/qCS
         2j/tkAJn5cZna6Az1nzKzo0MqwMdyPWcasIEmINSFb/E+GzMdWCFqOQd+oE/ae6gwVGC
         Ykcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791643586; x=1792248386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOzUK8aXNK95MikIEjp1tQfOk1H/IJqCnHMejxcL9r4=;
        b=GkdTbEHDhjAZ0MH0FVIjNyBk37rE1T399LaSGyGGItXi61TmPFdRaom42Vn56LHMEW
         CUonbXY+/DlE1O7MPnqhhLL+3d3fkR+2kk4z0vAXfNUCjkdWucKCFiBoDjtvvrWPuaJi
         GnuzuXKQeyanlR2c35G2y6vxX88Y8TzuFxPs4g6Kg+0NCWa+vPYDsdGeZvL2FfWXrhJR
         UwEVIzdq2NgCKBspawRsfIOuHjADwmdU66izxyIok1z0cslTMZTOMTbH66+i+34VZd4/
         ZWoRfa4N7Qj6Jr3V+k6W6CZxqgCuojX9zjdG6zEJt9OHMQymF9TjKSymRHGT1AvLTHJG
         Jq/w==
X-Forwarded-Encrypted: i=1; AKwUvBx+JD8NCCs5llP4qoU1jkjL9sBvkfptpM1eNaa96hzC3LghIRhD5Uuf8zF8Byc9DnK3yS3qaRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1ASnpNNw63UyBuqNaVFKMpwZRAyap3D08dldywFMH+sKqmfEh
	e5I/We6Hmzr0M5T8U2nlxARCPrF8q7Ig8S42/vWPU1TlTI45cumEC7b2
X-Gm-Gg: AYBFou3U+2sn93ZbZ1jSeCCQizNnRPhAUzWDRpiTdD2UGu2iQnAUSWH91y8w55gkAh4
	w51biIybFzwdanvbvOQNvTOhnryjvOca+Go4QAmBEHAnHIr2cbd+ez5ogkj8zBGtMzgpCSVWYmH
	Yd/EUWSb+n5wi5C8kEB/GlIWMYahpvM4W9FKsElDGByk0QzleO1XrzxquRCH6WMlZ8fgU5Bk4OS
	ozbWVA4yj+SuajJ4TWWhB2GAFbGkCxpyxO05RwoNIkf1M7wW5Yi3plci/ltx56uTgOFT7+CU77Y
	bSTLiKArNaEansM8/zCDiO7qE9OmTr82ThNHX770VpWpTpnOPGaJXTeMfX3iMj8yw+ZeU/EnQM2
	8IjluCHxeW8JdJAfTlh+5oF0SNUn9N12AEFTjiYvROf1OXvEUBiCJaRuoOOT6oUJh1ZZv+8CsKo
	dOt0jnTXcssw7Edut8jhN5BOfJh4oyCIkMCEXLAvDRq2P5t7Oa5OXqH4xSCmBTcfuCOB2HRhM3N
	gADIWqk2CdliuGc1jgVihhGyabUDBpbb6ry/1FtQHGtg4dlfnE=
X-Received: by 2002:a17:907:a4ca:b0:c29:f5d8:9c82 with SMTP id a640c23a62f3a-c31aa0dc185mr510677266b.49.1791643586117;
        Sat, 10 Oct 2026 07:46:26 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9767227sm247286566b.11.2026.10.10.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:46:25 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
Date: Sat, 10 Oct 2026 16:33:10 +0200
Message-ID: <20261010144621.974850-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010144621.974850-1-linmag7@gmail.com>
References: <20261010144621.974850-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the on_each_cpu() rendezvous, migrate_flush_tlb_page() walks the
other CPUs and zeroes their mm->context[cpu] when mm_users is at most one,
described as mimicking flush_tlb_mm()'s mm_users<=1 optimization.

It is not one. flush_tlb_mm() tests mm_users before deciding whether to
send the IPIs; here every CPU has already been visited and waited for, so
nothing is saved. The callback has also just set each CPU's own slot
correctly, so the loop only overwrites it, and does so while that CPU may
still be running in the address space.

Remove it. The shootdown shortcuts in flush_tlb_mm(), flush_tlb_page()
and flush_icache_user_page() clear remote slots too; once the next patch
removes those as well, every runtime update of mm->context[cpu] is made by
CPU cpu itself. That patch relies on the invariant when it reads those
slots to decide whether a shootdown can be skipped, so this one is tagged
for stable as its prerequisite.

Fixes: dd5712f3379c ("alpha: fix user-space corruption during memory compaction")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/mm/tlbflush.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
index ccbc317b9a34..239c72b8a741 100644
--- a/arch/alpha/mm/tlbflush.c
+++ b/arch/alpha/mm/tlbflush.c
@@ -90,22 +90,6 @@ void migrate_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	 */
 	preempt_disable();
 	on_each_cpu(ipi_flush_mm_and_page, &d, 1);
-
-	/*
-	 * mimic flush_tlb_mm()'s mm_users<=1 optimization.
-	 */
-	if (atomic_read(&mm->mm_users) <= 1) {
-
-		int cpu, this_cpu;
-		this_cpu = smp_processor_id();
-
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			if (!cpu_online(cpu) || cpu == this_cpu)
-				continue;
-			if (READ_ONCE(mm->context[cpu]))
-				WRITE_ONCE(mm->context[cpu], 0);
-		}
-	}
 	preempt_enable();
 }
 
-- 
2.43.0

