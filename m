Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047379;
	b=YkB5t7hHwthGXVOWH2X8u2YxLSIqUNFiuHWz8WjDOhoLng1QjWVpisxu6EZvMuTXrdWd
	 GHQomIybE6UFmf2knUodHh34/IJyh3fzfht4jy+F+iEGMu4lTIWIg6+zz0wNutwYGE+WL
	 Q2utVIB/S/QNsU0k1GE0QJBrFvRiGnPs/xKrgrTvD2vXtr8GcS4evEpFVC44oh4CA/hhu
	 EReaf+qzeeJ8S1tv3rpNvM5R6fDN4SqH+dNu5ByO4lJ2SWqesCrF+FURQHwSKRXAP5TCQ
	 0zlx7jJsGCtJEUw0QjMo6rFzj2gzTFIzdECRtD/C1VgHTVOugPhpCcUUK2fMPpOyLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O74uCKpOe+6OoO31YB0GQPdwRG2W/Ag54k+mFOEL9FI=;
	b=D4ZS6QHZ8871k2lVkNDyVM0dqhj1dGnagqSq84y62dm8VlW664Z+0elpaBxEaVKnTddL
	 vzlXOD3odbfi7ydqe7w2MbLcUxUaJFw75JPG7mZaFSZsK5byJCDniHKoipnLFKeAHz4Q8
	 2RPSDcBOfVTm2IwP7wxG0V53XaZIt2Yf3wHQ41jkg35sGPcS8T61+CAgmzVT/xSdkvO5J
	 UQFi6xEt3+pXk3QjhngG8XOHU7OyNOVL/a+rOLc5jeIUkbU/vkzwg3eCBmUNefhLvHhWQ
	 Ks/Apxvv62qNIBqu4gmFff8ES9yBlDmBVBZ7tRYA3cujbr/v99u2A99mps4Ezgkta2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AceVjbvd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA391606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AceVjbvd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1127B1F0089F;
	Sat,  7 Nov 2026 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047378;
	bh=O74uCKpOe+6OoO31YB0GQPdwRG2W/Ag54k+mFOEL9FI=;
	h=From:To:Cc:Subject:Date;
	b=AceVjbvdOljQpeF/89hr1yqH3zozqMDTR0mK5VxQiSh05+VHU4o9cvIKNW20Qhv/N
	 B7D42KB9Xxhb6w66EIEOlS4nR87lejs8LCPckjAduiSdnnfaFWK31lO6kueZFTSckn
	 Jhxyb2r4o8NkXJ+9aSSEQnqKPxSfmGAZLAcdF4eXQ3iF2uNkDFKCxY8RQtiBZUg2TM
	 mA0qYKSba+nnRjaIcEKT4JSDErsbhM0dKKFzoJ/sWKdN5f156YaMNw+VmC6IFVx14U
	 GX6aLqI/cgSzET4G5MeNWCHgynKpwI1gLBmdS2utan7sfyU36WMR4cDll0xkCFzfxI
	 MQccRpJ9Gy0Tw==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Propagate errors from cross-CPU FFH calls" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:37 -0500
Message-ID: <20261107052937-failed-6.6-36e96b469da2@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 36e96b469da24868f727b4cd168d7cf01cbd163d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052937-failed-6.6-36e96b469da2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




