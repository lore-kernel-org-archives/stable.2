Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064A40D567
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782086427; cv=none; b=R9QUELUADQeFXg1vGLgJt5ovsH6Oi8S9GV+brYxR0XZW82y+PJGSYl8EF+CUUs4n0sbuHdx5tMN6NkQuNOZpUO6f4KymcdUNdXz1TOSDgw327LzATFNxDbOo7aOQAv+sK1esBMHiDVg571NZ2Opohkz1lz/a5uguGgkKQEc1lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782086427; c=relaxed/simple;
	bh=RafX8TT5bZTWoZ3W9cX4Z3rY2+hgEEPhtXRpvHzEAEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSm1/cREV9PMmTC4Dsuje0zD/p86AVLJEo7DaFuwN8m3Qkgse6bJWplpJkOY39TLnVhuhv4cSVYwbJXkAJl3mpVQX1MqXMcvXojBcIOPK8T1FAh/+l9MgIhE/G2NyWbvi7vjZH7EoZcG/Vm5m8Lu0Bw8tWOzArxeaR8sQJtP5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1JNDIn+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1JNDIn+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49222b6e871so31865425e9.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782086425; x=1782691225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygRePlbWsEiPyMMNSNaFyLnVgGkv0rXZbOHCOYSq+X8=;
        b=Y1JNDIn+1fpI99FzWgGqnhEnOAJtrM5zkSezuSSMQSC26XD1MLqDPMLHPkmI4rrp23
         ifcmEY7cENNUwyET/HmrNFfurljqTsMlN+98j3ZK3aFAY0EJR0pWJ9ViLiEDce4J6nZb
         pmYl2fWRPcceZxxuKYNnhbbmuK5lKFgNp1VznhO1j6fv3KMGho11+FM5w3EyAuz/xB+d
         gRkiNtajNg4q9PF8BmeTbka8gys6BPBudAfKkeFOHxZKp8jlexd3X0COQrz9+g+E0aw7
         t+k75LOyn7rO/yOt+Tn8yWmoSNAiDqMP+HTx9XgmwDsr6SPr1LEFnJst80ScGfFn2fsk
         ZoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782086425; x=1782691225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygRePlbWsEiPyMMNSNaFyLnVgGkv0rXZbOHCOYSq+X8=;
        b=l04SXAztSv1ICREyFsLtT1T4NMl5/vAv3manfs05U4Djnb9JUUJieOl4WIAhb1kiuN
         soC4B6XLhpQ+X5CJrjmcJ+bnpZ+5Yj9iAl6tEuCnV2gH5WbmtZ3jjmC95eX1+gpvOOMg
         OjL6Gh2wk8PHALQrSmNb4Ll1jUS6Ma+NjnCAFbRW6qZ1Cby6yeU0ps6OWxt5dVqVkS6M
         unOjnneRFI1FKm+hBtIWa1dewfZ2A/qr43xI6G+JJVK2nALTX6zgs8PMfTzV2875Ono2
         cSsVKjd5Q+foU2S3eQQG6zLqejsq7r4CiNzvarx7B0aZDtH/agwbAlpcFREbjCeMnCng
         DDog==
X-Forwarded-Encrypted: i=1; AFNElJ9YEP/rxG9ROr7oke3bklxlNzeH0Lo6ZrMVNXv+GHBwkKOEe5mvWnYPXeTpApA06U0Ea04OF/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZnVQXnFJiEyd6McXwJMROWJ5y8xRdaZLxfBD/L9FdcVi0g48
	KI5a6CqIWFltXrEuvb9caiBQ88LVt2KiWhUgLwFSZrOy88Ocr+WaEZg=
X-Gm-Gg: AfdE7ckUWgOVxdAhCm7tIg0mjdaPqT+Y2BU6KYPz9rz6pQeMa8PIkdgeVy+FV9SJRiQ
	NbOXuXiuqWzU+wunmaTv54mfQT3OfMVQSPLEI7dyMaZuQlmBWs/qz8+2433DfBlggPtTKK7YwEj
	n6CTdYEvJVJy3q6SUU/SVF6Tkt8vJUIOPw6RPrYRPa1FLNkCWgcMhup7KPrqyfy+71aBu57VZCa
	+chsOId5cN7Zl1xHdM3pG+bwRMEJPYBdPbGbAKDynAYw3gYvYKvwoIN3WcliFy/QkQv6hN2BjlB
	Y3IP8Fczl9DPJJmXmOdcn5bGdJuWmevU3ImmadOB+o17pQUCjkhZFUiI/msYPKpqpZ5YpJS1zQ+
	fPg3KlQQ/02bzdYLsxA+wNnPB5annb5R5FHjDieRKNRdprO8RzAhrHTEX7g==
X-Received: by 2002:a05:600c:4514:b0:492:3dce:5725 with SMTP id 5b1f17b1804b1-49242581f22mr176954925e9.27.1782086424561;
        Sun, 21 Jun 2026 17:00:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fbbdsm187983235e9.12.2026.06.21.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 17:00:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Ingo Molnar <mingo@elte.hu>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
Date: Mon, 22 Jun 2026 00:00:22 +0000
Message-ID: <20260622000022.3375262-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621192324.2062795-1-tristmd@gmail.com>
References: <20260621192324.2062795-1-tristmd@gmail.com>
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
then attempts to allocate prof_buffer. If all prof_buffer allocations
fail, the error path frees prof_cpu_mask but leaves prof_on set.

Since profile_tick() runs from timer interrupt context and checks
cpumask_available(prof_cpu_mask), it can access the freed cpumask
between the free and the next reboot.

Remove the free_cpumask_var() call from the error path. The cpumask
allocation already succeeded and is small; keeping it on this rare
failure path is harmless.

Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtime")
Cc: stable@vger.kernel.org
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Remove the free_cpumask_var() call instead of adding a prof_on
  guard in profile_tick(), which still raced with the free (Tetsuo Handa)
 kernel/profile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 984f819b701c9..93180f9d21467 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -123,7 +123,6 @@ int __ref profile_init(void)
 	if (prof_buffer)
 		return 0;
 
-	free_cpumask_var(prof_cpu_mask);
 	return -ENOMEM;
 }
 
-- 
2.47.3

