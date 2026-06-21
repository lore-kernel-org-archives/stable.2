Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAF23EA94
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782069809; cv=none; b=R8lIXZC5JzFpcxM6sSbreZmS2OWA0DZa2OjXrskf9bcG46j2ONbu275XAHcYbWHatVFCMhth9VjPduTCxoxQ51O+RCMU9iXnaYuDBhRPuk4WnqNCgQUtxok4ZjYUNvpvR6gPEzPBmTbu9ZsxHsL9m000KmZ6NHHNt9gcbvptpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782069809; c=relaxed/simple;
	bh=uA04HhTsQ8dsNxyfMLdub768NjxZBn1yPSaIJCrMcAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dz5OIzIJoah32EIIsEF8JUUvJqtdwItWyITWXXY2dlUcw1FdQXQzXb4JiOYCKiE72ynXTwEPaEQaIvRHSvHVRXbyYINOn+cHWd9wY8+HuYBP6Cz72gsPajy5CGHkoZNtYPklhKsFiX+UQHxYq4+SpBZ4HA1bEIwZh55eQUhHYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJv7qvYz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJv7qvYz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso41800225e9.0
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782069806; x=1782674606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=be9MjW25f2njwerBgXRPJ/M+aGJqyGySllhx7C6vl6k=;
        b=XJv7qvYz6E2DTU5WEROSjG1ev5A803giayoMq/Huhaak+H95LS+snqA6HtYCmOrSNb
         AGBOGw56OYtF0Itppy1liNkJGFOQczdvJemgOnWwkXSB1iJeIu+vh0e5WlYo/Z0WRldO
         48PjIm8M0nkc/5i0S41vqLdRULYOHOOT3Lw6V2BfnIzE8H3foGYlQlEcjMWrxfMs6LXq
         V/2xx4g/6eHkxrbYwspIkTfVfmsBEHKGOnoldf/bARpmxH9F0Ccok9aDxHrlGaBpf+8x
         bnAHhh3jOqD/651YXAH8flOcqWhy5JZXZ/fGYwMq5PmkQrftaX/f/z+bPIOH1qZFS6uB
         VIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782069806; x=1782674606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be9MjW25f2njwerBgXRPJ/M+aGJqyGySllhx7C6vl6k=;
        b=KHy0D+wwPjk9yFQUfXjgk53gj8PFUC7PSG4+aU9y3d0866NkB83Y60DeLethKzvwCH
         1hu+cozV1vht/UhySLLL258gY4CQYgEQw1uStyhGxRnUvs6MmGtCLCnf3Jai444TEY10
         jw0bDeqUVFOowPgf6n5qSCi3kTx5DwbOa89bA6+sJppT2mQwxmOtzUPfh1vugMQMPF84
         RoALyFScjkRPLY9zLaaIeVqO7tPG3zOgzc55gkdDUI1BMJgq5D0kFvCwZpdebBtmeO36
         VzEQRjYZduXeOugz70g1BJA442OxHF7UHknZUvlvUU7o/MVrzQzSa236iRNZ2zRg0G36
         IsVA==
X-Forwarded-Encrypted: i=1; AFNElJ+jYZ+W0Z8GisTphv/h15ed+llAxMRWCN4mR7oRouE1rYXMlkG8we0BngDOHGnJ7STL/tx2JDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVI8yF/MxK2R6zrvmIbY8j7emqsWnwp+yMr+YOuTYxBHnGmgrF
	8v7JZvTRrrBKg1einj6JEMfkX4dVzeM8ykbAeyRznSuia0DHpP8uOic=
X-Gm-Gg: AfdE7clE4IQgNk/LX9WyCfSq7M7pHYl163/gaSy/xWQaWtCLRqkU0esM9ORXpYaKmzY
	HJwLoLGmHfPXEynFCo01OjRYkbpDiGbE4QqDIqO+bd2oOdi2/lH3TKeZSTGdm8PyZX4UlAu7Fkh
	qQg6zDf/nra72TrmM8sbU2uGjF2ur1pgFmTauO+kuOibRPu2iHk+PCTw99Mw5B7Aidgo5ZC4fck
	RcszAEcbPPs5qPGJpXOE4vTpCZ38NbDYUtSyHk3qOvU2QaMQXCKyIM2qSlkrmWKn26XqiIto00B
	Bg8Jesv+X5EF2KefKYyKI3LMeWIIeC9hEst7AE1bCu0JyX4lSc4SP/D/mOE2FBhE1JCRDpLou+x
	pt+sG5eZ/FQstEe58jXf3mzZBZ7pMbCbPHEZfMSihgUPvhoWpKS+ctTtVBA==
X-Received: by 2002:a05:600c:6a06:b0:490:b0bf:7606 with SMTP id 5b1f17b1804b1-49240a5bfafmr115465675e9.16.1782069806451;
        Sun, 21 Jun 2026 12:23:26 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e3esm18569656f8f.8.2026.06.21.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 12:23:25 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] profiling: prevent stale prof_cpu_mask access on init failure
Date: Sun, 21 Jun 2026 19:23:24 +0000
Message-ID: <20260621192324.2062795-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When profiling is enabled at runtime via /sys/kernel/profiling,
profile_setup() sets prof_on and profile_init() allocates prof_cpu_mask
and attempts to allocate prof_buffer. If all prof_buffer allocations
fail, the error path frees prof_cpu_mask but leaves prof_on set.

Since profile_tick() runs from timer interrupt context and checks
cpumask_available(prof_cpu_mask) without first checking prof_on, it can
dereference the freed cpumask between the free and the next reboot.

Clear prof_on before freeing prof_cpu_mask so the profiling state remains
consistent on allocation failure. Also gate the cpumask access in
profile_tick() on prof_on to prevent accessing stale state during the
teardown window.

Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtime")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/profile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 984f819b701c9..a166ad9512714 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -123,6 +123,7 @@ int __ref profile_init(void)
 	if (prof_buffer)
 		return 0;
 
+	prof_on = 0;
 	free_cpumask_var(prof_cpu_mask);
 	return -ENOMEM;
 }
@@ -325,7 +326,7 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
+	if (!user_mode(regs) && prof_on && cpumask_available(prof_cpu_mask) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
-- 
2.47.3

