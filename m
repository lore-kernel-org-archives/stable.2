Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4402394780
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390278; cv=none; b=c7sSi9x09Plr/pSvC+JHZ46Afhw/HJE5t07S0GRIUeZcJcSyQ4xJK8eJtDoMFFkDpbyo8yadtM464rA8SVscNhYJSW1jBE/VsdAZpjbV1Kkhh7rFWiMeNZ2UYcCOmWwILCqjuWXIUQW2samkXcMBDHol379mm4ZLW9UM1kcyXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390278; c=relaxed/simple;
	bh=J4R5rmhjWUaPceWThwvhl99inysUNFmvFJzEGwsihBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITW8WoU/nZsW9IO0f3jBpUrGKMbzbH3DaYzHW35eFQoDsKCe9OgSZx0Wf00S1zxwfi5nuw2mei3MEZv7FRJ7TPNniP4q071qT8UIa6rMsDW5yYXBGq7daVue3pBdNh1T2gGpENV9Z8o+3ggTqrjlSNKnwgNc2ZZAYjzYZuBGPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4Uyfkmk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4Uyfkmk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so3574843a12.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390275; x=1786995075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZlUEzCrTPRBX1FvFK7zfpZyojdDsTGC8+EAFkSxizE=;
        b=r4UyfkmkpeviHfgEFHUfNTWhetVu+v/sKMmFmz3KAV3z64ouQ2II9KUZALKMVcK4zL
         WEbz9ecdkRMDrbhbKIqdzF9cUKFu/iZuztTkMfwx0fogzJ8t0ln8yUYAr8dzcpqfAok1
         ZU7I8U1XXM3nNPN/PmCg8I9VTgm/dj0JiLVrI4DtMM4P8avyiEn8uwUJ2m9G5MaIBEB6
         OhiqdsKrqXUJvz7XjYydzL9YeUgTnKaEPLLPKbadloK/GXDc4mn/PGgEJYsMxyrJQ7AE
         9ylFBv0uG7bqC6DyO1cU+UoDO9Yy5jHkZoLUO2qlfIhtOj0ddIMnaAX1KUEQNhrCpmuK
         a9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390275; x=1786995075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZlUEzCrTPRBX1FvFK7zfpZyojdDsTGC8+EAFkSxizE=;
        b=rngGfQdwZD4VA6TFvNPBXuqTWwKKd6bKDN0rN3V3RynmOFZ6yxYr/mp0E4+UeuTDeJ
         erYwN9bW4Mb0FoGfoxjv1+nDhG0bc+2ApaVaIP1oXWD5A4D50cri5pEe9POH0m5h7Vfg
         NQJsbMwbYLTZYG1/epWYD9wmJag4PI2innsT0mi8kGkGLpK5zXvo3b6WKvoJIqjYC/sA
         vQnfKA7jiAUgoj7Qp6E/xNs67gNDEz+Wx12MGAoPgT6uyUr9mhFQHxHIlyul3uui0bfC
         XlmkmcYL6HMXkzxtpZHiQ5nHOMa7vspvTEjJ8J3NbXHN2j7k+xaKXI1mqrG6+1sMMb1O
         2a/w==
X-Gm-Message-State: AOJu0Yyx5lHjXWCbelMlEQhLiqWkZViTz9F6GOHlhBGIkxUPzHHg54dA
	EcUrcwvuBCev0v0RJFLsireKfBcd8LcNnE8NfoFkWbYskX86Qj9DssTu
X-Gm-Gg: AR+sD12SBs5lZ/Z3LGGHN9YuVwN9m5K5b5GHcE0O6nkecjr+bjxjIiMnR+lhFutDBVv
	MU9+2TxxyLnln8HtLzeZt7t0oWl5sAwaInc4lCIk1XWwkiuqNBRhvIAdh6SRMTpglZMg9foPFQY
	SVAaS59ijm4i6pqgiDtbFJmfYwUlFjkL22jRqA8B7P49sDgmwCq7M/wCizlKJn5POVSpWk3hQ1S
	jgiR3gPRuVt326L4aszJ5erZsbXORv36mTuX2dmbTpct3WRgcyeOT5c1nFRSMoMd7LkdTF7JPJu
	1RcUu283vDqUQTGmFcyqmdqFkJvXD+R1WMwM456ChU0JfbuelKyx2Snu+VlPSOOh5ZOnyp4r47R
	21IcG4cY1Ok5MjPsP8K1F4qIMlwI6xZzPmXVJTBt3X3DVTSuOby6SW+wZhwgK2lcT1gNeKcaUph
	SvzFXv0SjM+PMhnbfNvPIzhiQLkn5X9HhR1JzT4pCf+1wk9eaOqSefQqAprXzgml3RGQNIj4Vj7
	F6WaFXPUlVNuyjd0hFSr0Z1/1DkTK0=
X-Received: by 2002:a05:6402:44c3:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a355d641a0mr2010591a12.4.1786390274815;
        Mon, 10 Aug 2026 12:31:14 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:14 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 7/7] alpha: invalidate the local context in flush_icache_user_page()
Date: Mon, 10 Aug 2026 21:24:51 +0200
Message-ID: <20260810193055.3286239-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_icache_user_page() has the same caller-CPU omission that the
previous patch fixed in flush_tlb_mm(): when the target mm is not the
calling CPU's active_mm nothing happens locally, and smp_call_function()
handles only the other CPUs, so this CPU may later reuse the old ASN
together with the translations it still holds.

This matters here in particular because the function exists for
operating on another process's mappings: the comment above it describes
setting breakpoints through ptrace, and access_remote_vm() reaches it
through copy_to_user_page(). The calling CPU is therefore often running
something other than the target mm.

As in flush_tlb_mm(), the uniprocessor implementation in
asm/cacheflush.h already has the missing case.

No imb() is needed, here or in ipi_flush_icache_page().  Alpha's
user-space I-cache flush works by allocating a new ASN rather than by
invalidating the I-cache: the entries stay, but they are tagged with the
old ASN and can no longer match. An imb() is only required when the ASN
space wraps and numbers are reused, and __get_new_mm_context() already
does one in that case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 988e397b0b8a..e21bc3920bec 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -758,6 +758,9 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_icache_page, mm, 1);
-- 
2.53.0

