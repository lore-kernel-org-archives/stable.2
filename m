Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2573ECBFB
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790241; cv=none; b=FjQ3syc4MgptMx/JnKnm0waNnuS38nfTo1T1Ck+8/ASc+rFjl1fg5iC7XkldAOD/xxE+tstldK8z6S1cEdc/tPgi0NTRcyZJT3kop8C1CtZflLHiHghgLdfSYaYTpyxQwC+nGNQPqesOjmjB7RJTdK/O1M00VkbjJ43uSvrUo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790241; c=relaxed/simple;
	bh=nT7rf3DS1fmIVOm9ahfIEAeU4EzqZHo7ZuzJq87AbGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7sMbC6x3ioDjD0ZwlEb8gc0+G6zpdycna9GPcokrdb67bE3CR09MclNRiW4NdbMj8WJDUIXRH9lGGGygukQ3gC4SK9b1IXcDcReocLJ9bdvr6bF/gCzS2YBymciS/Y0BDUhgu+/NEeGx41iHUjg63/Ol8uaQwch8Unz1rJPsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz6rGNsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz6rGNsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28DB1F000E9;
	Thu, 18 Jun 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790239;
	bh=zOb5LhSt3BtCHsEASMGRQm0MH9anAZxtYIHx/0/L+hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fz6rGNsSZxoMFG+NDfgLbOLbwJATnFJ0mKDzlV4lxOv6uXe0cX3iEJ15jpPV+r4fh
	 n0R5pG0brUlTTqEyocOHOcg9fjadio2NohAtu6cRa6ju1IKEX5ojzoOTL8nbM5S5Ae
	 hze3qrv9kZd9GD7Vsna5NveELyp54Eaqn0PDOYXqScN/PVsTlJ9KRHYALk59PP1KPc
	 QmQKYI4WzlVbD0gVkRBzmWP1P3u3Jc6uKfesFvJpjnGisSNf/0H3s8o/AjjaCCIWvd
	 QQSvT6/nD7JjK7q0dCoeO4ZsF7rPfO9NP2phkQuATV+N/FCnde5P/IKevgs8r0A45v
	 O228gN87j6rMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
Date: Thu, 18 Jun 2026 09:43:56 -0400
Message-ID: <20260618134357.720470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061610-amber-humiliate-b27a@gregkh>
References: <2026061610-amber-humiliate-b27a@gregkh>
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
index 9d401355d560d2..970b310a2ac44a 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -605,7 +605,7 @@ static void debug_objects_fill_pool(void)
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

