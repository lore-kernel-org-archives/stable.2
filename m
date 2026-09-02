Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15C38735A;
	Wed,  2 Sep 2026 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329704; cv=none; b=ecRY2I4cd2pVEbnWXAj5/lirr1eCMf0pPNeMCvbaedEgGNLArRp4iHOOSWD6FnxaJS6wCu4ukCruzX2lyD5fBnFbTK4mfD5TIiNx7rifKkMw5MbNAL59CzkSrgbUWp+GwoB06XJINo0EWQC3hoW23aR1ulJ2P16nRuZ80JPJIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329704; c=relaxed/simple;
	bh=C7854izJEPuClmkkFQw4ChvrdMcmYJXkgMNGP1gB2/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUtSc37oMxz1pBNAgOlULCCTg94sSVDiuv5I+hrad/k3yI0rN/OGrXPyh5qUl+ACgbAWTHYmbjrXveQDV27H9Cy2BBpnEgKuvEukvktzGRi8rl9fQwC9qsJoCmjMkx8yqdi0QiU7bz1d8yHvw1U+Q296HTGGdkMf/GM3Gouao3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NBamitoT; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NBamitoT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788329697; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UL0E16epy44PNt8yQn/2+BDsOBNXFG2a9/inh0OfbBo=;
	b=NBamitoT3fEpHtGF+XbnQCFf3UlkdZ5VLSiIpct76hVGuwnBfip+dXwmEfkjTq1iWt2lyS+K73XbsXGdGWTaf9dM/bBoxDINqLiVQeCIf4CCb/75CCMlXORaWW4b9lkgLoqdqlN9hW1rvLcczpEQnTbyF6w60ukYcjs45tQQ1NU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XABSX4-_1788329692;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XABSX4-_1788329692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 14:14:56 +0800
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
Subject: [PATCH bpf v2] bpf, riscv: Make arena support depend on ZACAS
Date: Wed,  2 Sep 2026 14:14:51 +0800
Message-ID: <20260902061451.1416-1-cp0613@linux.alibaba.com>
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
return system_has_cmpxchg128() where it is defined, so arena map
creation fails with -EOPNOTSUPP on systems without ZACAS. The macro
is only defined when both CONFIG_RISCV_ISA_ZACAS and
CONFIG_TOOLCHAIN_HAS_ZACAS are enabled, so guard it with #ifdef the
same way mm/slab.h consumes it, and reject arena otherwise. This
matches how arena BPF_CMPXCHG instructions are already gated on ZACAS
in bpf_jit_supports_insn().

Fixes: f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
Changes since v1:
- Guard system_has_cmpxchg128() with #ifdef instead of calling it
  unconditionally: the macro is only defined when both
  CONFIG_RISCV_ISA_ZACAS and CONFIG_TOOLCHAIN_HAS_ZACAS are enabled
  (as reported by sashiko-bot), so v1 broke the build when either
  was disabled. This mirrors how mm/slab.h consumes the macro.

Why #ifdef rather than rv_ext_enabled(ZACAS)? The predicates differ
exactly in the configurations that matter:

  scenario (ISA_ZACAS/TOOLCHAIN/hw)  v1           rv_ext_enabled  #ifdef
  ISA=n or TOOLCHAIN=n               build fails  rejects         rejects
  ISA=y TOOLCHAIN=n hw has ZACAS     build fails  accepts, then   rejects
                                                  -ENOMEM again
  ISA=y TOOLCHAIN=y hw has ZACAS     exact        exact           exact

rv_ext_enabled(ZACAS) does not check CONFIG_TOOLCHAIN_HAS_ZACAS, but
slab's cmpxchg128 - and thus kmalloc_nolock() - does require it, so
on an old toolchain with ZACAS hardware it would accept arena maps
and bring back the very -ENOMEM failure this patch fixes. The #ifdef
form builds in every configuration and matches exactly the
kmalloc_nolock() availability gate in mm/slab.h.

This issue was reported by sashiko-bot:
https://sashiko.dev/#/patchset/20260901120013.16104-1-cp0613@linux.alibaba.com?part=1

Question for reviewers: should the arena selftests gate on ZACAS,
e.g. probing it via riscv_hwprobe() (RISCV_ISA_EXT_ZACAS) and
SKIPping cleanly on systems without the extension?

 arch/riscv/net/bpf_jit_comp64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 74efe4b138d2..151031e97a24 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2128,7 +2128,15 @@ bool bpf_jit_supports_ptr_xchg(void)
 
 bool bpf_jit_supports_arena(void)
 {
-	return true;
+	/*
+	 * The arena range tree uses kmalloc_nolock(), which needs
+	 * cmpxchg128, provided by ZACAS on riscv.
+	 */
+#ifdef system_has_cmpxchg128
+	return system_has_cmpxchg128();
+#else
+	return false;
+#endif
 }
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
-- 
2.50.1

