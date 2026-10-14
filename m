Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F964AD4AA;
	Wed, 14 Oct 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009253; cv=none; b=Ain+ocRm6xO9p4M5YJHTXi/54lkSgqYB94xZXD0punlzvuepz8H/Iq5aHnl+iQqhdsF5pPS5MVN/+QkEOqiohINQIC4QuUuNm5dFLZ98fmwF5IHBRi3CWdo3sE0AU2MXoqJc3D9Qejj9p56ZU2ZDRuAgtuqoL0eo/fsjWgINt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009253; c=relaxed/simple;
	bh=Sf0lWg/ZDgYVsD+qqHr+05bfinmhw+qJfx5qIlKJqnE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k/SdESjSWHcCfWgl1mp4vMly8DfCsbf7o8bUp0i8/3POeWa+6f2K0I5/axU0oubKqU1WWHlN9u/ytiNrI/uUbli+lW6VcGta1DgzZ8NtvP6URI4Y3qBps505YnmiwXPm4XXt299mOg+5o68NEe0elGsa3AL1fnR7sSQoED218YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJ2Gsj8p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ax++YXKN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJ2Gsj8p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ax++YXKN"
Date: Wed, 14 Oct 2026 20:20:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVa0ieKg6mJbweUhQ39c1wP7se/Auojbv30ijTdRFf4=;
	b=DJ2Gsj8pd8OBBf16vETCTQPcVBFGMiO4eSOOKQ86XtAENWo+nktam42C31f1TImX2yd7Wj
	HV42iSH3WelTKYOik8JRlyc8kW96GKxPDT7/HBYC96EV2iPnqzRrdKp37YXb7H4s8c33QY
	Ffh8AU5H2IPpEWtV79sN621JCcNexgu7eT1SH/V0TDkvDx5Dm5szESmmDK+DP9o73K6A/2
	AmeCATZcA+85cqXk132Kz+9A7n0hl0ZFpqUTY2YRcWyCxpPxuTt05Y1oj6wXFz4rTpm+aQ
	851NHg2L54Wf1vNLM1YGEvg7gBveQxMEXTRWovVrzgg4CRhg4RECpS7xp47jZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVa0ieKg6mJbweUhQ39c1wP7se/Auojbv30ijTdRFf4=;
	b=Ax++YXKNP9hH2bPh0l6+yhcfWuD59KDs61C2V0f8BWGfVEGeTBkLwpz4oU3UmR2T58Drrb
	a2QlyBkmQT81aMBQ==
From: "clocksource-bot for Wentao Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [clocksource: timers/drivers/next] clocksource/drivers/fttmr010: Fix
 clk reference leak in error paths
Cc: stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Linus Walleij <linusw@kernel.org>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260915045426.1726805-1-vulab@iscas.ac.cn>
References: <20260915045426.1726805-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200924901.2666337.6613074103224330022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/drivers/next branch of c=
locksource:

Commit-ID:     277e5657237a92e279ee28da2f5c07902cc6aa0b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano=
/linux.git//277e5657237a92e279ee28da2f5c07902cc6aa0b
Author:        Wentao Liang <vulab@iscas.ac.cn>
AuthorDate:    Tue, 15 Sep 2026 04:54:26=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 07 Oct 2026 15:44:05 +02:00

clocksource/drivers/fttmr010: Fix clk reference leak in error paths

fttmr010_common_init() obtains the PCLK reference with
of_clk_get_by_name() but never calls clk_put(). If clk_prepare_enable()
fails the reference is leaked directly, and every error path that jumps
to out_disable_clock only calls clk_disable_unprepare(), which releases
the prepare/enable state but not the reference obtained from
of_clk_get_by_name().

Add clk_put() to the clk_prepare_enable() failure path and to the
out_disable_clock label so the clock reference is no longer leaked. The
success path keeps PCLK enabled for the lifetime of the timer and is
left untouched.

Fixes: dd98442e17a6 ("clocksource/drivers/fttmr010: Drop Gemini specifics")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260915045426.1726805-1-vulab@iscas.ac.cn
---
 drivers/clocksource/timer-fttmr010.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer=
-fttmr010.c
index 308f94b..c255385 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -292,6 +292,7 @@ static int __init fttmr010_common_init(struct device_node=
 *np,
 	ret =3D clk_prepare_enable(clk);
 	if (ret) {
 		pr_err("failed to enable PCLK\n");
+		clk_put(clk);
 		return ret;
 	}
=20
@@ -432,6 +433,7 @@ out_free:
 	kfree(fttmr010);
 out_disable_clock:
 	clk_disable_unprepare(clk);
+	clk_put(clk);
=20
 	return ret;
 }
