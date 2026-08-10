Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E037C90B;
	Mon, 10 Aug 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786393068; cv=none; b=ZdTK7lsvnYpc2bDu1AHCzKPtZP3xur0M+g/y19gpZxWSDOB8LyGYLoZLxY6a+wdRQYSlx9h3I2JS2nIrUuTw034e8brw78lGplXC3/b0tgf+aJD8PAy7dEhWDs0nnKZ/hv93aTMPYlAb0qjeEl+5/h79ZP9ZHmFbQCciGcF57M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786393068; c=relaxed/simple;
	bh=cFLTuDNi5+JdGv2E2Md9scetopxSbkRWzv1Uxu/Pv+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K65Ea5OU2JoYHAo/B9xEbhuUW6EvbC0/1bP2JAOogmSbfo+oHKqMb+1v8n5pW03qsRm559AQS6r6eUTbdMDOu/ZBGDxwSdY/0ge0u5LLUJRH9o3uOz40Cp00E/L561v8pu43LYdcbbRDluLlLZ+p8mnUTqHBZWf3GLmHYJiYHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xii8Lhpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fhpyihbv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xii8Lhpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fhpyihbv"
Date: Mon, 10 Aug 2026 20:17:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786393064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtuxmT59eYsKlQFdOf/7/wnLH9vvS6r8fworg2bfyLo=;
	b=Xii8LhpzL/hsASgC3zlwt5BqtpI3F+T/n5uek0zibRhkBpuyIkkzucG3YQrjq1ICl3T+cy
	82DOK5Z1BWbKce8PfA0X1o+2c0f/L3TztjnSyLDs/6eD2HkWLDHC7b1CxXzO0EqoVj8LOi
	+ZZoGsIVBPfb6ktDgJS5R1wuJEuxVLF8NCjkbiVqn15bHPolukhlq/p9L7PWI0l9GyNMFw
	rtJoKuiNASeAlqm9yR727DJ6w6lOiKWbho6TcUsIM//XbSpsTBG5OVsaikoLoCZ56Idx2b
	UmCMB6Rnlr4gVDa2FRI37LZi6q3EbSUvNrChcjRzwgikXrngbUyHqsuQjLoYKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786393064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtuxmT59eYsKlQFdOf/7/wnLH9vvS6r8fworg2bfyLo=;
	b=FhpyihbvZHYxBgvQ7kYw5vg6APyB8QuuKsUuZXVRETuBDPXrjp39pVCJfIvnwVhnY27Hr8
	tRi3ll1igNWPJwDQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh_=28Schneider_Electric=29?=
 <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Check the return value of
 tk_get_aux_ts64 in __do_adjtimex()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260731-timekeeping-aux-adjtimex-return-v1-1-b7fea4692886@linutronix.de>
References:
 <20260731-timekeeping-aux-adjtimex-return-v1-1-b7fea4692886@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178639306244.442315.1016762624170879875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4b61084b11bcecce86d03804ff30f8d7b465593c
Gitweb:        https://git.kernel.org/tip/4b61084b11bcecce86d03804ff30f8d7b46=
5593c
Author:        Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weissschuh@=
linutronix.de>
AuthorDate:    Fri, 31 Jul 2026 16:17:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 10 Aug 2026 22:16:34 +02:00

timekeeping: Check the return value of tk_get_aux_ts64 in __do_adjtimex()

If the auxiliary clock is disabled during tk_get_aux_ts64() but is enabled
before tks->clock_valid is checked, then uninitialized stackdata will be
used in the calculations and indirectly leaked to userspace.

The same race window also exists after this change and also for the core
timekeeper. But in these cases the only effect would be incorrect
adjustments and this is userspace's responsibility to avoid this.

Fixes: 4eca49d0b621 ("timekeeping: Prepare do_adtimex() for auxiliary clocks")
Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weissschuh@=
linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260731-timekeeping-aux-adjtimex-return-v1-1-=
b7fea4692886@linutronix.de
---
 kernel/time/timekeeping.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c4230f4..c1863f2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3025,10 +3025,12 @@ static int __do_adjtimex(struct tk_data *tkd, struct =
__kernel_timex *txc,
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
=20
-	if (!aux_clock)
+	if (!aux_clock) {
 		ktime_get_real_ts64(&ts);
-	else
-		tk_get_aux_ts64(tkd->timekeeper.id, &ts);
+	} else {
+		if (!tk_get_aux_ts64(tkd->timekeeper.id, &ts))
+			return -ENODEV;
+	}
=20
 	add_device_randomness(&ts, sizeof(ts));
=20
