Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7103BFE3E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489387; cv=none; b=Y3/7/xOYNkPGVgNsQY29sbOJberKEGlD4mpELs+DvZRl3vj3rj1dBkRQcJLV16Iu1kCiIj40PH0nU/gDoPso7M/rIRvSSIu7mWS1XKG0DDXLrN5c+xB1+/oPgjpT7r7BDxhfq53JvQL7CQODjJIpjiWB5trsEINBhZo6072wGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489387; c=relaxed/simple;
	bh=Zc2UJIh/Gz4b/GfLgUvqGBXnO/DO2zauikqTsYZZdvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK68G+d2TdeY76jNZFD8y1UeuqI+LmsP5CeUxJSdmNUtUG8fdtV6sYCnxfWEt3Ccq/IOvQhqvK+oVaSqHh4dXhQ+w3acv4CWm6lPUBPOohg4QqMu6Ge0XLgmyQob9+UmE1tvjrV0zFfpvbFbFCE6wB9LIPAXFHb/rt3ijnMU4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbavzyua; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbavzyua"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e36c3478aso831585966b.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489384; x=1792094184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVpisjCcjbqYyAaO5WaK+JQliYnymANtNgrr9O1e3Ak=;
        b=Kbavzyuajexd84BqGXnkWLwV5dA3h0K+dfyCAIfh2XvADA74yulqIba8ErDd9UcTaJ
         Q3qyyAiTXHSnxDekCQxNpdISJ9kI6W9ZTOQAa3eoxWUZ1qDsq/NwKuwpC45VbP4aJNn8
         Yzc0TWU2+vUexoEK1O6FcRcxdmAsNET7suEglDhzjkiJnu0QYIVVu5sfWWCKovqbsj6x
         KkGebViuD8vVlqo0IF7E2CtMd52UUZqYHqkdBzEH9DRrB0NBRWyQmPXEQxZd8N/ziC6n
         6HeNMbctnpcoAbi5+XYvhtNZeNfQraGMy1Fk8+OPrFp2X7xFWJdkakwE7ZSWH50j2YEa
         uFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489384; x=1792094184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVpisjCcjbqYyAaO5WaK+JQliYnymANtNgrr9O1e3Ak=;
        b=TP3Pe35TUvTaWaRpAFwBEhoJev2EkHTCxTd24pdQOHcQMMAeJXGRjIN8UdyKvgTmiw
         NZxeo/jqSR3c1AGzT3wKMJ8MJrcPjeXOgfDI9QHcFWWxbNAfVCxNeqfjcCYuN8cW3e92
         FBZfReFTIV75C7jajhdeTh9FxJDP1CKEoES/i5TFa5L//CkC77NFTK1a7IvUJe4b/kcX
         /XhNxAzVO0J272/86iMsKFZO6KxC+OMirDlggNrq6zk0ZBxh5I5wlLv19udXvmD4Hgmb
         97AdCuItIreMOcxlv4qcUypYY6PHDLwvrmJw8J0Ek0fMf8C9SuMVtld3W6OrDpZmbhjb
         9sOA==
X-Forwarded-Encrypted: i=1; AKwUvBzXLpAky0xlda4Bw2JSXl8IswOSQcuEeouqDpuw4PGd070AsNuuwbC9MIANFYOuJCMJOAxWrfA=@vger.kernel.org
X-Gm-Message-State: AFuF++kxpdLRh2lFti1Uo/Im+ZAh4h7mJkM42Fv19Q/7Nd7fWTs9JJmf
	Q6Z3Ub5Qu4GSvagsl2yIkHflnAKdvLu91T0+es604hT/30UnbqYZi/Nu
X-Gm-Gg: AYBFou3eSVHF7Pl3nWFi9rLosvsV5hjfKPwxdhsR4AQYkyDtdlZd12TyU72nhzXarHl
	tzlo0kG8E0qN8GGTeudvmGPVFYK8EVzB7HZ5ZhZO9WRvYbK2GSRjnjNupM4GawHnd1M3Mx5dfti
	DmXHTEerrEeSkvp+RqeeU1QrF69ClHB3oUMGTm/Q41Gmzd5wH5nqOhEZ034zQ5Eq+FP+7ynRKFb
	n7+xu1UJcYOaodVHwDUvkh/o/GJDXf40QsweI69eMTft3TlwpFt9NngAQ5kbAMq+CZR33Az6v4p
	4xXPVMzud0ZOOvVHTOgfSk5L1m/bDn5qrZwHu+yaiy+/+4hBWt57I+tXX/speQuaP19JaVDUK4B
	zt+4/Wdni7BcDYBtgvCOJt80gbcpigb5bJIs7j55g/ZQ/Vsj1tqufXFhrihqpgV9t+vhFCpvDHv
	+8ZU+1Ir/UsOuqUNrnQbgs/wtp3o8CVk5cPNGsrEwgV6N5HtWTiKH1yjDcQ4RxP9FzTAw4yWeM5
	W/ntaedGQW2RZjXUQCVmdL/lSLOx8pFyWeRL4c9
X-Received: by 2002:a17:907:d1a:b0:c2e:40a0:7978 with SMTP id a640c23a62f3a-c317bd54e14mr640435266b.9.1791489384223;
        Thu, 08 Oct 2026 12:56:24 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a4d0c2efsm9906266b.26.2026.10.08.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:56:23 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
Date: Thu,  8 Oct 2026 21:55:17 +0200
Message-ID: <20261008195608.965266-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008195608.965266-1-linmag7@gmail.com>
References: <20261008195608.965266-1-linmag7@gmail.com>
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
Cc: <stable@vger.kernel.org>
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

