Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFF2ED870;
	Mon, 13 Jul 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979188; cv=none; b=tvTG2leYqakEq0LAKLJedmvtNK0iETsBIjy4NfYInNJnm2vs0mIX1nVczifQ4GZwS8+ptqUbnv6hK/xHJzoMB72aKf07AxK0Q5vGtWLYCL6kyZ7Qco3d8E9YkpweWk6vQzMexGzQ8YEU1QBvWSajNGBteYnj11ORg3RU4j5hPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979188; c=relaxed/simple;
	bh=CJ9IkET5sRymyFv98B4kj7+6sQYh6mAEtRJbD5E6WXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1gyePDkXU0IPftkC7CNMQoWa4sFulwVaXXxejXweSq93AJWcgzYJhNQRahfyVrNyBVqvtIFJ8KJsxr1dY9GAkRlLP743M8xeCwQIBroavGZnL7lBpDAbdz074GIUa3aVjz6wlUDZCfdfz2p947JidDM3wBO6lLWEWmPRcJyxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMkEhmJQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXhbx5eB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMkEhmJQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXhbx5eB"
Date: Mon, 13 Jul 2026 21:46:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783979185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v14wh1om427Akb5/11cGM6ieokjm8idrXhDKsPlzymI=;
	b=yMkEhmJQrYjM9Sc+bH6brcFzwW3Ze87GsRi2rOSrZHSYWlThwA2due6XnnStQqljcrbJXv
	oeBf5Igs/5QEjSilUcPRGTPCv8Yf7dvy897mPwA94HjHB3/r1hL2jTWI3UFwnOCzp/xWp9
	EKhkCLJWKYavlQjPTYBGqtpYrFi0AHCZ5x3vmZeqDizERkPJITxU+fA2/IrVhDgjnD2TsI
	3zznPTIRHs/R3/nr9t13+p2tYLJYpu08OEGe8n95AThjCkldCRN8klaOYXD/7nFugDmyJ5
	2n8lpIKbTIXqqyDx0dxBs0oBgZENTDD0ovhHWdQcFksPWSczpT1hKBAz8vPNmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783979185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v14wh1om427Akb5/11cGM6ieokjm8idrXhDKsPlzymI=;
	b=VXhbx5eBvP4ksAm/i6g4CtjpdgcH6MbacuCHtY2zWuOaQ3/Ps56Ico/J7xAv+FFyTOg+qq
	Te13rp2YzxiWtHBA==
From: "tip-bot2 for Kiryl Shutsemau (Meta)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/insn-eval: Move assign_register() out of KVM as
 insn_assign_reg()
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260713133753.223947-3-kirill@shutemov.name>
References: <20260713133753.223947-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178397918418.1844600.4665976501455212526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     1fe104b048d77d6cb25bd938e6a67450fb50e61d
Gitweb:        https://git.kernel.org/tip/1fe104b048d77d6cb25bd938e6a67450fb5=
0e61d
Author:        Kiryl Shutsemau (Meta) <kas@kernel.org>
AuthorDate:    Mon, 13 Jul 2026 14:37:52 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Jul 2026 14:45:07 -07:00

x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260713133753.223947-3-kirill@shutemov.name
---
 arch/x86/include/asm/insn-eval.h | 36 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/emulate.c           | 26 +++-------------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eva=
l.h
index 4733e90..ae05647 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <asm/insn.h>
 #include <asm/ptrace.h>
=20
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
@@ -46,4 +47,39 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, in=
t *bytes);
=20
 bool insn_is_nop(struct insn *insn);
=20
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
+		*(u8 *)reg =3D (u8)val;
+		break;
+	case 2:
+		*(u16 *)reg =3D (u16)val;
+		break;
+	case 4:
+		/* A 32-bit write zero-extends into the upper 32 bits. */
+		*reg =3D (u32)val;
+		break;
+	case 8:
+		*reg =3D val;
+		break;
+	}
+}
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b566ab5..c6dcb5a 100644
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
@@ -439,25 +440,6 @@ static void assign_masked(ulong *dest, ulong src, ulong =
mask)
 	*dest =3D (*dest & ~mask) | (src & mask);
 }
=20
-static void assign_register(unsigned long *reg, u64 val, int bytes)
-{
-	/* The 4-byte case *is* correct: in 64-bit mode we zero-extend. */
-	switch (bytes) {
-	case 1:
-		*(u8 *)reg =3D (u8)val;
-		break;
-	case 2:
-		*(u16 *)reg =3D (u16)val;
-		break;
-	case 4:
-		*reg =3D (u32)val;
-		break;	/* 64b: zero-extend */
-	case 8:
-		*reg =3D val;
-		break;
-	}
-}
-
 static inline unsigned long ad_mask(struct x86_emulate_ctxt *ctxt)
 {
 	return (1UL << (ctxt->ad_bytes << 3)) - 1;
@@ -505,7 +487,7 @@ register_address_increment(struct x86_emulate_ctxt *ctxt,=
 int reg, int inc)
 {
 	ulong *preg =3D reg_rmw(ctxt, reg);
=20
-	assign_register(preg, *preg + inc, ctxt->ad_bytes);
+	insn_assign_reg(preg, *preg + inc, ctxt->ad_bytes);
 }
=20
 static void rsp_increment(struct x86_emulate_ctxt *ctxt, int inc)
@@ -1767,7 +1749,7 @@ static int load_segment_descriptor(struct x86_emulate_c=
txt *ctxt,
=20
 static void write_register_operand(struct operand *op)
 {
-	return assign_register(op->addr.reg, op->val, op->bytes);
+	return insn_assign_reg(op->addr.reg, op->val, op->bytes);
 }
=20
 static int writeback(struct x86_emulate_ctxt *ctxt, struct operand *op)
@@ -2008,7 +1990,7 @@ static int em_popa(struct x86_emulate_ctxt *ctxt)
 		rc =3D emulate_pop(ctxt, &val, ctxt->op_bytes);
 		if (rc !=3D X86EMUL_CONTINUE)
 			break;
-		assign_register(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
+		insn_assign_reg(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
 		--reg;
 	}
 	return rc;
