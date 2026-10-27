Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133091;
	b=gsTL0gpUy2NgLD/FON71HxcsgYNvfNLdmhbqoWZmt/qqNHW15V5p4J/OS8wFHp5CgSpp
	 7hLKyv/F/s+Gz202wFyLowqTBMsR4OGnE/LnflhH2DzZuOUfnDms6/nJjD6a0AUT+zSqw
	 D62uwg0Wu1vA80dCXWFnIplcjt4btC1VyTmKW4vvpSzYbMiZ8st/+r3MHHXhHW+wH/VsK
	 +6OVB8p4X1BxPD4KUpf+2lvFSSmUYurHs/KFFkI6ujlpgQxgJGZkNF1XSvwvw8bSmM7oN
	 SP01UW26nvN/B9lmO2O/SoH+MTnSNhra7Bxi44XTMnIELJoTf5QCy4up8YADJK90YlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133091;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=VDEZt5ibGbxG3J0BPRRb4cIOdGOwzx5h+ShD4KwdcYs=;
	b=BwAF5DJ/8p/yT+F/Kf/RqwVR83LOD4t4liWOrx9uQUI97LxvteT52nOvWwaHKG4gNaxJ
	 IFOCaPkXSBR/8JGbXSWRDsiw9qS8dBZ2IUIHqYKJ1RvqM8/DQWdBzCUwm5n1DFOzti2Ob
	 lT+j6EHIBav31x6AbyVwFvTQJ5qdJGIsCv7HAz+DomoTvoJC95jErFhQ6ydWtVI4DC0Fo
	 hKcnKSzy/ktipjh6UDnhmyRDC61zWsqCmyITooaR2DDzOFCFlhYpq38c17EDYmkRiNiSP
	 OeuryZWCyOdBhRDpskdzwa8KHLQ5p54d4HtV2qbFhkEavYtI14cPwhgOSdsnfPoZsog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g47uYGSg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ow+pQBuG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F7606A31E;
	Tue, 27 Oct 2026 20:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F40F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g47uYGSg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ow+pQBuG
Date: Tue, 27 Oct 2026 20:31:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793133088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDEZt5ibGbxG3J0BPRRb4cIOdGOwzx5h+ShD4KwdcYs=;
	b=g47uYGSgWJ/rTTKaIfT28oE2RTfEKoOkT+Hiuf0QtlyUFXg/lYyv8XgrdZQY1gl8GpCQdZ
	Hh9EqyteseBwBnH8LRmP5Eou1KqGNT4ah9S7CQUiiqFNYLRCaWBnJHJrQy5zQeNQVjd/vU
	T88hE16hHW2vIoSJTUgFBa5G9W31wjw+kZt0qeDVKZIg7rk+XmQpq1Be7zytcamS8JFn0E
	ic+hoAH2G8J14DeyXusyFLEn269f++szcxEgyFBHJDRrnc9QIshq3vr3vut4KuzYa1cmvU
	wHawZq/SLVtX5dMooIcoBVtUujwGXS/2kgMNwB4vha9bhKemI4tj20A9BFm0XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793133088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDEZt5ibGbxG3J0BPRRb4cIOdGOwzx5h+ShD4KwdcYs=;
	b=Ow+pQBuGkhblMCjJHrqRKYimLX8NrN9D1pSfS6wspEnZPEwvUDBZI3eg6XAJqIyZzdXZ9k
	eeQhxendSUCe2CCw==
From: "tip-bot2 for Karl Mehltretter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Prevent immediate watchdog rerun
 after a delay
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261026010200.96371-1-kmehltretter@gmail.com>
References: <20261026010200.96371-1-kmehltretter@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179313308657.4109677.15373257069009991265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f322d7f7ae56bce728ba03a387e35380bc4ad939
Gitweb:        https://git.kernel.org/tip/f322d7f7ae56bce728ba03a387e35380bc4=
ad939
Author:        Karl Mehltretter <kmehltretter@gmail.com>
AuthorDate:    Mon, 26 Oct 2026 02:02:00 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 27 Oct 2026 21:26:16 +01:00

clocksource: Prevent immediate watchdog rerun after a delay

The watchdog rewrite made the clocksource check handle long intervals
between two measurements, but missed that the timer expiry needs to be
rebased after such a delay.

When a watchdog invocation is delayed by more than one interval, adding
WATCHDOG_INTERVAL to the previous expiry leaves the timer expiry in the
past. That causes an immediate second invocation. The resulting short
measurement interval can mark a clocksource unstable.

Cure this by rearming the timer based on jiffies, which places the next
expiry one full watchdog interval into the future.

Fixes: 763aacf86f1b ("clocksource: Rewrite watchdog code completely")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261026010200.96371-1-kmehltretter@gmail.com
Closes: https://lore.kernel.org/r/20261010065509.72916-1-kmehltretter@gmail.c=
om/
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f1253f5..58c0ca1 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -673,7 +673,7 @@ static void clocksource_watchdog(struct timer_list *unuse=
d)
=20
 	/* Could have been rearmed by a stop/start cycle */
 	if (!timer_pending(&watchdog_timer)) {
-		watchdog_timer.expires +=3D WATCHDOG_INTERVAL;
+		watchdog_timer.expires =3D jiffies + WATCHDOG_INTERVAL;
 		add_timer_local(&watchdog_timer);
 	}
 }
