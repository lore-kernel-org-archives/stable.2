Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459648167F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668280; cv=none; b=EGeKGVuYJIVcZvPBOa9bkJIkJ/hLYv1RIxpo/NWhgCX352aWFA4/OmlT+vOJU6Re6S+4TQ0JHKdBvDUPVAJT+5UA9lp0fEMm3t52Y737ilou92lg5v2wbfcz3PAlvN6CDfxjN7Woeid8//1oUYUXt66zk58YbGqbiumMfHsgUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668280; c=relaxed/simple;
	bh=uJuxdJ11xpqb/uIADP/AG6+GBI/UuL6qFemRTiS16iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRAHcN4T5GsOnzITxthp3t8Ht5u3fFpcVZ15wWJLb4x82PeUzdHcoot8TGZx7umOqZwfB2cRpdem+GGgSqnXv74asBWai/qVuVt3qNiQKKcr3EAR358a3XwGFKcYyYF6KWbxAYfiOjJVfVW4auQLzJFIkfV9fWBnVY7IerPYL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB9835aB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB9835aB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84eb992a881so3722401b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787668278; x=1788273078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JM50/AL438LfjlZf20xvx0/7DwGjtkqXtbjso4Komcc=;
        b=HB9835aBczau3cxv3uv4fn5KPKSZwME/WGl+14BGpHrZWN0uOEUQvY4hBlgZwQNNI1
         VOtVzvunAliZ4UGSbX9LMOX138JmsklVE8BtuPHCQtUtHJxQAACtiGhiwgJzeiQtSSDM
         7Cg3CaxqXAlFbrmcuArZRzNNQSpDw84T6vYQMFZL/OXmpWoVNwotmB4IeOFxz3XSelLG
         e70+hRse8K6JYCEOcxEgcq1NZ49dP67+kjIzDNHcqUn+cWmcr9EhkWjDC0EVZghxZGmi
         MjvAj5UbW8gO2UB/kdwQ+zgJEvvudW4CO2Tf/rCi9edSDVYS6l5IB5Nn+F2tsKBrc5ea
         /yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787668278; x=1788273078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JM50/AL438LfjlZf20xvx0/7DwGjtkqXtbjso4Komcc=;
        b=s3U052TvqJL7vaJ3n54BipHrk/hfwns3H4klpP1AfC7QCPAgfgg7qZCgUJdSjEC6DA
         gYp+CC45OGKT90Ai1O+E6WEQg34YoCoA8dWPIy2VZih0VfM6H+Q3P+eXZfqwfn1YLlT2
         u6pXgyFvyRSdF8hoFVwHuS384rZX6EfGTSmwGPTJV0pFZsqBB8U1n2d+CYUpmjcNUL9h
         L7J+MoySSjh66tO6HHdamuV/PGHlnmtIpiJ7d8o4hZ7vJfO1pMNz9/OLEVYli2W3gaUz
         4/YkYdjyk5PfiAcQGiONsRLRHLHECmS7l/WZCtxtFJfx6Rv8FUUP38rEMDoS9XnSOMM8
         UKkQ==
X-Gm-Message-State: AFuF++nEoGI4ZsiKbOVSZTCgWGzOhBfPvn7o9JlvroDvHslpbj/X71Kp
	Su1ftWiUCRFWmSDuboiG1oOVJpBIOYmCdxUEYjO0VQ6UOfv8vuKYjrlA6Rd4rQ==
X-Gm-Gg: AR+sD11NFvtewUNolRNlnySzsyVJ/R+4xKC2t2TYFfuTpPEHyEqkmRM00M1bvdeLH78
	ejxZgCN4w4O+dCOf6ZX9L0Zy14+OcJxNUJHzfn2hYU2MPg7Ima6uOwILOXPYXi02sCS0ZpqMw2m
	9G1TxsaLqqlzYr+o9RfU9fuQG3d9rcmaDwYNIH0hecZb30oQ0PQq7noyRtHN2NIR8Ba/LMUXqtI
	hU+lS6CLKjzlWbKzerqRMgbLrHSKbQnOh+mJJnFFNHkVEbki7jpEQa5IMdwjM7V6QBhGdTwIkcU
	GCJ+JyetZr39Otr2HuFjvKBxGdbO7XIIFfDTWJzd+ml8okXJf3h/vU7bDyaYHR6bN0oHug7tYXz
	l+wLaUEyBXRYumLpRJsugyIEcwENmm1P0sWJzklzf0HlrRyZyKOavffZFwTM5MMRkc3abulCkVf
	fG/aLbez8MpS/XHZ/IMVQGaQNCMxYAVrLEAgi4lMlp1TeKYvdKEr6k7WOZJrw3kNToAeKZ1mQXd
	uzFrJ4nxLlNSg/vJUyxPyaNPHUTWnEBTdFcr7aaccdJ
