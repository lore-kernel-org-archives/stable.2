Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038C48EC83
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053078; cv=none; b=sf0F/Azf5octDRS2uq5UGIENWa1fqe+KD2jdedG/kfX39laVDUdZ5UFsXGXbG/xjBgebGf1vHaukY+qtGwHuX8W4+D8cfX3U9kBnMNBXXaD86790BOhdrMVI5Bfnf2WTJ1EEObKsVw53MqaJVtJ8dl1vLCEFLHLeLRVS6WZYc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053078; c=relaxed/simple;
	bh=U4uM69tf7q5iw51h8O9gPxQJThAHto3eq1IxG/GH9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhPPcGK+Vea6Il+nD7rT1cbAGs5kSX3ZzufmzEQ+wL9BlUKkMEyKDi9LyQqanW0XiTy1+4hGmL0r3R6EIBtHerZnXEwsizJQRMsmGHrOu2n5CcEbwFQN0Dh+L51qR1XGyGeFL/vVE50eyUqORfm+yfmTzCrCStipzlBBsPljc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZrvoGNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZrvoGNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08101F00893;
	Thu, 10 Sep 2026 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053067;
	bh=WReRLQaQmACir7dFSApyET3D83N6zLqIRmficZ/+dAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZrvoGNZ4HSCuJjf8U3OT0QJ056YWKMt56BCwhU+829dep1h6sEvPIXHm4ud3QF2/
	 Ah8mZR4tVvm0HSCymEN52aNv6KmarrciET3Mqv4BeUckPbv7wWv8Xs8YU+0T0Sh4AR
	 gCL2Q4gCN8HeZxxszT06MReDZOxllSN/k973RlIU6vVaQmgSs4HHsTZVDYT0x69GZR
	 4Hcvjld8sOzwJ1H5UpBhSyWp88BFXJZIppK26TOoLcnOSUY72wbP1HsnfbDnkxpN1X
	 2qmJjH6ZkyJ//8A2RyEQp1DlNG+E9vF9mgrFN2O5DyYCY1r2CcjJpnv6xSAVYRgdcB
	 K3BUgOP2k5XaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ju Nan <junan76@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout
Date: Thu, 10 Sep 2026 11:11:04 -0400
Message-ID: <20260910151104.853748-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910151104.853748-1-sashal@kernel.org>
References: <2026090812-banker-manhandle-d0d6@gregkh>
 <20260910151104.853748-1-sashal@kernel.org>
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
index 6f607be9c9c43..b45d66d285cb6 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -23,7 +23,7 @@
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -361,7 +361,7 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock(&chip_data->rlock);
 
 	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;
-- 
2.53.0

