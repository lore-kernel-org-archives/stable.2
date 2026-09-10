Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B34A2A64
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054529; cv=none; b=AQDHtxS8DNDvB8LAgW+v6Fcng10fhVOXEmdBR0hyPNGTEf8equsAxVhvhZi96g6l6e16Cl8n/Nb4+V2G8HKiuXOW0J9ncjnbMK5vuhiTktkHEV/5ocPKyUZjDWZxCgVCzF4KYZIfZtlztURydSrgmK5rDjpwyuJxmA0jT69bWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054529; c=relaxed/simple;
	bh=iC5b5LXIbzr14Rj/pAEzjVjlwyxg8yEZ4aZgG5D/LyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW2j3VY+H8pXfQoNhePl8m4ZL8bk+IEi0Vdq1BSkAAuWrLCyaFsWGP22u7BxQ+6sBaehiCGDQbdfXf50XOFoPC2yWEKaW0YnFNIzsw6t2uK6sWOnjL8MuFU6/esH4eZOFtvFYxDwYBUFxJh4Qve+j398qhcHHS7P0t3LowsQ7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecpuv09c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecpuv09c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B31F00898;
	Thu, 10 Sep 2026 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054528;
	bh=rdthV4i/SzpKkOvOpumgp6Y+khMhn74sHd2LRxc+5zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ecpuv09c61+2pjII5MBAPP61nj+/1Z9f0ohuI9z07o3RLvFVmYRG5DPIOb8SBIq8q
	 H6dkpTTPaQNCPVuJevipNDidV8MqcClfUNiG075ybRDQS5ctFltt/8Zm3BrVrjXdtw
	 Qj9zWVVXITx2CBBMx9QV0sXhqzEl077TpZRQY4ey8Vz0qeQ2hphNCFtyavr+S92DDC
	 wc/NwGLhGPnpCXU9Efmo/adRwxwmrkPUHeiz9PUz99PUaxV1chQNbAtSubawPEHDL4
	 72Um0z89noA6YGr8CaN9hQSayaXZ0tRRqVXmQkHdR/TlUQJmcMN/6FicstXjzjF/5B
	 vfORLO46xzvGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ju Nan <junan76@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout
Date: Thu, 10 Sep 2026 11:35:25 -0400
Message-ID: <20260910153525.983390-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910153525.983390-1-sashal@kernel.org>
References: <2026090813-staff-splicing-7337@gregkh>
 <20260910153525.983390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ju Nan <junan76@163.com>

[ Upstream commit d31fbbade43f880b7e59e2b3a72722fe2725d93f ]

HWSPNLCK_TIMEOUT is passed to hwspin_lock_timeout_in_atomic(), whose
timeout argument is in milliseconds, not microseconds:

  atomic_delay += HWSPINLOCK_RETRY_DELAY_US;
  if (atomic_delay > to * 1000)
          return -ETIMEDOUT;

So stm32mp_exti_set_type() asks for a 1 second timeout where the comment
next to the macro says it wants 1 millisecond. The semaphore is polled
with udelay() from a section that holds chip_data->rlock, a
raw_spinlock_t, so preemption stays disabled for the whole wait on every
configuration, PREEMPT_RT included.

The hwspinlock core documents this explicitly:

  If the mode is HWLOCK_IN_ATOMIC (called from an atomic context) the
  timeout is handled with busy-waiting delays, hence shall not exceed
  few msecs.

Fixes: 5257169ade8c ("irqchip/stm32-exti: Use the hwspin_lock_timeout_in_atomic() API")
Signed-off-by: Ju Nan <junan76@163.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Radu Rendec <radu@rendec.net>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260821024756.24927-2-junan76@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32mp-exti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 34b7c9b2717f9..6e4ac65e14147 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -24,7 +24,7 @@
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
 
 #define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
 #define EXTI_HWCFGR1			0x3f0
@@ -558,7 +558,7 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock(&chip_data->rlock);
 
 	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;
-- 
2.53.0

