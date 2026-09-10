Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AB4A99C8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054672; cv=none; b=Qr9JnnPogtcoDh80lywX+a3f64t1/m7kpaB+NMFtef0p1KlaUNOk8bARjiLIMHj0et/UQEi3SPY0wrPjdqMXh3Ra3p6Gxz0jWXHMcks10tQ9LXAlFoaPqJivMgkSucfPw2QHN6Wgq0aRMAoMfKRHZ0jXzGXdbjz1YamwoTRfaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054672; c=relaxed/simple;
	bh=Bv4bC80or3m7BUgvIOolTRT5UNHTuTzC7bnfSpTi2ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c65mGtrctxwKuRdv/GQUHlImcNz9G/X7ffjaHEn2DC15OfO6gBnVLThM0YzqW80XIePcsjIsq49ffbuGXpFzidW29aR/xIZXs4r7qMjZSyl84p8YfoF4P5+DSUOar84y5dbxX6QDV9iPMneDtwv+c0klpXSQ16pS1IhDHEi2qKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2cYadjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2cYadjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE811F00893;
	Thu, 10 Sep 2026 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054671;
	bh=kKmKw3zmpx/6I5IUw10P96jFXh+runoneVd243tqUe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2cYadjKw0ARWEQrgOsL7UhQ4eK65m7BdhWWud4YZkMdV70NO4vdTZFDoMwU4VHm9
	 mNZocKsPnQD3eqEeGaYTrHXJUrLt6VFlWktGrI/Bh0ywYAhydNf2Wy0qtXfqzeUALG
	 eRhz/5Wb9beZbnOzPajkP+OPO1m6KV/1TAOCzsJ6CQUV78PI14tVA3q88CjgiPjEJB
	 Gm6+mUVc4kAMvX2LoyQo/cluGy96LIeH1/CCYdrCMSyOa6RnI3j+aFTHgSonai/x98
	 +VBON7OoQ/ZUPhHfc17VW5TjSbyD9JppaZnArMXQhMt2O7MBdy6uh6qz/j4IfntMzo
	 88YInvpU2+bLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ju Nan <junan76@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout
Date: Thu, 10 Sep 2026 11:37:48 -0400
Message-ID: <20260910153748.993578-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910153748.993578-1-sashal@kernel.org>
References: <2026090813-gallery-jackpot-25e8@gregkh>
 <20260910153748.993578-1-sashal@kernel.org>
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
index 71a46e76d8320..85ed9fe52e6bc 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -24,7 +24,7 @@
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
 
 #define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
 #define EXTI_HWCFGR1			0x3f0
@@ -508,7 +508,7 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 	raw_spin_lock(&chip_data->rlock);
 
 	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;
-- 
2.53.0

