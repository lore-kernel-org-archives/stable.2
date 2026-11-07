Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045808;
	b=xzps+N7Fx9RZZ5R3V2MjoQQp2rdC9ez9QX2XiRZBCNB3X4nX+VcpQksjDaeVtUC5xaLj
	 /Ew8xxNDfaCzR5Vofp1x5mLyS5sqXXcvhX2bpoW8GgvuaqutSvzVMVuqhns+oJo+PR3UY
	 2itp/erzdDuym2euAHJuh26gCbSMvoOUsj/6uPQekzVNpdVNBjRPkOEOUAqFhDxnV9BjW
	 Z3yrFzLtWjrwk99IDbxuAH74TR3skQEflQbxC+iis8bHNExL5LS7bbMXh7R3OWqffWp5D
	 7R7PLKNqnPkJ5coE/Hr6Gf7iAJ03+phPmK3y6GheYNOuZTFZdp3EJT+cGOoeN3fKFDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AQ4xV0oJiAsNgSoaa3w/bSEasLLzbcd+3ncv2ss0LfE=;
	b=4m9Fn83ZG9v9kptNG9bqJwyomA5eeqKN21IJBo7ny+bQr8AnB7XQJs2QQS19XLL0Eb8N
	 9+tRdORdhFjLAXvy2DQ7MqK/z0S03wLNz7U0373r3bA+KRbirDaeTJ1WvG+Pinx7zsdNA
	 5wWH4FxDJen7W+xT1bHI6QZ7VqccWFSx7w7/mii7V3M8kJb+l3yDS3H6Hx+3vY7/H2q/K
	 d+BxYinVhk++wqQw71ntJcuz58FOqurS/1yJbLd3Wv3ZUzPkdAcsABmNyA8UHEA2799hP
	 m5sNMHJJTUztA9jKHI40wC9bHeY1U43nmrgy7f6OQx4ekE6QPVXW3jpoTzZr9zzQ3Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJYbYWP2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4443606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJYbYWP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DAB1F0089F;
	Sat,  7 Nov 2026 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045807;
	bh=AQ4xV0oJiAsNgSoaa3w/bSEasLLzbcd+3ncv2ss0LfE=;
	h=From:To:Cc:Subject:Date;
	b=NJYbYWP2tc5nHTLZnkG6vOHXXz4G5WlyH2eNNN/s6msy7mv7ObUk+9184EbSVaH44
	 g7CErOSOmOVSY+ZP7TbQ9Ot5PcdioYmpvi5VrYlfmzNVy4U80p846Vw3NqzCayOjtm
	 txBaY6N26Z2XWobdsSb9K5BCyg5Vrzx9Vicw1fFqHSlgadkQu5FHgd/L1AfsT7iRak
	 SDRZkv4+xv/Qw3LYjxExft7RgVwRGJnBa9LTBMs/S47AQ063x0WY9bGeYx2TY2+ANd
	 R1idc3OWKnU0nDgDhBRlqsUuJst7aOjBfOO3C6lZtZ0NqHak0H63BcuKL1ojpObmyl
	 OC3NKSsyW+/uA==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Validate FFH register fields before hardware access" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:25 -0500
Message-ID: <20261107050325-failed-7.3-6b016c5c9644@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 6b016c5c96448c0a5f09328d37f66562d154a5e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050325-failed-7.3-6b016c5c9644@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6b016c5c96448c0a5f09328d37f66562d154a5e5 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Wed, 16 Sep 2026 17:28:01 +0100
Subject: [PATCH] ACPI: CPPC: Validate FFH register fields before hardware
 access

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
---
 arch/arm64/kernel/topology.c | 12 +++++++++++-
 arch/x86/kernel/acpi/cppc.c  | 14 ++++++++++++++
 drivers/acpi/cppc_acpi.c     | 10 ++++++----
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index d28438f8b83f1..2c030e78d5e45 100644
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
index bbade0da5130f..d2185b7a20306 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/limits.h>
 
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
@@ -45,10 +46,20 @@ bool cpc_ffh_supported(void)
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
@@ -65,6 +76,9 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
+	if (!cpc_ffh_reg_valid(reg))
+		return -EINVAL;
+
 	err = rdmsrq_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0e218f2be0fe0..96a94df242312 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2446,6 +2446,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_read_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -2490,8 +2493,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return 0;
 	} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, size);
@@ -2538,6 +2539,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return -EOPNOTSUPP;
 
 	reg = &reg_res->cpc_entry.reg;
+	if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
+		return cpc_write_ffh(cpu, reg, val);
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -2581,8 +2585,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return 0;
 	} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
-		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
-- 
2.53.0




