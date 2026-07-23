Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34773F1676;
	Thu, 23 Jul 2026 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794314; cv=none; b=kGDxchXs4GgBbisQ4pKLaPGjukbduEN6ngGprS0EzCaMRjILNA/8OUWu9yYJnY9jEOHkn+HH+xQt1FBCJngzxWjEQ0bGxGZFfcePCgVltbDDS8ZQKVFEoiaDDLaqd0rcbbW0tioeV4JywzqKv9USZytom+H5ilIrRUIipCnUAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794314; c=relaxed/simple;
	bh=F1+kWuqpvpcTSf45C9Bx4CN4aUsb3ARXSt4mox56iFI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iQ65S6yBRzfjdFMhnMfdVLidzc/3uDLMJPuIjO/5FjwuseCxgTElcSWbIls5dMLl3ozDqlXWDmD3KCItI8xK+zPIVMe8BXakadHCv3O7NFVBv3aVPe5zUrM5VyjbrMntPxwYJ+lTytL3R7A58PoviCzOThQDgEOsUJLvCDACJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDzSeQsP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDnJAcNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDzSeQsP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDnJAcNu"
Date: Thu, 23 Jul 2026 08:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784794305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM+fSbe4KRufkuUmCRbI7JsXvwaeDgoJo8Uf5n3fSG8=;
	b=hDzSeQsPXIvPPmeY6/zGCGNaY9lmjGlIkZYgJuwueH3zQdbMGsDy0NjDM2G2wzTi/ddGaM
	VgmlPUjrKCFpzZS+KYzNgPuQvYnQZ0IR/8inhp4JFFT+1Q+0Ej+zTl40JfVYtNr4FGZ9LY
	hZxdKcQalp2HOsC/JQtgDvmMlcVc1jFeTX1EdK5qri8MNaL+mN0RQr+AthNdYZmQvsKeCr
	pGjRaVw5eNJ5wxSCKFuy/t0l+MUBqAU9OWlzRh3E/wu9XWJ2PJcHwHFX23ylx9YIvNbLiY
	sr+OAwPhJEMduRucPzPiSFHRPJLSMmE8WAAh5Z14pnPGETLHHu36FWTQDlBGlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784794305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM+fSbe4KRufkuUmCRbI7JsXvwaeDgoJo8Uf5n3fSG8=;
	b=LDnJAcNuk0fdKdtgUQYZhH1q8O17QNV7Hyn9iByZbIChpBlKF0wDK6D/TIJT8oVrG5atX3
	GqSF/aMuckKsTgBg==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/compressed: Disable jump tables
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20260722-x86-boot-compressed-disable-jt-clang-v2-1-7373d38482fb@kernel.org>
References:
 <20260722-x86-boot-compressed-disable-jt-clang-v2-1-7373d38482fb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178479430326.2943223.16484059719740352393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4a9ec5ec9555ad62dc5b81a37ac946025c2ea002
Gitweb:        https://git.kernel.org/tip/4a9ec5ec9555ad62dc5b81a37ac946025c2=
ea002
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 22 Jul 2026 17:09:43 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Jul 2026 10:06:58 +02:00

x86/boot/compressed: Disable jump tables

After a recent upstream LLVM change to start generating jump and lookup
tables in switch statements in more instances [1], linking the
compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:

  ld.lld: error: Unexpected run-time relocations (.rela) detected!

Dumping the relocations in misc.o, which is the only file influenced by
CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
some string constants, which correspond to the string literals in the
switch statement in handle_zstd_error():

  Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 entrie=
s:
      Offset             Info             Type               Symbol's Value  =
Symbol's Name + Addend
  0000000000000000  0000006600000001 R_X86_64_64            0000000000000000 =
.rodata.str1.1 + 73a
  0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 =
.rodata.str1.1 + 78e
  0000000000000010  0000006600000001 R_X86_64_64            0000000000000000 =
.rodata.str1.1 + 78e
  0000000000000018  0000006600000001 R_X86_64_64            0000000000000000 =
.rodata.str1.1 + 78e
  ...

This optimization is problematic for the decompressor environment, as it
is built as -fPIE without any explicit absolute references (as described
at the top of misc.c) while not applying any dynamic relocations, hence
the linker assertion. To opt out of this optimization, which is of
little value in this special early boot code, and to mirror the other
x86 startup code in arch/x86/boot/startup, disable jump tables in the
decompressor.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6=
bc0eb014c9518 [1]
Link: https://patch.msgid.link/20260722-x86-boot-compressed-disable-jt-clang-=
v2-1-7373d38482fb@kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Mak=
efile
index 07e0e64..06934f9 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -27,6 +27,7 @@ targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin=
.bz2 vmlinux.bin.lzma \
 KBUILD_CFLAGS :=3D -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS +=3D $(CC_FLAGS_DIALECT)
 KBUILD_CFLAGS +=3D -fno-strict-aliasing -fPIE
+KBUILD_CFLAGS +=3D -fno-jump-tables
 KBUILD_CFLAGS +=3D -Wundef
 KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) :=3D -march=3Di386
