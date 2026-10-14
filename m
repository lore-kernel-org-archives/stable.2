Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA04A7CA7;
	Wed, 14 Oct 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009253; cv=none; b=cQa3j0h3Cx5P/UADTsHo4g2lGlKFkgNUGjKPCPrMcqjkOjZgs09bD3wu0nSwUN0Yz3Xva7jM85G1xfMbQM+eDvJvoxA+NBKwExb7gMhLrLnwcfqKKrTcDUur5fiHp4bH5Oe4bHTIQ/picr1Ix7mKgkZ6Zn9V3RUXzARIaXnAI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009253; c=relaxed/simple;
	bh=53QC68GwJ3a9/hATXBGN5XyTfXNG5x9+Q/jBsyR0X30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S1AHnBdfsZSezQ1duglHSr6EZ5xmFxYUUkGD7U0VnhCWT1uVQcW8B5ONfypCrxpylDNhOAem1uUhEnI6JZxsHHZ/v+prsvcUZTZ5YniJHa3YW0qhXtgzk8U+bAKj18CnNJldf5SZTqqfAxxXgKJM+2MX3he1xCtXmOoaO3iqsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dv/UNdZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PA/zpkiT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dv/UNdZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PA/zpkiT"
Date: Wed, 14 Oct 2026 20:20:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGGP0n7a8slTwrbovMtLz42bRtmA1/hLIXfXfat5LfU=;
	b=dv/UNdZi096KUn2X95WgdgKgOeAms/QR5FzfOBprH/eBP4AwkDs1K9GNbUtljQlw6zftAS
	E4p+DgSGd6SFdUu1FAuEberoErF6G2ltow1Twch6we66xawF8l50zM/Tg5w6qXSVCcsG8M
	ZL7sPVx+vim3h3OjRIcCRW/rsuIRzOStJS5gbcSrs8Ey9HWfsl1jVG6dEQ98hTQSl0Oe6G
	ychJkAAVwl+cvco1QN9TfkRgpwu6sVt+ezDGroh2obgDAEo8cdsoKLd+yfgjXrSxu+FUGk
	uH2423jqCPgUQKHorDNVzsjFLz0hibacFLbPCQ9QxW9VWNOPnrmDQ6/5JDfHMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGGP0n7a8slTwrbovMtLz42bRtmA1/hLIXfXfat5LfU=;
	b=PA/zpkiTAPCZgIcY7LrzNcXWRVSK3EBuv0GbVpjM0HiI1QkS4FZ72ONm/aV0rGL41C4+3G
	ntzi3IsCEQexxyBg==
From: "clocksource-bot for Wentao Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [clocksource: timers/drivers/next] clocksource/drivers/digicolor: Fix
 clk reference leak on request_irq failure
Cc: stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260915045242.1726702-1-vulab@iscas.ac.cn>
References: <20260915045242.1726702-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200924763.2666337.2325564574726063636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/drivers/next branch of c=
locksource:

Commit-ID:     9cc2e18b32f12d26ae6729c62a03640423956b17
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano=
/linux.git//9cc2e18b32f12d26ae6729c62a03640423956b17
Author:        Wentao Liang <vulab@iscas.ac.cn>
AuthorDate:    Tue, 15 Sep 2026 04:52:42=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 07 Oct 2026 15:46:01 +02:00

clocksource/drivers/digicolor: Fix clk reference leak on request_irq failure

digicolor_timer_init() obtains the timer clock with of_clk_get() and
enables it, but the request_irq() failure path returns without releasing
the clock reference, leaking both the enable/prepare state and the
reference itself.

Disable and put the clock before returning on the request_irq() failure
path. The success path keeps the clock enabled for the lifetime of the
timer and is left untouched.

Fixes: 9b8bb7736b78 ("clocksource: Driver for Conexant Digicolor SoC timer")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Link: https://patch.msgid.link/20260915045242.1726702-1-vulab@iscas.ac.cn
---
 drivers/clocksource/timer-digicolor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/time=
r-digicolor.c
index 559aa96..46e0c32 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -190,6 +190,8 @@ static int __init digicolor_timer_init(struct device_node=
 *node)
 			  &dc_timer_dev.ce);
 	if (ret) {
 		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
+		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return ret;
 	}
=20
