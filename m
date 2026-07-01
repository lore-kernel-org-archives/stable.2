Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9F43637D;
	Wed,  1 Jul 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903958; cv=none; b=WtgXZhz6+MOtUqAG2xI7geQ8U+NtiJoes77BSYGiH824Gk7bfhWv85kfTbEMa78R+Hyusy58y1lByrJibsFljcZZEGk/MTWcDa/jdY0HRu7ORawLI14r45pbMAHKIMMpHt3KJhnYzw1DkLcKXWjRWnFdjlhLtDbAYtl279ba/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903958; c=relaxed/simple;
	bh=vnWYLlGY+VUiBZLruci3hdmZHoM/Y601xdlONF5cgd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNHGzc7G6e0cbBSN19ZCFzrE0ORbqRoJV6GSIdan8GyVU1yCjIbhIgHJShMJnJrTToyCvlDVk9P2pb59CwtuZEcFhGrKGmEGzOaDIjd4JZM3lWFlgg+HtFCoHfLHQmZd8EcgrznkSo6HdPKFhiMzdmz3RzWD0YYDslTM/hGzbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=1HNGK6PG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DK3NQ4XE; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="1HNGK6PG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DK3NQ4XE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id A084013803F4;
	Wed,  1 Jul 2026 07:05:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Jul 2026 07:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782903955; x=
	1782911155; bh=INf90bYj02ZOXa5gxGLhfm9g3GjFI2Y+RZknOVHeSVI=; b=1
	HNGK6PGm8lhBoLfx+bsLsMjEUvmy57/G9Ychy/jiJidAPi5kNOCnuOVfa6OR7kW9
	OaDFM8sskNpaq7zacqhkgljLiXALkUxzl+Rn0r+CAtqN+n18L9rG8Hz6Amg78kLt
	TN/2ac/ONpDgeAfhq8C+BbvU5CA/E4QNdl1zXU1I/el7TKoE9WloFwrhIDbKmD5F
	EocRUEAPGNmUUrE6BhYTVU94Ik1YJUyN1i33OKvhmne2fpGrg8VQ/2xWWCzw8lXT
	5h6777Lwpi4zOK7S1MKd5eLBVuwdo0oUiXGHE/gwk6IZlSlwmQzsyY9yIeG4HFM7
	XsAhA9BqdmrMzOoY2NrZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782903955; x=1782911155; bh=I
	Nf90bYj02ZOXa5gxGLhfm9g3GjFI2Y+RZknOVHeSVI=; b=DK3NQ4XEkzFZZXQdR
	56X2m4X9xudR2huhIYvJADnJA6xM2FtYasc4LVgWWzg6zwA1ZeoO4fcr5SgB3CuX
	Mv1WjRIe6+LafgMNPOEQ5/RIdu4On/rPKlUk1Ao9Ka7RVz0D5axHlQCFchObvSbT
	RlOTLdxNQrezSGRtPswMNG1YdNaUuVSAqI6V35TibxrgQoqxnvfNGL+XpShwAaYu
	inY3d+zV/UqN3NYDLbX2zGRMnaflNSj7UuEfMNdrSwNg7rQLAOLnAuDFj2Y1Oizy
	RVo43iFwM9Fvd+ph1MnYBk8tge18Fxhv3TBA8Ybp7Kn/OvDurIAlMH2vw1QCuLr4
	hI+7A==
X-ME-Sender: <xms:k_REap1SOYH0tPFzXmEpY-VmA-8CBpr8N97cZ29IsnTlVWVRpQyehA>
    <xme:k_REatSRlerK8LvYAaC0NXAMNRw6Mggujg3jTimA9Ak8VS7wO87VuNdPHm7CWqytm
    HH2Kikra7f2IfasgybcxUgs5NhWD4aXufh9lP2EghcRitEUct2cwKo>
