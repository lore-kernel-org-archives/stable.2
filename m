Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A03B27D4;
	Tue, 23 Jun 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251244; cv=none; b=mx1f1rLlTPB5mKRaAevUSwMUER4CW1bYHbEgevhNhAbfqjCV/XtX39tHN8qBQUAUJMzbd18S3PhSD4ApnwNtVP/o84ToQgqu+GSVgXx0JY4+ob+jV6h+MQo1cJZ5oEb0KH5hO5vfj/f0kjfvs2NGYqJR0KZ6N162vc8VOIlyQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251244; c=relaxed/simple;
	bh=5zUhtrAdGHN5IF/2b8iNsjFUbPtdTc1dwXE8kptGCl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aQ20tAmz8w2GHSZy9rRmqxgJTNg8jL29DK22VswaY5v4OSemxjogtbn3ocWUyLTI/8BS7ONw3ziD6d/MtUnyG3MPZfGO2hrGlyU36gH2pQW4ywUb/taGObHRPNwjgJygHZ0isX0N2vHZ3HI5kb6ayTJZ9irzx0k1YpCDD1I8wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxqb9Kng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxqb9Kng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B401F000E9;
	Tue, 23 Jun 2026 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251240;
	bh=/0LMbDiDwVn7Np1c8cJ0fyDmbGJkv/yezObwHtuFrEg=;
	h=From:Date:Subject:To:Cc;
	b=Rxqb9Kngb9yE1x9Zj8O/LOmEJlP3NPR4EYsrPRqd3MEZyOgebqV7BL5etI73ZVU2B
	 jaqcaVqF0QlQvg7YYh5eZKOMXSyTwGnAlQBC0lE1m3S7CEcLfpa7mnDMHTQboo+VSl
	 OCZMs8IbyAju33w3O0R17TWc8BPyb4EqfM9F+BoTYlyE1laaWrFuUQuff9BT+/HCJa
	 ZQArZoCHjfVw4SiMq7iJkffoJ55b/WSdFFZmjLh4dITZtnLMlqi4/L3yDv+IOR9YTz
	 JIDiv/4I9irLT7cPg91UB6RbRxHLzxDumdFZQW/jnN5ekWsvyW0wJp6l8Jf58HJdOh
	 SPVwHNi6Qbicw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 23 Jun 2026 14:47:11 -0700
Subject: [PATCH] x86/boot/compressed: Disable jump tables for clang
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCQAxEf6Xk2cA24FL9FfFhL1lNqV3ZVCmU/
 rtRH88wc2YD5SascO42aPwWlTob9IcO0j3MN0bJxkCOvPNEuA4eY60Lpvp4NlbljFk0xIlxtHS
 yEXLpc0mBju40gKmsWGT93Vyuf9ZXHDktXzfs+wcHk4cCiAAAAA==
X-Change-ID: 20260622-x86-boot-compressed-disable-jt-clang-ef1dfca25098
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5zUhtrAdGHN5IF/2b8iNsjFUbPtdTc1dwXE8kptGCl8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlW/552yF9aP6vzVmmF0a+wG+oTJFe5LzVSmDx/mU/Oz
 yn165bf7ChlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATYd7F8L+g0NvE+d0kpY1H
 zk1otnj7f554j+mvz2JXjj9K+3ea2/EAwz+7kgWMpmviT3CI37Gpi2fRW+V45uPjYLb+pIWxSyc
 xp/EAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent upstream LLVM change to start generating jump and lookup
tables in switch statements in more instances [1], linking the
compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:

  ld.lld: error: Unexpected run-time relocations (.rela) detected!

Dumping the relocations in misc.o, which is the only file influenced by
CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
some string constants, which correspond to the string literals in the
switch statement in handle_zstd_error():

  Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 73a
  0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
  0000000000000010  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
  0000000000000018  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
  ...

This optimization is problematic for the decompressor environment, as it
is built as -fPIE without any explicit absolute references (as described
at the top of misc.c) while not applying any dynamic relocations, hence
the linker assertion. To opt out of this optimization, which is of
little value in this special early boot code, disable jump tables in the
decompressor when building with clang. This mirrors the other x86
startup code in arch/x86/boot/startup.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 07e0e64b9a98..1c0d29e3eeba 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -31,6 +31,7 @@ KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
+cflags-$(CONFIG_CC_IS_CLANG) += -fno-jump-tables
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += -ffreestanding -fshort-wchar

---
base-commit: 4708cac0e22cfd217f48f7cec3c35e5922efcccd
change-id: 20260622-x86-boot-compressed-disable-jt-clang-ef1dfca25098

Best regards,
--  
Cheers,
Nathan

