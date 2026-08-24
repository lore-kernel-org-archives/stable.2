Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DE3EFFBA;
	Mon, 24 Aug 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564093; cv=none; b=YeFwYOti4p4jA+Nc0+XGC231J23Qh+trlp9C1PslD5GoDxpLDMbaraUm9t6CNMmjNttPOCMr+0qjdPyeVktGcFSj//C3n2qhXdPK0bLAFToip9Qbi+vpxO4zb8BBaXbF2C8Ge7o0UzGAfdjNexOhTGygqu9zXFNp3r3vilGy6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564093; c=relaxed/simple;
	bh=heOtZrexFpj02TBC1ZUGwrinYUrNBMsAkbuJXrM3mjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaNP3M143mqiY6yX6OyWKp5F/FnyyH3+Bs0HdsyDNBUHKYgF9YHGHG8JOWvQWAcF7SVwRWzJrkMROly2Ox5/81UyBjQdUw8vLJdpWieEIGsog3l7i2J0atCt3f6bzLcMnJJAOsP5D7I3QOqIbFVVXJsPe/0zeJOiPzJ9xd2geJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MeX3Ioam; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MeX3Ioam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787564053;
	bh=BlOmK0hxH8yg/xtlWZc52Y8E1iGkm06urj2m8MTL+as=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MeX3Ioam6ULJzZVx4FaRyWLX5CFLambiYjfr+kaIRNzwl4gfJxM+PwxGp5IGBiV10
	 qDJKyiBOxzqaqO/IXXVzyAqdhUOrt9NFgdK3fwUYSRGfelWUX1Hgg/2G9YIjIzf+Cz
	 9RAjE8Ki501+6CbeNvOWCTPSEtpg2KfX0IvBZzm0=
X-QQ-mid: esmtpsz18t1787564034t822d70d8
X-QQ-Originating-IP: eYD2IK+oypIqXuEgbVqjdqP6o0qduYAs52P64cBWq4Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Aug 2026 17:33:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2674811632270747063
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	yangtiezhu@loongson.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] LoongArch: rethook: Do not restore percpu base register in trampoline
Date: Mon, 24 Aug 2026 17:33:48 +0800
Message-Id: <20260824093348.3814991-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M+McIMNbTNElWw7kw3vNmRbKm/niiM3fGNLfs0K4rQ1GoUrh6AO7+cZ5
	V7JFpUwg1i+s73HvPiqsOlCg8Kxpn2BV4OvDygv8gmRRzl0zR32NKBOJA4tm7++oe9JZyOa
	BdIFXiuAaiLdnCA5+QxIWRnlvvubWS9sSPl/8Wx70aC3hEt460CCKq6DEdW2t0UKRdK62r1
	I4jQpuDBOrlXsJh+oXYCG1oaR3W3WJLPcp4/o5JVAgvw0itl312ebodoJT3aUnvBQujBNry
	ZrGtInDvP8cuIVVK9W/A0J1o3id9O3JBkrsEIVSiaskcnG6OqFyjCjfDDSrqRlTzAzxPfjc
	lJBWHn3A8DxrPX2MBjKDbIIpiw/gucdHj5I9/sgttZrANSSPRi+5Ww4r6SAPzh1b7apJalm
	G0v4uD7nDz7slwqOQcz8xjE2xFdl2LwZ2qiGuDeEsF4G/m7lGWM9BFbDWGu365wBraHRwyg
	umEKzbvJPJbItYRHSQ3dzi/UEgGT4Q4C14WMTNgxSzSUdoe5cNPxQsIGmivjx0B3vkk9VS8
	qM3lq6iQwBcvH7I3UJlPlJgvxXGiDr8zD4RAyms0uzvwnWYsWyZwzM1EcQqnUd06LFcqFV1
	s8COhCxMs2xrmbC64K7YfC8tx2swk0T7rAS3kgc8Drpgbte4ObRBbbpuhEtVsMbZSPtA9OR
	875LVddY+MNBsyDtN0GrdsHYx1cl4KjAJw34y0mZwqoUe7F1f4m9x0y7VIrqMBUgEq10sd1
	avnJMqiIK1lM+9Fkn/SK/VjZFmv2wBZALgu5IMvHOuEN9Z5MpDpcFRAZfvlIxGdQluGy7JK
	gMDyC8qhmsBvC/X0W6K6Ga91BStZzUVDEUbP5dOTMFo31wduE9gpZ+Y9SY5ifnINw1Vo9pF
	kbj4ggX6yf09azbIwwwvD7J/ni62XCTjFG40dSGxX1n/2+7UJveyhEirWv2d9yzTs/hyYlR
	QURjJwKMIjaK66ZRAZa3xE0iXOIrPOuN4rO7hguqW8WXBenz4j24SPaCS+YFa8mlqkb2srA
	3Gpuj38cspPO8+RZcndMpRya6y9knhLqQZi/n/7jstAvHtb71XoNsLr4mYKXOszrTCbjT7J
	aWIH8Z4lfCVx6epIIcnExPR5rB6xR/5no+wJQqVYGMkL68G7dMLHhwwOD4H2TOJaqt+jWu5
	e9bjMfjv1eVK+Jw=
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
change it (kernel C code cannot write a global register variable).
Drop the restore; keep the save so that the pt_regs view handed to
handlers stays fully initialized.

The same flaw existed in the pre-rethook kretprobe trampoline since
v6.3; it was carried over when rethook replaced it.

Fixes: 3f5536860086d ("LoongArch: Add kretprobes support")
Cc: stable@vger.kernel.org # v6.5+
Assisted-by: Kimi:Kimi-K3 # debug and root-cause analysis
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
according sashiko report, keep cfi_st u0, PT_R21
Link: https://sashiko.dev/#/patchset/20260824082524.3801394-1-guanwentao%40uniontech.com

v1 link:
https://lore.kernel.org/loongarch/20260824082524.3801394-1-guanwentao@uniontech.com/T/#u
---
---
 arch/loongarch/kernel/rethook_trampoline.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/rethook_trampoline.S b/arch/loongarch/kernel/rethook_trampoline.S
index 2e009fbea53f2..94adead8faa5c 100644
--- a/arch/loongarch/kernel/rethook_trampoline.S
+++ b/arch/loongarch/kernel/rethook_trampoline.S
@@ -59,7 +59,14 @@
 	cfi_ld	t6, PT_R18
 	cfi_ld	t7, PT_R19
 	cfi_ld	t8, PT_R20
-	cfi_ld	u0, PT_R21
+	/*
+	 * $r21 ($u0, percpu base) is deliberately not restored: in kernel
+	 * mode it must always hold the current CPU's percpu base, and
+	 * restoring it from the frame would poison it with the old CPU's
+	 * base if the handler scheduled and we migrated.  The save side
+	 * stays so that the pt_regs view handed to handlers remains fully
+	 * initialized.
+	 */
 	cfi_ld	fp, PT_R22
 	cfi_ld	s0, PT_R23
 	cfi_ld	s1, PT_R24
-- 
2.30.2
