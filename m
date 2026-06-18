Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0849330B22
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788067; cv=none; b=KduJkPhpiG5DOsewOwGWlvhsOSMKBlROniR4a+XjOQz+MNfv4MjeOXr4SaCqEPhqdj5nYQPahhwincz7N012hokaLPCKBmoGtEnn1PmYZy2tDK+uxuXkn/xOjGgoCzeoUCcWGm5LoP20veGkh/mHmNkjuDFBaEFeNrcc0NSmApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788067; c=relaxed/simple;
	bh=a5Pk5eFfEUOSIP27IlvSHYNrtsQhvs+Aa/S7Jift7fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBLYmZ5Arrd73lFCmtp027Duv8ASl1PwMV8VdRt7KMb8QH3K7UaVZhN8zAWTwDcuPsC8Dqxm+X3ufsUlBAqwixM6xPmLApg36769qWsd7JTotq/KqQkuU8lXZMB9upgmxTrPsnMHC43iZvlV3zh/CplsCRafKMff8ejDfjefJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKnBsky4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKnBsky4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202061F000E9;
	Thu, 18 Jun 2026 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788066;
	bh=yyrZzbgMYhkqM9fHWKpsVNh1+001H3Z+e+XBf+fgbLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKnBsky4D9A8pYfWTf8zIxpVeViZB0s28Olr99LSZ2urozOgH5iufoDoYjlf7zhfo
	 3vQ2H5NqTPpwPQjZ1uUndVaF7Wt4AxoTkvnI0s0Pq5Ex7lV4BdO803Wmxb22UOK15A
	 ClPw8Oe/uI/e9AZZtd/0LLuiPOuzspwPGnERp8xkfgj2kfZvydjLAPRotYbIB/Zd9Z
	 PbcpkvoMRtYWrdm+aXhG4QhWfI7m6VTli3Ac5qo+ik7eRK2jM+L5qgKpvnhuCsATYo
	 6SeDCF1jjXjGz/0emS+aGg42sYihIN7JVLJkDmWgW5/IGDc++RKLinKFQ48pdCwUJ5
	 YiIVJc5zq9sxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
Date: Thu, 18 Jun 2026 09:07:43 -0400
Message-ID: <20260618130744.699242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061610-brunette-clasp-5eb6@gregkh>
References: <2026061610-brunette-clasp-5eb6@gregkh>
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
index 932e2d8dbd9b9b..d69721bb78b797 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -604,7 +604,7 @@ static void debug_objects_fill_pool(void)
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

