Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402628;
	b=u+dHRrab1jSJHxtg6AGsKf40dCZ/GZXei2LqoU1dtuBf059rEtXrxcY1a4xnDpgYoQpm
	 LmgG0l5UT80ySa5/V1EfAaKscnNq66AmXWoBDZns/QH4LVaRQfJ7AyQ+e83I+kHRhptSj
	 TkYQbTu67NQbvmr2/uBmRFI+zm0OAqDQVewFJ2IuNqMeqOtRB7MsX6oX/eErUfHbY1yeQ
	 Q8WDexd0eXzWf5Y7E/QGK1ixHJ2iXexh3Pqu2bJccGbTT1TCC74CWp+KLRQWt54f5iQxA
	 Kz1UAW5cQzZTB+MTUqInLsTeXVlVJusFmKSIbdLVFdSmi4npbeT2uL1r7P4hwneHqDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GDNT0b/bhyDzKt86MPLi6HOpcuh4V0yz8R1khihljtE=;
	b=QK4CmflAZM03QiuBxqKXaJAe7y67UfXrQe6jvevKWW+TKnOMn78nfIf6+S606tlosbWD
	 zUUorK1HNVWGwr7xBc7SQlZaLZVFrdUz+iWJr/lo7/DvHr5T/oOSGlZPHnj+abPJfwPet
	 vpWem5TxjsYOlWuPS/PiUtWqKHIpKQlzsQunMiRPbW47WmYY6iF0qdTOyufGLeLUpDtl+
	 VtaT3huF9X2qdTHMtvlIMlJnyDTDMT0NgNmg79wMTFvka/Ft75UwRZmKEBK8PSjlg6IHv
	 YE5aOqurUBLNcGbqiJ253ysHcvnjFG8Vl9QiT5L3Tabr8WYqDzT3AD9W/hV54yNRaCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgYVjWGm;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F45606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgYVjWGm
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso1089850a91.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795402627; x=1796007427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDNT0b/bhyDzKt86MPLi6HOpcuh4V0yz8R1khihljtE=;
        b=FgYVjWGmL1QtXCI2mQBKnfn2O8L/QNW0xtlxCmFqhqKTJ9rKCS0VeYFIfrZNHPkng5
         JSy0mkS4C7m5RIPnRV3MRpbI/OosOXlQXt8oEcHflv7O/vSNQaN5+1pSBP0B1O6TREue
         mQjNHGxbGkNLM+DS9nT5kz6YTaBbLxIL1EGw0fDLi4dWTDnsjWGS2VK1epjWKizRksWw
         tk69j75W+Y34KvN5F7AfeNmrrEQrOBeyv85iQtX7RUSe7nLJLc4YFI+YnK+/K1oEhgPM
         b7k97jCWm1nDKnQ7gyYT12iSMEHODazFXmbOAJ2znT5eTYuOxdiwVgxA7J0JWfQGlDcv
         vqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795402627; x=1796007427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDNT0b/bhyDzKt86MPLi6HOpcuh4V0yz8R1khihljtE=;
        b=Jhq94RzMHnnuwp3qJ37bWA3BydyNRgBfHiauKsKit7Zgwsikp0yx1oxXH6P1ZR5P3/
         yH5rZv5QGnwtxDHDT05o8MY9/35Ewpex7Tu7rSmDPzQmFg7uMsxKasm+N3MP7m9CYSHQ
         lxDSrueC6sSCrhyM+aSEYHF7nIv5cAnU+mdruX+TI4iaaXClfRNTS4P6sYAU8h3salXk
         FmderBMZNGMtadCI6I7mZipGj1msgDOSwkjQEceqwKidC/DACYLTDXiYy6Gj85DfqkO7
         0uaE/B9K7Kca26Hx1LeKwn+Cidw65G//drr3GoTqA5ysTBdLPafsATVeFD/90bpc0z7Y
         rYRg==
X-Forwarded-Encrypted: i=1; AL+hErH1osYxpZcggL9sSJfXyKsosLpWOayYopAhu7bnuOpEX7qgab9vhuGCJ6r6r3MwnCZPc2jF58Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X8J1217TzTmRodNPYeYeXUG+6alBerAzWJLzNnmgvxmiAEgtX
	/gAe4Tp9+Ey8n614+moQSHiS9sTifpdh46ZGZ2enXMfVTYyojMvUpr6d
