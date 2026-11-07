Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050163;
	b=2xrZ6Y+bOgso690PJ0FVx6ksv3HK0thPBsx0ccxSL4of79EVJWVhGTViw4ukU4GBo83B
	 G4DouE5CNBnvyfszvTtaAuB9oxpOUBm6QWUq8WfrFaP1i2GiE9F/sKpRf8/z571UqQ8QB
	 gw44QZuAk7LFaeMbXdFCldWcYbQkKc0QwLGu2qHHeOoAMNbA1ryYpLs4y+66r4vPCqmHI
	 nG0oEcb6KuYL+oOii3AnAHDL5SQBHrjOJCY8O0GypWAWP7mvPXlBwdLb3Xy3r+qPehLbP
	 oHUcTHlt/QoozmxEQhM/A9i4QpVuo7P8vdWM5U+WUXpX/E8jILbe9eA4I0Mmbrs74sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050163;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YdinD2FSjvCrQRLMTuRSmVB47KYq+cMPT9fSzepEMH8=;
	b=tOMruLJ3TcN3B+VbJwiNWudM6DkYSgLMA5rXW3LQYdTepY2dxWm69tX7K15Ti9+r9S2H
	 bZy9kWs8NQM7zojOSFWT+sXs0Vzgpa+MgtcNkGl1ykVMJuGG39mFIAJtaooitoKEIgCfV
	 Qs+lecpGlAImYUJldn64KJsR5LL/QKiklbM8HwLQnqxpfbK2hPwzRQNIbY6+sigp71pCu
	 laFQSl/DEjHvkhwRBb4wehlcOYW550Q2ZFrNDlXmmMviUw5avF97hvTxTI/f2pb1Cj5/N
	 uAvTlC0N44/RdNMsiufKeONOzMQ511o/4Cv4nEb/2NKpDUVoWxw2MU3TrOXOX8Hm0Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2YEILWO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E02606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2YEILWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27F81F0089F;
	Sat,  7 Nov 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050162;
	bh=YdinD2FSjvCrQRLMTuRSmVB47KYq+cMPT9fSzepEMH8=;
	h=From:To:Cc:Subject:Date;
	b=J2YEILWOS5dhEcnmiGBp2iF5SSTi1Pk6ZEp1P6y1aext6SwnbEg9yNMVs38vgPs+b
	 0qN/55MDJlhsLQcZojZWBkoOTtWxDiXPB1vYeNr5CA2UOAT/VWv92Ymlm9LIbNLukC
	 uLzVdfQMFJ9M2B4NHl8+87/s8qMQFVO6vpuMWfYNxYINbmwOXJ/huW2POS+SicSKUP
	 IQrUp4+T4Vj6YhvgZloPzp2/Ffgr7W48vjL34uVJ4LP7Q2gXdybmT0CjZq4V5sdFVJ
	 JnosxPPiwi+KAMLveuRtUz49JEIeIEtIcATkw7FU3kJuvYvZDj5IgQtEssO3pGAy3v
	 t97emAx/DEi1Q==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Validate FFH register fields before hardware access" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:00 -0500
Message-ID: <20261107061600-failed-5.10-6b016c5c9644@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b016c5c96448c0a5f09328d37f66562d154a5e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061600-failed-5.10-6b016c5c9644@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




