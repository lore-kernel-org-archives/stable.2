Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050842;
	b=B4wpkCEyqJsMI/jTR/psGBcyjtMOGUjHa/khXGseE52ZIXaVnJI1XN8GMDFfyiFjZW7m
	 uNDHIFNan+haSJ4lPSTAdWrSlXbWjFxS7c5gyy1kSX+qoa6seTVUA+zDTNpPdsp4AbxjM
	 emeirO3t864u+txZ4/BqvcW+ABdm3MDzcATlPNePRm6qrxvfX9RD6XrmNXRnOd7kBdVJx
	 9PNIVdQMmTp6GWQCaVT2DayNDLrKSKT5E8ZW6dDGFe3H8jUs7MHkaFkkXFNVilX/Yqpl4
	 d4Ry7369bAp2LyYjnisnUDdg4J2X+67dDNri0QnLvooySA17nWrBlMhqn8hqpQ2Lzng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8Twq3CE+3duWpwRdzOqH32GjsE0L3xzCDPcfGe1Vbu8=;
	b=qsBN776Y24Am862DHBxtCLATt6tSPGokw4nhazYZpQE/OIxq3v9zmLLHtfhsViRdLvuE
	 4I5d2VEyMv3cZXnARUCgZhvGIr7wXzYYUk0Xz3quqgkxSk4vfaFX/8Cj5DhK9jEGq02+D
	 G7ZtQPTugWd0uTyfTt2NpeF53Wm3b65buLsOvhF8qQA47I0O3zv9LtL5tpOZvQItxA1BQ
	 70C42KLIT2xl0IYMN7zexOMyLs5wKdkdELDd7cByKfw/XfSNe/cuW9RHyLFO0PitRG3tU
	 u3+A18/HWqlFiajrDBoqE+eIyn1diyBhKz14a9Uooj90wArcMFHDIiQHxc8IqzM1Rfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojNtdQFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojNtdQFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32E1F0089F;
	Sat,  7 Nov 2026 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050841;
	bh=8Twq3CE+3duWpwRdzOqH32GjsE0L3xzCDPcfGe1Vbu8=;
	h=From:To:Cc:Subject:Date;
	b=ojNtdQFFVI51pmsDDMTrBi3KA82iWWT3DCkAnkiiRZZ1mz5FUI8oA5BygFOd4wrIG
	 KnYWfzrCQAqDXKUSCwYzBLtF7T3+1273dW+dnVsiKeMxgMRFzzCQDAE1lfynFJx5a/
	 tG/yD7B3qGX+ERGT4UQ3L/ZjJwKuAQ69dSUdYRaKPoQ+GPbkCsepT16dLBt4UPRbyZ
	 +UfRfWgnWMU+fY+fkdDNYt5n3LwNnB8JO+FOAglaLyzcTKDgz3IrFa1G0RHg6wIGcq
	 HjW2ncQ0LbLCnU8fsRwQB+T091Yp4obNycCqsxMLsnmvglVAp21ray59fEBhDEVKBt
	 FnGY0zFMwA5xw==
From: Sasha Levin <sashal@kernel.org>
To: mattst88@gmail.com,
	linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] alpha: determine tininess after rounding in the FP emulation" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:20 -0500
Message-ID: <20261107062719-failed-5.10-b74843b38da8@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b74843b38da8f1186fd7d447646c835b47096a15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062719-failed-5.10-b74843b38da8@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b74843b38da8f1186fd7d447646c835b47096a15 Mon Sep 17 00:00:00 2001
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 3 Aug 2026 15:42:26 -0400
Subject: [PATCH] alpha: determine tininess after rounding in the FP emulation

IEEE 754 lets an architecture determine tininess of a floating-point
result either before or after rounding, but requires the same choice for
every operation.  Alpha determines it after rounding, and stdlib's
tst-tininess confirms the hardware does so for the results it produces
itself.

The soft-fp emulation has no notion of the distinction and always
determines tininess before rounding, so a result that the hardware would
not consider tiny is reported as underflowing whenever the instruction
happens to trap for software completion.  The two paths then disagree on
the same machine.  A multiply of the largest subnormal double by
1 + 2^-52 rounds up to the smallest normal and raises no underflow when
the operands are normal, but raises it when an operand is subnormal and
the instruction traps:

  glibc math testsuite, test-float32x-float64-mul:
    Failure: mul_double (0x3.ffffffffffffcp-1024, 0x1.0000000000001p+0):
    Exception "Underflow" set

