Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828537DAA3
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739593; cv=none; b=Cjz4mHSTxQ6P9cbXdTaJv08Ug0ctFZnd53jM8bpdXn100RwReNEZT9qOFrftjhCsZBN/9y+XGS+diZgyDRGkI7YgvGPvnHKiRGn7l4QdTQyhsa83NIeK7xUSjrmw3FNKhJ/nWyNbexsXKQiuLYBplZ/vztgQ5Bs3HYJVorxFI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739593; c=relaxed/simple;
	bh=aVIj/tHTVkfMeQkCJAXJDwxvYrsSqdIQR1AB1XuOdqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACsxP4kRU2OMNKfcd66qsy5L3diYy72UqZtQyY67TrBlF41zMfOPWHG7/SuNsiaaHbGQU4To+Kr6ev2TiZGSGp4CfMDi1OcHUXUXwurumtNaCM56BJQ1X50wH6EE1JoIDu6bsj7eBEDRoMYwvJ02CPOrZbWSi5dCiyDfw1P61kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3lZ9Ka1; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3lZ9Ka1"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aVIj/tHTVkfMeQkCJAXJDwxvYrsSqdIQR1AB1XuOdqg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786739588; v=1; x=1787344388;
 b=q3lZ9Ka1TXd2lPVAKCs509QJFGpGGAjGoYinKYSo4Saijb8tRoSUV4Aq21ZTRGQ4U6EEQ5U4
 uUUITQId0Rtjr/PYcqEus/mORghaptCJACE6Fz05HGORy8xYzNfHKGYOpdJfS9CG/Jsp99aFFUg
 gEWwGeD4g8exAfPs8qlihYqY=
X-Envelope-To: stable@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id e7a3931e394e01b3;
	Fri, 14 Aug 2026 20:33:08 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v2 1/2] bpf, x86: Fix per-CPU address resolution into an extended register
Date: Fri, 14 Aug 2026 13:32:47 -0700
Message-ID: <20260814203248.3714536-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814203248.3714536-1-vineet.gupta@linux.dev>
References: <20260814203248.3714536-1-vineet.gupta@linux.dev>
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

