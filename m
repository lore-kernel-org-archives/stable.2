Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785163;
	b=idU836mH7qdtF1cd9JI2hI8jLYVHHiLf47QNM1ubAuJAieJGfpiQbuembqJsAVCa0v+O
	 8dCsz9xAkIUCVj2lqIdZyFlrMJJN/HKFm6IanfJFEdcDIzCI6y3s/FQaFmUrZaHtvr61h
	 2Pxorw+BqhIYwRBCMaioK/4tmPBGRzx9sOojwXZjbgHbLrWVy0elTypPzXsgoqNtWqQLS
	 pEGHZkVYtHJU8CDs6sr+haq3s49vA3rWDm8lxAZ3Ktnmc4LWxUBFQz55hXSsslgPKlsqM
	 TZ3IN0u98aQHweVLGG4LjhmhxozaUlbzXzYbbKLXsPJ7VQ825GyVYkShrzaKOJpFQ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785163;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=z4unnz/GEVivP7Yv7tJW1au4CPpTLZscR+Qb1Qq0HqY=;
	b=Z2gI8tLzMN4sJRjj3rztfLRlhvkkJhKTnhfid25k8vfG9ZHS0HqqjP5dIvVCnykVPIp4
	 stIMIC9RBor6WsLqZx8IDfWS14MZ8ImwYypYpnkp3Nd2TK1osuwPRYWEJO1/OwyjjSakt
	 60Pp9NEDhBBlv2BpgKkse1PgRInfpjVn9CMByJfjpLCeD7ykgl+pQUSI/4iXnYKgflShC
	 jW83ZRqgVPafxhg9XFteAf0Y+X9gGN3GOru9yHig4ItndDxMQCGLirdYt7hFMZTurCUxJ
	 DwgwE8TUZnpUZ6J3XA3dDYAe8lnN2vu3gVjnC/PWa3VhpRwnIOJ5Kssv2il9XBghBxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lUezmFnj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wNj1Bfsr;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB18606A31D;
	Fri, 23 Oct 2026 19:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB18606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=lUezmFnj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wNj1Bfsr
Date: Fri, 23 Oct 2026 19:52:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792785161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4unnz/GEVivP7Yv7tJW1au4CPpTLZscR+Qb1Qq0HqY=;
	b=lUezmFnjyNwFk5IcbYgVnp4Y/v1vb6q1Tkeolva+ItDl+Eki2cWujtb+0Q2PilwbziW4dT
	dwUE75258IyxYZEuc0cs6Bb2ElXGWHOgd1VQMo/pfji1iDLF7y+GwPHY/7pDT0ZueSrHLc
	rUk82LodXhPJULG1cAMCQITJh0LmpQ+CxC1l5bAtQm7HSfPCXAkKZ8COQF4vAV4sPXVYXl
	PB1XCPJ/0yDclk4BTO0fBA7Au7i+p9IWksxWAa/iStyLUhEeIFA7NkOE41graw+lWOrdTP
	cA5D8h6AiFEy7VvQu/YrcicggTPxMT8SIdvBNN6LKW75V9j+0cl5Pl2iVOcwkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792785161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4unnz/GEVivP7Yv7tJW1au4CPpTLZscR+Qb1Qq0HqY=;
	b=wNj1BfsrIKU+HfETtXRPlE44zOmqfuHSOzJCNpwFheFIeJBxCWx7uNudXWaChaQkqrf/Tu
	Ss8fveRdgxs7saDw==
From: "tip-bot2 for Daehyeon Ko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timekeeping: Require permission to set auxiliary clocks
Cc: Daehyeon Ko <4ncienth@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 shaos <shawnq1@163.com>, John Stultz <jstultz@google.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261019080324.4147815-1-4ncienth@gmail.com>
References: <20261019080324.4147815-1-4ncienth@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179278515898.3012171.8502728157439269868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     524d95c8a2000cba6cb80a173d76cb746c561244
Gitweb:        https://git.kernel.org/tip/524d95c8a2000cba6cb80a173d76cb746c5=
61244
Author:        Daehyeon Ko <4ncienth@gmail.com>
AuthorDate:    Mon, 19 Oct 2026 17:03:24 +09:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 23 Oct 2026 21:49:57 +02:00

timekeeping: Require permission to set auxiliary clocks

The generic clock_settime() entry point delegates permission checks to
each clock-specific callback. aux_clock_set() does not perform one. Once
an administrator enables an auxiliary clock, any local process can
therefore change the global clock offset.

A test process running as UID and GID 65534 with no effective, permitted,
inheritable, or ambient capabilities set CLOCK_AUX0 successfully, and a
separate process observed the new value. The same process was denied by
clock_adjtime(). An AppArmor profile denying sys_time also blocked
CLOCK_REALTIME changes but did not see the auxiliary clock operation.

Call security_settime64() before mutating the auxiliary timekeeper. This
matches CLOCK_REALTIME's permission model, enforces initial-user-namespace
CAP_SYS_TIME, and gives LSMs the settime hook while preserving authorized
clock changes.

Fixes: 60ecc26ec5af ("timekeeping: Provide time setter for auxiliary clocks")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: shaos <shawnq1@163.com>
Acked-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019080324.4147815-1-4ncienth@gmail.com
---
 kernel/time/timekeeping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ea2e6e5..1b34282 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/loadavg.h>
+#include <linux/security.h>
 #include <linux/static_key.h>
 #include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
@@ -3215,11 +3216,15 @@ static int aux_clock_set(const clockid_t id, const st=
ruct timespec64 *tnew)
 	struct tk_data *aux_tkd =3D aux_get_tk_data(id);
 	struct timekeeper *aux_tks;
 	ktime_t tnow, nsecs;
+	int ret;
=20
 	if (!timespec64_valid_settod(tnew))
 		return -EINVAL;
 	if (!aux_tkd)
 		return -ENODEV;
+	ret =3D security_settime64(tnew, NULL);
+	if (ret)
+		return ret;
=20
 	aux_tks =3D &aux_tkd->shadow_timekeeper;
=20
