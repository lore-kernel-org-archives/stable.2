Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910342E007;
	Mon, 13 Jul 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949884; cv=none; b=H3Ul3yWpy8wV4fG/l1ETolNtBWQI3+WfXHbST4WQZsUjGiq/qc96aq3c0OoOTuiFzBDeWRmy8YDnjXaDUNQFINgo7BwQynxtJDFj+jBs2yRXvn4P8qF4ZZfphH2J/0hK/lsV9igeBTPeI7D8DzIkOKCq0B6q8N+VRrAcNdPksbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949884; c=relaxed/simple;
	bh=vOdjohvfT/JVM5+C4VK9UHHmS0dTShzcpvJWsJleNZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKOtiSEQ8Z9cXtcyZbCBNIjC/1A9ugfPo7SrCDYzERV7R9bpIkZEMo8qgX3/2mvLDC0p7hLc8OMPoBu7l51sRP3Fo9t/9uKjKOgUVAtB/YEMlhzUwk/bUHij3zE6JjgCZzqKcyK1iW0qHpQED3PaPRQv6JFJYWBPh+zL53pZ2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=rogB8Emm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oz/RPRLS; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="rogB8Emm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oz/RPRLS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id D0FA413000C6;
	Mon, 13 Jul 2026 09:38:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 09:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783949881; x=
	1783957081; bh=2BOhLxRDrmefh4M9XySyk/MCBQ/z2wAYsJMssS6fQpg=; b=r
	ogB8EmmNSm3HNRgqx35bBss1goUiq/DoUq73fj6qXAcqKlRHcZQvPv6p32T7Bwtj
	pW9I9aJSWeGOvUqmBSyD5y0uqnIlKCQvA07rxNcBZio17y5FWWzpMoIM5o+Fc7ba
	iz1z0lkKlyonSqPVakS+aO9V+3bDK/8klF5JSfoBpcXbngGglZmeRpouxIUQVV9j
	7BxfzlGyHp9rMkuy6fKEuqYNtN4wuXIP2vTY3REnsDhlQreH9VQ2Dy8WzhGM/CgO
	eloJq+jcipXv59KPF8QOxRihA6ckFEYY1rFJc6YFHK3owncj3GtlUL4//oyAR2QL
	kwT2Vsm2aO+vYo3wAwjig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783949881; x=1783957081; bh=2
	BOhLxRDrmefh4M9XySyk/MCBQ/z2wAYsJMssS6fQpg=; b=oz/RPRLS9x3C6o7Wd
	WDlwodrfLl/J7Tj11IJnW9Wj35xc1h3srbmJe4zEFEvNWpuQ/ZeO2VkKBZZxiXnL
	rw5UlyYbZ3oaUCKew1x3OtUGFHYxAZ0Jn8lw70Wvda0Wqfdrw+Xk+hHO34QWHa44
	1DHIbH/PrBczFu+xVCtzJlkmktEB7nB4SEX+hTYM+jiKJwD4K3C58aPSU4XBCsg+
	iN8CDkpiY5quKPHClMwqxHlaXvySxJ9JeO/ofqKdiMtDfn3fC8xtt9+6MkgheDXh
	F8DSGMppLTKM7OLEkz+xyek+t2SVoTlI6qqr+/9veVMYomo7HssSm7A6+Nr+1Jf7
	bd3wg==
X-ME-Sender: <xms:OepUagI_LAwxZG_YawLKudg0jSPWJXd2KIrgi9xncbi8gI9oMeQHwA>
    <xme:OepUatX2gtcM6YsPXgFKxZM-ENIwAyTCFgqo1mEcubJfoH74Hk6iXEovjI8qwUwga
    BoGpWpViPeNaLZH4VWQjcN-v_gBax_Axg_LuGoEdNSxS_0Tu-A6jDPV>
X-ME-Received: <xmr:OepUalPvmabT6_P1z70_QtBKsRTBVcIBYnsnA1QIdcGGIuREMMOYxd9sLEiDdQ>
X-ME-Proxy-Cause: dmFkZTFQs0i3wS5Vl8SeTNASfEPj1lXCeauVb8beM61HiLv3fATtJz9SK0Vdzpd4QIEsL5
    GailNmiN3IQWIz5zHKECR3wLxl6J6vifHDtUPcmfY57ZY/1fcfGvR7GMD5kke9ymcub7j/
    76wI/XlAzgLriqanNPyKkJ1vrEk7lkz83sLT/ndmHNZGD3bt+nSyG1fEnNpbtFx0/9v6AC
    sNXsK0pdaNviGChqCQ22zotcKFrnYhH1fHTT9n50jdkwiK2+NXio2pJpO0SaVfSAj8suql
    x79Whg/E/6h2KgpjXM/CcIwq1NEbpakcfLMat+1P9i0rkjE4OEWpAvW193LDrEgl5njaJM
    edlbua2zAPA2mlXTSOnpN9fDL7IOIk7bN0qoOrJ6f43NMP7py5xp/s4fmsuqQZ/2EnpHCR
    Iiy2mN5UrCnmwb68vlbN8Z/45/sJeR+gVufDXGFevNPxGPuewn2V9lDWcALGeaavT2+XuI
    FWqKKqAdYuLMl/OXIjzd6cpqEFO+QtL1QnWnGAKi7Pb/cxuX/X5Te1YVFEf+0w4lXwYm83
    2Z4MeZ1GbyBZLsyNYXTQ2HWmytgIR/jyNlAzxmjqk9262tDVZxG5qSK8Go9av0pc8Xrmm9
    giXjpCIfBs8PkwOpimSBbWrNXhkG8ZcfrKSaVQfdsWUxUtBmw6uUxL/O2o1g
