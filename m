Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708122;
	b=QBmjrccMBCw+UZvl8hooIuf0KfMhSEysvjSYhYoJfDnWEkDHQjTIm1lolAIHaj2sX8ze
	 1s2UDreVYqMTAZhjU++z8iTrsNm1DAs3VAHq4IQsY/V8J7EzJh3ez9LCXN3fQIXvsuvmK
	 fxqP/doV83G58SEgjWT7TNwh7CtBmafNpZrYmI/rYoFvvT+bSgwpN8TSg713TydNDif+5
	 WYZ6Jf44t68qomvHlqANt8k26hQXqUtDrLRCu72Tm9bzUw1YZdYYc3nV6vgfOlH/Ly8BR
	 2RVre/FQrjx3kqzWjvenySJSg3CrAwEr4RuVeBYA4Hh3vK1POWppn6D+bUrJE8bsktA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708122;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Az0jRdxGz47BjnODeEnvbQw0VUqHNe+289mTFIQtnuI=;
	b=DH9hcFZ+7i9nywOr8spLoueAVGrMSvVZGBtFTyqVz2di6NLMCztAxC9C+EsFN+xAgfL1
	 tey3EMuP6ALaybE1e7h1Ytg6dWRE81Fl9waMspOct7bf0a3xDm1CrxOcYhjpUXHUigaqP
	 RCPkWbZSXAPqw6lBDSmJRtrySf7rNfg98Iy4IOxJQpmh9fWLaMrFeIFfwOTKpLFwB8adq
	 6UkH2pz52eNtyAdXtvbL5bKlGRl5GVvvtauKZ4MFHZZqOPgt3YgdKBTDAaBu5jvrXT9+/
	 tKE1vNyhkMVRnk5cMZE1VdGeNZ6ikuWsPO3BXlqGOIYhUuIBSTOTJ9F4vwp1/k5muFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ULK2gffl;
	arc=none smtp.remote-ip=95.215.58.129
Received: from mta1.migadu.com (out-129.mta1.migadu.com [95.215.58.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE79606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE79606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ULK2gffl
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=81K8WfCO8nBk12qXo8VaeOOQz2j4c2B//fXEZS73Xuk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708119; v=1; x=1796312919;
 b=ULK2gfflzlP3r23liZ8MPyd+t2AH2aJwLZifOfqXFToamgSvKseujjaNbQQN3oO4tNEgg5yT
 TNCT7qBGzArcpjaDTDJiYsN50lPEdHrk68PDC6HGXw3d/YJDEsL0PUY3CGvhlhKeK27M4QGHcaA
 jBRI8bo5EVUuWMXodb8F50T8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6afe1e7c39021c6c;
	Thu, 26 Nov 2026 15:48:39 +0000
X-Mizu-Trace-ID: 6afe1e7c39021c6c
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH 6.18.y 4/4] bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
Date: Thu, 26 Nov 2026 15:47:13 +0000
Message-ID: <20261126154714.169698-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126154714.169698-1-leon.hwang@linux.dev>
References: <20261126154714.169698-1-leon.hwang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 7a0855e73757ee9cf25ba635a1c735018ecba742 ]

The BPF_MOV64_PERCPU_REG insn requires JIT to emit native code to for
'dst_reg = src_reg + <percpu_base_off>'.

However, the interpreter ignores the 'off' at its ALU64_MOV_X label.
The 'off' indicates the insn is BPF_MOV64_PERCPU_REG insn. Then, when
the interpreter loads memory from the register, it will hit a page
fault.

[    2.545572] BUG: unable to handle page fault for address: ffffffffacaaf034
[    2.546485] #PF: supervisor read access in kernel mode
[    2.547167] #PF: error_code(0x0000) - not-present page
[    2.547850] PGD 134e63067 P4D 134e63067 PUD 134e64063 PMD 10021c063 PTE 800ffffeca550062
[    2.548912] Oops: Oops: 0000 [#1] SMP PTI

Set jit_required as true in order to disallow interpreter fallback in
core.c::__bpf_prog_select_runtime(), if any BPF_ADDR_PERCPU insn is
patched to the prog.

BTW, rename the helper bpf_map_supports_cpu_flags() to
bpf_map_is_percpu_map().

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260715141122.15783-4-leon.hwang@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
[edit]
  Add bpf_map_is_percpu_map() directly because 6.18.y lacks
  bpf_map_supports_cpu_flags().

  Apply the map lookup and bpf_get_smp_processor_id() changes to
  do_misc_fixups() in kernel/bpf/verifier.c.

  Omit the current-task helper hunk because 6.18.y lacks the verifier
  inlining introduced by commit
  eaedea154eb9 ("bpf, x86: inline bpf_get_current_task() for x86_64").
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 13 +++++++++++++
 kernel/bpf/verifier.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb78a97085f6..eab8a4953621 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3765,4 +3765,17 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
+{
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ed5d9e0db39..865d474407f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23209,6 +23209,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					return -EFAULT;
 				}
 
+				if (bpf_map_is_percpu_map(map_ptr->map_type))
+					prog->jit_required = true;
+
 				new_prog = bpf_patch_insn_data(env, i + delta,
 							       insn_buf, cnt);
 				if (!new_prog)
@@ -23313,6 +23316,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
+			prog->jit_required = true;
 			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
-- 
2.55.0

