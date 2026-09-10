Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384D47D932
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055089; cv=none; b=GbwFxdbjqNAwwy3G52+joawwbDVilfW66hVc7sU71XAj4p28RJi3WKNiCRzRrUECs91emxEnHx8sMeWHWDYP5dTBq2ZqtQeTvvXkR/pxc+ap+of3AD42hzfB4hd8k54P6TSR6nxF+krA+Xh95apBvBlC1YqHgFP+dfTU8schI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055089; c=relaxed/simple;
	bh=D5n1dRWxS8syqPVknutKljB5mtyBreAU1CnzKmu8J9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKkHdNV/iyiYVJlyU7SHUMKVHVrBZrGlRVQJLJFq1ZPiF0BUODrefngI/HP33MIwswy4s8VGyLIVm+A2LOsypXOEcEQWVX8vVoROQBUa0+kHx1HGY/caBxgx2o0e+8F42GFTvzzgzuJ82dHRrK9Gis6diWwXZ68QW/eXcSer9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrL8pfdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrL8pfdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D33B1F00898;
	Thu, 10 Sep 2026 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055088;
	bh=BeYEaWuqcJFw7kpPv/Xb0lE/qbZTJoWFelX0kNNOiH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrL8pfdLb+ey0NU/YMLklzyouKu2jXUls8ogSLR0ngAOqw+j4SeFVcTJ9C6zl2kBF
	 vjUY40f9Xnf1cbKsJsYWN8w7/YZqOANbKGYVNzPiu3QzBYgOmUuxuZ2ZOrVj4tlA6h
	 nge/JIqaLb/GOOe6FvEt07ovy3fTKqYaTFxHpVuEk5c/qdYUuv4QX0ExqHkI8aiuyP
	 n32uPAlC+Dl2fcvwwNivF5NQtuhe3XvRi2FZ2VfqXm443XVdtGC3fBhXnLY0FmlZUT
	 QTT96Qnc6rDmWlyV1vUCc8p6cuiqnnkgbXKNMGqzpq06XyT4XjXwQZ01QXKGTW6YSE
	 qYmIQC86R23Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ju Nan <junan76@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout
Date: Thu, 10 Sep 2026 11:44:44 -0400
Message-ID: <20260910154445.1032754-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910154445.1032754-1-sashal@kernel.org>
References: <2026090814-trapper-singer-17bb@gregkh>
 <20260910154445.1032754-1-sashal@kernel.org>
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
index ed43ced2d6ed1..fab88feae3e3d 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -24,7 +24,7 @@
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
 
 #define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
 #define EXTI_HWCFGR1			0x3f0
@@ -503,7 +503,7 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock(&chip_data->rlock);
 
 	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;
-- 
2.53.0

