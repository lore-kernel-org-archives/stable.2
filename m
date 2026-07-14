Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4AB47DD79
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040691; cv=none; b=NSiYpJnVMUca7KO8Ysfsv3ee4APx9tIR2JDUW9COriuXRkbxCgD6CZh0nI/WjyT+VLQ6crb4sKekgXyulaMHypCImdcC3gtjVEgI8I0NqTlGS1wY4yuGRU1lJECMocNA2/rEFrfkH5M1QMg1dyNsB2Scm8E8uwh+vKeeNvJuA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040691; c=relaxed/simple;
	bh=yNuW/XLgJjMQ/gunTyiSTZ5O5ZaGQRIaWdbVQ7HUJnc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uG+JeQhTcvSvtER54HPL8sSHEvvyHDL5nRhV2y5GvByw3mv4YGdY+6NKuKfE5Fe96rSw16zO0asPem7K+vxJx1YliLcIgNNW3aR2JNYCZOYvcU6u4NAOdKLegCDsccY1H1hFQsHez9QUq3upLF1t8uJD6cqrazM+OpvQhIW+olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHBO1T81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHBO1T81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721C21F00A3D;
	Tue, 14 Jul 2026 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040684;
	bh=F0IjIED4VmRZ1SIexChS9TsXYY/U67hI2vc6MwF5WD0=;
	h=Subject:To:Cc:From:Date;
	b=bHBO1T81VzHCUbDlL47roDrKTDgOs8PE9htIW07tI3I8+lBPwuLbBOHYtAjlFesCZ
	 gQrxN47q3ylNWejmTRq9wjP4nyqyaDicHRozmQ8xCP2D4iSxBbu2WIjQFS0B3X5PFx
	 rlS2jQ2yekBL6jzObGMAfAYMpDmdcrEKIOVbWbhk=
Subject: FAILED: patch "[PATCH] s390: Revert support for DCACHE_WORD_ACCESS" failed to apply to 6.12-stable tree
To: hca@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:51:18 +0200
Message-ID: <2026071418-catsup-creasing-f440@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071418-catsup-creasing-f440@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:37:46 +0200
Subject: [PATCH] s390: Revert support for DCACHE_WORD_ACCESS

load_unaligned_zeropad() reads eight bytes from unaligned addresses and may
cross page boundaries. It handles exceptions which may happen if reading
from the second page results in an exception.

For pages which are donated to the Ultravisor for secure execution purposes
the do_secure_storage_access() exception handler however does not handle
such exceptions correctly. Such an exception may result in an endless
exception loop which will never be resolved.

An attempt to fix this [1] turned out to be not sufficient. For now revert
load_unaligned_zeropad() until this problem has been resolved in a proper
way.

Note that the implementation of load_unaligned_zeropad() itself is
correct. The revert is just a temporary workaround until there is complete
fix for secure storage access exceptions.

[1] commit b00be77302d7 ("s390/mm: Add missing secure storage access fixups for donated memory")

Fixes: 802ba53eefc5 ("s390: add support for DCACHE_WORD_ACCESS")
Cc: stable@vger.kernel.org
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index fe5eebaecb7c..33988cc96af1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -166,7 +166,6 @@ config S390
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
-	select DCACHE_WORD_ACCESS if !KMSAN
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
 	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index d23ea0c94e4e..99748c20e767 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -12,7 +12,6 @@
 #define EX_TYPE_UA_FAULT	3
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
-#define EX_TYPE_ZEROPAD		7
 #define EX_TYPE_FPC		8
 #define EX_TYPE_UA_MVCOS_TO	9
 #define EX_TYPE_UA_MVCOS_FROM	10
@@ -80,9 +79,6 @@
 #define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
 
-#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
-	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
-
 #define EX_TABLE_FPC(_fault, _target)					\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
 
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee7699..e9287036392d 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitops.h>
 #include <linux/wordpart.h>
-#include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
 
 struct word_at_a_time {
@@ -41,25 +40,4 @@ static inline unsigned long zero_bytemask(unsigned long data)
 	return ~1UL << data;
 }
 
-/*
- * Load an unaligned word from kernel space.
- *
- * In the (very unlikely) case of the word being a page-crosser
- * and the next page not being mapped, take the exception and
- * return zeroes in the non-existing part.
- */
-static inline unsigned long load_unaligned_zeropad(const void *addr)
-{
-	unsigned long data;
-
-	asm_inline volatile(
-		"0:	lg	%[data],0(%[addr])\n"
-		"1:	nopr	%%r7\n"
-		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
-		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
-		: [data] "=d" (data)
-		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
-	return data;
-}
-
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 7498e858c401..063b4346742d 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -50,22 +50,6 @@ static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
 	return true;
 }
 
-static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt_regs *regs)
-{
-	unsigned int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
-	unsigned int reg_data = FIELD_GET(EX_DATA_REG_ERR, ex->data);
-	unsigned long data, addr, offset;
-
-	addr = regs->gprs[reg_addr];
-	offset = addr & (sizeof(unsigned long) - 1);
-	addr &= ~(sizeof(unsigned long) - 1);
-	data = *(unsigned long *)addr;
-	data <<= BITS_PER_BYTE * offset;
-	regs->gprs[reg_data] = data;
-	regs->psw.addr = extable_fixup(ex);
-	return true;
-}
-
 static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
 {
 	fpu_sfpc(0);
@@ -134,8 +118,6 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, false, regs);
 	case EX_TYPE_UA_LOAD_REGPAIR:
 		return ex_handler_ua_load_reg(ex, true, regs);
-	case EX_TYPE_ZEROPAD:
-		return ex_handler_zeropad(ex, regs);
 	case EX_TYPE_FPC:
 		return ex_handler_fpc(ex, regs);
 	case EX_TYPE_UA_MVCOS_TO:

