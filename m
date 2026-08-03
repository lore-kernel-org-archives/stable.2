Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6439794B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800455; cv=none; b=uyazxZMFnSiwLcrfz6ntf9RmLRCxvhFc1oHh+SOZUTnYCsHFYbTx/+mqPKNSiaT8Fgrd7YLqfG3w7OAIW87agdncx9YotcJCGMJlQgWM3tDRl+tIHS0KpqSUQzS/DeP6XBJlFbZb+z+rTg5zMQK+UVYNuuxMtYOODl3Xltggo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800455; c=relaxed/simple;
	bh=l7nUfbmcaF4fNgdDGLaluLSkk7Vtw5eJN5GAj2QQfq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7zAXW2o1qJnY+wbXwjRd4EnjxOtX4KEN3a1ObSLSNudY/yKe5rNO7uTZt2NH/e0dfJUDKl9ow0u68nxTUstWLD1OW+pMGA2vO+AuRYCCOe8Tk2SX9obLvydv4wkW6c6Nf3SNPA/MtjeX17MyWlT2TIrdUhdOakuJCvo6Q5HUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGgpVXP/; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGgpVXP/"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6611669cd16so5460524d50.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800451; x=1786405251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2j9pfRfEIp9EnFpow/3t02qd283vXOlzX6oo/fcXlc=;
        b=UGgpVXP/khMSfc9ttEUIqTVy5cbTCBDtfR2MBMSdv6FTzuTDrWOSyTgB8TgqULTS5A
         VINTeLpRFN0f85mCyyiRlwMildC/IkPd+byPa0Z9UVsOx4yjtxxnWEWQpheimZIe5/lG
         pmxv3ALKrCSP2AcF4rIkKhBYBxrpKvwFJBjAKy9uKIxmR/aQAf8ddak57Q+cAbjE+PLb
         ytu9n2aZ6mqfLgtVV8IvFUwZ6SV4pRWNFarSLTIQUrkt57hHJa1Bfr6FVjpg0kB4FuJu
         4u1va7P8H+4gl12h1sIxPWx4q6tKHz5IkINuC2Y6hLny7yM3aySom7ectyQJGfODyHI1
         4mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800451; x=1786405251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2j9pfRfEIp9EnFpow/3t02qd283vXOlzX6oo/fcXlc=;
        b=MqklOoAalJWQkyYMZ7+kpAcSjsvT32HZmuDxIkDIbmc0T50mZQ05d+4FwVHQGRCBG/
         tosZC/vrVG3nEycga2zTOvIBIwVWuDpgxhrCqN1/xJ/xSu6lNHmwEKRuYPK66BDwmfM5
         L/b8UPp2eW9+xz/x+i/iFynceZNLo88EDGI4mmt36fQj3iRyn9lsNcThxOKolUbcIcSd
         KqSm/J+WfMZb6bParZeX15+ZH+PeyADOagYGKf8hi72CHEJ1ENXaKeZFU3Uv4KlsWSG4
         QNImND19+mDmf4RrfIcg6oTh7P4l0psIGEMlq/9MgrpFXIKm0s2gfUu6H/x1Ed8fIUkI
         +z/w==
X-Forwarded-Encrypted: i=1; AHgh+RoKno/FqehEYoYLcKhTbKUnLrldhcFjmzx2q3xX4/B7OOd5ipwXbgdj4DZufEzhnu5jU3LHrgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIKJJiy4N/xaPWeFrjVtfagTHUahaEGv2dpe9KyIHwFfWO/ix
	94PffcTXs/gVjORTuf5BNKuDCBcy7MxqettPLZKYhbhId1sNBBrns6Eg
