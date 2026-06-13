Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF861CD1E4;
	Sat, 13 Jun 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781360529; cv=none; b=PA3OKOzj8LccfjqLWahpBQGT2LNdkniZi84QWUjV2FAqD+rl4zNthn0FcJlaTiL/+J1eVfP/mY/6ONME++on3hh6E7FLvhkb44X1O31Fwu2fsjXEY4K/dMXQQxf+DnstTfuotTMqPsmmRY7W0gElBELV+Yw3Gn4Lq2EvNLKCP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781360529; c=relaxed/simple;
	bh=S7LHjHt+zo+uuJMVwpgGBHY1ELTmNDL57UaA+eyJR6w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fii7Ra/mILDiJ/zTcveXXN++h4xip9ybtNM8uIxHp+d8tN4b+iaAPVju4Xpn7xoHh+a13bC7EzZREoJancspdDqvpMyU32aAia5fJqMhm/ImCWi1nKwR9yI3DB8O1+36tt6ap4A14iukuqXqhDiVdJjFaMLwxcBjpnOzM4v5qYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3yt9CNaj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kzkU0A6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3yt9CNaj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kzkU0A6"
Date: Sat, 13 Jun 2026 14:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781360527;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3BVhr/oA2GlDTl39spwNyqDroESQnp6fqTWR8h6hag=;
	b=3yt9CNaj+YQZ8k0A53rcB/FdQE3G38gfxffh6txgyEHPJMKfZIAqq1rwZ719552GygDjhI
	SrUb8nRZUrSDWugwoYcm7Ahvw84GhgsXK+iaMU9t47iWaNRvo7yybGzUt0IspTEeYHu+6h
	aqjGRVtdmFZzeJPyLaMQ/sOaXz7cs23hbZyP/rwO8FmkvTkJmjC3XXQl8pXHzYlzqg8jK1
	eYC6/Nzr0rnd1q8h8A/4jly82uDEdTp10bckRon3aWtAu0DhAXJvUgx04r0976uTjEymd3
	EPZVDO3UgxQyewSQt3FFe/GBMotAnaWba9HC3WvRLmtOC0MbPMS9VFBo7Ymajg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781360527;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3BVhr/oA2GlDTl39spwNyqDroESQnp6fqTWR8h6hag=;
	b=2kzkU0A6kb4CiVO0kFqCP4VLCOoS0QX4McbE14bWe+Qa1EAFCo1LhcUW0zC0wiNLjev3P5
	bZnpIdFDlGGoaFDA==
From: "tip-bot2 for WenTao Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Fix pid refcount leak in
 do_cpu_nanosleep() error path
Cc: WenTao Liang <vulab@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260611161738.97043-1-vulab@iscas.ac.cn>
References: <20260611161738.97043-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178136052544.1650852.10838221436932008078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     87bd2ad568e15b90d5f7d4bcd70342d05dad649c
Gitweb:        https://git.kernel.org/tip/87bd2ad568e15b90d5f7d4bcd70342d05da=
d649c
Author:        WenTao Liang <vulab@iscas.ac.cn>
AuthorDate:    Fri, 12 Jun 2026 00:17:38 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 13 Jun 2026 16:16:02 +02:00

posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() error path

In do_cpu_nanosleep(), posix_cpu_timer_create() takes a pid reference
via get_pid() and stores it in timer.it.cpu.pid. If the subsequent
posix_cpu_timer_set() call fails, the function returns immediately
without calling posix_cpu_timer_del() to release the pid reference,
causing a leak.

Fix it by calling posix_cpu_timer_del() before the unlock-and-return
on the error path, consistent with the other exit paths in the same
function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260611161738.97043-1-vulab@iscas.ac.cn
---
 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 395e297..74775b9 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1506,6 +1506,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock=
, int flags,
 		spin_lock_irq(&timer.it_lock);
 		error =3D posix_cpu_timer_set(&timer, flags, &it, NULL);
 		if (error) {
+			posix_cpu_timer_del(&timer);
 			spin_unlock_irq(&timer.it_lock);
 			return error;
 		}
