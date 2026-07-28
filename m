Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011E3BBFC2;
	Tue, 28 Jul 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231455; cv=none; b=DjtYFXbyPHHbiq5abYvvSO1UPaGHK+Yr7n0ZWFaqzD5m7dNOQpeE+t2ATYHh5m3TvI7HhOJIV5HSKg5wL8zyNCnHWFJ8KFdDiMgHUppNLOpL56C+oUs/Pu+AcuLjRpX1LelUUoYbxrOoD9Wmw0ZOtz8gxFoyJQWtrvo2KphL8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231455; c=relaxed/simple;
	bh=u7q9AsM+ki5AlsnpwWFMF+9oIaQLH+1sEJj2Rb5cdm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XYNKxzTCm0AiEeS1VdFBiua2unJCJmSpTDR1fL8AF0ZkOG2lGbfT24CeNjHxCnRp171QfQ8hcmUrC8+NWzyhIDBMaV6L6JazWQCno6idH7tdXOxgkBd5iqsNizcyaspu8E6kQ1ok/SjU1fab51Xv0V1iyJ/JMWfAjP/aUIOkkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=iybyurhY; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="iybyurhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1785231432;
	bh=8fCOUsx0444xOiYJjLi/BxZmA+7UPJFelel0WkroNHA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=iybyurhYeTkkLCpxtmrXVpJNZn0Pak5WlIyEFJyOFGzTYCQ4NH/5ew58O+tZDLOvi
	 QsM+CCAHbVC2u1wYWeJJwAbxmheGSoulExDk8MUETgz1b7Ovk3L/XeTAlEFM2Nt82/
	 Xf6EelXmDGdnk6bAoeg0K480KVD2ri3QV9zk4IZc=
X-QQ-mid: zesmtpsz3t1785231429tf850c34d
X-QQ-Originating-IP: LCEw3mgx4E2Gruu0oCqUhT5bIyN/Q0xwg1kCeX7B0s4=
Received: from [127.0.1.1] ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 17:37:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3040970083133766586
EX-QQ-RecipientCnt: 15
From: Peixin Xie <peixin.xie@linux.spacemit.com>
Date: Tue, 28 Jul 2026 17:36:12 +0800
Subject: [PATCH] riscv: acpi: Handle LPI architectural context loss flags
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQrmnCDMkMeBXDYqwFShBJi8SEc
 HdHXbzFt3j/AcYqbHApDlDexeS5ZLiyABrTMjDKPRt85UMVfUQVox0TrYJz3iYPVgy9i3WbAjW
 1g3xdlXt5/7LX7m973Sam7duC8/wAZl5243gAAAA=
X-Change-ID: 20260727-riscv-acpi-lpi-timer-6f1739a6c831
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 stable@vger.kernel.org, Peixin Xie <peixin.xie@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785231427; l=2112;
 i=peixin.xie@linux.spacemit.com; s=20260727; h=from:subject:message-id;
 bh=u7q9AsM+ki5AlsnpwWFMF+9oIaQLH+1sEJj2Rb5cdm0=;
 b=OyPyxwPg/spQvU2rXgykpOsHasu2MJGcUToy65otILXBQKyoFvo1iMbczUh077ZHsuIlpJ38e
 7klUMbgC2lYACnaK43HFfPkezqSD+wDCxuw5Q2MlUkRFUbc2RBEgCC5
