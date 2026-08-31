Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B42385D62
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187752; cv=none; b=KAcy2WzXfxpnH6YePl5e9pF5TVBcQtEKEKTQgtWSpigsNE0urRVv2dzdxRxmk4xWwoU/cOAlcrXO61CC8kZ6ncyjOa9y5JqAkG7bCX+hS0H+ijzPBmK33H4X7vNbnuqaapTkyHzgHhpX6kdcG4bHwp8MAWG3yzNP8py3380zyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187752; c=relaxed/simple;
	bh=C1lF3gn4PlZOId9Mf6TvQ4ziZitw+Q+94byOj9Hfl3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VnL9ZMmgG3n7gUCJlIszjG5DiswPvtdwN446+XKwM6L8MqsdH9N4O1XOMw/kSnYH0ogQ8PWX0SR8tpWOqpOJs6KQL8tmEKPuZgTGUwnuIevwRNuXJZFMdfFeiPnbhGLGPJfDZe5Iqagj/jxkcUVtepuMcYYqygYKuSgIwZTekSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osRFD/Vz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osRFD/Vz"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90cd4631090so40864086d6.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788187750; x=1788792550; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6nJTLcyWSPxl+4itx4My99BV7MYdBXZSTbutUq6o3MY=;
        b=osRFD/VzSmWODMiAEAy2Zwu2635ofwhLSbXSzEL9N7YTvgM36YSoa0T/n37XC+Fcfn
         Jf7QE1tdNwP5FnACs/01iqc6Oa+3jHeAHE+8Ca03kbs6iM4Axjif08l3GJRx5RN/6oNV
         P+gWGvctLDTsz5MYeOCq4uiBrSQV8jA9ZB+7lheGpBaqA4a64/536y/hOB6/UsYPsAHM
         QxBIrsUESoZqCXPbXQtDb47iMcjcUcyUnpv3CLSLy1w2ALOjJoZy+RTgT/0iUY4uvu50
         g06jWwwsbyQk4s0HqUr32DNgo08i6cw/vATsLDZKbE6VFC1sEVBKCR7R3HgbKJ/ji6wg
         df6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788187750; x=1788792550;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6nJTLcyWSPxl+4itx4My99BV7MYdBXZSTbutUq6o3MY=;
        b=Nj6zMTNbg4HktKwsZ1rbKWfJD3dXpqc+LNEZOXx130odXmeb5epY9iZM7XRci1vzb+
         s274J7L4qJ5MbMCBHGAzbJHW17y9X/OeqwVZsasshiw18aqkXvSxUL0iPCMF3MXvzits
         ZHEZSyFOVaBF+dy2dnI4DTDP0NvCFJXdX2lqHeV+e7RsfO3fdWFa8wxx3vCCANxHUDE7
         ciPXc6nT4xhcXKLETYbjpepkR5QzvjI0VnY7oMSjEvHsltEw2N9d+qbGtpdJS8s5kwaS
         u/h1j+PUnpfq9zyj52XtVmBK1SsvEuT9VAKupaUi0dPAuCwATTysoJ/v7zGn+/bamkov
         SfDg==
X-Forwarded-Encrypted: i=1; AKwUvBzy2bBwuJlfUVeem1u1CDLjjWOep5fXN+A+zmBppNRSu9Qa2LduRuPq4B0iXWuNaIMNCMDFhB0=@vger.kernel.org
X-Gm-Message-State: AFuF++lFCeHr8l8FNCJoLI11E4SaL1+Y6W1cKX219s7m0uSndjssZQIW
	F0Smv2LeCeWHlbfe9atE9sHTCxyPH3S9Y1sprOhgCJT14pqcpyEKHL0nsclTqOafeQ4=
X-Gm-Gg: AR+sD10BsFCyj2wB4AzO0HWO8vf7suBO0s8whPD+U7QdQsKPsaAVmeUMt0/1yZBDkuw
	70jYCqho/ryK8/Fw4WKrAHCT8Lw49lnmzZgqHNIEZ3vz+SpO2mMBDms8FJ9qZZZDML+BfyT2H6d
	FUwshVq5tQbMHuya53QCxR7PBhuwnzW9Sts82JcAJRErKOQK1A8r60/YlQ7mmMSPIoMXJNcr5HY
	ZHBDcbNi9OvzIBnxSoLdG1c42Ti/4reoRyfT9bd3JQgQIhmwUavWBUkVYIhFVQVpPNM0kWQrZMq
	UUP1Po22ZIbtz6PKzlXEi90W2uKN/u6rgTBe+cAe8UuimMGY6XQcyoNKYoGLWKHZuWTG0VIN0z2
	A7/MIRed9/T2t1ItGzupPtEn8YxENjLmoGGn/FZHG2sFFTf6Zlwc34G2wzFJXstK0hm2LpliyY9
	JuHl/sxZlGDCzH6BnlzvqKVhnxygpmN+PgjJfYS1kKuQGpNymV4dMUMZd2+GpUAEllqpe3rPxMl
	j/qUXz3CF0/rnWYOoDHV5sT7hfx0mJmQapGy2kZ6kn4tpVDUGkN3GoLK9pqUDqvgpaIjPS+IHp/
	T8xqX329dfIkYr8EKrX/T4FhHziEkFqbaVrchmuPYtc=
X-Received: by 2002:a05:6214:763:b0:8ee:d9b8:8538 with SMTP id 6a1803df08f44-90e871991c8mr103911176d6.9.1788187749782;
        Mon, 31 Aug 2026 07:49:09 -0700 (PDT)