Add _FP_TININESS_AFTER_ROUNDING, as glibc's copy of soft-fp has, and set
it for alpha.  It determines tininess by rounding a copy of the result as
if the exponent range were unbounded, which is what the definition asks
for.  A plain check of whether the rounded result came out normal is not
equivalent: it differs for values that are still tiny once rounded with
an unbounded exponent range but reach the smallest normal on the coarser
subnormal grid.  That plain check is what the hardware itself does (it
decides tininess from the delivered result), and it is why a divide such
as -0x4p-128 / 0x1.000002p+0 in FE_DOWNWARD delivers -0x1p-126 and raises
nothing although the result is tiny after rounding.  Such cases do not
trap, so the emulation never sees them; where it does get control, it
follows the definition rather than reproducing that deviation, which is
what glibc's soft-fp does as well.

The macro defaults to zero, so powerpc, sh and sparc keep determining
tininess before rounding as they do now.

Cc: stable@vger.kernel.org # 5.15+
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/sfp-machine.h |  4 ++++
 include/math-emu/op-common.h         | 23 +++++++++++++++++++++--
 include/math-emu/soft-fp.h           |  8 ++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/asm/sfp-machine.h
index 5fe63afbd474f..bff1ad963c689 100644
--- a/arch/alpha/include/asm/sfp-machine.h
+++ b/arch/alpha/include/asm/sfp-machine.h
@@ -59,6 +59,10 @@
     R##_c = FP_CLS_NAN;						\
   } while (0)
 
+/* Alpha determines tininess after rounding, so the emulation must do the
+   same as the hardware does for the results it produces itself.  */
+#define _FP_TININESS_AFTER_ROUNDING	1
+
 /* Obtain the current rounding mode. */
 #define FP_ROUNDMODE	mode
 #define FP_RND_NEAREST	(FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT)
diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 8ce066c035cfa..1d1ce5c08efcf 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -135,6 +135,24 @@ do {								\
     else							\
       {								\
 	/* we've got a denormalized number */			\
+	int _FP_PACK_CANONICAL_is_tiny = 1;			\
+	if (_FP_TININESS_AFTER_ROUNDING && X##_e == 0)		\
+	  {							\
+	    /* Architectures that detect tininess after rounding	\
+	       only signal underflow if the result is still		\
+	       subnormal once rounded as if the exponent range	\
+	       were unbounded.  Round a copy to find out.  */	\
+	    FP_DECL_##fs(_FP_PACK_CANONICAL_T);			\
+	    /* The class field is not used by the rounding below,	\
+	       and is unused entirely where this block is dead.  */	\
+	    (void)_FP_PACK_CANONICAL_T##_c;			\
+	    _FP_FRAC_COPY_##wc(_FP_PACK_CANONICAL_T, X);	\
+	    _FP_PACK_CANONICAL_T##_s = X##_s;			\
+	    _FP_PACK_CANONICAL_T##_e = X##_e;			\
+	    _FP_ROUND(wc, _FP_PACK_CANONICAL_T);		\
+	    if (_FP_FRAC_OVERP_##wc(fs, _FP_PACK_CANONICAL_T))	\
+	      _FP_PACK_CANONICAL_is_tiny = 0;			\
+	  }							\
 	X##_e = -X##_e + 1;					\
 	if (X##_e <= _FP_WFRACBITS_##fs)			\
 	  {							\
@@ -161,8 +179,9 @@ do {								\
 		    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);		\
 		  }						\
 	      }							\
-	    if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||		\
-		(FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))	\
+	    if (_FP_PACK_CANONICAL_is_tiny			\
+		&& ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||	\
+		    (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW)))	\
 		FP_SET_EXCEPTION(FP_EX_UNDERFLOW);		\
 	  }							\
 	else							\
diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 5650c16283830..02ada0a9fca16 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -31,6 +31,14 @@
 #include <endian.h>
 #endif
 
+/* Whether the architecture determines tininess of a floating-point
+   result after rounding rather than before it.  IEEE 754 permits either
+   but requires the same choice for every operation, so this has to agree
+   with what the hardware does for the results it produces itself.  */
+#ifndef _FP_TININESS_AFTER_ROUNDING
+#define _FP_TININESS_AFTER_ROUNDING	0
+#endif
+
 #define _FP_WORKBITS		3
 #define _FP_WORK_LSB		((_FP_W_TYPE)1 << 3)
 #define _FP_WORK_ROUND		((_FP_W_TYPE)1 << 2)
-- 
2.53.0




