Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF23F7894;
	Wed, 17 Jun 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708257; cv=none; b=lE6YopvKEdAWD1s/TZqEa+DOd4fDB5lQYP0UAPGSllQSj75moFN+5sYEdGu2k91gDFV7T/k0Nxb0+SeYE5TgPeNmeabi5DoKIiPztgi0vg4aSx2OfM2UDWSBjbIQOSYit6kx6RKNMAhbSZJGbEc+Rtos34glyCt6FYv5O6SQzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708257; c=relaxed/simple;
	bh=fv5dOpAW67iqFL47fR3xXEWbHsq/577+lwYFzZwcF7E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tUNgir54rP+1lRlZHmUvldXeWz+NxI6QCowTxKkfgnJHGrjtC/Ub+PFuthWliK/f3JjEOXCp8QqjpyheEEtkKhY+ZkDzSx9/VvjaPngFfuzIA7S87gVPlVNXSXGDi/Kfeiq/QmZDZdOqCQr7naI1Utv3+BNSDmM6FDB/1BWVbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XG9foDWC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTB01KKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XG9foDWC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTB01KKP"
Date: Wed, 17 Jun 2026 14:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781708254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iPwSubwqAnX7nq9Sydj/EIPAB2STY7iQ/nSSMZXc58=;
	b=XG9foDWCp+kuxeecjmYnL3n2hq7tIL1uPGG4H2aNnvSktyhFOYYj2WLGuG+0idcsrT2ZXB
	bXWCOyF6QgLgIzteUhToGP0AKfqAlkV2VRy/HIScd9LZOJUzCsr70PYBoJBaVxdr+Vbphl
	OvCj10GTZzFbjXiZODD+ebfxnOicnB0nXQ8W4TRU65aUsLVc0yRdpfyLtFm8C+jbMX7R3F
	5jE2oYsc9QQpacBbFDEaI8k/MgsrbU6BS9SSEvNegig9MwZ2dFACCvJL00c8s6Qu2e4naB
	3vrfPet6s+t1aR16sL/xY+R43OSY2Uj5B1q7Qaqvstvj7vEWHQvzn6uNepzSlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781708254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iPwSubwqAnX7nq9Sydj/EIPAB2STY7iQ/nSSMZXc58=;
	b=fTB01KKPwBHVG3+SyOfI6IHtPR6vxlFvrGrF7qWXuzUeClDbJEwuM7eShw5fzhaiCiS+nH
	vw3uOZgWir7ACXCQ==
From: "tip-bot2 for Mikhail Gavrilov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Register default clocksource before
 taking tk_core.lock
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Breno Leitao <leitao@debian.org>,
 Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com>
References: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178170825255.1650852.6401156316192794514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     8fa30821180a9a19e78e9f4df1c0ba710252801e
Gitweb:        https://git.kernel.org/tip/8fa30821180a9a19e78e9f4df1c0ba71025=
2801e
Author:        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
AuthorDate:    Tue, 16 Jun 2026 12:09:14 +05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 17 Jun 2026 16:55:26 +02:00

timekeeping: Register default clocksource before taking tk_core.lock

Commit f24df84cbe05 ("time/jiffies: Register jiffies clocksource before
usage") moved the jiffies clocksource registration into
clocksource_default_clock(), so that it is registered lazily on the first
call. __clocksource_register() acquires clocksource_mutex, but the first
caller is timekeeping_init(), which invokes clocksource_default_clock()
while holding tk_core.lock, a raw spinlock.

Acquiring a sleeping mutex while holding a raw spinlock is invalid.

The default clocksource only has to be registered before
tk_setup_internals() consumes its mult/shift/maxadj. Neither
clocksource_default_clock(), the ->enable() callback, nor the registration
itself need tk_core.lock, so fetch and enable the clock before acquiring
the lock. This preserves the "register before usage" ordering while
keeping clocksource_mutex out of the raw spinlock section.

clocksource_default_clock() has a second caller,
clocksource_done_booting(), which invokes it with clocksource_mutex already
held. That path avoids a recursive lock because timekeeping_init() has
already run and set cs_jiffies_registered, so the registration is skipped
there. This change does not alter that; it only fixes the invalid wait
context in timekeeping_init().

Fixes: f24df84cbe05 ("time/jiffies: Register jiffies clocksource before usage=
")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260616070914.65818-1-mikhail.v.gavrilov@gmai=
l.com
---
 kernel/time/timekeeping.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0d5b67f..b1b5ec4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2061,13 +2061,14 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono =3D timespec64_sub(boot_offset, wall_time);
=20
+	clock =3D clocksource_default_clock();
+	if (clock->enable)
+		clock->enable(clock);
+
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
=20
 	ntp_init();
=20
-	clock =3D clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
 	tk_setup_internals(tks, clock);
=20
 	tk_set_xtime(tks, &wall_time);
