Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA339A05D
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122083; cv=none; b=HIgChB4Bk9mB3rtvZlINS8fyb/bZ58AMK9sRhd4LPJzrF+T0RjV/ZuZLIk3YtuZ/JAEgrN/x+3uF+zeTO79ukDt4p1WbP1h7W1K7RQupIHIhpL+4O1Bi4s4h8ueqWXRevywGQdg3Yn4VQi+CKQc70+NXjVtiMXC1JTRgats+iBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122083; c=relaxed/simple;
	bh=N33bS6d1fb8GwHLGigaBidVRxWEIFPI33TQGP2A5Kgc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lwvg16fsx4y5C1Ey0/SLiWc8jZyKS/wWPs8jW3zoNvEygd03zEX+v/wWLvXbrHFPa19ZD50XmXyLoe4aQc8gR4UtyETW06CXVR2RLmMZ8aIGKPfAcW2dPfyMULV8W++PplTjZvo4CBfTWf95m05WlKePTZON8e8cewHdWEDyaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfOH8Mbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfOH8Mbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3944E1F000E9;
	Mon, 22 Jun 2026 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122080;
	bh=EK3Jzgwc6drkAbd3vS+vB9oP77g/BmE+bjWb++tgjpo=;
	h=Date:From:To:Cc:Subject:References;
	b=CfOH8MbrjniUnRoIpZzj2p7T8xX0OMIIYMoASRAmX+zWuKH0N1XGp0tevmMjFtMTX
	 rjdUWLEw9t6UonBaCJsrlXNarxFeBtc9VNRqQSdKFPOARoxpXkXKtpsjQzLMZgGL7f
	 56iQzdt1mPY6D7+I6jxxR3dvtffD0tHpmoiMUnvd8wdL9IKuuzTEkToVSC/je46Uao
	 hRn61Kxyj2oV2DJb0y2EQHKaOqGr4oATbtkJdjHq4snKm0qxH4ciBy3dWzfQf4Pd3V
	 SV3oVdVy5jU80WgbAe3a4SpeIeo1BJwJZ4KcDcO9CPAHSGVT6P1z/I6TCxDOlAQaB3
	 yLnMwa7k3v/BA==
Date: Mon, 22 Jun 2026 11:54:38 +0200
Message-ID: <20260622093321.529425167@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.18.y 1/4] debugobjects: Allow to refill the pool before
 SYSTEM_SCHEDULING
References: <20260622093040.582177124@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 06e0ae988f6e3499785c407429953ade19c1096b upstream.

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
---
 lib/debugobjects.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -731,7 +731,7 @@ static void debug_objects_fill_pool(void
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching

