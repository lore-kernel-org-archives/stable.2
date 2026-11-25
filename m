Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623640;
	b=IaZYs4IwdodFhRELmTVgB2xPoLja3Il56jCFnDFm3nrorP7GqGP4MiOmGV/EuqYjwGOW
	 FgMB0zbec9bz7Cie2y+9wz2h90VHcZ48N1qGn68Bg11XzScfMbqzKm7fAmiu3uVJ6fQjs
	 NhZzbxmnIidiJ4rpvKf5ckbxvKcYWlzHdDFWDcbNa1+I/HJeYJMgVKRrJifVmiEdgMqV7
	 kcsdhgR0i27MblvLESc6Kl70khTVlGxz80c+EG/SwkiheLo5ommsD5KolR7fYx3km4weW
	 BedFpOcx07JxP5uKWyaes6/C20kABAlB0RjwQVUHiSibDddTti1ma0xMwogOqhyUw/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZG9BEbV4YxPc4cR4uft8/XmqB1k2Znin6Xz6a4GlQro=;
	b=Bxe2x5VZUb/qAxGx59k/T9A6vnO6Zc0/vCCNMlLdnmFORhvqNH/qWC+JiesLsOc2kLR2
	 AvAQaYQ4WMZNwj+JsYlNK+VxLOX/gt5fovEWJs8NZe1ZpWzhqW4SeaP9SvZp1p5JoxqIl
	 2CN7f/8blFoU4vl8er2m+9Azd7T9YL4ZcYuV3jGAU81zKKzXStFlz6p/E57AheTx0Ccbl
	 L67+XUhNasQ7yicnAzlHcF2kW4yKZ8y7ePzrxZsHHfOVMyr8atRghjNmGu0WJFZg/zaC0
	 jER7E0dJBhYBBPwf+haNTjtt1AyMrHmN+3Tu9eN6Sv0r+W415+pKECL80DjRE85PBpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq486k65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D9606A682
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq486k65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942D41F000C6;
	Wed, 25 Nov 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623640;
	bh=ZG9BEbV4YxPc4cR4uft8/XmqB1k2Znin6Xz6a4GlQro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uq486k65jw+ilbJZ77ZEyzfTkyIUFsIjWgZL1UVasBUHxuHrQ2/jSRkbpmeiRM+XU
	 Z4nHpjus+/KpTtMr+paUQysqoRC29cAGkSnWfFW0/yZALehaWurze6NlAYpvEIdbwm
	 1AuZO0T2oStmRPmkELsmd8cvJsX/9KOWffIa8lt1JBNo15mK4SNpJrv1+/bD5Vi/F4
	 eKhU3wRR3st3kyPNeuQTzGBluuSpR1lWfyoB04a7vpDqDJPrB3JS443B4C8ZTidOnC
	 G98o//dcZDve4Sadn367870uuYNkTQpX+eJCZFiSjYjW3l28wV48SoegKqQu71eKT0
	 kPpXEfmmiIQKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] arm64: suspend: rely on daif helpers to handle PMR
Date: Wed, 25 Nov 2026 11:20:37 -0500
Message-ID: <20261125162031.756040-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-presoak-impromptu-e705@gregkh>
References: <2026112540-presoak-impromptu-e705@gregkh>
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
index eaaff94329cdd..c41724a40b756 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -99,7 +99,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	int ret = 0;
 	unsigned long flags;
 	struct sleep_stack_data state;
-	struct arm_cpuidle_irq_context context;
 
 	/*
 	 * Some portions of CPU state (e.g. PSTATE.{PAN,DIT}) are initialized
@@ -121,6 +120,9 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * Strictly speaking the trace_hardirqs_off() here is superfluous,
 	 * hardirqs should be firmly off by now. This really ought to use
 	 * something like raw_local_daif_save().
+	 *
+	 * This also unmasks interrupts in PMR in order to reliably
+	 * resume if we're using pseudo-NMIs.
 	 */
 	flags = local_daif_save();
 
@@ -131,12 +133,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
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
@@ -159,8 +155,6 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		__cpu_suspend_exit();
 	}
 
-	arm_cpuidle_restore_irq_context(&context);
-
 	unpause_graph_tracing();
 
 	/*
-- 
2.53.0

