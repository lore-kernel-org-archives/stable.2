Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046642;
	b=bd8ikwrkx3v4uI8g1DEN3GA1oVjPsMqZYe2iBY7cuyruAeUBQ6ImniemiFwrGFSD86DK
	 KWEP8F+JXnzmYx0TK1GR9psEDpneMdvwPS/QL/kLchG90HaNydVeWryaDCwlPiFD/Ylea
	 cfgHpcV9/omaSgwGxlt3xf2lwRt6cuAqs0TcqUzRntTuIDg4l8wgBv65YlZG6xBavRyxT
	 K4ahk4is7Ci13I+1yTWCqc8UbUBfl1NeDacOo+CncMBjSDAIlC8hvdCtidYHtF9g7EuZ/
	 Rwa3cylC3DrbN5BUpV29wVVr3OkZNTPo2jZzGGPQdyIunafxGNtW918AIEMQxEc+aGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IkIlwLjvWlKW8K7aV8hDYAb16op/kH5ci8AWEINNNvU=;
	b=v1LNZ4HX/dbp1cHR9FHzzinpXgtFk5bp12BtyNULREgk6h02dlXOKZAJm5GTVDBX8wbr
	 5z/0YASwtt225H5r9vjyAzZ/AJDNAE2gumCU3rjtf+n+ZyZ6O1LKzRQ/irXwJZfttpbFB
	 62a/LBWEqwlYlxu+rjdz46hngc/rWlDVxF8GjwEJukWh83lxkHnSksTo4M2soGJNWka8d
	 /HE9PY21KQmUd969221MpZoMNordQ9B7nCGrd5Bhpyfi3ENfEjHwN+47eqAyo93QvcF9+
	 0ScTVeKLrth+zrqokVYvMnBiiqZeNapgeuuLQ3YrllQhA66Yr9eHttE+IMUnKUOC0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGuBrSyw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A58606EEBC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGuBrSyw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090B31F008A1;
	Sat,  7 Nov 2026 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046642;
	bh=IkIlwLjvWlKW8K7aV8hDYAb16op/kH5ci8AWEINNNvU=;
	h=From:To:Cc:Subject:Date;
	b=BGuBrSywb4fWkwR1+BVSFklGCchDW3b9fZlBSWoS9Il8o4KX+k+43lnFgjfA0Lnhl
	 GT938hE5ryqJHLvLZSp8H+xWa7asZetaOpYO7H+fPTkiuea2/uHCis4trjiCQzOJxL
	 NaMVnqm9pOlYZ3WpXupsHFWE3bJ7zfiWRAywdD/ly8YzQtsefidL84yEQdeTndPRb8
	 TuywJHXyTDSyAeE6HoY4+fvCQNl5WCkGlZCg/w4mIyoxMe+nFPiYSrHz+KcSAo5ROT
	 Sb3B2AZK3gU4YtapbvNgBFwYP+lPyCnifIPEBDP7sEADgcC5s5ZEdhKQXhOc2u/gsA
	 JYQz0/lZ2pSKw==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Propagate errors from cross-CPU FFH calls" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:21 -0500
Message-ID: <20261107051720-failed-6.12-36e96b469da2@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 36e96b469da24868f727b4cd168d7cf01cbd163d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051720-failed-6.12-36e96b469da2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




