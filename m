Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA9324A05D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698100; cv=none; b=iCFDmdyH2craRFlh0n433LJgavy8pLQbMU3TRX4wf/46a5LT76V9Jzi3sJMZROvPO51Z1Z7XxbAH+PW8y47Z+i44/GwTbTNz4hWHuudc0gdN/VxwobSHBkHXhYmamNWz852aCeSxZf6jFlIGJwcE6pRXiA7FaSgTDn+SJR6HkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698100; c=relaxed/simple;
	bh=YjsAhYXUodz7nc4xjdfUxVayCu7T92r33C55MOfrInU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIy8zl0l164FWy4YNhD4k+Z+wQ2VU29cXlOUjJWXzL8jKMyGka5po9iyQlZXD1coxoFgQXGXH/iE783rJYVcfe+5abJixfzZr8Hxiwaj52cFeQXt6uNlJuDrXlLughBYJZ6c4JiPT9J0JFGF6qSrhs53L0f5Q0d28PSq8zF4E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkpWpsan; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkpWpsan"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49230a567a9so10110825e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781698097; x=1782302897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0jOMZCcA1H7BGnP4Ncr7NnGD7quAU2khlteKx4MJN0=;
        b=FkpWpsantnKAFhI2b+a2A2WgmVrui8g4xddO1qZi0zQpARTHfc7fqytYWT1+VK43TV
         N4Ud0ch2bExcsdANmWtGHdpoaC0O5YeEQ1agzSkSP0GifIU1XSUwJZaHg5VGqIEDVK2c
         8HkuzcbTIBfJRKvCYgQVKocpfTxHrwq1OFshK43TVP4VpdRTDr0SIoDqpxfV0DDUO5in
         Omrjfp2Wus+n/rU5g+ROolPnATccDXMQtgk6wTwRu75bY/F5//932PuXYosGOey42PAG
         zjli1oFed2E//4kTDdeCBaukRVhljUwHnqlxkuW6TgDhohhkclNsICH1QMzcU+sY4/61
         X92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698097; x=1782302897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0jOMZCcA1H7BGnP4Ncr7NnGD7quAU2khlteKx4MJN0=;
        b=NYxtgRuHjs0OuOLuRIYCeRcV+t8XEOc5tYKr1/fE3QZ+O9ciVCy4Tc78naJs9bbW+f
         35dG93acCljjbOINHDQax+xunGymys8woZG92rgoZeSpiOuemKnYaEADZ+ymnJLqqpH5
         dDFc87Faftr+TfJBfZX/DSQSCu6ulK392x9x5jraXsHoD4ljT+Z8aYVDVCfYQ+WOy6hI
         jj5cA+TG1KnSA9vrWuqP6haJN8UKFLSctA5W9P1wIBbVAgB9j8IjpNK0qfmuQX95d++x
         w4efsaQwV1nvWMcsHoYQAIyqLQEZj4OWT1fkyQWFagar3GIAmIIVqSl/AqfRgjdRGJcy
         dCPA==
X-Forwarded-Encrypted: i=1; AFNElJ9z51p2vfsUslEHXErV8DICfDR5wNr0p8s2LhM95U+GyiI8PXewFdGfyLa5LxVJKcXnNzqHHFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrG1TN1df0K7ixwEUa7EE+BcpvLTWMF5nq1KVpSLHqnx6Sw0so
	RolnJ2RpEYYNUtRx4LgZlBYDZzK25fAKY54o2o1/0rchYcUz26lSBRM=
X-Gm-Gg: Acq92OGwb9fEuaxr4OE4K7/ZpqnDnvnXcGSclyAvJmR+QXr9dP8Zwaas4c8WSVbA0CG
	UKhVpkKtnm0wRVa9+vFkP8HRNZnG2B+iKrtROH58qkTjGL3L9196hY0JNu7LYWfEPLgMogub7Qs
	3VbJbX3c8HVbXvcgXITRgKds9glN6ITbUFDI9DzzGjRwouIg1lnf6y2kk9mjDKO3feRckKswE1p
	AE49/aH54i9Xnse8PCu49iXZcYRj6dkdiy6ZuFxp8CYaMwDQqcwex2+hBqlyuicaBQ/qIl/ynRk
	GF4Kc1BZz0GWEmZK8PnwZaWy0a4hYJuLlgDgYvVt9SYd7SgGsnWX1Is5DUIsOwcmtdkIiwF6hGw
	AaicsHw4vnN5MthHeide8uI2ksIHLfJzGd32QiFhttmerPz84pAe/S9x20+5Tf58Lkk/U
X-Received: by 2002:a05:600c:4fcb:b0:492:3214:cbe6 with SMTP id 5b1f17b1804b1-4923341f59dmr55904685e9.23.1781698096974;
        Wed, 17 Jun 2026 05:08:16 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm153691355e9.6.2026.06.17.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:08:16 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Wed, 17 Jun 2026 12:08:15 +0000
Message-ID: <20260617120815.3910671-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..7e30dddc7721 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7532,6 +7532,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.47.3

