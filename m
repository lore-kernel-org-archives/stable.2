Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F9390615
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242966; cv=none; b=kPKSc9lriCh7FPGKfHsQiKt10YB36O2F2pnCWpYG9Mn9eonIuNGtfp/inB64Su53SSaOpuR5Yu0oYRBlrJ7Ibqp+Kcfqi+jFsXbTAVlXl5RaWz+LUKmpXsHQ2XVfkbCjI2en7x0/Q5bmPLJHAFxiECXjfIdraW/7Bt3otAuFMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242966; c=relaxed/simple;
	bh=R7KzqYlc77nKhM8iwHaTEz7kvU3XedYSYPxeFsqKjG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sB27vRuR11yEh0xOJ/J2uQqz4Mfe/CE0t87IaSLmsuO0yRsbw7I3beUpLKAss1aaZZPI9el3cm1VthSl966bA1qRVGv4xg4tkRSN2+AQWx4gGiRcWMj68Jt+/yYm3CRFthhDgNP5Zi4emG1GmKXZmb0mkOvOKkQoRMGtMHfNe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYZ1HeFn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYZ1HeFn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so22532465e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242961; x=1789847761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GysJsE8mePqJNLXM00GRKUzojaP5JqBAXeEHJ7TcA4=;
        b=LYZ1HeFnQQbHEJmYgIoQL6I6Ij8AtBqqUmDy5Lzegm7AlriG6HY7BXTmlA0+rscQau
         diy7iBQcPviLQcyF4nF8pl0a0tBgwwMNlJgiDYaWseto31jdA3LIqUYAvn+QzgNlZNFp
         acGBSWg8Vl5bZkC8DYDUNZCIfrvbuCYDbMmpVA2xpuADYW8G9pbLp+IJtzYevmm/MAW8
         ns2WWumWOAH2jI+CfvXIz1hoYDatSmUCNElDQAK81cbYg+QbOZwW6T/nNxj0v08fYWvV
         723zPql4/XZfmXXdM6jjU+X19pVTpmUsD9dIhnP3W4a+NQfdFyAip5/4VTdChX+BtPru
         xLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242961; x=1789847761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GysJsE8mePqJNLXM00GRKUzojaP5JqBAXeEHJ7TcA4=;
        b=KFyD1ntRCkdH0WVmc2CllJs4LgEnT9K0m7gCQhIeNf1Klr9TbG40+xxNgpWlMSFeek
         DPKc1QuJLn/USHEnKAmBiGD1rBwkUouJXdj8TSVLYDNnmhQFumqIYd6k/XAEPZjFHyT1
         JCcBbfte6+8VZu8VDxttbFnuAHylvb8Am9s5/kCREoyAlEoxo9xuSuBW3/HcF93Zirpi
         kF0AGsAcEfgxsair5ZPETEEdvaf6YukmViRlykf2UbSRUQCVMeqxDH3iD1GgZSHHnLwK
         9IOYCEeiuUqpEaVzGD9DI1+G49XSXbAIE9s97pySxsTJ+wJbb58prGoucih/CHAPB01c
         vgdA==
X-Forwarded-Encrypted: i=1; AKwUvBy7oQSUl3dfYbx5G/yksvIsl5yC5GCU60IGicbJz/nU9FxlFaZCCdf45rn4jSP/Yl5ShT2x5s8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+uoWPYA6ChbxqfUkzydCxlKAU8GzQO8m7OvjfQ2ZLz1KrThmd
	GGlhvixyuRvki1TO7QYzLAZbOKWQ1jQ+j2Fja8No2hUNLGh50ct0/Adm
X-Gm-Gg: AYBFou0+zdHPxo0uJ5z33uHqBSwrNFL7CQIRL/I/2fluTw9DK/bRKA6Z3mjhUFpTsFK
	+N2sDR3VvmKk4xeKIXR7FSbec4cz9qHsHbTHzk3OubqsUlV9oFKO7jhhxYfn1b2p3F63sGsg+Cq
	ywm6eR91YyccaW/gni5ooT84UaHsMzziO3FqxYqRm0cBR0VIXc4+iAjdGQ9tNhPsGhjn747x4Bt
	Dw6Im3pOxQolnl5GfxVJL9FjacGAz8d+x1skPcYcZUJZWLFqsMwWxd/lUXgX0oV5mbpAfpMINqF
	/P+GWYIBeawIsLs51KUmHvalXP+jgmOBygTt97ci/t29nFwBSDeDtbQMXy3fqk/EO5WJo1hu9/T
	/wGMNMYskxRz3wB/EzDhhCdJFugEbZUoORx8/AOSREkxW1KeEJ7wXwrCQu5YXoJPTOzJzE8Z1uS
	A5rleKJq1p/HfUJb29GCtf0cOd0aKF62GZEgjSIT2Mrhyul/pPRyg/K3XqswIqEiCVi+Ry3FKsR
	WaHzrOY18UzhmaMB95W4NlWNSfh0WIpBbDkt7jRjJRLLVW92O4aGB+I3rwgIZwe1rgFJB2Dr7M6
	DKvkPkjpsq5hN6Gbpoa8j4Sp7B8231aEEcqBcvarmFRMAlBkcCsDN4ttJig1ZCYZOHVpu+UsgW9
	e1wqQTs0=
X-Received: by 2002:a05:600c:3b18:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49e61646becmr99559535e9.0.1789242960978;
        Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
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
Subject: [PATCH 2/4] ARM: cacheinfo: count external caches in early_cache_level()
Date: Sat, 12 Sep 2026 21:55:50 +0200
Message-Id: <20260912195552.76673-3-kmehltretter@gmail.com>
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

early_cache_level() counts only caches described by CLIDR. An external
PL310 is absent from CLIDR, and its arm,pl310-cache compatible is not
accepted by init_of_cache_level(), so early allocation falls back to
an incomplete count. init_cache_level() later adds the DT-described
L2, forcing reallocation on the secondary CPU with interrupts disabled.
This defeats early allocation on PREEMPT_RT.

Use init_cache_level() for early sizing too, so the initial allocation
includes external caches described by the device tree.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Without this patch, patch 4 keeps the warning on QEMU vexpress-a9
(4 Cortex-A9, PL310): the early size is 2 leaves, init_cache_level()
wants 3, and init_level_allocate_ci() reallocates on the secondary
CPU. With it the warning is gone and the cache sysfs tree is unchanged
(L1 data, L1 instruction, L2 unified shared by all CPUs).

 arch/arm/kernel/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 860eeb03cfe5..31591c947254 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -111,13 +111,6 @@ static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 	return 0;
 }
 
-int early_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	return detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
-}
-
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int level, leaves;
@@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+int early_cache_level(unsigned int cpu)
+{
+	return init_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
-- 
2.53.0

