Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9921A8F84;
	Tue, 25 Aug 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622563; cv=none; b=kmgQdmrtwjx4If1umpHBnrkr1FkTdq0M4ByxVBWBMk5js/V7h5NIwjfkguQcsQVhVzzvUIV3IRkXcEbhPG3LBbefOml2QR+rI+Iy3iYdYhS/x379ZyokhhMabFjHSh2QekVLhQWxSbo5LXPKNP1ooenOuV8UcJVYOr+TXoNB4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622563; c=relaxed/simple;
	bh=AF5pKzImQNdwrQFr0In/qwMjLvp+LBK2QTys739r888=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AuXPNftnAALzcOVlCtlkh66V7i29LBFhsqARYBTNFqBoznG4ApeJKI9QtZE1kufxUaPHKS6H54P/3Q2a35WyJgrjgJC6mkniz95w0d7neCBxbiHfp+m1MPAImbNN/pZ7anb2GYQJhiqO0/Qmvim9Q+p3DYctYeBdvOeJwNP9/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cLtJIM+x; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cLtJIM+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787622518;
	bh=qRiyU0DoKKcxojYlzljbl+JNJ9VKHBiaEYExpAI6lCk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cLtJIM+xKhRUDpm4H+i/Pp5WBiaTrrVS2/wujvW3gxLeIXnW9HOcVOQunNdGOZwkQ
	 Fk8qHlSluh3iDRjb+q8+LOLi8Ug6p3bAEa4tOqHB+OkDxyGGeSNr8s4xc6SIu1q/51
	 AIffCxcQLrBg3YxqtreYPGJctTV+4ubgwVclv+/U=
X-QQ-mid: zesmtpgz1t1787622500t978aadee
X-QQ-Originating-IP: TXpQtByIU58RcarrWIcwdw9wFx4XaKb/Y+67iMcCSYQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 09:48:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2398855939932772287
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] LoongArch: rethook: Do not save/restore percpu base register in trampoline
Date: Tue, 25 Aug 2026 09:48:07 +0800
Message-Id: <20260825014806.3926864-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NLUem33HMZ4dcVSZrgAXDtPP0io/fIs9ODqeim/v0z5Gupsqh1OLVUg9
	8n9dKW2XRvoVvAR8O7TvTwSwx8ArFC94HVXz4EXf9gMPz2F7teFsIAdRm2H00Bu4nGtHzCE
	USTjIXEFP7x0p39UCC4X9mdfuuStMglQ5OzaMOJI9un52gm3cKpaZufqvkh7iJW6SzaATSX
	Lngjb7+ax4jDURUfm3t2bywYJ2U7BcANhCHzj0rPCKG+O+7TxkXo0AGwWdBwLTZnmxvbOaH
	TuFptVBcEjSoLYuxDnbLqBfgPiIfrc0bjtjl6/Q5VXbJhoe8E50IDWyzE2jbnvmOS6K0wmK
	/Wp0bkX+lPAydYPYB6Fh6oBCkuuVZGciO2D/2mgPHSaTU88QOY7z/t6kTy5FkKF7G+8+K4H
	5tSfxvNKLyHUZbAYyZfQIdLhD6VtLwcz34MUIpwG5KGWhqYo1mRNxu+3dEQ+8pjDxSOnA4t
	C+MnRY5xCK/MAPIikD4infwsZf/YEDcxLAu1e61Labj079+abQ6hbbjl2xH2VfwnD7ejSLv
	9IFFtX8qyLDk3hIcET7Rwqz3iwoC9idhmitzHy3pvDLO6iTd+EULD2B4dxdpJDRSqidldNm
	yf63lSqZzVpBJ4mJcVcJWlmmTskts9g9CqfkpZ2VHg4lfKExvtkR97ZWrMDwIE4fCRH4IeH
	IMwuZJV85xpQ5Ux/ejSWwEu6BjzRoQYyDRCAdFGjXsuuRTVWvY4fLv5LaIFHvlbCKN6RXUR
	FlKVKeXoqUVfgq1gXRU72e0GnireljXL5Do7S1S8QiQRMZkwYBq4Zf0IS0GT5SZXux4h7MT
	guHYLG/HowVIjP7v5ycb984QlRAyDSjvfzjYkFKXklO/RjDY9OWCU+W8U63d2aTu/n9cLfC
	5wco0tdad+4b8x2cssMdhkzwATIufuAoI+XZ6Dw85tci3r4mk/TDt2wJoINSOBPMK6zojEh
	R7qoLuwrAPmdkgvUaHH4ssjViAgg5heAGnohDaCRfDYUh+5jEcuFB944CHN4W4z8YVWeQwJ
	R1bJa0//OQKvwW2MytwseqVhqUrOXITswJArFTUTCySmUELB1BEqHFGFcvbZBJ++SF5GoyU
	mKGxcrDnHF5Jz+iFkbX3s8C4xjIUu3rsr1BBiF9F5oFSLUfYkbTFDCz14fASh4UWw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The rethook trampoline saves $r21 ($u0), the percpu base, into its
