Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AC315D29
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802827; cv=none; b=iooUUxL3Q2k+YV4Th1dcNlgSjJ8BIew8Q7IQBrdaJE5vRsfc1Xdiz5/ANSfS2n+TuHS1rWRgKjXRvLOkvVgoXEk2nvikXjFcablqd5r/Fvr1ec3Bq7QUZgnQb3AD8vM65dOb/sbJraM/Iv1ydru3PGgjvfMLmrr8DdbaJU/rQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802827; c=relaxed/simple;
	bh=DPDyCEihiFM/u44UmNIjDt/nyBXG1bmV9KcLzfatXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhvpsev7ZlL4oRS+b0aUEFPH+hIBwD6JH2bo71jVCqnmmWDaqtHEnzt+P9+iAee5MtqT52f0ScWK9r5P6YqQmZoS/jLXN+bACusolo2oByfccQYugeOknwHuhq8oym3gIQQKX/3k/2Bla01Tyn6x08ke7ZkgqFwhN3S3xAEN/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg5HR/LF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg5HR/LF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1320597f8f.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802822; x=1784407622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmoAV8UWF1T8XHPG609ZOYG8y3KrBiLQM4o1W4fAjFw=;
        b=Sg5HR/LF7CkmUmlqNI1QzZpwG80A9yvp+FPnrNgIbzgj32MMVZSNfePQS5Ugl10N8b
         312DbglvDX198chcY7QD2S+ZRzNZ29htbZADQ+R816KqNmXLVSZm0VRCta5vhz0c8lUb
         L0dMAF1vTvJzupoa6APkXzbPxlfy+tvVOrr3nkyoImth6FPWoVajOZSd565i5sZScNdf
         C/pS3d0cxbSWfC76/7aFmTYNPrUL2g/9/z9MY7LovksUoSpmv97W1Tr84IthgEIzTo56
         c+8y/yby95tw84tDgrCR0+9bPxOj5mgKYF9pxoAs8gi2x4HfJo1Ufo1B6Y2BHp4MVBR8
         RluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802822; x=1784407622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmoAV8UWF1T8XHPG609ZOYG8y3KrBiLQM4o1W4fAjFw=;
        b=MdBity2B2ywkaWJm4YqyijBp4l4FZcq3q5egxbwbHHcJODmA48SoTnfb1w/BZU2ZGL
         ca7sj6n7JQGYsp2ANNS3pAoRNuX0XhDYhuATt8dAv/bquqf8NYmnlAxvExQaunNw/z4+
         yW6Jl+khEGKpF+mI1LvTnExrfliLee8C4Ar3w4lO0Sv+xd8ztrlb6Z/nva9bmibbyP6A
         i/oQIuTx3SrDE5iMxyIPMKDMfLfvV3RrxklEzZG3zFVKdLFdN5mtOMDSi44p1ftEMzd8
         ZKzurRTptluj3wcdo2mpqHvYveV6wyvf7DyHDmE4TeCIGi2gyCUPRydCy0kYKKWB+jtU
         g6OA==
X-Forwarded-Encrypted: i=1; AHgh+RqurWC9csMPGK40etMhGnIfc1vnEuqvofLEpwfKqDst0K2zJvFiXMiZLav/8Ikm7BCkDx2KeCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUR3hQJBsr0+GLOm8+WQdHniDO3fijt4oJpeUYxTtOH5JJzKYf
	eQRHNH93udqmFcp2kXvFRQoxxfGEQVf6ybVIz8j1DTeFKZG4zLfh9SY=
X-Gm-Gg: AfdE7ckqJYfXV24n1cjE7PiyfbB9tphErif0SqNxmrfGy9amukw0nHBKhRNNQtF7AV3
	baGeyAvonMCf0PcZseAJlAIUs0BLDJQjQEN26U9acqUQHNJcXcByrXv+zZanqR7V3Dx3FA6pk6H
	nTEWVLsppCQ7AW6tPGmCKf79uVNjQ4x20kLxjUqQYRCQdxXCgJY2Kff4+hj2lUR7KGSueHtDZl/
	J0ubvooPg0yDun3HbYWy8VkRBw3AQckmt4tnJAlt8I0eL50lzrga8uqJ/OiwY0t077YNOwMHlLq
	ihlklvt7SDFCwTc9drsXXGk4VzeCpXbxQnzo5qwOGKJO36HR53+EhZJbUfAI4/XUZ5i1ATHB4UQ
	S5WDBqtHKm4cMhVZ78GefBEESmBBW5Dd46UG2ksYsCJrE9bx5NjzYQJTu2Q==
X-Received: by 2002:a05:6000:4905:b0:474:bbbb:bf17 with SMTP id ffacd0b85a97d-47f2da2552fmr4147321f8f.0.1783802822129;
        Sat, 11 Jul 2026 13:47:02 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm69561366f8f.34.2026.07.11.13.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:47:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maheshb@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net v2] net: reduce XMIT_RECURSION_LIMIT under KASAN
Date: Sat, 11 Jul 2026 20:47:00 +0000
Message-ID: <20260711204700.1760374-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711134732.1385563-1-tristmd@gmail.com>
References: <20260711134732.1385563-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Virtual network devices (ipvlan, macvlan, bonding) can enter legitimate
transmit recursion when combined with packet forwarding configurations
such as IPVS NAT.  The existing XMIT_RECURSION_LIMIT (8) in
__dev_queue_xmit() detects and breaks these loops, but the allowed
depth is too high for KASAN-instrumented kernels: each recursion level
consumes significantly more stack due to KASAN inline instrumentation,
and the cumulative usage overflows the kernel stack before the limit
fires.

On x86_64, CONFIG_KASAN doubles THREAD_SIZE from 16KB to 32KB
(KASAN_STACK_ORDER=1), but KASAN per-access checks inflate individual
function frames by roughly 2-3x.  For an ipvlan L3 + IPVS NAT routing
loop, objdump measurements on a non-KASAN kernel show ~1.4KB of stack
consumed per recursion level (across 17 functions from __dev_queue_xmit
through the full IP output path and back).  At KASAN ~2.3x inflation
factor that becomes ~3.3KB per level.  Nine levels -- reached before the
current limit fires -- total ~30KB plus the initial call chain, which
exceeds the 32KB KASAN stack.  The overflow hits the VMAP_STACK guard
page and causes a non-recoverable kernel panic (BUG: stack guard page
was hit).

On non-KASAN kernels the same loop is safely caught by the existing
limit: the "Dead loop on virtual device" message fires and the packet
is dropped without any stack overflow.

Reduce XMIT_RECURSION_LIMIT to 3 when CONFIG_KASAN is enabled.  This
keeps the recursion counter well within the 32KB KASAN stack budget
while preserving the established limit of 8 for production kernels.

The recursion path triggering this is:

  __dev_queue_xmit -> dev_hard_start_xmit -> ipvlan_start_xmit
  -> ipvlan_queue_xmit -> ipvlan_process_outbound -> ip_local_out
  -> nf_hook (IPVS) -> ip_vs_in_hook -> ip_vs_nat_xmit -> ip_output
  -> ip_finish_output2 -> neigh_resolve_output -> __dev_queue_xmit

Tested:
  - KASAN kernel (6.8.12 x86_64): panic before fix, "Dead loop"
    drop after fix.
  - Non-KASAN kernel (6.8.12 x86_64): "Dead loop" drop both before
    and after fix (no behavior change for production kernels).

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: Switch from per-driver recursion guard in ipvlan_core.c to reducing
    the global XMIT_RECURSION_LIMIT under CONFIG_KASAN, as suggested
    by Eric Dumazet.

 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b54..bdcb61d352afb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3640,7 +3640,11 @@ struct page_pool_bh {
 };
 DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
 
+#ifdef CONFIG_KASAN
+#define XMIT_RECURSION_LIMIT	3
+#else
 #define XMIT_RECURSION_LIMIT	8
+#endif
 
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
-- 
2.47.3

