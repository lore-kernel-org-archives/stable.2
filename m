Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822C40E8FA
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979688; cv=none; b=R56FDm5fGh+oW4arLf2Eeunabzt9qoKpXzJdSGtZk/9lJHTiDyK4DiG2KE2+E3399pLshr5sNPy0Jl7uI8pk4ONFchkb1XexLqM3Xhpx68YPztcGV4FLPiifrFrLeboOs8Nz1Oxd7e3GSi9w7yxOHXHJpBqKsEmzuSvbH33iiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979688; c=relaxed/simple;
	bh=0Z+e/OdRh7vWb/zrJFf8bLcehs/oqWvr693tmYK+cXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ub1U2J0Kr3tvFhuzchZ2eI3JQzNh5GnQnWxWzySMIn5t2hr2EMW9FpZ0OpTjMwPHoUVnGan6qtkIJiP7B52pBPp6pd9uvrr8GTvDVmFGoFe93pAmJkDaa620jxbVGkxFAEh3oNM06YFIPgXIwO6zBURipf1h5cwKPoFcwn5PKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqxxAowG; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqxxAowG"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so5941855e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782979685; x=1783584485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0s7OKBGnkDY1ld78GA7O9n4AGhFwWRGm1kjn5yI6YM=;
        b=JqxxAowG5SiZYTuRGunUA5CUUxL26njktxnAjNPgEIP19Ftycazh9BQhYry3+PJgZM
         KtA6VIWRVsSP7gvMSQ7Xs2Z9D2rMmz2rwc8N5CBxZ/JAOvrLxTU0lrEUOgMFa7VlPfMJ
         m1USVD0EToW04jCFCkGZaXxsLmKCm686a1YFfwGlqrOpaf2rOVVVPaPQI2PH9e2gaHFs
         77iDZWEx+pn3eE06utDiYHTTrkmgqkyBCyceQn7jNRfF8d9Ly7i79Zuup73kRGqS0Bbk
         Dt4NY7/dn/0qgD9Ljs5Ohq6YZUlFuNe0mShzH13ygUpujMK+3f7htweHemlzCoPgrgbX
         Tc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979685; x=1783584485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0s7OKBGnkDY1ld78GA7O9n4AGhFwWRGm1kjn5yI6YM=;
        b=F2tK0VcPCunxgwCFBIAo/7PSlDGXJA/2kk29dMDGENhzicVqGRvS2E7FVSgtlsEwkN
         JIPho/9hvtwdl8lo/reKyE3CakDeb6qes4jklR/+SzCorurlXO1z+vmrHZlM62bPfUC1
         +fSfbDc4jbNCdD6t40IfxLLsqM+JR4Yv72PZDpFj6OwtrrDtXvM/H20phlxjUJhMaoch
         FR9vweUOeE7LrV+CFtuBRqYgozEQsd2mGsrhD9ijj8eNux+uOTwwwEelxhTL4OZwvj7g
         lYKJLM4kcLDqHuFDg0/7HzFGQi78wuvbm4LSVYnglM37GXf5zyRwASwNMgSkhCk/1BhO
         lS/g==
X-Gm-Message-State: AOJu0YxBomzD2h1VxFGqhG0z3cbZ1ogk2t+5T0Pi7xUSWo82MmFecTZx
	Rnmjsk/MOv8aTWDaQqRu1LEu+fPlSCibDOWaPkJq+gsRbMssNnT3bTBDPqe7L8+lCqDDioLG1qP
	NurSvFUp3A37F
X-Gm-Gg: AfdE7clftSDXnZPlg9/r9fpUgUxfbbWgqChmCfxwSeMX6myAtC9JTw6cw8MGFH3Zi79
	yDksnU2Q6BxwrPIpAF+EAALuvcCExTzhZSA3FLICDQaFBrhJUYkt9sZPxYrSbOBnUBPMljDU93T
	6f9e5BrWkTICLONZAp/YL0OcsJgSLxAieViUngWZKfgbiu41tGojgOTkLA9cWttUEljjEZp2mJj
	8LmP4SKL+UcBu/lPrFMadSjMEIKFFvuVmokH9AXTNOzUjfBHLNbq59ELUaXcBhc3Kln+QCs61in
	+bcSAXyZDyaSJOQpZXtDmczUyXaXczz1KSfHwQZ+cIgYtkbOd9App4Xm9RqMv6xQVeDvd4u9w97
	7rpPOJaxobJa1zhOUA5J7cgQBun0FIaJlPqvzNtihCCm9Gy4lN6uMA5KNL0EPbcXeVa+vvRHBq2
	PQmdNiJEVPy/Ht5Z248KA/yeW6oZx7aXaIk341VyY=
X-Received: by 2002:a05:600c:8b75:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-493c2b3ce9fmr70074755e9.2.1782979685560;
        Thu, 02 Jul 2026 01:08:05 -0700 (PDT)
Received: from localhost (27-53-177-85.adsl.fetnet.net. [27.53.177.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe84efefsm2148988fac.2.2026.07.02.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:08:03 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 6.12 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Thu,  2 Jul 2026 16:07:56 +0800
Message-ID: <20260702080757.98071-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.

aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
compute a 19-bit signed byte offset for a conditional branch,
but unlike its siblings aarch64_insn_gen_branch_imm() and
aarch64_insn_gen_comp_branch_imm(), it does not check whether
label_imm_common() returned its out-of-range sentinel (range)
before feeding the value to aarch64_insn_encode_immediate().

aarch64_insn_encode_immediate() unconditionally masks the value
with the 19-bit field mask, so an offset that was rejected by
label_imm_common() gets silently truncated. With the sentinel
value SZ_1M, the resulting field ends up with bit 18 (the sign
bit of the 19-bit signed displacement) set, and the CPU decodes
it as a ~1 MiB *backward* branch, producing an incorrectly
targeted B.cond instruction. For code-gen locations like the
emit_bpf_tail_call() this function is the only barrier between
an overflowing displacement and a silently miscompiled branch.

Fix it by returning AARCH64_BREAK_FAULT when the offset is out
of range, so callers see a loud failure instead of a silently
misencoded branch. validate_code() scans the generated image
for any AARCH64_BREAK_FAULT and then lets the JIT fail.

Fixes: 345e0d35ecdd ("arm64: introduce aarch64_insn_gen_cond_branch_imm()")
Fixes: c94ae4f7c5ec ("arm64: insn: remove BUG_ON from codegen")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260415121403.639619-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Confirmed that after this patch is applied, BPF selftests on aarch64
still passes on 6.18[1] and 6.12[2].

1: https://github.com/kernel-patches/linux-stable/actions/runs/28509125434/job/84504843132
2: https://github.com/kernel-patches/linux-stable/actions/runs/28572297925/job/84712643104
---
 arch/arm64/lib/insn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 4e298baddc2e..e9e9a70ac155 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -338,6 +338,8 @@ u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 	long offset;
 
 	offset = label_imm_common(pc, addr, SZ_1M);
+	if (offset >= SZ_1M)
+		return AARCH64_BREAK_FAULT;
 
 	insn = aarch64_insn_get_bcond_value();
 
-- 
2.54.0