X-Gm-Gg: AZFdTZfrlMhIbRThKkw9gq/eHqNkPsT+/kUnyqmSBSYxO8aIb3CW4WyzWhhq6e+dmd8
	58+ju7J3NtPl//vDT9kh8q0miFEWUDLgfSl8bSON2CeYrqQTHJeu4P5cR9RTsXT3IbhAbFdMAF4
	tRie86WNtASS1g3yD1802I8HV+anzgvRVmgj6JyzPJJBkB+xT11TIsT9VJDQftCGF7kzasmjzNY
	BIp8uiu3pom0RBu7xnvGRF6dOciRHWsOW0aCuX3Dgpg771E1njnVsacdmZrtt2+1FHgW6mX6I2b
	hRUUHCid6z/SQH2tBdSql951x3tEHvADw7D/fR5Rk8M0oYIOHGSw3p6Ws059nVGEo8z9hfBUnjH
	OzNHVajWDDwpfMqj3NFTNKL7xDAxSrXV6aW5oouv3ov9mOae9pYXBTHjz+AjJDMtuJ10oMRoKj5
	EO3TB7lQbpB0vr80wSwmPrCWoJpzxDv/DgYC768twdt/t8SN5XpQU2+Qv1lnFcvNNin82OlgksK
	h0Z0tscvSjRpMovA3Q2qGuX1j6usn9vsk4Dmm0URiFXLQaKGiMGbM+T2KuYbHzdGGa/vCvNCdOK
	lhYwamOlcDBJ+3OYh6Z5JauzVWQBVui8VQ==
X-Received: by 2002:a17:90b:1a90:b0:3b0:e388:d9da with SMTP id 98e67ed59e1d1-3b41c92ce29mr8507796a91.29.1795402627197;
        Sun, 22 Nov 2026 18:57:07 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm15279137a91.14.2026.11.22.18.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:57:06 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-mips@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] MIPS: Fix genex.S build with LLVM before 21
Date: Mon, 23 Nov 2026 10:56:45 +0800
Message-Id: <20261123025645.2385330-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Since commit 56651128e2fb ("MIPS: Fix idle VS timer enqueue"),
BUILD_SKIPOVER_PROLOGUE uses label differences as the immediates of ORI
and PTR_ADDIU. The LLVM integrated assembler accepts such an immediate
only from LLVM 21 on, so LLVM=1 builds of every MIPS configuration fail
with LLVM 17 to 20 unless LLVM_IAS=0 is set:

  <instantiation>:7:11: error: expected an immediate
   ori $26, r4k_wait_idle_size - 2
            ^
  <instantiation>:10:14: error: expected an immediate
    addiu $26, r4k_wait_exit - r4k_wait_insn + 2
               ^

Wrap both expressions in %lo(). For that operator, LLVM 17 to 20
emit a LO16 fixup instead of rejecting the operand, and resolve it when
writing the object, since both expressions are constants by then; no
relocation is left. Both values are between 2 and 30, so %lo() does
not change them. GNU as and LLVM 21 to 23 emit the same code as
before, except on microMIPS, where GNU as now uses the 32-bit ADDIU in
the delay slot instead of the 16-bit one. With GCC, the 2 extra bytes
replace the 16-bit NOP that padded the end of the prologue, so all
symbols keep their addresses; with Clang and LLVM_IAS=0, except_vec_vi
and the code after it, up to nmi_handler, move by 4 bytes.

Fixes: 56651128e2fb ("MIPS: Fix idle VS timer enqueue")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505071331.Z0N2eSkr-lkp@intel.com/
Link: https://github.com/llvm/llvm-project/commit/b65e0947cade9bd39036a7700b54c1df4ec00756
Cc: stable@vger.kernel.org # 6.6.x: 56651128e2fb: MIPS: Fix idle VS timer enqueue
Cc: stable@vger.kernel.org # 6.6.x: b713f27e32d8: MIPS: Move r4k_wait() to .cpuidle.text section
Cc: stable@vger.kernel.org # 6.6.x: 2b6d718c8dbe: MIPS: Fix whitespace damage in r4k_wait from VS timer fix
Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
v2: only the stable tags change; the code and the rest of the changelog
are those of v1 [v1]. The tags now start at 6.6.x and name the two
prerequisites Maciej suggested [review] plus b713f27e32d8.

What each stable series has today, and what it will get with the tags:

  series  56651128e2fb  b713f27e32d8  2b6d718c8dbe  will get
  ------  ------------  ------------  ------------  --------------------
  7.3.y   yes           yes           yes           this patch
  6.18.y  yes           yes           no            2b6d718c8dbe + this
  6.12.y  no            no            no            all three + this (a)
  6.6.y   no            no            no            all three + this (a)
  6.1.y   no            no            no            nothing (b)

