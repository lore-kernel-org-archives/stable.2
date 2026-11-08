Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137247;
	b=aTZ+QvvoFCyM/CvNzyGRNSNXa/v298sn00ZhtV/LDELujeBYsSURctxYxIL/EWr1aWBD
	 kpngNz3X3KnYnJkLZ4y08OeaZjIgW6Vs9RYgVn9p753I7rIUD1YsJKMRdyMCKs4OghHWW
	 oNtmvipvftkCGy9r+mNFEPMYujZtBPF3siZ01RwSel2ifCQUjoyJDJipPLLokhXs1f0n7
	 yTqC2sytvy4xTO6qHNZjHT0AF3uOqTKCWfIHBXiekNLOsK90zVz0LAPxFIq2ocRaMCNev
	 pFrzkn4qgUDvopMoXMsU1MgAnxqvNplg6b1u3g9mioRA2mmZtCeS2y5521lIhn9PUPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137247;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XQFkkCFQzsWl8l3S1s03S99g8kD0089P5WHlO6reYbw=;
	b=ChjNXyVZqZ3l4X7+TNlKxkb1kxGnKnLoXf63LFrvCNYZfexqb85jtK4WqQn2rNI3gi1O
	 oqyQt1hvsnNbviRFIYZzxUD9cclAJgS0Rhds4hoRNI5Q0Eb8ZNa6+LEUtftdoIpmXf5E5
	 caI2b00f0GrO3en5088/qDWMMyPexHXYA/qm1cDpe5lYcRCp5UOd9tE3DdKlaoucfLYnz
	 QKJ6Y9MXO6zZS/IKoLKtsgEF4aIwKuPCh2q4/7X4N09d6qDPnKuHvMtwlJdHwzFJRw07o
	 vmgTsoQ+z/Z7yPJJyu3Q9hFE+eZsil9dCKmcttzbAltbEOYltvvbeZad3Wm25ioK0NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oKnlx59K;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5342606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5342606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oKnlx59K
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3972B15A1;
	Sun,  8 Nov 2026 03:27:23 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FC6E3F632;
	Sun,  8 Nov 2026 03:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137246; bh=+fU9VckY24Zmi8sBSf3Ekby2Pz4rVgqrSW21F6wE4Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKnlx59K1tpXWnwc92h61K7mwX4C2NpR836/QZofzQTEMplDRqaDnIru9Y+cN2O96
	 VAr70ZCWneal4GdFjR92t3iHbzJyay86fpfG9L7inY2f+GMX/2qKgBcmxwPyEzsM6n
	 jmn+hDe9c8aZanuzXA4fZlYTotazwTQ0+kAQoqoQ=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.12 2/3] ACPI: CPPC: Propagate errors from cross-CPU FFH calls
Date: Sun,  8 Nov 2026 11:27:16 +0000
Message-Id: <20261108112717.2565915-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108112717.2565915-1-christian.loehle@arm.com>
References: <20261108112717.2565915-1-christian.loehle@arm.com>
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

commit 36e96b469da24868f727b4cd168d7cf01cbd163d upstream.

The arm64 and RISC-V CPPC FFH accessors ignore the return value of
smp_call_function_single(). If the target CPU is offline, the call can
return -ENXIO without running the callback. The accessors then consume
callback output which was never initialized and may report success.

CPU offlining leaves the CPU's CPPC sysfs attributes present. On arm64,
the AMU feature mask does not exclude an offline CPU, so a paired counter
read can expose uninitialized stack values through feedback_ctrs. RISC-V
has the same problem in both SBI and CSR reads, and its write paths also
inspect an uninitialized callback status after a failed cross-CPU call.

Return the SMP call error before using callback output. The arm64 single
and paired counter readers already check the helper's return value. For
RISC-V, also check the callback status before copying a read value: an
unsupported CSR sets the error but does not initialize the value.

Fixes: 68c5debcc06d ("arm64: implement CPPC FFH support using AMUs")
Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://patch.msgid.link/20260916162805.1039247-18-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/arm64/kernel/topology.c |  4 +---
 drivers/acpi/riscv/cppc.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 721df857d737..326cf60d8d58 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -289,9 +289,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-	smp_call_function_single(cpu, func, val, 1);
-
-	return 0;
+	return smp_call_function_single(cpu, func, val, 1);
 }
 
 /*
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 10a2b554b3cc..ef3b052f9dad 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -99,6 +99,7 @@ bool cpc_ffh_supported(void)
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	struct sbi_cppc_data data;
+	int ret;
 
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
@@ -109,19 +110,27 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		data.reg = FFH_CPPC_SBI_REG(reg->address);
 
-		smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+		ret = smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+		if (ret)
+			return ret;
+		if (data.ret.error)
+			return sbi_err_map_linux_errno(data.ret.error);
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return 0;
 	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
 		data.reg = FFH_CPPC_CSR_NUM(reg->address);
 
-		smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+		ret = smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+		if (ret)
+			return ret;
+		if (data.ret.error)
+			return data.ret.error;
 
 		*val = data.ret.value;
 
-		return data.ret.error;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -130,6 +139,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 {
 	struct sbi_cppc_data data;
+	int ret;
 
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
@@ -141,14 +151,18 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 		data.reg = FFH_CPPC_SBI_REG(reg->address);
 		data.val = val;
 
-		smp_call_function_single(cpu, sbi_cppc_write, &data, 1);
+		ret = smp_call_function_single(cpu, sbi_cppc_write, &data, 1);
+		if (ret)
+			return ret;
 
 		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
 	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
 		data.reg = FFH_CPPC_CSR_NUM(reg->address);
 		data.val = val;
 
-		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
+		ret = smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
+		if (ret)
+			return ret;
 
 		return data.ret.error;
 	}
