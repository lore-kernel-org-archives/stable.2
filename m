Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83365414410
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125752; cv=none; b=l1wnOOFL4KM9DnYud5Fh6dunMmELcehq46dY7E7e4pX+XtZR+AMRGu8c7mtv0EDaqUsViC8i0B/fOEyisYkLtjsOR1ld6q0eZ50wbrrWEEmqOTmWy733lr1NFVThJeWLKZzWbgDWsX7EuxrUdQZ2FKpAz2Yf1zKKCE85HjuuqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125752; c=relaxed/simple;
	bh=vHW9MTxRH+t3fa3QMkmV/n4EiVgYaEhS4OjbFt64cio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWeKZHbCYNqFT2tBzCniHIe7N9RE5C5+vCdNNNbhl/Oat4EaKno/3Ekw7F83mRnPL09CZjzMMSHdlFgNSQynL44sPrQl0wjW6XpakHzS0NHruXoFdQLpMKkJdnCuAcEH3TptInVJfPB+X4mgs/xQbzvrOND0+GA4JPCY/a8K5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbJWAkV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbJWAkV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306FE1F00899;
	Fri, 11 Sep 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125731;
	bh=8kJSAgeLvNd6yQQBg98vOo7Nb5vmu37eCd9qGKOLlQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbJWAkV6OyQUcaAzMVRCe8Q+SYT3mW95J2/OFKzSGZ5Ki/tqDK8zmdu8XZufNRC+5
	 4L950+CcZYSagmrGGDSk3et1FktD098KMRYAGyjVciMQ+Q7T5XdV4rPpwZYeG7subR
	 EIuJ9n952V23U9GT2QVYDqRnqCyAWrCIFqelHNxj9qoNyJds6G2Y73wPH1/nzw6V6f
	 buBLCGjAwYms1Qj2VIzbKkfFhpx0T6+o8W5GsT7R4LaMsmTVRSEvi6NcW4PZJW7jur
	 4yc/zwC9UvcNcUKOZ4sJG2Ow5P9c2odK75erazQK+XdLb88X0NsltMr68NtRf4OmbY
	 qCHYUiPP7aGUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 11 Sep 2026 07:22:08 -0400
Message-ID: <20260911112209.352376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090944-either-skid-8b36@gregkh>
References: <2026090944-either-skid-8b36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Huth <thuth@redhat.com>

[ Upstream commit 42398caf16c955251a2dab86f797b76adeb99899 ]

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembler code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This is bad since macros starting with two underscores are names
that are reserved by the C language. It can also be very confusing
for the developers when switching between userspace and kernelspace
coding, or when dealing with uapi headers that rather should use
__ASSEMBLER__  instead. So let's now standardize on the __ASSEMBLER__
macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement), with some manual fixups done later while rebasing the
patch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250611140046.137739-3-thuth@redhat.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Backport notes for Linux 6.12:
Keep the assembly-guard conversion only in asm/nmi.h, whose guard is
context for 546dde823a36 ("KVM: s390: Fix memory corruption by not
reinjecting CK machine checks"). Drop the other header conversions,
including changes to machine.h and net/bpf_jit.h, which do not exist in
this stable tree. Preserve all stable-specific header contents.

Also include the one-line irq zero initialization from b239410c7653
("KVM: s390: Zero initialize irq in reinject_machine_check"). The target
expects this initializer in its interrupt.c context; it also ensures
that reinjected machine checks have zeroed padding and logout data.
No functions are added. The target's machine-check fix is left for the
separate target backport.

[ sashal: Reduced backport -- upstream 42398caf16c95 touches 33 file(s), this
  backport carries 2. Not backported here:
  arch/s390/boot/boot.h
  arch/s390/include/asm/alternative.h
  arch/s390/include/asm/asm-const.h
  arch/s390/include/asm/cpu.h
  arch/s390/include/asm/cpu_mf-insn.h
  arch/s390/include/asm/ctlreg.h
  arch/s390/include/asm/dwarf.h
  arch/s390/include/asm/extmem.h
  ... and 24 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 546dde823a36 ("KVM: s390: Fix memory corruption by not reinjecting CK machine checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/nmi.h | 4 ++--
 arch/s390/kvm/interrupt.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 227466ce9e416..6454c15318544 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -33,7 +33,7 @@
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
 #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 union mci {
 	unsigned long val;
@@ -104,5 +104,5 @@ void nmi_free_mcesa(u64 *mcesad);
 void s390_handle_mcck(void);
 void s390_do_machine_check(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6f13144906417..3fc07da7fd7a5 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2863,7 +2863,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
 	struct kvm_s390_interrupt_info inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
-- 
2.53.0