(a) On 6.12.118 and 6.6.162 the three cherry-picks and this patch apply
    cleanly. For malta_defconfig, genex.o builds with GCC 8.1 and 16.2
    and with LLVM 13.0.1, 17.0.1 and 21.1.8 (6.6.162: also 11.1.0),
    and kernels built with GCC 16.2 and LLVM 17.0.1 boot under QEMU.
    56651128e2fb needs b713f27e32d8: without it, all the code after
    r4k_wait in genex.S is placed in .init.text. Both were queued for
    6.12 and 6.6 in 2025 and dropped because of the build failure
    fixed here ([1] below).
(b) 56651128e2fb conflicts in idle.c on 6.1.y and older.

[v1] https://lore.kernel.org/r/20261104030147.3117325-1-shingekinocore@gmail.com/
[review] https://lore.kernel.org/r/alpine.DEB.2.21.2611040746160.6502@angie.orcam.me.uk/

The notes of v1, unchanged:

> No MIPS hardware here. Against mips-fixes (v7.4-rc1). All builds use
> W=1 and kernel.org toolchains.
>
> - genex.o, before and after, with GCC 8.1 to 16.2 and with LLVM 17 to
>   23, both with the integrated assembler and with LLVM_IAS=0. Configs:
>   64r6el, 32r6el, 64r2el, 32r2el, eyeq5, eyeq6, malta (little and big
>   endian, MIPS32r1, microMIPS little and big endian), ip22, ip27,
>   loongson3 and cavium_octeon.
>   - The objects are byte-identical before and after with GCC, with
>     LLVM_IAS=0 and with LLVM 21 to 23. The only exception is the
>     microMIPS ADDIU above. The 4-byte move with LLVM_IAS=0 is harmless:
>     set_vi_handler() computes the offsets and the length of the vectored
>     handler from symbols before copying it, and ejtag_debug_handler and
>     nmi_handler are only referenced through their symbols.
>   - LLVM 17 to 20 now assemble genex.o for all of these configs except
>     microMIPS and Octeon, which the integrated assembler rejects for
>     other reasons. For malta (little and big endian, MIPS32r1), ip22
>     and ip27, these objects are byte-identical to the LLVM 21 genex.o.
> - vmlinux of 64r2el, 32r2el and malta, built with GCC 8.1 and 16.2,
>   LLVM 17, 20, 21 and 23, and LLVM 17 with LLVM_IAS=0. Where both sides
>   build, vmlinux is byte-identical before and after. With LLVM 17 and
>   20, genex.o was the only object that failed before, and vmlinux links
>   after. No new warnings.
> - The malta kernels built with GCC 8.1 and 16.2, LLVM 17, 20 and 23, and
>   LLVM 17 with LLVM_IAS=0 boot under QEMU 6.2 -cpu 24Kf. That CPU uses
>   r4k_wait(), so interrupts go through skipover_handle_int. Each kernel
>   boots to an init that keeps the CPU going in and out of idle and then
>   reboots; a QEMU trace shows every interrupt that lands in the idle
>   region resuming at r4k_wait_exit. A microMIPS kernel does not boot
>   under QEMU -cpu M14Kc with or without this patch, so the microMIPS
>   change was not run.
>
> In the 2025 thread [2], Nathan suggested requiring LLVM 21 for MIPS in
> min-tool-version.sh, and Maciej an #error for older Clang. Both would
> also stop LLVM 17 to 20 builds with LLVM_IAS=0, which work today, and
> the stable trees would need the same change before 56651128e2fb could
> go back to them.
>
> On 6.18.y, which also allows LLVM 15 and 16, the patch applies after
> 2b6d718c8dbe, and LLVM 15 and 16 fail and are fixed the same way.
>
> The 56651128e2fb backport was dropped from the 6.14, 6.12 and 6.6
> stable queues because of this build failure [1], so 6.12.y and 6.6.y
> still lack that fix.
>
> [1] https://lore.kernel.org/r/2025051415-unloader-likely-b0e6@gregkh/
> [2] https://lore.kernel.org/r/20250521224450.GA2412476@ax162/

 arch/mips/kernel/genex.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index be1b049d856f..ef27965f6ad9 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -146,10 +146,10 @@ r4k_wait_exit:
 	MFC0	k0, CP0_EPC
 	/* Subtract/add 2 to let the ISA bit propagate through the mask.  */
 	PTR_LA	k1, r4k_wait_insn - 2
-	ori	k0, r4k_wait_idle_size - 2
+	ori	k0, %lo(r4k_wait_idle_size - 2)	/* %lo() for LLVM < 21 */
 	.set	noreorder
 	bne	k0, k1, \handler
-	 PTR_ADDIU	k0, r4k_wait_exit - r4k_wait_insn + 2
+	 PTR_ADDIU	k0, %lo(r4k_wait_exit - r4k_wait_insn + 2) /* ditto */
 	.set	reorder
 	MTC0	k0, CP0_EPC
 	.set pop

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

