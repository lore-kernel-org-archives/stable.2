Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049161;
	b=DQvcXhZqzcOVCFkNyFdrB9rF6QQRIEkT09KBeYqrhFl9P9Kac/LHwUzpXWw0kM2fwYkl
	 g/27ujVqrX63Q3WHxk4t2yVN43DbSRCb8Oz3yOiokuxxJwQ3JMNYT6guZ6FIU0Sl9Lqyh
	 LiN3KAsoa43r+52YyjWPbWTFg/huqzjPwqQRI19bfCBh9OIVatF+/CzQK1jdke7nPxfYt
	 FaLZahVjzz8kO4YrfjeweHdTfDlqGzoxv/mLSABTnDt3V3/IXw8w7BwCOuz8vW5f0VE9o
	 NfE6G5BjJmOTSJYk3kuIgSEGDzUFATtZRPFba47KaoxOdxD0rGNwihN8Orqxjow+SPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FGjvd6yU9A672+vmMo3xhRuoY6FxjrvAjjTrDozGJDc=;
	b=PhvH5Uvzg8oItAn/W7Wrdqv3c7hIUt3WdeaQ/YColtVYCrf8sC9h0yq9pXRBrCQax1wK
	 DzEQnvInzubiXC2oqr2N455FIZeihpuQ7HLzO0SpZCfALy6ZfRlyvVfbrGFXJyjQOIk5F
	 +o1u+dlLGcoABB8cA158lgemsuGFR4tT22sTel3ooC3E9fVTxRrUqBac6zPDIH+6CzR+W
	 5Vt2gmI6uhPWv3QgQK2yqJeSDSv+XSVUHbox08PLyuptBVGAFhE1vB3iCmpgHqQc+AT4G
	 Y4u52sXUPegb6H2wIJOvYFrI/EPqwS0StJe56kaz5GKggsqWnOAbnSzOT5cZBdnJWuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GW7ry78C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D06606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GW7ry78C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD071F0089F;
	Sat,  7 Nov 2026 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049160;
	bh=FGjvd6yU9A672+vmMo3xhRuoY6FxjrvAjjTrDozGJDc=;
	h=From:To:Cc:Subject:Date;
	b=GW7ry78C5J+Hqp858TcGy/qj5mbZp0rHhlb3aPWaWEiDxB5Fe40S8GFvIWiu27hE4
	 l3jL4Mvakt5hu8r4jqqGrtvEhdrubya/i2nqrHrTX46jUG4VJrTGcvfRYPO6CdMLwo
	 l/BS+xPLiIEzDMVE6bwc8OypRjCUl7pTvwXGPLBev776EuR2ZkcRWWaknisudNyGaW
	 SVadubM7/RQ8ZgLz1bi3MgBOM3ysrPdN+PBAK+xtUruoDc/GFP22II1oRb3xnL+hGf
	 R0VU4pO8ciA5NIfS339jlAAazToziXOT/vh2cfBjzaFeIjKDLbVCNuSGaF860VAXzb
	 pAoWbCbXr55vQ==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Propagate errors from cross-CPU FFH calls" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:59:18 -0500
Message-ID: <20261107055918-failed-5.15-36e96b469da2@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 36e96b469da24868f727b4cd168d7cf01cbd163d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055918-failed-5.15-36e96b469da2@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36e96b469da24868f727b4cd168d7cf01cbd163d Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Wed, 16 Sep 2026 17:28:02 +0100
Subject: [PATCH] ACPI: CPPC: Propagate errors from cross-CPU FFH calls

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
---
 arch/arm64/kernel/topology.c |  2 +-
 drivers/acpi/riscv/cppc.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 2c030e78d5e45..55bd8fa3e95cf 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -427,7 +427,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
 			return -EPERM;
 		func(val);
 	} else {
-		smp_call_function_single(cpu, func, val, 1);
+		return smp_call_function_single(cpu, func, val, 1);
 	}
 
 	return 0;
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 42c1a90524707..4ea4ddedd91f1 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -97,6 +97,7 @@ bool cpc_ffh_supported(void)
 int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 {
 	struct sbi_cppc_data data;
+	int ret;
 
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
@@ -107,19 +108,27 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
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
@@ -128,6 +137,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 {
 	struct sbi_cppc_data data;
+	int ret;
 
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
@@ -139,14 +149,18 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
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
-- 
2.53.0




