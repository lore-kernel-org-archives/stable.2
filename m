Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137235;
	b=vUNDU4wrhjIdFRywBOuFPy5LPyDM1PcagqD0Zf020u6Q18wuyLEPg6mwyL01ZdXhMPtP
	 wFDMw3gVibITYDERzXojaT30ohDBwKGzJzSLDnNZwzkTC942iy49fcciCL7YT9TvcGhVD
	 lyQhNiHoUbPxzgDy2ewdhYPu4+ZqIxJ6//xxC3NzRs4HTzgQxv5LTtwqH40j2MLnyQdq5
	 yx+ioB5kXQMZuuFkZRVpUabtCIi6NetIHU09vf2K79EGAgbw+scMLHB9l/ozGKSFKvX/3
	 AdNONb8TnsY9YrbX85nrlH83Bc4IBZ1Vwc75MTnb8Y5TiiO7kSln6aBGfIMPJkik2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137235;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YX07GiDIcFeOzABs+F6EAMIQ4G0IYXmDelIBQNftAAA=;
	b=B+4JKqODmhTBQJ6vniIaEnEUEkokwpF6fwGLIjjSPl6u0bU49xMpCRXdowetNltQiqBS
	 RV3fjJmO999Ea8bboYSmX4mi8z3HsEZAYJ8DCl7wQkQzOCZgpU4JhyHbYXMweYghWHgTp
	 zn21QVrIq/b2VTBfpKFqGen+UHpZ5jFKVYsnRdGZZut24brS1nilgGfVWStxRMgPj1Wst
	 Y0pBMWympLQduJpo6XgaGM768hZdC8LLrAZpasATKxb//y3r39sHpq+vpMoQCD45m+eW6
	 ebKmJC62pNlYBb3g0p0Uhv/HUruB49+4HE2MfxXkIP52c9c9pAfeMff/e5CtseVdpKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Brj1Elrt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E772E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Brj1Elrt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB0A176B;
	Sun,  8 Nov 2026 03:27:11 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 525683F632;
	Sun,  8 Nov 2026 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137234; bh=61jwzY/P8hLMU8lphi17Lu4i3kkLQbpf5mOjsTibi7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Brj1Elrtg4J3IC9S9aaHuWejJQZZzQahoqh3wW/xeiQTfQzl5qLxMEb8Zlx4JAn6z
	 6FLSGPF2ddlFYOpafSPx35xkvLAQlU9A6YCYz6XriP21DKFihOmtjnlvqg6FOR4zyh
	 GUR4BZnBW97laURVdFjOkOkRmdLIrwQafJ3pTxqE=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.6 1/3] ACPI: CPPC: Validate FFH register fields before hardware access
Date: Sun,  8 Nov 2026 11:26:46 +0000
Message-Id: <20261108112648.2565681-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112648.2565681-1-christian.loehle@arm.com>
References: <20261108112648.2565681-1-christian.loehle@arm.com>
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
 arch/arm64/kernel/topology.c |  9 +++++++++
 arch/x86/kernel/acpi/cppc.c  | 15 +++++++++++++++
 drivers/acpi/cppc_acpi.c     | 10 ++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 61df0918585b..7f50162ee7c8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -320,10 +320,19 @@ bool cpc_ffh_supported(void)
 	return true;
 }
 
+static bool cpc_ffh_reg_valid(const struct cpc_reg *reg)
+{
+	return reg->bit_width && reg->bit_width <= 64 &&
+	       reg->bit_offset <= 64 - reg->bit_width;
+}
+
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	int ret = -EOPNOTSUPP;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	switch ((u64)reg->address) {
 	case 0x0:
 		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3d..c1dd7d4082ad 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/limits.h>
+
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
@@ -32,10 +34,20 @@ bool cpc_ffh_supported(void)
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
 	err = rdmsrl_safe_on_cpu(cpunum, reg->address, val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
@@ -52,6 +64,9 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrl_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9fbcda250ba7..1ffa8bee5053 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1010,6 +1010,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_read_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -1036,8 +1039,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, size);
@@ -1083,6 +1084,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	struct cpc_desc *cpc_desc;
 	unsigned long flags;
 
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_write_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -1107,8 +1111,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