frame at entry and restores it at exit. In between,
rethook_trampoline_handler() may schedule via preempt_enable_notrace();
if the task migrates to another CPU, the frame's $r21 names the old
CPU's percpu base, and restoring it poisons $r21 on the new CPU. Until
the next user->kernel transition heals $r21, this_cpu_*() accesses
(runqueues, RCU per-CPU data, timer tick programming, FPU ownership)
hit the wrong CPU's percpu area.

Under kretprobe-heavy preemptible load this corrupts scheduler and
timer state: scheduling-while-atomic splats, wrong-CPU RCU warnings,
WARN_ON_ONCE(rq != this_rq()) in nohz_balance_exit_idle(), and CPUs
parking in the idle loop with the constant timer never re-armed (hard
lockup). Reproduces on a Loongson-3A6000 with kretprobes on VFS paths
plus heavy file churn (OS install / unsquashfs).

By convention $r21 always holds the current CPU's percpu base in kernel
mode: exception entries reload it only when coming from user mode, and
RESTORE_SOME() restores it only when returning to user mode; the
context-switch path never writes it. The live $r21 at trampoline exit
is therefore already correct, and nothing in between can legitimately
change it (kernel C code cannot write a global register variable). The
same flaw existed in the pre-rethook kretprobe trampoline since v6.3;
it was carried over when rethook replaced it. Drop both the save and
the restore. Drop the restore to solve the issue, and drop the save
to keep the code tidy and for a privileged reader, neither matters much,
so no need to clear it.

Fixes: 3f5536860086d ("LoongArch: Add kretprobes support")
Cc: stable@vger.kernel.org # v6.5+
Assisted-by: Kimi:Kimi-K3 # debug and root-cause analysis
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v3:
return to v1 patch, remove the save/restore both.
Drop the restore to solve the issue, and drop the save
to keep the code tidy and for a privileged reader, neither matters much,
so no need to clear it.

changelog v2:
according sashiko report, keep cfi_st u0, PT_R21
Link: https://sashiko.dev/#/patchset/20260824082524.3801394-1-guanwentao%40uniontech.com

v1 link:
https://lore.kernel.org/loongarch/20260824082524.3801394-1-guanwentao@uniontech.com/T/#u
---
---
 arch/loongarch/kernel/rethook_trampoline.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/rethook_trampoline.S b/arch/loongarch/kernel/rethook_trampoline.S
index 2e009fbea53f2..1601894446845 100644
--- a/arch/loongarch/kernel/rethook_trampoline.S
+++ b/arch/loongarch/kernel/rethook_trampoline.S
@@ -24,7 +24,6 @@
 	cfi_st	t6, PT_R18
 	cfi_st	t7, PT_R19
 	cfi_st	t8, PT_R20
-	cfi_st	u0, PT_R21
 	cfi_st	fp, PT_R22
 	cfi_st	s0, PT_R23
 	cfi_st	s1, PT_R24
@@ -59,7 +58,6 @@
 	cfi_ld	t6, PT_R18
 	cfi_ld	t7, PT_R19
 	cfi_ld	t8, PT_R20
-	cfi_ld	u0, PT_R21
 	cfi_ld	fp, PT_R22
 	cfi_ld	s0, PT_R23
 	cfi_ld	s1, PT_R24
-- 
2.30.2

