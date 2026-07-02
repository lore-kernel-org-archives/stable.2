Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01152EC0B0;
	Thu,  2 Jul 2026 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006218; cv=none; b=Pjpw5G5a8v35L6Han+ZZNOV49wyAV7vO8y5KDLI5D+QnpOe0PGbQzPt5W+gOWX5NoZcFK//guc5HIcTdBzf+dbmBxczauZQlv0iQc7VoE6JG9Jm+g3yA/vkh9+GH6kLzmpBdIcDCAIIOJXZz32fKsqnJBttG5dZOAMvqg+IPKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006218; c=relaxed/simple;
	bh=PO3RQadhhafzQjDUP1/w7jfossHgyjMRP8oUka2GElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD8KQkWyUXCgE10OFyAm17i7jAVLNSFIURflb2aO2JXYdwJGtOokBORA+/mCQvgIkx19oqKang3UdiwXpLs/fGuOiZKbGxJE7MpxPeInGUifgH8Ilo7oqy7HZeqUj1kalP31yH4HtyvIGRo8/mwHDmrdGEg67hVPlMtCBUKLpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=1JMUcA/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6ANRLiT; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="1JMUcA/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6ANRLiT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 678EA13000EB;
	Thu,  2 Jul 2026 11:30:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 11:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783006213; x=
	1783013413; bh=yVr7COG1V0mSeWOwqoS20oxbxIKulSuicEJR4P2Z54Y=; b=1
	JMUcA/2JtYubBkqN2wkKeaCwXhoSAlfoMvBPOor4gL11nildSUBSNm7cA2t4vaJK
	csb4tmpIAs/VN0rUIDcR+ArmU0Tnbi01FIZFHN/Z+C5fCdvk55NwwspRZClWIsuG
	t9lJ2QBVTy2NY8lKRJcG1KXA0twU46wB+ElqBixKbF4rNeUvVHt+td1YoHoYFs1W
	HhoMZAukx6yMFfsVlMVpXuluXBDn57joyYQ3usYKqImiPgDoHCbqdMh0Q8cyP5zD
	Qlvt2oTFQvNVdY7S0IR1T978BL57NtDD77uTqXGFRCXTJUXPU7ebse3cMrykGqbP
	rckEw2boHvcSkZfNGQUgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783006213; x=1783013413; bh=yVr7COG1V0mSeWOwqoS20oxbxIKulSuicEJ
	R4P2Z54Y=; b=E6ANRLiTvBCmM7lCTP9nWt6je2y0KCQL1a6pDqwutVGUB3ZXpe0
	13r0JMAIsqC9bh7mQmm45h5IeiMqM3t+tHaktgbVur2/TNrF867phXfEv62E3JKF
	7CbwcqwgVIfaI3PN90C8iipTYALKYSB+ST/5xGSg8EP9MGAPtXpPSgFmW+xu2Nml
	OBEw8Umdg8nTW/blTMhd/XR1MSbxE3//LxPCv85/1WBa5TiyUMqGrW0swPCQEqje
	xUYtMwtC1HcegRUZCBIVj9C1GxNBn7S6+Poa2idy6uCPC5M9+Q9VM7WVEc6pVvFl
	QXOpzlv70zlOBeBHbw+w7MXkWwXTD/SQTSw==
X-ME-Sender: <xms:BIRGaovJWiLcoGavXGqeynyFoLBFH26s0Ua2oKUeMrHB2FesNI_aeQ>
    <xme:BIRGahpeg2o_4Djk3d7z7_7iyaU5GN72UH6ArYIdVHc8P7dtz60uLIitXGD6rNvEy
    -r43iClw0KimjrxNKuzngmdMe7Tpd4qo8Ta4uKZKaQLTJz6CwzAfMd_>