X-Gm-Gg: AR+sD10/Z7DkoaqGNmxLu6pZ9ntV56cwdzygaoQ7TiqZy02F6oMLjgBWbBfBeKrqZcr
	TXkaKKzZWwbPGOvKYEWQ3IwF8W+x/2H8kILxbnbipt/QRBTN6Io+9E7CJ6dz/vPDovEfw4uYqNZ
	TPE7Lr9IrRe0s3tISFlHBIP3/4RY7sbo8oz//rJmGCYBvoXxNYRbmqhiRMZbz9txOzsK0H0bK3o
	CFaof0GjQMe5K35gsffVZtpXVKNzZco5EJU6kXPvOMNJeXD8srRjwVlSUTbSpS0EYLMAJ1Hwzfm
	EcYCdXFMXGXn+UOMpYzUBqQKHNYgBn6lgm4yyHt0/CHqO83ES78gKnXPMPVQ522QgPfB38Wa5xx
	ukGkJNPOqx7nH4ixE1F4HntrYjuuZQ8H8UkteNmPd259azluuV2v0QonJsuBukEK7AjYVhXEHlQ
	BXXhPXBsZJjhiHx+/XO7/7LH1rDaaylrML9ujiEh+S7JfguwPAmjoTw0gBZhVW
X-Received: by 2002:a05:690c:e3d1:b0:81e:f1e3:52ad with SMTP id 00721157ae682-81fd4ba85a4mr156253787b3.30.1785800450957;
        Mon, 03 Aug 2026 16:40:50 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e2b0sm62638757b3.8.2026.08.03.16.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:50 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 03 Aug 2026 19:40:46 -0400
Subject: [PATCH 2/3] alpha: don't leak hardware-fabricated FP exception
 bits to user space
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-alpha-fp-exceptions-v1-2-c99d75608e60@gmail.com>
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

On EV6 and later the hardware records exception status bits in the FPCR
before delivering a software completion trap, and those bits can be wrong
for the instruction that trapped.  Converting a double that is exactly
representable as a subnormal float sets FPCR_UNF even though the result
is exact, and an underflow trap additionally sets FPCR_INE even when the
emulated operation turns out to be exact.

alpha_fp_emul() only wrote the FPCR when soft-fp raised an exception, so
whenever it determined that the instruction was exact the fabricated bits
stayed in the FPCR and were reported to user space by fetestexcept().

Pass the exception summary register down from do_entArith() so the
handler can tell which exceptions the hardware attributed to the trapping
instruction, and always write the FPCR.  Clear the exceptions that the
trap reported but that soft-fp did not raise.  EXC_SUM reports only the
underflow or overflow when the hardware also set INE, so treat INE as a
candidate in that case, and treat a trap with no reported exception as a
denormal operand trap, for which the hardware can fabricate INE and UNF
as well.  Bits that software has already confirmed in ieee_state belong
to this or an earlier instruction and are never cleared.

The imprecise path passes no summary.  There the trap was taken somewhere
in the trap shadow, so EXC_SUM is not attribution for the instruction
being re-executed -- and only EV6, which traps precisely and so never
takes that path, has fabricated bits to clear.  For the same reason the
clearing is guarded by implver(), matching swcr_update_status().

On an UP1500 (EV68) this takes the glibc math testsuite from 831 failures
to 28, the remainder being unrelated to exception status.

This belongs with the preceding fix to ieee_swcr_to_fpcr(), and should
not be backported without it -- nor it without this.  That fix stops
FPCR_DNOD being set unconditionally, so denormal operand traps start
firing again.  Those traps very often find an exact result, which is
precisely the case where the old code left the FPCR unwritten and the
fabricated bits visible.  Applied alone it would make spurious exception
flags more common, not less.

One case cannot be resolved here: an inexact instruction without the
software completion suffix never traps, so its INE reaches the FPCR
without being recorded anywhere else.  Such a bit is indistinguishable
from an INE the hardware fabricated for a trapping instruction, and is
lost if an underflow or overflow trap with an exact result follows it.
The FPCR is the only record of those instructions and it carries no
attribution.