X-Received: by 2002:a05:6a00:10c4:b0:851:c1d2:c48d with SMTP id d2e1a72fcca58-8523c8722b1mr12961226b3a.8.1787668277445;
        Tue, 25 Aug 2026 07:31:17 -0700 (PDT)
Received: from localhost.localdomain ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-853213fe8b9sm209994b3a.58.2026.08.25.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:31:16 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	Taegu Ha <hataegu0826@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 7.1.y] bpf: reject overlarge global subprog argument sizes
Date: Tue, 25 Aug 2026 23:24:32 +0900
Message-ID: <20260825142432.2347543-1-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026082526-remindful-aids-773b@gregkh>
References: <2026082526-remindful-aids-773b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit de36adca634634c205a9eb8b56a28175ab7abf5f ]

Global subprogram argument checking derives generic pointer sizes from BTF
and passes the resolved size to check_mem_reg() as a u32. The access-size
validation path then uses a signed int, and stack pointers negate the value
before calling check_helper_mem_access().

This creates a wrap when BTF describes a pointee size larger than S32_MAX.
For example, a global subprogram argument of type:

  int (*p)[0x3fffffff]

has a BTF-resolved pointee size of 0xfffffffc bytes. At a call site the
caller can pass a pointer to a 4-byte stack slot at fp-4. The current
PTR_TO_STACK path computes:

  size = -(int)mem_size

so 0xfffffffc becomes -4 as a signed int and the negation validates only
a 4-byte stack range. That range is covered by the caller's stack slot,
so the call is accepted.

The callee is then verified independently with R1 as PTR_TO_MEM and
mem_size 0xfffffffc. A small instruction such as:

  r0 = *(u32 *)(r1 + 4)

is accepted as being inside that BTF-described memory region. At run time,
however, the actual argument value is still fp-4, so r1 + 4 addresses fp+0,
outside the 4-byte object that the caller provided.

Reject sizes that cannot be represented by the verifier's signed
access-size API before the stack-specific negation. Add a verifier
regression test for the oversized BTF argument.

[ taegu: Backport to 7.1.y: check_mem_reg() still takes a register number
  and reg_arg_name() is not available. Emit the equivalent R%d diagnostic
  using regno. The patched v7.1.10 kernel builds and the targeted
  verifier_global_subprogs/anon_user_mem_huge_size_invalid selftest passes
  after booting the kernel on x86_64 under QEMU. ]

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20260528062155.3988156-1-hataegu0826@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                           |  6 ++++++
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bad71f..c4173bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7119,6 +7119,12 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	if (bpf_register_is_null(reg))
 		return 0;
 
+	if (mem_size > S32_MAX) {
+		verbose(env, "R%d memory size %u is too large\n",
+			regno, mem_size);
+		return -EACCES;
+	}
+
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff..0ff8f85 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
 	return subprog_user_anon_mem(&t);
 }
 
+__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
+{
+	return p ? (*p)[1] : 0;
+}
+
+SEC("?tracepoint")
+__failure __log_level(2)
+__msg("R1 memory size 4294967292 is too large")
+int anon_user_mem_huge_size_invalid(void *ctx)
+{
+	int (*p)[0x3fffffff];
+	int tiny = 42;
+
+	p = (void *)&tiny;
+	return subprog_user_anon_mem_huge(p) + tiny;
+}
+
 __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
 {
 	return (*p1) * (*p2); /* good, no need for NULL checks */
-- 
2.43.0