X-ME-Received: <xmr:BIRGaq7TQrGbtkt4QskhzvX9XE0lhXdEjjlrApQzK6gT11kS4vuXyK836EDgKg>
X-ME-Proxy-Cause: dmFkZTEJI1jWeAlTfjpfguI2Nz3JmZgl4jiS/m+17fpbGL08e/GeY4s8hebc/2OY4X3ZEf
    2CckfU2h84BM8nzpLoDDim4x8CtHU9xlMqmgsTwvzXauI+0W7Fh2LVl88IV/75qy6M/dsU
    RkePHQogMLh7j5X/4EsDAU+e/JHCr8vNPaoWz8sQG7F/59PAOeAznazt5D1350F107DuXC
    REeEUaslp8Pah0MsyB2YADsmfcwBBEs4DMYMHhzFE/eFuIXRzk7ldQGI70P5Gi/qXIOxzP
    YPbq/Vx7mbRb/0yeDeTXqDzHSrBuG0TpO/ozpIsQwV7ak4Bwp1MKw9+46yhNQQTzGCHkhy
    LBNWbFrE3u51nChYP6AO4TA7iG64knvNrcfGp3Aun7H7f6tYMeu/qaMrRdMpiQdY7SU1Ev
    1wBucV5zz5DJIjblJm9DYd6cq4TC0Lmy6frss+kPzx0VQstes9mdDDgEBz/BBhW8Wurzwe
    QsxZsTLQYC/lwSoeh9YsIRyrEBsTeXIj/Zte4sgIt0tSCmy5S01KJgvROaKm/x2ztHJGZI
    lwM7YU9gv0HY3AmN+9v2kwdQkxcg9Iae4iLS+t5VhTTHTxkBZSBVnpv/2b25csA0b7TWYR
    29jD3+LEvbYX56aCf+Ws3csBAI+9hdH12yOe52hruRz4AbfHH+2hwdKZ9IXg
X-ME-Proxy: <xmx:BIRGamzXlXqXxlMNXNoeVeK0pVQR1dhGwaif7XCMMOkpW-6YpS4iaA>
    <xmx:BIRGaqRgW_JDIYPCCCawd8MDFbu7_Lgl-mk6LsZ4hGd9zf29KED16A>
    <xmx:BIRGao9TqMpbjzuyhhlS5Gtc-3QbEBRrlf55m9W7vmOGmjCJW55eQw>
    <xmx:BIRGasFAfysbVEZ4zdMfG7bf6CcKN0q3jhLS9qZhkrine2uuD6lCrg>
    <xmx:BYRGaiaZqxXpMyRJtAdDcMprDiqs4i192CvWrhnMXPwtH-gJoIIGkSXU>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:30:07 -0400 (EDT)
Date: Thu, 2 Jul 2026 16:30:04 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Laight <david.laight.linux@gmail.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Dan Williams <djbw@kernel.org>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
Message-ID: <akaCzNRGVy5Xr-bG@thinkstation>
References: <20260701110547.764083-1-kirill@shutemov.name>
 <20260701110547.764083-3-kirill@shutemov.name>
 <akUrORhAmRur-lHP@google.com>
 <20260701180033.6e9c07aa@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701180033.6e9c07aa@pumpkin>

