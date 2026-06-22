Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0E3644C9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122117; cv=none; b=NWzQJlp71mRqOsMIe/N3NzYZ5fl1ZQ9gJiDpLHpNNtpEfiUjdkSRShFK3yBYLCA15CSOo3QM2+Er/n7QTLtMNZTETppoM75zv5i65vnsHiC9T/oh1kDqvSpc9n17YGKOPq0nl0Ewv3tHYsAXYrxMjDsLjgMDu23Nm9diOTqsv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122117; c=relaxed/simple;
	bh=cZleeDJkvfG9CWhmw76fwkci1b3DYdiDD5Mu9SrOh7E=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BhvuoAvVVEor1tNts4suYeUv0nXAWHWB+iAn6J/O5JExZrnYqweGzAJ1f08lvq/2jjHipCH2t4xeFN3z9WXiUMbVvy9zdvOc0vmR/S8SulKbVybnfqH1M6N/O9aSBgMyP0RUBoplVWb7adQyFIW/jeOd8So+uyCmeFHNTjt7E8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/evU/fW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/evU/fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48A71F000E9;
	Mon, 22 Jun 2026 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122115;
	bh=T61vrN2WtGUqjoM31DzcpbQRmltAxbvteH2cHPdyYQQ=;
	h=Date:From:To:Cc:Subject:References;
	b=k/evU/fW6OtDsEAGRQ7TSm0IWZ0iQJ23PrbsVNcPPkYKKAEtNvxEm3/ho6OcSptXV
	 6Z1qClmbbDPdYWlp55F0p/1bLfI6zjKq1D/kXfj4POpWs/MdGBVz0z+U1YD5Z5DACd
	 9HWGVba66YGQw5ngSq8GzobWVhQkPTZgBPkTdoN1tCTf26QuxY8xlFHVGu9YnQYhYq
	 M1nLMgkGXRd9u39/JbWtmC3CjDD5uz75HxiDCjUyCD7Eog2EeFUEeVH4VJWCQAedNJ
	 EpWpCdGTi9otA3EDPsKJAZab67VDmUwqvRRFBjRXZBvLUcg1KqgomjEBjTpGf54cd7
	 Y05jiYoOSQs7A==
Date: Mon, 22 Jun 2026 11:55:12 +0200
Message-ID: <20260622092952.095465135@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.6.y,
 v6.12.y 1/4] debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
References: <20260622092400.929691694@kernel.org>
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
@@ -604,7 +604,7 @@ static void debug_objects_fill_pool(void
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching

