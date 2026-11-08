Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137268;
	b=OytR1mpgy0WbA50gh36uXT4KxHEH+Z4rRy9uaRJyaVomQoHAnSyo2tJHuUc3drXeepLH
	 M52NvcqbW7Uq+es5SQmWYZ/J6jpdhDfxspPQFLN7U9IHVCNJH7pFXTECMFQwYcokojB7F
	 /fn4x8J/cp3YmkeBXyC6KUX6WL/MFW/MokoFnyECOIrBsCvqh6nfXzA4AqYqB0djUIM+T
	 lFt8O9mi7gOhzoRoHkfkxrXJvUQXhs2xgdwYdOGvu2yAy2RVzbpd2J9ft+j9tXZSN1EcU
	 jTBFwhwDS+pul2pKyvWK4NXbCAQqGqWasynjIeiPAtlt5y51itCRrUvcUWUwbrgfYiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137268;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rKbsyn6aq8Ab11nVyUwOE5jR2aRhteCwfWZZuQ0tI9c=;
	b=eyyEfqWIrYrej1C/G1IZ7ZXk1vrJBPNpKe/jarkU0pIhtJUTRQEKF+8obVSg33P/+qOq
	 MtcNx3grYSyp56sA5I0nL8gfshSJglaVvrV3hGS+Eu7Bk29LbMNDyvGJEuffXlDAJ7h/y
	 +WQpSIF6efxN/VYcn0FNYaIY8TVQnxYcISTXCXcpENdRn5B46KRPcb/uZD9U79XwgddN7
	 9NfleRg+zKpbmdAzUjR0h9DyJCxxq1PPITAB3iH/7KGc0Hg9GWjRwCjQJOi7ZBl8iagPn
	 3Qm7hFjFUfk1nNjDTF2+7cJoSXXEHvnBMq1HuIb+xSf8TuLdk+HDPSGLy0oaw/f7uFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QH1W4UZO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8B606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D8B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QH1W4UZO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64AB116F3;
	Sun,  8 Nov 2026 03:27:43 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B9BB3F632;
	Sun,  8 Nov 2026 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137266; bh=b8gh4HwOdPSiSKzRz1ho5qqZxW98LrhVC8pGkEteb3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QH1W4UZOh0FPGvfXoCsTYaa5laD9udaxswZKFmZ2BARsTDdhqXffPT75ErmpOeyko
	 CcSJIRM/H+2qJHUlg2ewwK9M433NfxxyE6Y+jNpLYYG3qamdAIiNt6ahzYY/MJ3VYl
	 lymbfJZmIRQyoD82bJ5Qt66gUEWc8wfu+qLczAkA=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 7.3 1/3] ACPI: CPPC: Validate FFH register fields before hardware access
Date: Sun,  8 Nov 2026 11:27:36 +0000
Message-Id: <20261108112738.2566137-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112738.2566137-1-christian.loehle@arm.com>
References: <20261108112738.2566137-1-christian.loehle@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6b016c5c96448c0a5f09328d37f66562d154a5e5 upstream.

The x86 CPPC FFH accessors construct masks and shift values using the
firmware's Bit Width and Bit Offset without checking that the field fits
in an MSR. A zero-width field or a field extending beyond bit 63 can
therefore cause an invalid shift. The safe MSR accessors only handle an
access fault, not invalid field arithmetic after a successful read.

Also, the 64-bit GAS address is implicitly narrowed to the 32-bit MSR
number. A descriptor with nonzero upper address bits can access a different
MSR from the one described by firmware.

The arm64 AMU counter readers have the same unchecked field arithmetic.
Validate the field bounds before reading a counter, including both
descriptors in the paired counter path.

Dispatch FFH accesses before decoding the GAS Access Size in the common
read and write paths. Otherwise, a large access_width can trigger an
invalid shift in GET_BIT_WIDTH() before the architecture validates its
register. That field has architecture-specific FFH semantics and is not
needed by the generic memory/port accessor on this path.

Validate x86 MSR addresses and share the field-bounds checks between
related accessors within each architecture.

Fixes: a6cbcdd5ab5f ("ACPI / CPPC: Add support for functional fixed hardware address")
Fixes: 68c5debcc06d ("arm64: implement CPPC FFH support using AMUs")
Fixes: f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-17-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/arm64/kernel/topology.c | 12 +++++++++++-
 arch/x86/kernel/acpi/cppc.c  | 15 +++++++++++++++
 drivers/acpi/cppc_acpi.c     | 10 ++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 806373aac3db..6f0e705357e0 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -470,6 +470,12 @@ static void amu_read_core_const_ctrs(void *val)
 	cpu_read_corecnt(&ctrs->corecnt);
 }
 
+static bool cpc_ffh_reg_valid(const struct cpc_reg *reg)
+{
+	return reg->bit_width && reg->bit_width <= 64 &&
+	       reg->bit_offset <= 64 - reg->bit_width;
+}
+
 static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
 {
 	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
@@ -506,7 +512,8 @@ int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
 	struct amu_ffh_ctrs ctrs;
 	int ret;
 
-	if (!is_amu_ctr_reg(reg1) || !is_amu_ctr_reg(reg2))
+	if (!is_amu_ctr_reg(reg1) || !is_amu_ctr_reg(reg2) ||
+	    !cpc_ffh_reg_valid(reg1) || !cpc_ffh_reg_valid(reg2))
 		return -EINVAL;
 
 	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
@@ -530,6 +537,9 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	int ret = -EOPNOTSUPP;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	switch ((u64)reg->address) {
 	case CPC_FFH_CTR_CORE:
 		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index bbade0da5130..174b734e8261 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -6,6 +6,8 @@
 
 #include <linux/bitfield.h>
 
+#include <linux/limits.h>
+
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
@@ -45,10 +47,20 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+static bool cpc_ffh_reg_valid(const struct cpc_reg *reg)
+{
+	return reg->address <= U32_MAX && reg->bit_width &&
+	       reg->bit_width <= 64 &&
+	       reg->bit_offset <= 64 - reg->bit_width;
+}
+
 int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrq_safe_on_cpu(cpunum, reg->address, val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
@@ -65,6 +77,9 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrq_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..dc9e1c1fb071 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1133,6 +1133,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_read_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
@@ -1160,8 +1163,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, size);
@@ -1208,6 +1209,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	unsigned long flags;
 	bool locked = false;
 
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_write_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
@@ -1233,8 +1237,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
