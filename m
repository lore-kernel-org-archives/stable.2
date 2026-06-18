Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA53FBB67
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787549; cv=none; b=CjqqsqAg0S7tsFjv0LcAdbQOILiN4U4r5pcRHC0BXmWg3iaPne0EVTEaiJLEv13o0sIUL/dosLUMgBcGY2Tz+A6HTJ6C2K4Jk6jzSE8k/42Nz3lVCsfrL4Mtt5wfbr8rqFTwTqP+f5JNcnFiVa5G5cxiNTnuWXW0bjibWJtL1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787549; c=relaxed/simple;
	bh=0kUHnS3cwywV7DFsDnlsEy5noZwbzNyyH7Ny9fqwHbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf9XdfYtA67Mkl/t/T8dsktRsK8Qn5WIkr0e0ZXGblGrH6q8hMloVYdTat2xdVsYaJRPogO2uyB7pGyduWEPh0ukYPhoCZao47qzqJ2DXRHFlMWJ+UVeWPFVBNuWr2ItGPnFE9H8N8uGpUTFhUXTyhpd15wo9iUMFeExa2lBYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXRAxZA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXRAxZA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5ED1F00A3A;
	Thu, 18 Jun 2026 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787547;
	bh=pUZSBGUbhZXn8LtAQa4ziGG7BhOiBSPvBYAIe2YJqBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXRAxZA7tA7ELczVDDD+mLgprMksZznwf3c8AchzZ+41gc9i91Rs5CIGU7OI0tEVQ
	 GMkjXg/ptp1/WYes1mU/vtxD9U9/qqEBMA1FqscvwI3jK1EjzzybmbdJOhHLZyRdiZ
	 rP8iGTGbqJZ7AfYQk23vFUmplzEts8uZYeNIANBb/qM6e1avWYW5JyOq1K/fvOQbEP
	 cItTXjHi8jTDvvav4T4zZW/ffMiJJx8omyJqgtUymiA1wF+Nzs5ZIEvvfI+GzudMV8
	 nAlkMY2CMHxSAkyOOqKqIHxgVF/mtLPcrOdYIzYyo6PNPNw7zwkugHtLXXz1As5+n3
	 XsvGucW6QvGHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
Date: Thu, 18 Jun 2026 08:59:04 -0400
Message-ID: <20260618125905.692105-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061609-grievance-habitat-1c05@gregkh>
References: <2026061609-grievance-habitat-1c05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 06e0ae988f6e3499785c407429953ade19c1096b ]

The pool of free objects is refilled on several occasions such as object
initialisation. On PREEMPT_RT refilling is limited to preemptible
sections due to sleeping locks used by the memory allocator. The system
boots with disabled interrupts so the pool can not be refilled.

If too many objects are initialized and the pool gets empty then
debugobjects disables itself.

Refiling can also happen early in the boot with disabled interrupts as
long as the scheduler is not operational. If the scheduler can not
preempt a task then a sleeping lock can not be contended.

Allow to additionally refill the pool if the scheduler is not
operational.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-2-bigeasy@linutronix.de
Stable-dep-of: 5f41161059fd ("debugobjects: Do not fill_pool() if pi_blocked_on")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index e4b7f77ece3b4f..9d59b797d1b507 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -731,7 +731,7 @@ static void debug_objects_fill_pool(void)
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
-- 
2.53.0

