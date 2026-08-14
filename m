Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A687364925
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744996; cv=none; b=jE5yF+E84CnBZRo2k7vW0G3tt8l+dcDwMPYjiNTZt4VrokxV2Z3Ur9MLRo1K/Ww0BXd6Pl3AJbPgvJ7y2atLC7M53f2xyrbIEhWEh0DE22HED63DGxD6jh2bSyE7vgViGjgfxCOc6t0PitFoNVDxxUkM5Fv+9S0TZxUMTAgUt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744996; c=relaxed/simple;
	bh=A0pwEcUmFnhmuPem67TBlaGWjijsG5HTlcmdOV+G4qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFlZC29x7j7Lna+hChVw6t56boLfDnnl1HTM46pNV0hAPPr7UBD7KCV8LLk/DP+M/cR0FMcnuc7bWzK9ou+pDl206xDrtPvIOSuAX+aEoC3VXKX1UdpazWLhwXaAao7utJXvW5c6sl8sgZWQp4U5emy3cXbO2z7nBw76ZGRD1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZR1urit; arc=none smtp.client-ip=95.215.58.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZR1urit"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A0pwEcUmFnhmuPem67TBlaGWjijsG5HTlcmdOV+G4qc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786744992; v=1; x=1787349792;
 b=jZR1urituhqXzOatHUBDlIrBw2HckGoArqLBI+MOI2Vy6OpkayYFw/QjR6jiHM1CgiBW12jW
 cFaSVRUzVAVVlzWf10aaWMo/FjLWzewfKUpmu31Xioy32CLUx6iSoota/lwa1E5uyX2CJTNO1Qe
 Py+ggLDBiyX+1nkvSD3D7MIs=
X-Envelope-To: stable@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 05e17389428761e9;
	Fri, 14 Aug 2026 22:03:12 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf, x86: Fix per-CPU address resolution into an extended register
Date: Fri, 14 Aug 2026 15:02:53 -0700
Message-ID: <20260814220254.3797467-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814220254.3797467-1-vineet.gupta@linux.dev>
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The destination of the per-CPU address MOV is encoded in ModRM.reg,
which is extended by REX.R, but the REX prefix is built with
add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
this instruction addresses memory as disp32 with no base, so the bit
has no effect at all and the high register bit is simply lost.

Every is_ereg() destination therefore resolves to the wrong register,
picking whichever one shares the low three bits:

  R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI

With BPF_REG_5, whose reg2hex is 0, the emitted

  65 49 03 04 25 <off>	add %gs:<off>,%rax

adds the per-CPU offset to RAX rather than R8. The destination keeps
the unadjusted address and RAX is clobbered, so the program goes on to
dereference a pointer that was never made per-CPU:

  BUG: unable to handle page fault for address: 0000607e386a8894
  RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
  Call Trace:
   __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
   __flush_smp_call_function_queue+0x1e9/0xc80
  Kernel panic - not syncing: Fatal exception in interrupt

R5 is the mildest of the four, aliasing a scratch register and faulting
at the store. R7 aliases RBP and would corrupt the frame pointer, R8
and R9 alias the argument registers.

Use add_2mod() so the register goes through REX.R, matching how
add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
hardcodes 0x4c for the same instruction with R9. Encodings for the
non-extended registers are unchanged.

Problem showed up when trying to resurrect BPF_GCC CI (selftests built
with BPF_GCC).

This has gone unnoticed because clang reloads the address into R1
before each per-CPU access, so the destination is never an extended
register. GCC keeps several per-CPU addresses live at once, and
test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
the address of a .percpu variable ends up in R5.

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Cc: stable@vger.kernel.org
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d920772af7d5..1a9fb530adc3 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1935,7 +1935,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				EMIT_mov(dst_reg, src_reg);
 #ifdef CONFIG_SMP
 				/* add <dst>, gs:[<off>] */
-				EMIT2(0x65, add_1mod(0x48, dst_reg));
+				EMIT2(0x65, add_2mod(0x48, 0, dst_reg));
 				EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
 				EMIT((u32)(unsigned long)&this_cpu_off, 4);
 #endif
-- 
2.53.0-Meta

