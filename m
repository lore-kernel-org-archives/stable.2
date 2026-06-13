Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60832395DBE;
	Sat, 13 Jun 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781357299; cv=none; b=IqJuH857yKwALuWOEn1KLwEYTb9Hs19HenFH45gG5z4lmtMdqoLJ9l0eIhRvj+Ts7+7A9+IURzJJz2Z/Dqj0OgVMLOxFxkbvKI5LJU1nZkEShQ8S/mjH8Jfvo0OvEpEE6ABwOj9a2j62/nbGFU1BfmaF1w3pYOW5KpjHtbCSE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781357299; c=relaxed/simple;
	bh=CKTHH5Mp6NvMFsWldJLzACQKE5NFf7C1eJRWQoNmNh8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gR0rDxdRwBKclz93UYdTaclJF+uZ+AGelxakg+kIyylDxwCyVLbt7e5jNn/RhcJr5ZPn4RLnTXoLVya3jKyru+/XosaxE2PFQvt7eMCHYQdeMhNwvjqtnFBKHObFhlSLeIVHgedCIxE4X00nS4fuKOB46IyHztKvTNZQ4JBJr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUYqSj8j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2HZBvoQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUYqSj8j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2HZBvoQ"
Date: Sat, 13 Jun 2026 13:28:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781357289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLcgbT6Uni33uuc0Zz/yUQsXs+rFXi+dNX3MAZxpu5w=;
	b=jUYqSj8j36TYg/ZKJrjqj2TwdIhJY9XEsgJnW2Eb/EzTmwvPndQLXCk4fDnzkjGzKOlKaB
	UdXGLb6DuaQ9qBd4IAktplvu5+Gs3tH8pbEQFsWGAQ5x+cJIZsFaD/vlJmNJfsn2axiS4W
	D5J84XfPHTfMT7aqqixroZSLzdyNoyl860kIoHnRQaDljcwpH0Ob148DuVdzIwfViaRVJ1
	mVrTHTxCte2Xlk9IuYi2iTHu/In12YOe2lVI4tr6GFuj4a33+Pgn3CZvr4khkhDe1p7SQQ
	TLv3k6hBXFKHl7FwaH+OrEJsLTQkiLTUkCWpKM+1z8lhICTbKfXv/fSuxH5wyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781357289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLcgbT6Uni33uuc0Zz/yUQsXs+rFXi+dNX3MAZxpu5w=;
	b=B2HZBvoQaeDe/b2AyXeHUl/e9DKB5y/WepOgeC8TbpS1ApKYjoIpaHCDgUG04hZWwOSuVv
	UB7dHerUegl1ulDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] time/jiffies: Register jiffies clocksource before usage
Cc: Teddy Astie <teddy.astie@vates.tech>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87y0gn3fve.ffs@fw13>
References: <87y0gn3fve.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f24df84cbe05e4471c04ac4b921fc0340bbc7752
Gitweb:        https://git.kernel.org/tip/f24df84cbe05e4471c04ac4b921fc0340bb=
c7752
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 09 Jun 2026 17:14:45 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 13 Jun 2026 15:22:40 +02:00

time/jiffies: Register jiffies clocksource before usage

Teddy reported that a XEN HVM has a long boot delay, which was bisected to
the recent enhancements to the negative motion detection. It turned out
that the jiffies clocksource is used in early boot before it is registered,
which leaves the max_delta_raw field at zero. That causes the read out to
be clamped to the max delta of 0, which means time is not making progress.

Cure it by ensuring that it is initialized before its first usage in
timekeeping_init().

Fixes: 76031d9536a0 ("clocksource: Make negative motion detection more robust=
")
Reported-by: Teddy Astie <teddy.astie@vates.tech>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Teddy Astie <teddy.astie@vates.tech>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87y0gn3fve.ffs@fw13
Closes: https://lore.kernel.org/all/1780914594.8631fc262581453bbf619ec5b20621=
70.19ea6c8227b000701b@vates.tech
---
 kernel/time/jiffies.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 1c954f3..d514288 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -60,15 +60,14 @@ EXPORT_SYMBOL(get_jiffies_64);
=20
 EXPORT_SYMBOL(jiffies);
=20
-static int __init init_jiffies_clocksource(void)
-{
-	return __clocksource_register(&clocksource_jiffies);
-}
-
-core_initcall(init_jiffies_clocksource);
+static bool cs_jiffies_registered __initdata;
=20
 struct clocksource * __init __weak clocksource_default_clock(void)
 {
+	if (!cs_jiffies_registered) {
+		__clocksource_register(&clocksource_jiffies);
+		cs_jiffies_registered =3D true;
+	}
 	return &clocksource_jiffies;
 }
=20