X-ME-Proxy: <xmx:OepUapl_3Oy429H2WIk0qkyEzA7fOo6RmXpO5SKTjQhqLYElhDPmVg>
    <xmx:OepUaoWvU6oMLBLxqx3ixePDaf0DYt343nE9ivlN4yMxuN7VrQ9jqQ>
    <xmx:OepUaoLgAKAJ2d0Eou8Z2OOgNV0r10otevzFbvgz_3fVfF9ALk7VjA>
    <xmx:OepUasb_5mvmggfJQz0L6ZdVEil1qrDBtp4DgzeiDFImIbVkZNGSzg>
    <xmx:OepUavhRSn8KhqMKN45WnD9N_c4I5mkLN4KsMIj9g4nXGNXH9YnwGba4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:38:01 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v6 2/3] x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()
Date: Mon, 13 Jul 2026 14:37:52 +0100
Message-ID: <20260713133753.223947-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713133753.223947-1-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

KVM's instruction emulator has a small helper, assign_register(), that
writes a value into a register following the x86 rules for writes to
general-purpose registers: an 8- or 16-bit write leaves the rest of the
register untouched, a 32-bit write zero-extends the result to 64 bits,
and a 64-bit write replaces the whole register.

The TDX guest #VE handler needs the same logic for port I/O emulation
to get 32-bit zero-extension right.  Rather than add a third copy of
the same switch, move the helper verbatim to <asm/insn-eval.h>, rename
it to insn_assign_reg(), and route KVM's callers through it.

Add <asm/insn.h> to the header's includes so it builds standalone in
callers that have not pulled it in transitively.

No functional change.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
---
 arch/x86/include/asm/insn-eval.h | 36 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++-------------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 4733e9064ee5..ae05647a0afb 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <asm/insn.h>
 #include <asm/ptrace.h>
 
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
@@ -46,4 +47,39 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
 bool insn_is_nop(struct insn *insn);
 
+/*
+ * Write @val into *@reg following the x86 rules for writes to
+ * general-purpose registers (Intel SDM Vol. 1, "General-Purpose
+ * Registers in 64-Bit Mode"): an 8- or 16-bit write leaves the rest of
+ * the register untouched, a 32-bit write zero-extends the result into
+ * the upper 32 bits, and a 64-bit write replaces the whole register.
+ *
+ * @bytes is the width of the write, not a property of the instruction:
+ * an instruction that, say, sign-extends a 32-bit immediate into a
+ * 64-bit register does a 64-bit write here.
+ *
+ * @reg need not be 8-byte aligned: KVM's instruction emulator offsets
+ * the pointer by one byte to address the high-byte registers (AH, CH,
+ * DH, BH).  Use narrow stores for the sub-word cases so the access
+ * width matches @bytes and the adjacent bytes are left alone.
+ */
+static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
+{
+	switch (bytes) {
+	case 1:
+		*(u8 *)reg = (u8)val;
+		break;
+	case 2:
+		*(u16 *)reg = (u16)val;
+		break;
+	case 4:
+		/* A 32-bit write zero-extends into the upper 32 bits. */
+		*reg = (u32)val;
+		break;
+	case 8:
+		*reg = val;
+		break;
+	}
+}
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5c7515..c6dcb5ac48af 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -24,6 +24,7 @@
 #include "kvm_emulate.h"
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
+#include <asm/insn-eval.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
 #include <asm/text-patching.h>
@@ -439,25 +440,6 @@ static void assign_masked(ulong *dest, ulong src, ulong mask)
 	*dest = (*dest & ~mask) | (src & mask);
 }
 
-static void assign_register(unsigned long *reg, u64 val, int bytes)
-{
-	/* The 4-byte case *is* correct: in 64-bit mode we zero-extend. */
-	switch (bytes) {
-	case 1:
-		*(u8 *)reg = (u8)val;
-		break;
-	case 2:
-		*(u16 *)reg = (u16)val;
-		break;
-	case 4:
-		*reg = (u32)val;
-		break;	/* 64b: zero-extend */
-	case 8:
-		*reg = val;
-		break;
-	}
-}
-
 static inline unsigned long ad_mask(struct x86_emulate_ctxt *ctxt)
 {
 	return (1UL << (ctxt->ad_bytes << 3)) - 1;
@@ -505,7 +487,7 @@ register_address_increment(struct x86_emulate_ctxt *ctxt, int reg, int inc)
 {
 	ulong *preg = reg_rmw(ctxt, reg);
 
-	assign_register(preg, *preg + inc, ctxt->ad_bytes);
+	insn_assign_reg(preg, *preg + inc, ctxt->ad_bytes);
 }
 
 static void rsp_increment(struct x86_emulate_ctxt *ctxt, int inc)
@@ -1767,7 +1749,7 @@ static int load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 
 static void write_register_operand(struct operand *op)
 {
-	return assign_register(op->addr.reg, op->val, op->bytes);
+	return insn_assign_reg(op->addr.reg, op->val, op->bytes);
 }
 
 static int writeback(struct x86_emulate_ctxt *ctxt, struct operand *op)
@@ -2008,7 +1990,7 @@ static int em_popa(struct x86_emulate_ctxt *ctxt)
 		rc = emulate_pop(ctxt, &val, ctxt->op_bytes);
 		if (rc != X86EMUL_CONTINUE)
 			break;
-		assign_register(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
+		insn_assign_reg(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
 		--reg;
 	}
 	return rc;
-- 
2.54.0

