Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2925477E;
	Mon, 17 Aug 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955877; cv=none; b=SYimp1RZKe4KzzA/rZ106V2nr6Irr3+G9SmziFZdb6nCXCJQpVruEqkFZ634pD6kB2g//anaFohBSZG4Q148SGtsXruQLf1dXByVs65wo8ZvLNsxVK7QpkN7b4Ah92IiAhsAzis9+f9YetVkK2zS+Y8pEppA/SLTyK3vJv6elL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955877; c=relaxed/simple;
	bh=L53zf0HmXpiDcFUI7eDfC9PZVws6kOswVm8xaMYmS1g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m3Ro5ZwPcrGMataFb77cBRHuIjDN8oe/FZh6bI5Am6QhUB4fJoYUGW5SIYKXpQ2TaCk11KoWJmdguWWz6m8h2XvLwg6P8O8RYw6v8XnXnfgb4iQB6gvunC/uefeG7qYmUAuHav+T8jIvUZO/lW/6nFSFHoY1CQSwRSBs+cjWKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGfCVuIb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8dKo8S2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGfCVuIb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8dKo8S2"
Date: Mon, 17 Aug 2026 08:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786955874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVsT+0N/QEbqs3P0nbmz2Oc+qrPbenrvgqNkuhFfthg=;
	b=tGfCVuIbx7fXX+leEvXUyZWhfbdyyiBbG6+PJkB7g0wZbloF2b3vooEL0CWec8oQaH9wW9
	8hVL/kVmpcVRb1gszp0XtM0uphCE1S5U0VpHqhjY7ReiOjWh8k35rjRF6UR698+Vf2Pq1J
	vqRAjINAXTs2rBVoGCDZBBsoKoReQazYhmYujUCJx8TahQFHqAXYsLuj02YFTLnwpBquoE
	Ex0EDgi/hL8c2ilfR1f0PuDjEO1tGwlnikn0cIVZUwXjapPfTbYaTILL9av8YICVVVufsC
	O67+S6zMdwHlmz2S/OYUzDC9O4m2YN9dOJ9KixgOlzHtI4QFUVl0Pfqd4ZyHOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786955874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVsT+0N/QEbqs3P0nbmz2Oc+qrPbenrvgqNkuhFfthg=;
	b=v8dKo8S2CFYHVEd547vkpwFM/i0kug5xXMJKHpp+tQGP/U64fkU453q/dELzfXHXD7UnDU
	I4ysjyfZaMBj7UCA==
From: "tip-bot2 for WenTao Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/nxp-pit: Fix IRQ leak
 on cpuhp_setup_state error path
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 WenTao Liang <vulab@iscas.ac.cn>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260628130700.45680-1-vulab@iscas.ac.cn>
References: <20260628130700.45680-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178695587251.1542179.70229304547225165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     05520e035f8332c8e33f3011b5ca016fde61793d
Gitweb:        https://git.kernel.org/tip/05520e035f8332c8e33f3011b5ca016fde6=
1793d
Author:        WenTao Liang <vulab@iscas.ac.cn>
AuthorDate:    Sun, 28 Jun 2026 21:07:00 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 13 Aug 2026 18:13:01 +02:00

clocksource/drivers/nxp-pit: Fix IRQ leak on cpuhp_setup_state error path

When cpuhp_setup_state fails after pit_clockevent_per_cpu_init has
successfully called request_irq, the error handling jumps directly to
out_pit_clocksource_unregister without freeing the registered IRQ.

This leaks the IRQ line and, since kfree(pit) follows, leaves a
dangling pointer registered as the interrupt handler's dev_id,
potentially leading to a use-after-free if the IRQ fires afterwards.

Fix it by calling pit_clockevent_per_cpu_exit to properly release the
IRQ before falling through to the existing cleanup chain.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 /=
 s32g3 support")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260628130700.45680-1-vulab@iscas.ac.cn
---
 drivers/clocksource/timer-nxp-pit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-=
nxp-pit.c
index bc5157e..2f70d1d 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -328,8 +328,10 @@ static int pit_timer_init(struct device_node *np)
 	if (pit_instances =3D=3D max_pit_instances) {
 		ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
 					pit_clockevent_starting_cpu, NULL);
-		if (ret < 0)
+		if (ret < 0) {
+			pit_clockevent_per_cpu_exit(pit, pit_instances);
 			goto out_pit_clocksource_unregister;
+		}
 	}
=20
 	return 0;
