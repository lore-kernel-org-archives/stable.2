Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED22D8385;
	Mon,  3 Aug 2026 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720087; cv=none; b=B92Qvynz3DzvcOxQeH1FYzFYnnBFkpEBN1ECpy9MpMozF0wnMvtNNCxrE+VsagGS0R3kb+lcjEQgHK7rdAgpaH7WJpZUHftUSjSVLFPmtCNkb2kxcxg94XPsyV5BzsmyLY8zWmdK2bA1qgdML0cdXs++G3ykIa0mQul0AYVwCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720087; c=relaxed/simple;
	bh=IGIOiqUPBvXhRjSU/l2LErCmIBv4zjk2X496JkYviSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AWLPwukI6zkjLSzh9umZaOHhWEwCjOGBiKhvQ61jCbID6VUMDRr140VIpDE0GZFafshe6Ye7VR318+DtgsUADobWE5naVNI3S82l/pRsblZTVS9dMDIo/nasje0GzAypuLWAyIAS1Y3cg7eIqTQkxZ32AzKawFq/f5J8OnZ7LlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=FFe8RCT6; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="FFe8RCT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1785720061;
	bh=E/59ULRX3fcCiGaKpCuRRXWmoaL5FaPHckfKK8MWx3I=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=FFe8RCT62tPoC5H7XAOS4Nb3a6f/9e8Q4Z10AD9u+an1/hffTv83mlkyZyrFf0Abs
	 9oFmRGfJTf3VWLPcdIkMnDonavvZJ2Bo07M5NQXArolx6RQx6LDj948YNgC2lqfRi5
	 VibV9WAjyTPBf7KWX+WSdoN8qfQecI4FZG3U9Oj8=
X-QQ-mid: zesmtpgz4t1785720059t895a68f2
X-QQ-Originating-IP: 25z/h3E5qMZ+0hCnj4opg5fruy6r28swwuWlwxx6GhA=
Received: from [127.0.1.1] ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 09:20:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8004584693986170675
EX-QQ-RecipientCnt: 17
From: Peixin Xie <peixin.xie@linux.spacemit.com>
Date: Mon, 03 Aug 2026 09:20:38 +0800
Subject: [PATCH v3] riscv: acpi: Handle LPI architectural context loss
 flags
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-riscv-acpi-lpi-timer-v3-1-520fa13732f5@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Nyw6CMBBFf8V0bUkfSsGV/2FclHGQMbzSQoMh/
 LsF446Fi1mc5M45M/PoCD27HGbmMJCnro2gjwcGlW2fyOkRmSmhUmGU4Y48BG6hJ17HG6hBx9N
 SGp3bFDItWXztHZY0bdrb/ct+LF4Iw+paFxX5oXPvrRvkuvslsv1EkFxyMEoVgELiKbvW1I5T4
 nsL2NCQQNewtRXUPzYVbWerBQqhJEK+a1uW5QMET+MQIQEAAA==
X-Change-ID: 20260727-riscv-acpi-lpi-timer-6f1739a6c831
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 stable@vger.kernel.org, Sunil V L <sunilvl@oss.qualcomm.com>, 
 Huisong Li <lihuisong@huawei.com>, 
 Peixin Xie <peixin.xie@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785720058; l=2769;
 i=peixin.xie@linux.spacemit.com; s=20260727; h=from:subject:message-id;
 bh=IGIOiqUPBvXhRjSU/l2LErCmIBv4zjk2X496JkYviSo=;
 b=7emY4Fm+omxuUdtUfXXDuy1oWJBhRA+5HYU363aIF47ZCim7OKi8x77q7dXFpyADtPbwgrgci
 gwvKzMf/GSeA3j2FINxIoXzgrhnKcrcyiveEvbS+MXAzDLnwz4a0wvh
X-Developer-Key: i=peixin.xie@linux.spacemit.com; a=ed25519;
 pk=jczO0FmEQZBoClfXslkwCsHKDmSRchQ1hQr8W7yiiXg=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MqaMy+sfJ9q6/Df7fVJVz47fl4AMH1Hx0i/23OKL9XHrvb1ZZbWArqOU
	2kQBIp6ZXZ6ELSjSmSITpaGyt7949QRAznnyHmqo3Om8ick80AbEA4baqdDFdnyWVM9fA/B
	yhVF2DPFzYI6SAxfCo5z9Rkr0n0JhPV33lbrntCT9/hS7S6bhcK3eNl6xdVOlc3vOcax/Y/
	B1uTbIDmzB/7t/DdLxQAsDl9YDn96GOLwegqAXHz5q2MbDrbc41pIljAxW6D9fY3v071Wjm
	iZy21TFakhKpf5Aodc3U4YATHQuXwkx1N6ICpDeSeT+sm77yGgRLzTwAd6/u/hw4JHtk3BA
	uF531Y3tyOViO4KJvD/p8mmegTaZKsGLTfuEuGcD1GImW8Z8jf7ydfmakdsDWopt+du+WHM
	W3QXU5gmlveb6sNraz5ND16dMZrm1p+mBfcTSpRVScece82Wb83/9idyyX8jW735KWfFCCl
	OFS3uoL6hFiDqF6J3WpU75b0UBqeAaXr+KpDGRttxRJY3Jq612AM0Y048j0gA0qUXk3zzcS
	6/7WvZ1oEJqGN6qVpsLvK2HooIssZQKZKzCCifnCnUHjh3+SL1+Orq8MXByCSWhuEZfcjRG
	HUVu7xwnh426fJZ/TlnU5HUKk4xYwrGjTvNNXcwC4jwnrpDo/Q9zxM6nNs4u5maTAQFJTWH
	Zbbnkeou0wj3BspIlj3trq+gtNK5yLLlqPqIVCyDnKxdIvN3xjmTtEZN/Hek3a0aMo1QjUp
	NCGRwWvE0i/WQ9b/3lJEf7fKx/WTxVFYrTdQptki+0D9a1HwdqID61FTxJCOyYS0zeyZwwB
	CL1/9kR4kTtZd1c4rOdVQXPrbGGOq8Kfajc9MbKBO0DMnuCou0piT2WHN/xcMWSw8zR5y1t
	KzjMeuZ4DFAYXQCU1HO6XxPkrEYgSdQ1t94BokdM+f5bvSi6SMLHm49s/h4VsWL5/2t72Xx
	mKqG2qX+TzNunNkwmR5h+PRXYcfrJbQw9eJfOVNYuaILjtjYqHNUmP+o2czyt8UWlvzEKh0
	EcftFwH6s0izyjqmkvCYioOyAoZY12f1oRnAJT9LNRJeQ3pwkOliyK8LeujWcexr9OnNG/p
	omUmT5623DGa5v5xjtxZdCi+aL5tn0eS2Q14le0F6Em
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
---
Changes in v3:
- Use the PDF specification numbering, Chapter 3.1.2 and Table 4,
  following Sunil's clarification.
- Link to v2: https://patch.msgid.link/20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com

Changes in v2:
- Correct the FFH specification reference to Chapter 2.1.1.2,
  Table 3, as suggested by Yixun.
- Link to v1: https://patch.msgid.link/20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com
---
 arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..f4db04f5bbe7 100644
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
+ * RISC-V Functional Fixed Hardware Specification Version v1.0.1,
+ * Chapter 3.1.2, Table 4: Arch. Context Lost Flags
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