Received: from coder-so-so-first-ws-0.coder-so-so-first-ws.remote-dev.svc.cluster.local (ec2-54-163-97-9.compute-1.amazonaws.com. [54.163.97.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f5ad4sm85798426d6.23.2026.08.31.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:49:09 -0700 (PDT)
From: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Date: Mon, 31 Aug 2026 14:48:44 +0000
Subject: [PATCH] x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEyUlWoC/3WNwQrCMBBEf6Xs2aVJlFD8FfGQrBuzKklJWi2U/
 rttPXt8M8ObGSoX4QrnZobCb6mS0wr60ABFl+6MclsZjDJWdUeN/oRTZ5GCYJDE4gcMYyKMrkZ
 kbVWwzKwMwaroCweZdv3l+uM6+gfTsDm3hXeV0ReXKG7Rq28pf3J5cmn36u8XLMsXEIxBzb0AA
 AA=
X-Change-ID: 20260831-b4-x86-cfi-fineibt-func-hash-e160f6eee02c
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org, 
 Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1788187748; l=5030;
 i=soheil.kdev@gmail.com; h=from:subject:message-id;
 bh=C1lF3gn4PlZOId9Mf6TvQ4ziZitw+Q+94byOj9Hfl3w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgYX+H9SUmlJjsvfFMerxTO2vrcLc7N
 L+14FQr0ICkN0QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPlJwjp8J6gHLBPVLFJ842ln5d71SmS0Zk+tBT9s1eo/JWFavr2JqDcxe9+XE6ev7/v9OCcTVPY
 GRPMnQ4BMcAU=
X-Developer-Key: i=soheil.kdev@gmail.com; a=openssh;
 fpr=SHA256:qCjbY5l1s4KsiNmUm70DTccyboi5PK8d/VuDVN0FDz4

The switch of the FineIBT preamble from "subl $hash, %r10d" to the
shorter "subl $hash, %eax" moved the hash immediate from offset 7 to
offset 5 of the preamble. fineibt_preamble_hash was updated to match,
but the open-coded offset in cfi_get_func_hash() was missed and it
still reads the hash at offset 7.

cfi_get_func_hash() is used by the BPF JIT to give a struct_ops
trampoline the CFI hash of the stub function it stands in for. With
FineIBT the trampoline now gets the upper half of the real hash
followed by the first two bytes of the next instruction, so the first
indirect call from the kernel into a struct_ops program,
tcp_init_congestion_control() calling ->init() of a BPF congestion
control for example, fails the FineIBT check and the kernel dies with
a CFI failure.

Move the FineIBT preamble template and its offset defines above
cfi_get_func_hash() and use fineibt_preamble_hash there, so every
reader of the preamble shares one definition of its layout. The
CFI_FINEIBT arm is only built with CONFIG_FINEIBT, the only
configuration in which cfi_mode can take that value.
cfi_get_func_arity() does not need the same treatment: the __bhi_args
call whose displacement it reads still ends at the function address.

Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: stable@vger.kernel.org # 6.18+
Assisted-by: LLM
Signed-off-by: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
---
 arch/x86/kernel/alternative.c | 72 +++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 91b1cdd16569..1b22062cabfe 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1198,6 +1198,41 @@ static bool cfi_debug __ro_after_init;
 bool cfi_bhi __ro_after_init = false;
 #endif
 
+#ifdef CONFIG_FINEIBT
+/*
+ * <fineibt_preamble_start>:
+ *  0:   f3 0f 1e fa             endbr64
+ *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
+ * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
+ *
+ * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
+ * UDB on x86_64 and raises #UD.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_preamble_start:			\n"
+	"	endbr64					\n"
+	"	subl	$0x12345678, %eax		\n"
+	"fineibt_preamble_bhi:				\n"
+	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
+	"#fineibt_func:					\n"
+	"	nopl	-42(%rax)			\n"
+	"fineibt_preamble_end:				\n"
+	".popsection\n"
+);
+
+extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_bhi[];
+extern u8 fineibt_preamble_end[];
+
+#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
+#define fineibt_preamble_ud   0x13
+#define fineibt_preamble_hash 5
+
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+#endif /* CONFIG_FINEIBT */
+
 #ifdef CONFIG_CFI
 u32 cfi_get_func_hash(void *func)
 {
@@ -1205,9 +1240,11 @@ u32 cfi_get_func_hash(void *func)
 
 	func -= cfi_get_offset();
 	switch (cfi_mode) {
+#ifdef CONFIG_FINEIBT
 	case CFI_FINEIBT:
-		func += 7;
+		func += fineibt_preamble_hash;
 		break;
+#endif
 	case CFI_KCFI:
 		func += 1;
 		break;
@@ -1363,39 +1400,6 @@ early_param("cfi", cfi_parse_cmdline);
  * anyway.
  */
 
-/*
- * <fineibt_preamble_start>:
- *  0:   f3 0f 1e fa             endbr64
- *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
- *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
- * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
- *
- * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
- * UDB on x86_64 and raises #UD.
- */
-asm(	".pushsection .rodata				\n"
-	"fineibt_preamble_start:			\n"
-	"	endbr64					\n"
-	"	subl	$0x12345678, %eax		\n"
-	"fineibt_preamble_bhi:				\n"
-	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
-	"#fineibt_func:					\n"
-	"	nopl	-42(%rax)			\n"
-	"fineibt_preamble_end:				\n"
-	".popsection\n"
-);
-
-extern u8 fineibt_preamble_start[];
-extern u8 fineibt_preamble_bhi[];
-extern u8 fineibt_preamble_end[];
-
-#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
-#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
-#define fineibt_preamble_ud   0x13
-#define fineibt_preamble_hash 5
-
-#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
-
 /*
  * <fineibt_caller_start>:
  *  0:   b8 78 56 34 12          mov    $0x12345678, %eax

---
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
change-id: 20260831-b4-x86-cfi-fineibt-func-hash-e160f6eee02c

Best regards,
--  
Soheil Hassas Yeganeh <soheil.kdev@gmail.com>

