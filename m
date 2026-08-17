Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C93C3429;
	Mon, 17 Aug 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955878; cv=none; b=MnEtGvm35POW6EpZRBRylUIWRVroLbXrGicUtHoUMUwG59SIZkUYGo9ZQl0ixVCtFu9rtuNZtoZcBYlFkheFRvVpWZxRI1IB4uo7H4s03PjY33yCJtHr76vamiq7HjFNZDb8SI+KOK9CnYxo17ePjFo0sIZPQpyfRSpWRfz7DoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955878; c=relaxed/simple;
	bh=6+THv/VN/Y+n9BVIKhbN/v4vhN7xpQ+o1F8CVld/c/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KfpSMzPdn1+Sxz2UKiQ70B8O+S9TfRPGWTJvW228p5wxpKHEnFpe6V4+h9HvyW42/oYjIOj5HrOeh8F/jMQ136YskX0CBtMPUB/IVCmZbioI3HxuKMYj0ffnqX1tBL5wventL5i9LpvTxITg/Wwcjc5lWmLTOJCeB6BQqq9t8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeuldaVS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTfMORlb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeuldaVS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTfMORlb"
Date: Mon, 17 Aug 2026 08:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786955875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqpeupT4hhBpNxpSIddBxKc75rO+7F5W1JfhyL/OP4g=;
	b=VeuldaVS2xK41DqdyOiqoV63AuwEw+HkKZSaD0V5gjwLcgO3HAwPi9lwjfhEyCFo81GTRt
	ovHUPTAoYPI1RIH3BcbhM7czASC/bF8CMqTV+LeUX7CmVI+Eb16uXXOTzu4n/h9HusLKZV
	eVvyMBYbEfN19OTdCKbMY0fKgkhHNbO8fK76OrXzwHicyjIreZRphSFqHsuoL687jb/F1L
	67DW968cLhco73bHIW5uYQUquEmEPSwH9bZlZS35EakT8Ce0OKQ9lWUkXQLDbFW3afS15r
	nLbHk5G+lcf9KhtQcNdV0Siu9njJwjrYwSkhkfke2eOMAYkcE+8xtR/1OdAjZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786955875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqpeupT4hhBpNxpSIddBxKc75rO+7F5W1JfhyL/OP4g=;
	b=TTfMORlb8cQhXbY/lSGoiKF9qmLbMvh/T6e0mhZcMwI6KMg/CoQXbmwZc0cq6FP+DLBau7
	hdcjwGOCbCqGPLCA==
From: "tip-bot2 for Felix Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-sun4i: Advertise
 a real minimum delta
Cc: Indrek Kruusa <indrek.kruusa@gmail.com>,
 Felix Yan <felixonmars@archlinux.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260624220434.4183732-1-felixonmars@archlinux.org>
References: <20260624220434.4183732-1-felixonmars@archlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178695587398.1542179.16026420239437792986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d21808328225ab8cee46885bf9a0dffcefbe630e
Gitweb:        https://git.kernel.org/tip/d21808328225ab8cee46885bf9a0dffcefb=
e630e
Author:        Felix Yan <felixonmars@archlinux.org>
AuthorDate:    Thu, 25 Jun 2026 06:04:34 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 13 Aug 2026 18:13:01 +02:00

clocksource/drivers/timer-sun4i: Advertise a real minimum delta

sun4i_clkevt_next_event() compensates for the timer stop/start
synchronization delay by programming evt - TIMER_SYNC_TICKS into the
hardware interval register. The clockevent device currently advertises
TIMER_SYNC_TICKS as min_delta_ticks, so the clockevents core is allowed
to call set_next_event() with evt =3D=3D TIMER_SYNC_TICKS.

That programs a zero-tick interval. With oneshot/highres/nohz timer
operation this can leave the next event stuck, which was observed as a
boot hang on Allwinner D1 after the clockevents core started reusing
forced minimum-delta events.

Advertise one extra tick instead, so the smallest event accepted by the
core still programs at least one hardware tick after the synchronization
compensation.

Fixes: 12e1480bcb49 ("clocksource: sun4i: Report the minimum tick that we can=
 program")
Reported-by: Indrek Kruusa <indrek.kruusa@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5N=
J_5sLq2AYL6zER2c0A@mail.gmail.com/
Assisted-by: Codex:gpt-5.5
Signed-off-by: Felix Yan <felixonmars@archlinux.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Tested-by: Indrek Kruusa <indrek.kruusa@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-riscv/CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_=
5sLq2AYL6zER2c0A@mail.gmail.com/
Link: https://patch.msgid.link/20260624220434.4183732-1-felixonmars@archlinux=
.org
---
 drivers/clocksource/timer-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-su=
n4i.c
index 7bdcc60..c2d04ab 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -208,7 +208,7 @@ static int __init sun4i_timer_init(struct device_node *no=
de)
 	sun4i_timer_clear_interrupt(timer_of_base(&to));
=20
 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
-					TIMER_SYNC_TICKS, 0xffffffff);
+					TIMER_SYNC_TICKS + 1, 0xffffffff);
=20
 	/* Enable timer0 interrupt */
 	val =3D readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