On Wed, Jul 01, 2026 at 06:00:33PM +0100, David Laight wrote:
> On Wed, 1 Jul 2026 07:59:05 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Wed, Jul 01, 2026, Kiryl Shutsemau wrote:
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > > 
> > > KVM's instruction emulator has a small helper, assign_register(), that
> > > writes a value into a sub-register with x86 partial-register-write
> > > semantics: 1- and 2-byte writes leave the upper bits of the destination
> > > untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
> > > the full register.
> > > 
> > > The TDX guest #VE handler needs the same logic for port I/O emulation
> > > to get 32-bit zero-extension right.  Rather than copy-pasting the
> > > helper, lift it to <asm/insn-eval.h> as insn_assign_reg() so both can
> > > use it.
> > > 
> > > Add <asm/insn.h> to the header's includes so it builds standalone in
> > > callers that have not pulled it in transitively.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > > Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
> > > ---
> > >  arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/emulate.c           | 26 ++++----------------------
> > >  2 files changed, 34 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> > > index 4733e9064ee5..0c87759816d3 100644
> > > --- a/arch/x86/include/asm/insn-eval.h
> > > +++ b/arch/x86/include/asm/insn-eval.h
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/compiler.h>
> > >  #include <linux/bug.h>
> > >  #include <linux/err.h>
> > > +#include <asm/insn.h>
> > >  #include <asm/ptrace.h>
> > >  
> > >  #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
> > > @@ -46,4 +47,33 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
> > >  
> > >  bool insn_is_nop(struct insn *insn);
> > >  
> > > +/*
> > > + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> > > + * or 2-byte write leaves the upper bits of the destination untouched; a
> > > + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]  
> > 
> > The placement of the "(matching IN[BWL], MOV[BWL] etc.)" blurb is confusing.  I
> > *think* you're trying to say this behavior matches that of MOVB, MOVW, and MOVL
> > instruction mnemonics, but the blurb is buried in the snippet that specifically
> > describes the 4-byte write behavior.
> > 
> > FWIW, I think giving examples does more harm than good, because the behavior isn't
> > instruction specific, it's architectural behavior that applies to all writes to
> > GPRs, as defined in "3.4.1.1 General-Purpose Registers in 64-Bit Mode".  E.g. for
> > a MOV instruction that sign-extends a 32-bit immediate to a 64-bit registers, it's
> > not that the instruction is exempt from the normal GPR semenatics, it's that the
> > instruction performs a 64-bit write to the destination even though the source is
> > only 32 bits.
> > 
> > And the B/W/L terminology isn't architectural, it's AT&T syntax.

Agreed.  Dropped the IN[BWL]/MOV[BWL] examples and reworded the comment
to describe architectural GPR-write behaviour with a pointer to the SDM
section instead.  I also spelled out that @bytes is the width of the
write, not a property of the instruction, to cover the sign-extending
MOV case you raised.

> > E.g. trying
> > to encode "movl" with NASM yields "error: instruction expected, found `movl dword'".
> > Yes, the kernel uses AT&T syntax for assembly, but I think this helper should very
> > explicitly document that it's emulating architectural behavior.
> > 
> > > + * etc.); an 8-byte write overwrites the full register.
> > > + *
> > > + * @reg need not be 8-byte aligned: KVM's instruction emulator points
> > > + * into the middle of a register slot to address the high-byte
>                  ^ it isn't really the 'middle'.

Reworded to "offsets the pointer by one byte".

> > > + * registers (AH, CH, DH, BH).  Use narrow stores for the sub-word
> > > + * cases so that the access width matches @bytes.
> > > + */
> > > +static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
> > > +{
> > > +	switch (bytes) {
> > > +	case 1:
> > > +		*(u8 *)reg = (u8)val;
> > > +		break;
> > > +	case 2:
> > > +		*(u16 *)reg = (u16)val;
> > > +		break;
> > > +	case 4:
> > > +		*reg = (u32)val;  
> > 
> > IMO, it's worth keeping a short comment here, because even with the explanation
> > above, I suspect most people will think the code is buggy.  E.g.
> > 
> > 		/* As above, zero-extend 4-byte writes on 64-bit CPUs. */
> > 		*reg = (u32)val;

Added on the 4-byte case, slightly reworded.

> Or be even more specific and use '& 0xffffffff' rather than a cast.
> Particularly since the casts of the RHS in the byte/short cases aren't
> needed at all.

I'd rather keep the body exactly as KVM has it today.  This is now a
straight move + rename with no functional change, and the v4 attempt to
rewrite it with arithmetic is precisely what introduced the AH/CH/DH/BH
clobber Sashiko flagged.  Tidying the casts turns it back into a rewrite
and diverges from the form KVM has shipped for years.  Feel free to
submit a separate cleanup on top if you feel strongly.

Updated patch below; I'll fold it into v6.

-- >8 --
Subject: [PATCH] x86/insn-eval: Move assign_register() out of KVM as insn_assign_reg()

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
  Kiryl Shutsemau / Kirill A. Shutemov
