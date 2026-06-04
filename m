Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D4477998;
	Thu,  4 Jun 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576698; cv=none; b=GquGXLm+2NOV6CPNmgNBt4QWDaPNAs9nSFUvUO3H+gRd9oz4DzT+Tuvx7XR+X3gz1jauipgYiOZsrN975azXc3LjCIz5gDj1PTTJ4PB+9Q/T6csILMjYeUQLCnRTfAJ6u3Ro3y0RwAG1oiBt8o7qbRWibcl5MHIFtlDbRKH6EEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576698; c=relaxed/simple;
	bh=we47YYaE6BYyUxQ1wet770jWCAm2yCbUyoIKyySk65E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZpUf8LdRU/Yi2x2jqYq2bZOGuc2ktTLB602dPGbQX1k4AHfKseOk8f6hQ7XoUTfQfPHT2AZDvjZN7GskCHZ9bua5ygzbsdna0nhuLHDspvd4twT7BGbcsnswdEKqLtO7iMTN6hfsVRCtO/mfSf36XMcdtFEWy2A/2FO7vz3JqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Is0+Vxt4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H561HnD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Is0+Vxt4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H561HnD+"
Date: Thu, 04 Jun 2026 12:38:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780576692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y7XyB8fb80ukOrz2u8tkp2EKPbJfiUwvRSitI7jk60=;
	b=Is0+Vxt4WMKzyPjnD+sPwMB4xl2JVuPv40PEJ9QvyILaip6APFbGIzYDYR5gBMuAnHnC18
	G2nBAj6lR6tejveo1bhxkp+DyMMK638Ga4DjPX8MatS55+J6mXktnU1vmwR4nulqXoq+cs
	hM22HT/Jvjar2pUlZuWxkNnw31REaUHx4wa6HrhMH/apE9oU1SOxKnkjDkliH2tXm8x94j
	dzBzgB3b/y/pN+AgRNj/3NkeqVIqINNbHSvlTXdHN7bP0alp1aw099wOXQXJLXGMf9WGda
	y1fUAcJsjF4U3JChPPeQKIpqWlDz4lYSEOKjPpLJSTz2nO32+14poVOY2NBAQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780576692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y7XyB8fb80ukOrz2u8tkp2EKPbJfiUwvRSitI7jk60=;
	b=H561HnD+8YpDBKNpC/eFrqXawrSZbf4hpTXAjZquVhdh+psYeuX4kVNoV/x/AVVqhbYW1U
	Jvg1sYbM/4tOzbDQ==
From: "tip-bot2 for Amit Matityahu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Fix livelock in
 tmigr_handle_remote_up()
Cc: Alon Kariv <alonka@amazon.com>, Amit Matityahu <amitmat@amazon.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260603170139.33628-1-amitmat@amazon.com>
References: <20260603170139.33628-1-amitmat@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178057669029.710.16956490801880312395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     d486b4934a8e504376b85cdb3766f306d57aff5b
Gitweb:        https://git.kernel.org/tip/d486b4934a8e504376b85cdb3766f306d57=
aff5b
Author:        Amit Matityahu <amitmat@amazon.com>
AuthorDate:    Wed, 03 Jun 2026 17:01:39=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 04 Jun 2026 14:35:33 +02:00

timers/migration: Fix livelock in tmigr_handle_remote_up()

tmigr_handle_remote_cpu() skips timer_expire_remote() when cpu =3D=3D
smp_processor_id(), assuming the local softirq path already handled this
CPU's timers.

This assumption is wrong because jiffies can advance after the handling of
the CPU's global timers in run_timer_base(BASE_GLOBAL) and before
tmigr_handle_remote() evaluates the expiry times.

As a consequence a timer which expires after the CPU local timer wheel
advanced and becomes expired in the remote handling is ignored and the
callback is never invoked and removed from the timer wheel.

What's worse is that fetch_next_timer_interrupt_remote() keeps reporting it
as expired, and the event is re-queued with expires =3D=3D now on each
iteration.  The goto-again loop spins indefinitely.

Fix this by calling timer_expire_remote() unconditionally. That's minimal
overhead for the common case as __run_timer_base() returns immediately if
there is nothing to expire in the local wheel.

[ tglx: Amend change log and add a comment ]

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Reported-by: Alon Kariv <alonka@amazon.com>
Signed-off-by: Amit Matityahu <amitmat@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260603170139.33628-1-amitmat@amazon.com
---
 kernel/time/timer_migration.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1d0d3a4..52c15af 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -978,8 +978,12 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u6=
4 now,
 	/* Drop the lock to allow the remote CPU to exit idle */
 	raw_spin_unlock_irq(&tmc->lock);
=20
-	if (cpu !=3D smp_processor_id())
-		timer_expire_remote(cpu);
+	/*
+	 * This can't exclude the local CPU because jiffies might have advanced
+	 * after the timer softirq invoked run_timer_base(BASE_GLOBAL) and the
+	 * point where the jiffies snapshot @jif was taken in tmigr_handle_remote().
+	 */
+	timer_expire_remote(cpu);
=20
 	/*
 	 * Lock ordering needs to be preserved - timer_base locks before tmigr
