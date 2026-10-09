Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2073D45C5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581119; cv=none; b=imOBj2BuHdqX7LJlX4YV7lC0giDpg/+jMSfTdUTBGnHks3Wo35bOn29qGslxTq+57UxAJXv+YwqkXMb/IpAluwSya8fgl+eSy5EwHaivpSBL9zVKCura4FNU2Uqn6N84eFDCaSRmIaUUSBXZdOlo3TVV69VF7GbaE3k1OHUk/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581119; c=relaxed/simple;
	bh=l+10RVdMjooYlozj00YagPRxJnPJycDfAXhfTLYB5mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TamW51hqBp07yc6arHNVGvgj8n5ou2wjjoFtCeB3GGp7CwAcrj2Ov82nGk7LWrGFZxGgmjUZVtlZq1DduCfqXZHjinAESeM7fQf7jgln0+CIrV8my421Cc+cyXTkjkL13fQiw6E2BfyTmThXxxo8r8loxliUsocvlfixuku0cSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktohFhsl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktohFhsl"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so196140a12.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791581116; x=1792185916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOFw7EBDtEEegIcDVyyhj9teTCiXNTrYQF7gDTs01rI=;
        b=ktohFhslSR+DmIgXgBd2nUJhJngV/w5DDmedFhW8uDnuZM2689KB4ez9BVYdwOcHR7
         i5EX7dxL4ojPB7kVQmYEwfKIvOPF3henb2uNVgLGWgcysxuyBPxxmOw0MfJKO5U32X4b
         Zc4qPJvYYhqPzBiiLJJpAPwqayMTcs3BFJ+aEyf2Oju1XYbLxj436OjYyTTwHc3Xg2gS
         o7K+zIMxWBM0SnWZ0trYT0OJcjEuII0KNPZ92JJkyeV2PLfRL/SRr4KkKntg7vCyzqGr
         bCXZh77QoXhtfusOHPk3nt7/L7EtmJ0I9qXUfWKfkvL/WOETnt4+zZFFCizwoCZIoj8V
         MvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581116; x=1792185916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOFw7EBDtEEegIcDVyyhj9teTCiXNTrYQF7gDTs01rI=;
        b=Ffeq7++o2pfB8h1taJ8fI8ooVAf7oDS8qMvjVWQSCNnDzT6wlsgOSwzQUQMMIwCpA6
         at2GONDZBIvmtkK0JMK+DhRJNS3+v9wFDcJSqO2Di8BVTMn6MWMc0OjfbNEr2+5jmSlU
         Y8ys6eaeJOope/nBLlSogNvxEaXvVsKaTUQHj/ZSSqSca58tGIgymUPDAxC9cs+6j3WA
         L6KJuoNNbJ66vueyYQwGVARFCDquC9//0P6iUn1b9CVPyykTebWrIt73v9ILu808x+Ie
         zQbFLxgkM6JaTYrTSihfcsGi1iET9k8ZefjExD3maF6iWscN0erbn9FRkTqo5DyuHCUB
         O90g==
X-Forwarded-Encrypted: i=1; AKwUvBxaqHqojWKo7Nu1ZpeUXJm+rJZTWSTFE6Is9VG0g7KvzsSdY5LVfJ99yIa3iEA2jmc2R17s/Wc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHccVS2rCUTSqdmLoBd4yU8VF0M61DyuDBZIh6sIEObV98gqjG
	tEwR7Q5SbLguLrn/wdTFGNdrEE2UILA/iIRl6KzIXqJFOrruwXshsvbR
X-Gm-Gg: AYBFou1eUWhBPdZ8/Y4WQCdWnjx3+u+fItPXMVYj5oP7UY4P8DEaaN5z8tdNhj3kt7G
	/D7PTbtZOwP5ys4t5iOJ5buBMSUQMVAKUiQjDOhBSPzkXN4EFFaiQPUcJ1pVISH79ccxRSyaXsd
	Z6Y8TnXq/5/eUi9c4PsYXEKc6iAiDgypx0p1yRmHLgE31zUcWG+dZSc9rhDE89zqtkNIyfmNSvu
	rHBK5zDU6mpjfL8qmdAM1Ag4F/dxbJ7khcNcasjcmsPDGuVomtzrAluLDCD23PgPynWkQg4lPJJ
	Vt0ZoqhWXT8oKaXwZZqgaZmIcwoWpG954M0UKXQwOCTl/mMyVoCQ1jUSHPHYQaEF2PuAXjnkKoZ
	Zj8hGZWl6fK5kdwHd7m8i3DOnCNns0ZdtgZ5Uwl5kfMzcMDEJeV0PED7TtbWTlctz8J8mSmRj2L
	mH/46uy0xWXFp3SMeQS4wrgnnyj8AtFQkKSBaOHkAjjeieQCbgAhjfUP1ZAl7AsGzJMbDUHvkLS
	3yfIQw8AXYSSh8G8J5fGkn8pxVwPskhbb2LQzh1YJ94yyL9GSw=
X-Received: by 2002:a17:906:f59f:b0:c2e:4b90:3c56 with SMTP id a640c23a62f3a-c31a9fcf0c2mr331531266b.13.1791581115807;
        Fri, 09 Oct 2026 14:25:15 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae42sm149079966b.15.2026.10.09.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:25:15 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] alpha: do not clear remote MMU contexts in migrate_flush_tlb_page()
Date: Fri,  9 Oct 2026 23:19:35 +0200
Message-ID: <20261009212501.971158-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009212501.971158-1-linmag7@gmail.com>
References: <20261009212501.971158-1-linmag7@gmail.com>
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
Message-ID: <20261008195608.965266-3-linmag7@gmail.com>
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

