Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED5184;
	Thu, 23 Jul 2026 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765402; cv=none; b=ZryD2kCxYxOgPt9rNfNj+zb3m51XBLKvc+h0uZda5XpVkr+mlS41xQxBwAakYwCciuzlAX9g9WvF4DzMKKKO7Z77nE5BxlFm457IjyBuDT55C/af6kzPWsgEws/D7W3f5sZfirY5AzuOTOBleZG7xGyi2NXxBjUhCAyXDXs6rNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765402; c=relaxed/simple;
	bh=Zu9oImaDwyIfoRz1q2AfzbW8Vir4fl7pMnnm74kpUNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lh/M897d6NW905TUS3Cubk55NMzViXgod1Oe9CgwqjU0UoWEmQ4PtKtNrzB45ou4fnI6hRK2VL5DSvCRFodUwx8ZQtFZ/p4urxEYKWDsD9Pua/2aft4vlj/0zBAa7JtwH0lbBva0ER89KX8E3VgjdD2kFImMN8vuyDZhB+XfioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/MErgR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/MErgR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211C41F000E9;
	Thu, 23 Jul 2026 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784765400;
	bh=RGDKxBCbXr9QOavwty6iyYJZjfOOVij2zQPxRnMUWOA=;
	h=From:Date:Subject:To:Cc;
	b=I/MErgR3ZkWUQgplmAG73RA7x8E0Y5es79mUl2qlzf5K3RqHNppc5kPYQ7u+e6RDc
	 od1g8r1SejPUCEBsCvA0wYycWHI8EqA4sN483Oi9PSuWhuTNOWZzQAN/XfFGUUeQx0
	 JamwP1uoqJaNlQAgpBdbyWjgMNKCf29sfxweao/zBzO2XwNLRyGyr4J50nNqHIdzQM
	 HLa5rrmOFYRcDZ0rU6tQ4xgkBKoltWH7/9/rmfENlfRFQtxDV4VnhFbo4XYcJ8IUiq
	 IYsgUHt6NO8useASROPmFwmlwsiz/OjpOnzctThUg1q6lg9NOaOxg78VoZdyWK6zIf
	 xrSHw/sBXmpQg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 22 Jul 2026 17:09:43 -0700
Subject: [PATCH v2] x86/boot/compressed: Disable jump tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-x86-boot-compressed-disable-jt-clang-v2-1-7373d38482fb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dkxbU0BX3sOwgHYKRWxNBwmGc
 HcLxr3LP3n/v1kYYXRI7JItLOLkyAWfgjxkTHe1bxGcSZlJLnOeSwlzmUMTwgg6PJ4RidCAcVQ
 3A0KfrkMqAVphrK6l4ueSpakEWjfvmlv1zfRqetTjtr0RnaMxxPf+xyQ27qc8/aecBAhQhbJaG
 1UKXlzvGD0OxxBbVq3r+gEWItSQ6wAAAA==
X-Change-ID: 20260622-x86-boot-compressed-disable-jt-clang-ef1dfca25098
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Zu9oImaDwyIfoRz1q2AfzbW8Vir4fl7pMnnm74kpUNM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmJ0Vc1H053DmDzfF69e4/OgbVPJmdtuHtwadeSeatne
 XP/XH10d0cpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYSOxKRoa3v1fMYX75Tzud
 KSRR6di2aPn1wVoum2Wvi22qcGN5f8SUkWHC+nsfbrdHdMw1Fqyx4ztqcnleq0eP9ocv0zYJTL0
 97xwvAA==
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
little value in this special early boot code, and to mirror the other
x86 startup code in arch/x86/boot/startup, disable jump tables in the
decompressor.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Disable jump tables for GCC as well to mirror arch/x86/boot/startup
  and adjust commit message to match (Ingo). I kept the rest of the
  message for future 'git log' travelers to see the original issue.
- Link to v1: https://patch.msgid.link/20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 07e0e64b9a98..06934f9691d6 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -27,6 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(CC_FLAGS_DIALECT)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
+KBUILD_CFLAGS += -fno-jump-tables
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260622-x86-boot-compressed-disable-jt-clang-ef1dfca25098

Best regards,
--  
Cheers,
Nathan

