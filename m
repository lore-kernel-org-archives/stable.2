Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623986;
	b=QjajZuEjxiMkm324ANYDD6OPD3tICRArJnE3zGnE/p/p4BFQeoqLs11OA22jfBTxjbPt
	 IyOhecdevn4wMTKk2MRBh3c29Tb32bYV0WPgeW+XlACTdyDwz/W1akdcV5wVo1SOaZw8F
	 IOw1JOqitTLiI/tVNwPqli/YjapY0rm8aYLLBcagvAp0R7co7nd6eSPNTQmzE7VSrrS3B
	 H9iAuQIe2/qxCBOLEISJ+n+MW0bP+YpUrY3jkn3lnJZbobuV1GF5UBMslttZwIovf5pOu
	 cGxSWoGyia7gH1/VZQrnDSiukwhc/vVUnRLi//XY2izrD6QvCaj4b1smy6HKb1cT3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jHIAuAlgOFM6ocku+oPj/BuROI9M8e3SXUCe5scHzAs=;
	b=kIRIdZ/znUGVYowxla86gi1LjBCFVEOqOQaCKchscrU7wJtxb6Awk+MiQkcQD5/diOEk
	 2GQBHFQC7PmTSFg4y4VKlbZnF/pZC9AAVrNS1JCNFwqq5xW89AUM8YG2tiI2sap0fjrt0
	 vuxWl0ZDwefIAfymBV7TLeliDTE54j7z6BzW55GRqb69MmNPMlUYOmoUGL5b1MLIz+tJg
	 WzZ8j1Bs3EvuTxVpDo7Cbo6A9SrtMCHbk2IA6q+1Qxy6vKenO01FWbAx4XQZ71Lq2WOpo
	 I7tPON2GCMB1caT4SF/0L4yNkuE9cXj02Bby1AgrD9ahYq0SYB/WRA/Wt3AzBcbQWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHEZ6Elr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHEZ6Elr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662C81F000D8;
	Wed, 25 Nov 2026 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623986;
	bh=jHIAuAlgOFM6ocku+oPj/BuROI9M8e3SXUCe5scHzAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHEZ6ElrGbWbjwJkeQteg5upm3k5Nu61dqL4BZZHe+0+Udm47kt7aK4MxWEwjN8HZ
	 XLEUdjq1Swj3l9IFyGEl57QzXlWnPaHBSED7HS6QeWh9DErPpbvVDIXuALiJqN/ZIi
	 wUwDI9UsG/WCepUbyrHpKE1GnvozfAFftCsw8SMDl97AFGvhHR6jgbe6LQJvm364Ld
	 R+Pi7jybLKDyo/PfoX4li82LzB+Ny4PrCw6a4VEaQG+YpoExcgHdR6cTkFoeCYjRsv
	 iXzPwKIrin5tJe7t9MTS8cp6vSiQB+s1VTs+VyE6Zwc6wBme8Uhzm6FcR+3ndUacLK
	 KxHbLVWQJDVGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] arm64: suspend: rely on daif helpers to handle PMR
Date: Wed, 25 Nov 2026 11:26:23 -0500
Message-ID: <20261125162616.790035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-spelling-version-c8b0@gregkh>
References: <2026112540-spelling-version-c8b0@gregkh>
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

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

[ Upstream commit 630ca6c58fcfeaddd96dd46e7b11826013977955 ]

Commit 77345ef70445 ("arm64: suspend: Use cpuidle context helpers
in cpu_suspend()") added cpuidle helpers to handle PMR manipulation
and restoration to ensure that the CPU receives interrupts when suspended
and pseudo-NMIs are enabled.

However, those helpers are called in between a pair of `local_daif_save()`
and `local_daif_restore()`, which already configure the PMR as expected.
Effectively, `arm_cpuidle_save_irq_context()` is a no-op here,
even when using pseudo-NMIs, and `arm_cpuidle_restore_irq_context()`
would not restore proper interrupt masking configuration early enough
if there were unexpected changes during suspend or resume.
(This can be observed with Trusted Firmware A (TF-A) at EL3 handling
suspend through PSCI. Even though it should not be the case, TF-A can
reset `ICC_PMR_EL1` during CPU_SUSPEND, thus resuming the kernel
with an inconsistent priority mask value on hardware implementing
more than the minimum number of priority levels, such as Morello.)

Thus : remove the cpuidle context helpers as they do not do anything,
but keep the comment mentioning the need for interrupts to reach the CPU
if we are using pseudo-NMIs.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: ad3fc05c7e65 ("arm64: suspend: Only track cpuidle context for idle tasks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/suspend.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 045af2bfd656a..65bdeebb3232c 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -99,7 +99,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	int ret = 0;
 	unsigned long flags;
 	struct sleep_stack_data state;
-	struct arm_cpuidle_irq_context context;
 
 	/* Report any MTE async fault before going to suspend */
 	mte_suspend_enter();
@@ -112,6 +111,9 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * Strictly speaking the trace_hardirqs_off() here is superfluous,
 	 * hardirqs should be firmly off by now. This really ought to use
 	 * something like raw_local_daif_save().
+	 *
+	 * This also unmasks interrupts in PMR in order to reliably
+	 * resume if we're using pseudo-NMIs.
 	 */
 	flags = local_daif_save();
 
@@ -122,12 +124,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 */
 	pause_graph_tracing();
 
-	/*
-	 * Switch to using DAIF.IF instead of PMR in order to reliably
-	 * resume if we're using pseudo-NMIs.
-	 */
-	arm_cpuidle_save_irq_context(&context);
-
 	ct_cpuidle_enter();
 
 	if (__cpu_suspend_enter(&state)) {
@@ -150,8 +146,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		__cpu_suspend_exit();
 	}
 
-	arm_cpuidle_restore_irq_context(&context);
-
 	unpause_graph_tracing();
 
 	/*
-- 
2.53.0

