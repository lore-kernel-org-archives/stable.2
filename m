Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046026;
	b=CAyn0221Fv3IT+30QzurJ1D0//yrvS8zeWIYYhBaSCZxWBkmoMonGnzqG38ax0sF6Dbk
	 trcQIYVgOX4KTdgnPPKS6rPX+oM0RsUH9pcRWc7kmjY6B9lX8lyC26vDdiZcgl9SUkj0B
	 rjU33Tb3ZZVGEj0HPXvuI5Ht6HpNhU4fDNgphJ46aJPudRNuS1mcyDSSKgNy13gcYz6Xv
	 3k+FsYZuzcC5INSgRuaWHyoN/E3e1SflrbWNAkRi0SHj9iOCSMB4EiF+RwticLuolw92J
	 3BxNsi72wzFsPk9p7aYXlMc279Heuvytinzt8+kjh2BEYacvNgSq//kpn6MlX952LUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dr0XL2VEj5o1R9eyQMFCy6oZW+TDsZ+wlLmBet8OfQk=;
	b=Ju7/lqES1KTcG4M5LvDq9Pn0wAVYdvG1tEbzk4vh//2yks312D7a23YJ8ZIBUoSV8VEP
	 3j/XmkeMlryKXd2zAGVC1m5OuDfAtI+Pfwx7mtfBVJx1dPkWkKi766mDybZNsC5sEJGt+
	 /+HRFDyffVDpJK5Uf0PI1yCv04ACgH0NXTwGX8nD9zrz3RtjESTjX6Dv6ye9YFoUnbPyG
	 YaCooiFnoZh41wcqCOuOt70spENF/YpCfblb43AV2vuxNAQ3EUQoqOx0l1LuZEbdzPrxO
	 jjZgLyLhC0PqTf2OyZdGR2IYW8M+OIz+m8sErzApnS9qhDyjtXDLUbvj4BYednuM8XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFEgdwWf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4304606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFEgdwWf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9E51F0089F;
	Sat,  7 Nov 2026 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046025;
	bh=dr0XL2VEj5o1R9eyQMFCy6oZW+TDsZ+wlLmBet8OfQk=;
	h=From:To:Cc:Subject:Date;
	b=DFEgdwWfCAKqAne3iB0o8EAbxYzmtKN8nhrN3n0rn3nCbD6lQ8VFFmWhmdLUZpjmB
	 gPNS1R33dlc36X9s6tDzhHMB4nARmf8dOKxCkpIggnaZfqP53gsXez8CuHg8wfxNl5
	 RQBwMDcrmyvX7d4UFmwi+T0Gw6TqRQTs2mJOu/KahrJY2aNG87PfyZektGZ6PpEmD7
	 nzy7OCpH5hCgwC5pVmdkTOuxkd2478EHnf/IdGpovk7DzRezMaZIJzlcb6wyZ2Rym3
	 MKzxlF9yUy1nTQ6JjE1fxCXbIRtJDM7w7IFR7ttrnMwAr3233FzMUPl5LkHbxijoUs
	 wHJTrzKOLicOQ==
From: Sasha Levin <sashal@kernel.org>
To: christian.loehle@arm.com,
	sumitg@nvidia.com,
	rafael.j.wysocki@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Propagate errors from cross-CPU FFH calls" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:04 -0500
Message-ID: <20261107050704-failed-6.18-36e96b469da2@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 36e96b469da24868f727b4cd168d7cf01cbd163d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050704-failed-6.18-36e96b469da2@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




