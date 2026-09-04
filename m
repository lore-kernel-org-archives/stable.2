Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28C4AA569;
	Fri,  4 Sep 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531852; cv=none; b=diNR+eaYMW1Mq5YGGdjzkbqzAtDVJdrsgktrDb1xO0pxjPKVAc2Lyi7wjMf2dQuWdsMC15v/ZVtD6exD4a16+71d83sIwOwKEsPBF81Nt6waX3h9VTF+5OM8CV39KsV4O+xNDNbZKQ0ilGqiSBAkS5CNl++0Okvtr7X/WyvYd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531852; c=relaxed/simple;
	bh=cSeLWYPY/mcwIVrsEL4G7N7JU6xpFkt+FUXXo1QKlx8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cdPELMLmBn7RCc18UaT4NyQdVNLVpmx/mpIkCPCoiPFLXPz/wptdn9jrNDxWLX8MPQRW3koyAeRGJl8i3zsEyU2+CLstsIDJgl1Le3IuQ0oLW2pZWa1+LUM/v0gIrq4tUhQaMMq/aDehk4pZ6bAUAGSFgwIxsMpqrVKWh6K+Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBW7bhFl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbuzHIdC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBW7bhFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbuzHIdC"
Date: Fri, 04 Sep 2026 14:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788531848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6gvtUy8KYGiFyk6kS64PBPCxK7ZQAkHBrH7/+RyFQs=;
	b=RBW7bhFlemi3WMxfe+Ub2XYIQjrVeSDxuv1wat766NIVV3lM7mp+dg+M+qNV92AD2I+zej
	FSVge3dKq+IgVVyEx96pCtshuAdGCc6wy6WmpQJVRKSQyrvD72k3BZuC16fQOjfO4FAq7U
	f5ZwTXkwJBsUgNmz5lQptPzz8V8BhJbUUh9tRqX/lSI+jkJXyBDH7EMClgeMuXiJgn2x/o
	kqohrNdO1BGUo+GDEg5zFTNK/C9JetBE8whZbIedzS6YXd+AfusL9EDScUe9GhZ2I+m5Mn
	uOMS8CLLo1t2mmPp9alsY4lqNeBTXkxPT5VyP07J9gJupNC5Eei9xOQtaxldRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788531848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6gvtUy8KYGiFyk6kS64PBPCxK7ZQAkHBrH7/+RyFQs=;
	b=DbuzHIdCMqdyr9SznkK9rcVkexjfte5+f2QixRDhUIEYsXGKwb58M8o+5urABBRru7l4Ag
	HUfo1FvMWetOCUDQ==
From: "tip-bot2 for Ju Nan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/stm32mp-exti: Fix the unit of the
 hwspinlock timeout
Cc: Ju Nan <junan76@163.com>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Antonio Borneo <antonio.borneo@foss.st.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260821024756.24927-2-junan76@163.com>
References: <20260821024756.24927-2-junan76@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178853184680.3717435.344979410009701519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d31fbbade43f880b7e59e2b3a72722fe2725d93f
Gitweb:        https://git.kernel.org/tip/d31fbbade43f880b7e59e2b3a72722fe272=
5d93f
Author:        Ju Nan <junan76@163.com>
AuthorDate:    Fri, 21 Aug 2026 10:47:57 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 04 Sep 2026 16:19:04 +02:00

irqchip/stm32mp-exti: Fix the unit of the hwspinlock timeout

HWSPNLCK_TIMEOUT is passed to hwspin_lock_timeout_in_atomic(), whose
timeout argument is in milliseconds, not microseconds:

  atomic_delay +=3D HWSPINLOCK_RETRY_DELAY_US;
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

Fixes: 5257169ade8c ("irqchip/stm32-exti: Use the hwspin_lock_timeout_in_atom=
ic() API")
Signed-off-by: Ju Nan <junan76@163.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Radu Rendec <radu@rendec.net>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260821024756.24927-2-junan76@163.com
---
 drivers/irqchip/irq-stm32mp-exti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp=
-exti.c
index bf3a2de..a19e91f 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -22,7 +22,7 @@
=20
 #define IRQS_PER_BANK			32
=20
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
+#define HWSPNLCK_TIMEOUT_MS		1
=20
 #define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
 #define EXTI_HWCFGR1			0x3f0
@@ -376,7 +376,7 @@ static int stm32mp_exti_set_type(struct irq_data *d, unsi=
gned int type)
 	raw_spin_lock(&chip_data->rlock);
=20
 	if (hwlock) {
-		err =3D hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		err =3D hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT_MS);
 		if (err) {
 			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
 			goto unlock;
