Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A5442135;
	Fri, 11 Sep 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114837; cv=none; b=F17msCu0wurErLfmNTWi5zhGU6qk7G2NohaIOWcPD4bc0HXlbvire6HESpbuFQTSPnhTbe1zVeXa1w7RUcj9g8aBcMHkmVEC4ZPtRrwOQfenrDkqQmzRBff1ZeDLRnXmoeWvBSPHBj9aILfXS1vgwaorWyu8TT6uB0W/QWk5rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114837; c=relaxed/simple;
	bh=qqLjM3cA03EA+uVLllYWVsib7wPeHs3eWoHtwm1WkF8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q7hhMbzZ+cg6ACuwHZGlXAXB3nPAMM0M6CUwYozsJOfSdYoO379HWKTAhfUDrjZ7H7DRWOAUhr/pRMAcsp/NRCw5O1y60V2fl80ptrZXy0s2m6Gd5bc9cZYew2VwIBNGtSmnXftMQG5/cpAwUzOofNuJhX34w3AlgJmOYcIwCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3Qc8FFS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUYb8j0O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3Qc8FFS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUYb8j0O"
Date: Fri, 11 Sep 2026 08:20:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789114833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q43YZeY+1hBCkYeXGRGhjq+NT6aa7HDTh9/Wsts6Z98=;
	b=u3Qc8FFS6np7utOfyHBlLDNssS/oll8uJdpcGadSt3jJlEP17pd5L9TbvTxgvfJ+4PA6Cm
	dArJgPI/RO40+1qKSrlZ38neN12gww25JQmfWSbs4vCfzQdsVaHnXGta3uRCXJgjCZNIqf
	PgmXK7FBHalOid9Cw/JODfiRIs6kNPlZjNGFdnCPL7dgI9FkmemBjW1dngRMPm7jz64iCS
	XheKetyVo6O2GT9locc9ItokNmfJcbbinPBCqajxQTM9E/Dv/VVNZNtUJeeO5H0EnXCepF
	BQ+LhDCBuXvZEa3owfl5akox1OVvuDvI6WHwUGuAgtcsCa0mKzHJ3C/yHGegMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789114833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q43YZeY+1hBCkYeXGRGhjq+NT6aa7HDTh9/Wsts6Z98=;
	b=RUYb8j0OE5BMTyvfx5Cc1K/E3g+u1I+94Ulb1k8/6aE7UO5nSN/Jkqpv2sWYxci2Au3+TP
	/FHkgC9ez1lYB5Cw==
From: "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Use hard expiry when updating timers on
 the same base
Cc: Andrea Parri <parri.andrea@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260910143442.2018-1-parri.andrea@gmail.com>
References: <20260910143442.2018-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178911483132.623050.11273554283612054728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c5dcb3aadc18d7b82ba64790721b005d18193d35
Gitweb:        https://git.kernel.org/tip/c5dcb3aadc18d7b82ba64790721b005d181=
93d35
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Thu, 10 Sep 2026 16:34:42 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 11 Sep 2026 10:15:42 +02:00

hrtimer: Use hard expiry when updating timers on the same base

Rearming a queued timer with nonzero slack can leave the timerqueue out
of order. remove_and_enqueue_same_base() checks the new soft expiry
against its neighbours' hard expiries, then stores the new hard expiry
in the node without requeueing it.

For example, with A at 10 and B at 20, rearming A at 11 with slack 30
passes the neighbour check but leaves A's hard expiry of 41 before B's
20. The same function also caches the soft expiry in base->expires_next
when updating or inserting the first timer, giving next-event selection
an earlier deadline than the queue head's hard expiry.

Set the timer expiry before handling the queue. Use its stored hard
expiry for the in-place ordering check and both updates to
base->expires_next.

The early update is safe because remove_and_enqueue_same_base() runs
with base->cpu_base->lock held. The lock keeps the queue stable while
hrtimer_can_update_in_place() checks the new expiry against both
neighbours. If the check fails, timerqueue_linked_del() removes the node
without comparing expiry values before it is reinserted.

Fixes: eddffab8282e3 ("hrtimer: Keep track of first expiring timer per clock =
base")
Fixes: 343f2f4dc5425 ("hrtimer: Try to modify timers in place")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260910143442.2018-1-parri.andrea@gmail.com
---
 kernel/time/hrtimer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 530d612..cbf1693 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1263,13 +1263,23 @@ remove_and_enqueue_same_base(struct hrtimer *timer, s=
truct hrtimer_clock_base *b
 {
 	bool was_first =3D false;
=20
+	/*
+	 * Updating the sort key while @timer is queued can temporarily
+	 * make the tree inconsistent. This is safe under cpu_base->lock:
+	 * no other queue operation can observe that state.
+	 * hrtimer_can_update_in_place() either confirms that the new expiry
+	 * fits between the neighbours or timerqueue_linked_del() removes the
+	 * timer without consulting the expiry.
+	 */
+	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+	expires =3D hrtimer_get_expires(timer);
+
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		was_first =3D !timerqueue_linked_prev(&timer->node);
=20
 		/* Try to update in place to avoid the de/enqueue dance */
 		if (hrtimer_can_update_in_place(timer, base, expires)) {
-			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
 			trace_hrtimer_start(timer, mode, true);
 			if (was_first)
 				base->expires_next =3D expires;
@@ -1280,9 +1290,6 @@ remove_and_enqueue_same_base(struct hrtimer *timer, str=
uct hrtimer_clock_base *b
 		timerqueue_linked_del(&base->active, &timer->node);
 	}
=20
-	/* Set the new expiry time */
-	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
-
 	debug_activate(timer, mode, timer->is_queued);
 	base->cpu_base->active_bases |=3D 1 << base->index;
=20