X-Developer-Key: i=peixin.xie@linux.spacemit.com; a=ed25519;
 pk=jczO0FmEQZBoClfXslkwCsHKDmSRchQ1hQr8W7yiiXg=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nsf/gSMgV+kGvFgt2GnbzpdQTRJunaFc0PTTUmUHWpe4pOHxM6wiTqNs
	c8mGR0ez7Fjjc7a2lZLkCvkYjbyhj1jqGp/mQZTYVkJbL/WWkG352pbVfmugwW0VfNnUZj9
	U+C1H3NJo3hZAq4eRmGtIvNLOmtxSEWd3ZuZITbuzBy67cpvK+Edu+VwSe91QnZn1Lh0oWw
	4CQ4g9dMuMBc66jXG0rxKom3a67Hp7cm+J9ZiXsZBEeLLna5tMFbMP0/Ytok28R3is5lMqN
	FFFx+s+oQ8axxo9audvDszjrmIbZZOzSk+W/QFcp1M4c/JXdV7oElo+2MIvmZ8gwxxcJyZ8
	bkEbnZlvw3wS6TvDhgW9Kh46bbN82O/FQ5fkD/9fMJo7zxaaOEO23nTyQJ8K6mLGX/ukQRC
	UKNQ/KawmZWF7PtXY/7pvS8Ll6Kf/KhzWmVrhN7SNlxLVzjnzHtSI+0mLtpIv4qQjNW1lIq
	RKLkzYjt/hkQ9Ehs1oF+AmA3pj2dBEdFH0mqibIhC6+A+FZLfhHRmoqz7KGF4OqKxbIwGAB
	y7VjhgKPv6YkV9SJSwjs0YZVbR1ZV1FleFtF/AyKiTdrvo1K6yJlQYHftkFuqIb30SQl9PQ
	zMxiVm8t9dAiZrxaZLAEVzTrCaod2Qg3uJiIlI1fMGRap0WM7B2I8DsWbPsy4824g7VmkGE
	BfYm8i7rSB5u4kt+sOGhab46edYKSbz4ZTnrXLa2CSn3EP1ChbBCrwRe4Jdxbk4I7F1CiVv
	l1okjVnHqTFnKa3tXejhmVNC0Q4j+YRsFKlEenUIp6RsCFMuzSag+khEcT1EQjAjKII19K3
	xZwRHDZXr7AdXeUedhQ8UBDwrhhxoAJTaEaxLLh3sxcy5fgisjjaB/MSGlNAT/5vIB/4dZb
	fS965wx0X2iTdyJ+sL5TCFfZbkIxgDnl+m5ncS6NSvpcGPSg6NtpxqYWVatm/CoY+Ez423D
	G/rHcaqx+nW715/Hqlsy6GeKMyQauLfrsv7ZJ6uzsZjVAcg2X+QexgAbkJumXX42aFIuwWE
	Ngrb/l49qMkZCbEd+3cmGykfg5QIyn6vzkuDmyzuonIlwkbTcjSjWZlMN2b6bw9BTEELOmW
	c11wHtld9DMANmLsck26a3pe6X1MUas89oGZquIANPM
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
broadcast timer") replaced the generic nonzero check for LPI
architectural context loss flags with arch_get_idle_state_flags().
RISC-V does not implement the helper, so it falls back to the stub
that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
an LPI state loses the hart timer context, preventing cpuidle from
using a broadcast timer for that state.

Implement the RISC-V helper and map the hart timer context loss flag
to CPUIDLE_FLAG_TIMER_STOP.

Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
Cc: stable@vger.kernel.org
Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---
 arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..3a3da834c340 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -12,6 +12,8 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
+
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
 
@@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+
+/*
+ * RISC-V Functional Fixed Hardware Specification Version v1.0.1
+ * Table 4: LPI Arch. Context Lost Flags
+ */
+#define RISCV_LPI_HART_TIMER_CTXT_LOST		BIT(0)
+
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	if (arch_flags & RISCV_LPI_HART_TIMER_CTXT_LOST)
+		return CPUIDLE_FLAG_TIMER_STOP;
+
+	return 0;
+}
+
+#define arch_get_idle_state_flags arch_get_idle_state_flags
+
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)

---
base-commit: 1d6f0a217c662693d2307ee06851cb4bfcbf9529
change-id: 20260727-riscv-acpi-lpi-timer-6f1739a6c831

Best regards,
--  
Peixin Xie <peixin.xie@linux.spacemit.com>

