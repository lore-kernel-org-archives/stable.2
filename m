Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2A372ED7;
	Mon, 24 Aug 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559993; cv=none; b=YLNs7VmoQoQLslEK0GGTNbd99Vw4TT6tbnl5UDKu53T/S6QUVYmedzsmGhE83uU2xmh8Ssf05KqAvv46N4IO0MtC2h3CF2462Ehr+EJDV5Jk5DDAMPDnLgaeN4KyFQ63ujyU7RBc1tFp5m67/6gl6sOJlXdyPdyjBW+LfNC5Vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559993; c=relaxed/simple;
	bh=gnMZQhlcLdQZfBgNd8RKcF9khoOP6CQEisRAnDO6COs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gBAAFxZ34Gxf0g1BTmIYoi62jVYZfhCt5iEXf/TbWAVCq+7tzcYbm6m+PIaflPl3ahiPNlARZKL3NB1i5vjlwQrsoBknc3k5jpXwA5470y/sscM0W4w9EiRJTlOmyYfG+Qb1u+l3g+OF2QZ5fRg5IzF8YcnyVjSzSazqiYs7oHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hNKnQ8XF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hNKnQ8XF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787559949;
	bh=czL/yE0bCmAN4P1FOK/8SGR9DFbiHNsq7jBEhme2hcA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hNKnQ8XFwA0XiPmAAcEF9WXLk7EiszGcyT6Gqsle8CtfbdtYViLzL/PM2+uVkhXNY
	 9LePFZ7eeP9opjmrd4mT4uDlejsei4h6cmyH73XChgfFozSeIETI951kjJyVCUTIsk
	 VwhNP6DxUozsE52+FLbNJpFOu/6v0ozKtbBy3a9A=
X-QQ-mid: esmtpgz14t1787559928t2a1ddcc8
X-QQ-Originating-IP: 0ANnjSMeXacE1awNZUHCmy1QCe0M/7ANd9jEhMnZya4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Aug 2026 16:25:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9794084815403460053
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: rethook: Do not save/restore percpu base register in trampoline
Date: Mon, 24 Aug 2026 16:25:24 +0800
Message-Id: <20260824082524.3801394-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OD6FFkn240CDDTy1/XoaQcPqU+TV9vj/uxto0uaZ6Y/MTbbfbdIbSq6Z
	rw+hBThI2pUcEIZp61vDeFNckV9gcYdMPMR0vFjmDNoKnpJggj2Ob+p3Xugf/98t5iO3x3P
	/Lb2yW9+McmEmi7MeNaE7UYkI66V911Atzvck1U96CpeUd76tvivnqveapJ/4RvvfTsGRR3
	MKt8v01dXFbQtwYuD8APb4oA7jKNhNRs8rnjObNFTnIk8uWbPkvs6pxho42dZXNEfU55D0B
	pb1eq2fdQTIMJ0PbG8rM8vdBgsDGiZtLtcun+2ZzdFMXFLbXVzIB+hItI2kld+sLsQtMxpA
	NO6LWjEk2BTlsGyBZ+Xebt+0g+GQH1EpctoqGXjnw2fC/b/h+IkgniTOsSIa0XHSkP9lShd
	r+RrJFx2D4A0VgHwjizKJZpmSw0Y/PmpaGY6qy7iY4r5NNlWJT/nb0L8dlY5Sx/gJ9W3xwW
	eUWOGcp1XWjhASJi6tvXClIPHZVOCVoe208hfyBv4mGNmnye+6pohz0/J07m7T/xhIjoesV
	fcP6bU7y2tJpO4xdmoQkzVvfNPVVfZNxjr3XyDYQ7oNgKffOEH7cuCFJdNNNUA8Us3+Z5tD
	cBgaGf5V506t67zZ2GkpvWagzeMs07JqAz8LYBdT+h8QTIs54egld1QNn9P3ltPFVndGGXe
	KcoMxHDN0bcY18iFD0EgAUE4oNOlKz9T8pSQfxWHOgSFM45W2eM4fXUQa3vqaol1/QuZUUj
	Sl4Yb1Hc1rkRxJcucV+MROFxC8A5c9FJaJqfh/IEMgiYxknFBaTkIMseFsC4nykPkUsOJUM
	/lPYmuTCMN3pt774UxBENWYv2rsuQk/i+VtUrfrdPrNEcoFXFQh8wUu0h5az23YFCeBe5wP
	PM/A3RtG37xptML24+aZtYp95IkMWg+ennB7plL7x/apJOe1xFIkDkIXwB2wx5jf2l3espf
	xeYEH6xrkFf5iDbIE6qXGAsKYKIr4q/6rK4trvR5RWTtlvEy0XpQYnbVW9PFxgxDkER+Peb
	xfiRZPDjblgbXIvRqZojJq10h1lQVLbGXUpln0GnLrg9r3JDl3UGMBf3pLmTO4wZFAo6I7Z
	9kROb7gVcJP
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
the restore.

Fixes: 3f5536860086d ("LoongArch: Add kretprobes support")
Cc: stable@vger.kernel.org # v6.5+
Assisted-by: Kimi:Kimi-K3 # debug and root-cause analysis
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/kernel/rethook_trampoline.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/rethook_trampoline.S b/arch/loongarch/kernel/rethook_trampoline.S
index 2e009fbea53f2..5efe0268b3143 100644
--- a/arch/loongarch/kernel/rethook_trampoline.S
+++ b/arch/loongarch/kernel/rethook_trampoline.S
@@ -24,7 +24,12 @@
 	cfi_st	t6, PT_R18
 	cfi_st	t7, PT_R19
 	cfi_st	t8, PT_R20
-	cfi_st	u0, PT_R21
+	/*
+	 * $r21 ($u0, percpu base) is deliberately not saved/restored: in
+	 * kernel mode it must always hold the current CPU's percpu base,
+	 * and restoring it from the frame would poison it with the old
+	 * CPU's base if the handler scheduled and we migrated.
+	 */
 	cfi_st	fp, PT_R22
 	cfi_st	s0, PT_R23
 	cfi_st	s1, PT_R24
@@ -59,7 +64,7 @@
 	cfi_ld	t6, PT_R18
 	cfi_ld	t7, PT_R19
 	cfi_ld	t8, PT_R20
-	cfi_ld	u0, PT_R21
+	/* $r21 not restored; see comment in save_all_base_regs. */
 	cfi_ld	fp, PT_R22
 	cfi_ld	s0, PT_R23
 	cfi_ld	s1, PT_R24
-- 
2.30.2
