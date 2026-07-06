Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129442641D
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341385; cv=none; b=dCvRAaTsufOb698bF169YG4Q+zkl0ImorFGQAN7xjTe/dEphMpBwLkaPByH65fugHc7lsNxNO3vHAy1IaCWtuPQUwc/PW3koWmc8e/yzvfN973QeKXtWcc1UQqE/uMxvKF4HQTfmFUEwj+mPhC5aPwHXcXzbjeuN7AogbcU1+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341385; c=relaxed/simple;
	bh=jUPc+5WtBurcnphhewtfgmYQy6E/CJXBKo96AnCyWR8=;
	h=Content-Type:Cc:From:Message-Id:Date:Mime-Version:To:Subject; b=TEQQ3qSxCweDCgHigGPYcenVQX+2Sf7mnZPfY4SzJ+zz1dAbZBnfdIcHT6bDrDkJt7RYUWKUlAznvor9kYh6Ic+Ekl/7yUIbTeKn0HYPxfUZBJF6/hrd7sOSD3MNW5aBer/ulSYGBT2BTt2nNDwMcE9CaxzBOUBNVMFLe9eRse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lx1IfXdI; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lx1IfXdI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783341370; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BQ/HUFk88w9Hw/0H2O7JanH4HOFyPcr4jmVMK/jTRIo=;
 b=lx1IfXdIa+GjabASoRaQ5UOQzhq2z/7McrY3Q3zBmPY2YqjVtF6r1SZlLxBQLkcCGMulyU
 izmF1628wy39cO/XO1XOKds4LvaCGJpYNeGauIm14Ufzz3jTNPuaQk8vD6Wsf7s0qDHl4m
 0KCzTspPl2RPJZsij6lgsDDLdQCG4AzYYBKutbwT6symIuRq30TMOKgZtqHHd9V8M76UER
 HeEvaSTRenoXJVCUfCC0aZfdsMZMFqrPPWW5NTM24XPaZJjwNttex8rviLCz6OXjc/ad7R
 rESr5Ea6v5+xCxgvwMrR5Icg7wWqkIr/yVh2L/+C5+BOz8MV1gcGi57bXiE18w==
X-Mailer: git-send-email 2.20.1
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Rui Qi" <qirui.001@bytedance.com>, <stable@vger.kernel.org>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, "Andy Chiu" <andybnac@gmail.com>, 
	"Puranjay Mohan" <puranjay@kernel.org>, 
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, 
	"open list" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260706123554.455065-1-qirui.001@bytedance.com>
Date: Mon,  6 Jul 2026 20:35:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a4ba139+2b8ec2+vger.kernel.org+qirui.001@bytedance.com>
To: <palmer@dabbelt.com>, <pjw@kernel.org>, <aou@eecs.berkeley.edu>
Subject: [PATCH] riscv: ftrace: only use pre-function NOPs with call ops

Commit c217157bcd1d ("riscv: Implement
HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS") changed CC_FLAGS_FTRACE to use
-fpatchable-function-entry=8,4 or -fpatchable-function-entry=4,2
for all dynamic ftrace builds. That layout makes the compiler place an
8-byte area before the function entry, which is used as the per-callsite
ftrace_ops literal when CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled.

RISC-V can still build with CONFIG_DYNAMIC_FTRACE=y and
CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=n, for example when
CONFIG_CFI_CLANG is enabled because HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
is selected only when !CFI_CLANG. In that configuration
ftrace_call_adjust() does not skip the pre-function literal area and
only returns addr + MCOUNT_AUIPC_SIZE. With the pre-function layout,
that points into the pre-entry padding instead of the callsite jalr, so
dynamic ftrace records the wrong patch address.

Use the pre-function literal layout only when call ops are enabled.
Otherwise keep the previous patchable-function-entry counts so the
recorded address matches ftrace_call_adjust() non-call-ops path.

Fixes: c217157bcd1d ("riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3070c3874305..235730a243aa 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -14,11 +14,19 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
 ifeq ($(CONFIG_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=8,4
 else
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
 endif
+else
+ifeq ($(CONFIG_RISCV_ISA_C),y)
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+else
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+endif
 endif
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
-- 
2.20.1