The bug predates the git history, so there is no commit to reference in a
Fixes tag.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/traps.c  |  6 ++--
 arch/alpha/math-emu/math.c | 88 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 7004397937cf..7cd20e5f9ee0 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -166,12 +166,12 @@ static long dummy_emul(void) { return 0; }
 long (*alpha_fp_emul_imprecise)(struct pt_regs *regs, unsigned long writemask)
   = (void *)dummy_emul;
 EXPORT_SYMBOL_GPL(alpha_fp_emul_imprecise);
-long (*alpha_fp_emul) (unsigned long pc)
+long (*alpha_fp_emul) (unsigned long pc, unsigned long summary)
   = (void *)dummy_emul;
 EXPORT_SYMBOL_GPL(alpha_fp_emul);
 #else
 long alpha_fp_emul_imprecise(struct pt_regs *regs, unsigned long writemask);
-long alpha_fp_emul (unsigned long pc);
+long alpha_fp_emul (unsigned long pc, unsigned long summary);
 #endif
 
 asmlinkage void
@@ -185,7 +185,7 @@ do_entArith(unsigned long summary, unsigned long write_mask,
 		   emulate the instruction.  If the processor supports
 		   precise exceptions, we don't have to search.  */
 		if (!amask(AMASK_PRECISE_TRAP))
-			si_code = alpha_fp_emul(regs->pc - 4);
+			si_code = alpha_fp_emul(regs->pc - 4, summary);
 		else
 			si_code = alpha_fp_emul_imprecise(regs, write_mask);
 		if (si_code == 0)
diff --git a/arch/alpha/math-emu/math.c b/arch/alpha/math-emu/math.c
index 68d420bfd3c0..e3f2df3729e3 100644
--- a/arch/alpha/math-emu/math.c
+++ b/arch/alpha/math-emu/math.c
@@ -52,13 +52,13 @@ MODULE_DESCRIPTION("FP Software completion module");
 MODULE_LICENSE("GPL v2");
 
 extern long (*alpha_fp_emul_imprecise)(struct pt_regs *, unsigned long);
-extern long (*alpha_fp_emul) (unsigned long pc);
+extern long (*alpha_fp_emul) (unsigned long pc, unsigned long summary);
 
 static long (*save_emul_imprecise)(struct pt_regs *, unsigned long);
-static long (*save_emul) (unsigned long pc);
+static long (*save_emul) (unsigned long pc, unsigned long summary);
 
 long do_alpha_fp_emul_imprecise(struct pt_regs *, unsigned long);
-long do_alpha_fp_emul(unsigned long);
+long do_alpha_fp_emul(unsigned long, unsigned long);
 
 static int alpha_fp_emul_init_module(void)
 {
@@ -86,7 +86,22 @@ module_exit(alpha_fp_emul_cleanup_module);
 
 
 /*
- * Emulate the floating point instruction at address PC.  Returns -1 if the
+ * Exception bits of the exception summary register (EXC_SUM).  Bit 0 is the
+ * software completion bit; bits 1 through 5 report the exceptions the
+ * hardware attributed to the trapping instruction, and lie at the same
+ * positions as the corresponding IEEE_TRAP_ENABLE_* bits.
+ */
+#define EXC_SUM_INV	(1UL << 1)
+#define EXC_SUM_DZE	(1UL << 2)
+#define EXC_SUM_OVF	(1UL << 3)
+#define EXC_SUM_UNF	(1UL << 4)
+#define EXC_SUM_INE	(1UL << 5)
+#define EXC_SUM_MASK	(EXC_SUM_INV | EXC_SUM_DZE | EXC_SUM_OVF	\
+			 | EXC_SUM_UNF | EXC_SUM_INE)
+
+/*
+ * Emulate the floating point instruction at address PC.  SUMMARY is the
+ * exception summary register the trap was delivered with.  Returns -1 if the
  * instruction to be emulated is illegal (such as with the opDEC trap), else
  * the SI_CODE for a SIGFPE signal, else 0 if everything's ok.
  *
@@ -95,7 +110,7 @@ module_exit(alpha_fp_emul_cleanup_module);
  * stick the result of the operation into the appropriate register.
  */
 long
-alpha_fp_emul (unsigned long pc)
+alpha_fp_emul (unsigned long pc, unsigned long summary)
 {
 	FP_DECL_EX;
 	FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
@@ -300,12 +315,56 @@ alpha_fp_emul (unsigned long pc)
 		swcr |= (_fex << IEEE_STATUS_TO_EXCSUM_SHIFT);
 		current_thread_info()->ieee_state
 		  |= (_fex << IEEE_STATUS_TO_EXCSUM_SHIFT);
+	}
 
-		/* Update hardware control register.  */
-		fpcr &= (~FPCR_MASK | FPCR_DYN_MASK);
-		fpcr |= ieee_swcr_to_fpcr(swcr);
-		wrfpcr(fpcr);
+	/*
+	 * EV6 records exception status bits in the FPCR before delivering the
+	 * software completion trap, and swcr_update_status() above merged them
+	 * into SWCR.  Some can be wrong for the instruction we just emulated:
+	 * a CVTTS of a value exactly representable as a subnormal sets FPCR_UNF
+	 * even though the result is exact.  Clear the exceptions the trap
+	 * reported but that soft-fp did not raise.
+	 */
+	if (implver() == IMPLVER_EV6) {
+		unsigned long spurious = summary & EXC_SUM_MASK;
 
+		if (spurious & (EXC_SUM_UNF | EXC_SUM_OVF)) {
+			/*
+			 * EXC_SUM reports only the underflow or overflow,
+			 * but the hardware sets INE alongside it in the FPCR.
+			 */
+			spurious |= EXC_SUM_INE;
+		} else if (!spurious) {
+			/*
+			 * No exception reported, so this was a denormal
+			 * operand trap, for which INE and UNF can be
+			 * fabricated as well.
+			 */
+			spurious = EXC_SUM_INE | EXC_SUM_UNF;
+		}
+
+		/*
+		 * Never clear an exception software has confirmed.  Every
+		 * instruction that genuinely raises one traps for software
+		 * completion and is recorded in ieee_state above, so a bit
+		 * found there -- including one just set from _fex -- belongs
+		 * to this or an earlier instruction and must survive.
+		 */
+		spurious &= ~(current_thread_info()->ieee_state
+			      >> IEEE_STATUS_TO_EXCSUM_SHIFT);
+
+		swcr &= ~(spurious << IEEE_STATUS_TO_EXCSUM_SHIFT);
+	}
+
+	/*
+	 * Update hardware control register.  This has to happen even when
+	 * soft-fp raised nothing, to clear any fabricated bits.
+	 */
+	fpcr &= (~FPCR_MASK | FPCR_DYN_MASK);
+	fpcr |= ieee_swcr_to_fpcr(swcr);
+	wrfpcr(fpcr);
+
+	if (_fex) {
 		/* Do we generate a signal?  */
 		_fex = _fex & swcr & IEEE_TRAP_ENABLE_MASK;
 		si_code = 0;
@@ -387,9 +446,16 @@ alpha_fp_emul_imprecise (struct pt_regs *regs, unsigned long write_mask)
 			break;
 		}
 		if (!write_mask) {
-			/* Re-execute insns in the trap-shadow.  */
+			/*
+			 * Re-execute insns in the trap-shadow.  Pass no
+			 * exception summary: it describes the trap, which
+			 * was taken anywhere in the shadow, and so is not
+			 * attribution for this instruction.  Nothing is
+			 * lost, since only EV6 -- which traps precisely and
+			 * never comes this way -- needs it.
+			 */
 			regs->pc = trigger_pc + 4;
-			si_code = alpha_fp_emul(trigger_pc);
+			si_code = alpha_fp_emul(trigger_pc, 0);
 			goto egress;
 		}
 		trigger_pc -= 4;

-- 
2.54.0