X-ME-Received: <xmr:k_REauYH24EIC0Dh6g2LMp1oT56wV71vlaLWX6bK45O4fIjW_w5kl_LEZ43xcQ>
X-ME-Proxy-Cause: dmFkZTG1WSuQ4n80upOxybLx7D4c9WF4TSUsQHN7nA5ZgVwSLIcrLvfGVrCliwa4vJT3lR
    P9dv/PFF4rsFhBDneGlP6wSoLg+1MglTYuX2mBzi6RfF6x0Z2DrDLWcE5E0xq10HLkHsdU
    ZOIPsDYdruBhfOMCqig8YFU8vwPEenbaGOEuLD/ruEVlteQ+r5gklfQyTq/swIAzAxWjjX
    RTlgqQGsfDhGK3TAVgg99XA7WyvNJjamDMgtVWq7MDShrBdoFGaf6e28fK3rTUFlTIGczH
    qR3P60m7UGL3FGdWiVAh7bKRTXZamkJrYsmzSAzWdw/VuV5EjBgANMNR8H/7m2Uh9nM3Uv
    T82BrB6KsGVPy1GvMF5GFyFNQZ7WJVN+vzpWMyDsYvgIqTX0hjUpKNmhJ288/1wL5ZxMUn
    XFJ0ygiKlK/Rr3tbv/ng9OJrOeELeJNG2II+pUCu3fFYMU7A3cTEYuke83X0HA4jf2CfsT
    eJLg2xOxL7pXBuZ4tx/rI28O/6k1z6sCVPaix3LHmP7YqfeFTh4Vos0yb1dh8Mbqur/nFp
    DXPmiX0lKmkHwkHPwDITFjBCt87QVdUT1lp5s5ZrtsASA3EyeM9OiL/NixD/IQqM5N+3b9
    oTMxRnIPxBpgNrt5/bM7i2dl4uVky8ZXbHXUKvOwH/+T+wptdv/Lq9y6Y+wg
X-ME-Proxy: <xmx:k_REajAILOV4LHZp2ww3Gzv0uDDxyKR2oJ5BTiwmvMqo4vGdMdRhIw>
    <xmx:k_REatCBHLYSyJnr3q2c8UJKB7IWfHpCjXCQ5ACzjPFV3cpj1p9lGA>
    <xmx:k_REanHMlfhtuOkwgN2w0xenkNt1yeszzeeNRfQLykpE0eVlOcQvRQ>
    <xmx:k_REaokunLE-y-FoT92hZvaVsvvt1Zv-yjkEv8ow7pmLlVLSFEKN7w>
    <xmx:k_REaqNIPK7YrMQ8pQpBu7vM2DKpfuXBZMVjQs9quwInor9HK1aKSekI>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:05:54 -0400 (EDT)
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
Subject: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
Date: Wed,  1 Jul 2026 12:05:46 +0100
Message-ID: <20260701110547.764083-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110547.764083-1-kirill@shutemov.name>
References: <20260701110547.764083-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

KVM's instruction emulator has a small helper, assign_register(), that
writes a value into a sub-register with x86 partial-register-write
semantics: 1- and 2-byte writes leave the upper bits of the destination
untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
the full register.

The TDX guest #VE handler needs the same logic for port I/O emulation
to get 32-bit zero-extension right.  Rather than copy-pasting the
helper, lift it to <asm/insn-eval.h> as insn_assign_reg() so both can
use it.

Add <asm/insn.h> to the header's includes so it builds standalone in
callers that have not pulled it in transitively.

No functional change.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
---
 arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++----------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 4733e9064ee5..0c87759816d3 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <asm/insn.h>
 #include <asm/ptrace.h>
 
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
@@ -46,4 +47,33 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
 bool insn_is_nop(struct insn *insn);
 
+/*
+ * Write @val into *@reg with x86 partial-register-write semantics: a 1-
+ * or 2-byte write leaves the upper bits of the destination untouched; a
+ * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]
+ * etc.); an 8-byte write overwrites the full register.
+ *
+ * @reg need not be 8-byte aligned: KVM's instruction emulator points
+ * into the middle of a register slot to address the high-byte
+ * registers (AH, CH, DH, BH).  Use narrow stores for the sub-word
+ * cases so that the access width matches @bytes.
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

