Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EE33D505;
	Tue,  1 Sep 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268306; cv=none; b=URFTz62PaoW0DJPkHWVIGcMw94f1HSVpahML2UUxSjI+pmeh3f+veFq2driY8ujsvSTBR3VLHmFO3vSb4ilFh6JwKv73ZeoCZ5eRw2qq1ExbVvnbCXaWZrIxmsuIIuKAMOg/dDWrUCLJiamcdH07Q7WG8iP/cnKtgpWXZj2VaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268306; c=relaxed/simple;
	bh=+Xn2xSVt6Y4AR6W37ZftozKIkqPqngS2wWhVGJC6Ces=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aY6+3wpzBqkRxSyBB1mZIZSG5FBLhMJWRJRcv/V909vkTmztPQ64tjKLQ5bR5lSHo77xS+qHNxhX1fJGOK/oxGu7Gy9mIIfp1WrL7ecJFd6uSRRJA3c4keEbYOXYsSbSbsX9xTkTq9oU02rZBF3eWgXEIwhQs9RRRT9Gpltsts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYLLPrOX; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYLLPrOX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788268298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ATJH11bxVHIskQuz+vJepFf7SUqYuoorOP97hyHmC+g=;
	b=CYLLPrOXEmpGrCPe1+wFisykuMsRd3FgbiyqStxUxxYsUbAIWqkiyenOxxeiFYpjacChZD+lSA7s3iAcboZU8v5JxFRc0iBThChn5eCRK8I9LqhzE7A+RUV7bD4p+ofewS/aqUv37is4tnw8QC2JN/NN2nwc1zXE9GAFpJD3aEE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XA8SKn1_1788268294;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XA8SKn1_1788268294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 21:11:37 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf, riscv: Make arena support depend on ZACAS
Date: Tue,  1 Sep 2026 21:11:32 +0800
Message-ID: <20260901131132.16241-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena range tree allocates its nodes with kmalloc_nolock() since
commit f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
kmalloc_nolock() requires slab caches with cmpxchg128 support
(__CMPXCHG_DOUBLE); on riscv cmpxchg128 is provided by the ZACAS
extension. On systems without ZACAS every arena map creation fails
with a misleading -ENOMEM.

Report the missing support instead: make bpf_jit_supports_arena()
return system_has_cmpxchg128(), so arena map creation fails with
-EOPNOTSUPP on systems without ZACAS. This matches how arena
BPF_CMPXCHG instructions are already gated on ZACAS in
bpf_jit_supports_insn().

Fixes: f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
This issue was reported by sashiko-bot:
https://sashiko.dev/#/patchset/20260901120013.16104-1-cp0613@linux.alibaba.com?part=1

Question for reviewers: should the arena selftests gate on ZACAS,
e.g. probing it via riscv_hwprobe() (RISCV_ISA_EXT_ZACAS) and
SKIPping cleanly on systems without the extension?

 arch/riscv/net/bpf_jit_comp64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 74efe4b138d2..0061c1d4ed98 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2128,7 +2128,11 @@ bool bpf_jit_supports_ptr_xchg(void)
 
 bool bpf_jit_supports_arena(void)
 {
-	return true;
+	/*
+	 * The arena range tree uses kmalloc_nolock(), which needs
+	 * cmpxchg128, provided by ZACAS on riscv.
+	 */
+	return system_has_cmpxchg128();
 }
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
-- 
2.50.1

