Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707023;
	b=qvr8diHzSqk++8f/e+CltZ6oIcRREN4WU3dRqj0YibRP2Mfojh5gceHaQuWpJQsn9GrN
	 lbSYDxmpmDmRAZpIu1YyfI9adHIIcW7/7S6m3Jv1JoLwcTLOdFzWDLkBR8AMR21S+FEoH
	 d7O6WrNart60dTAOhhALh+v9uk1togB5gNJjTStbCDav7Pj3m+MzIuROXkYoqWyiYd8vg
	 J0tj237ZLXfnVd2qtl67bdZ0eit26JMeBPTBO79Rrc/BQ3e+Yr0iZPut+rekYfr9adrzP
	 Z9Y2hV2riFxB+gZjr9+drO+Cz4l6ixRSkhHO52xQm9TWCaf6KmhSzgKSLcNbugwNeAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707023;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pV9LYyS5no18P8wMmqxsbdDstEfk9Dko+WUNHMb01zA=;
	b=NYMpJkQb5vCDRfsjn41F2nolntx5PRHiXyOmi+FaDSUbLMcVWdQW0MzRyDWaV5zCQRiE
	 a0475zMocm1e43e9FRa4mnng8cyp8w0gcAJA6Q+1Ljz5YNCdCwoXd61i26+xnjcnOsrlJ
	 mUiJ9lvmNpEZrp5CjNwdd0F2cikK/8BtoelFv2vO6lU3wJAJPCekdgfkoi+K8a9PdFKGL
	 ur+Gtsur81fb1HFeqsdshsdIWpBfvh1A219X2Uqyg34STGBGJxMNaVmSZ7ErRd3o7MWnu
	 82TNvTYbL0MJWhjjd23iXneWRqKebrff6SKv+AJqXWsbggKTVgo4aVgh4AonMlLYpSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vZMbusTh;
	arc=none smtp.remote-ip=95.215.58.187
Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F8606A332
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D66F8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vZMbusTh
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gdH/AC9PXhJxwEqukW6dICGaO7oMXhC4tWIb1lClyBM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707020; v=1; x=1796311820;
 b=vZMbusThgDYefRVSqoYrKZ5CReCIhnwRmPSKqcSN8RYPDVlu9ONi1q0WZ1DEY1PKfi184eM0
 B8a3Yt4bjt6XR/3TXipWy+u9MJxKn0ojqAI232h6/C55vCl6NfTUqC6l+2Mom1yXxH5rl3cje05
 YNbLC6s5kUND9Fdo0fjbGlTk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b52ee4e27b36d103;
	Thu, 26 Nov 2026 15:30:20 +0000
X-Mizu-Trace-ID: b52ee4e27b36d103
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	KaFai Wan <kafai.wan@linux.dev>,
	Leon Hwang <leon.hwang@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH linux-6.12.y 2/4] bpf: Reject programs with inlined helpers if JIT is not available
Date: Thu, 26 Nov 2026 15:30:00 +0000
Message-ID: <20261126153002.162337-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
References: <20261126153002.162337-1-leon.hwang@linux.dev>
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit f1c27922576edccb99d0257827d09bd05c0304a6 ]

When an architecture (such as LoongArch, ARM64, and RISC-V) implements
bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
call offset (insn->imm) in bpf_do_misc_fixups(). This is because the
helper is expected to be inlined by the JIT compiler later. Therefore,
insn->imm remains as the raw helper enum ID.

However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
if JIT compilation fails dynamically (e.g., due to OOM), the program
falls back to the BPF interpreter.

When the interpreter executes (__bpf_call_base + insn->imm) with the
unpatched raw ID, it jumps into an invalid address space, triggering
an instruction alignment fault or a kernel panic.

Although these helpers have valid C implementations in the kernel, the
omission of offset rewriting makes runtime interpreter fallback fatal.

Fix this by setting 'prog->jit_required = 1' when helper call rewriting
is skipped for JIT inlining. This ensures that such programs are safely
rejected if JIT is not available, preventing the runtime kernel panic.

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[edit]
  Apply the bpf_do_misc_fixups() change from kernel/bpf/fixups.c to
  do_misc_fixups() in kernel/bpf/verifier.c.
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9fe21072c0a..492355f69d26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21414,8 +21414,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		/* Skip inlining the helper call if the JIT does it. */
-		if (bpf_jit_inlines_helper_call(insn->imm))
+		if (bpf_jit_inlines_helper_call(insn->imm)) {
+			prog->jit_required = 1;
 			goto next_insn;
+		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
-- 
2.55.0

