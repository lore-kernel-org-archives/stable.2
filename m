Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252029;
	b=U9uKz5g3SNJC+Iy16NJ/Vzl6gqfc1yXLSLPKjCNkVRlspdQyzM0ihZacQ5tNxdv3/u2T
	 nRYJh2vtOm60x60JY4B+faS+cl5icrnNiu7zaTxeVftYEsqLIcjpUny3XW8dLn7eNxp0r
	 bvOvLsXmNJIOrsgvGgyPXnbhTRQGuZR+U3MzHNivRU21zQ9FfCtGerWPBDSXh9dZ8BrJ3
	 tPzKKT7TUYdoDKXgLFb8mMH1/yEMRghAahJ+sSmNs+j82yINhFfCaldHyYgktJRvTeN9z
	 Ct0Pzrni2UE/M5F5rIgom0fgBgCnVGqMeVUq/Ga8jl41f78ejO4PDWpBR01yRvb3Gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252029;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=8KWnbpW8U8aRa3MplkVaafabfv3H+gZ1D7AlDgbRTrE=;
	b=sXoz1XtK8YRYAs8+Zgzr7iuBIVS4ESKjUh+vjEw9vF2TD43zVZQskO8HfbH5vEy88HRO
	 AVUlR/r/2u3wSBIQKwUCxREwTDu7bXuELBAx/yXY70thqGhgNmQCmqgr/13GygUVR2wmG
	 h2hGXDbVfSCT3nwnWAe6V7PgtmOO0qNqtaAvjgNKc1Cb5GoZjAvZ9NRPXtwWOATCOUBZA
	 uTFUpZsOMJ157/ZX8+SjAJqrYUH66DgeNdRXmuyktuvm68rh1xEKAeTpYBAmghrEKl2hJ
	 SmRFmFuqSRX4scBT3oItV8qeMlX+cg3pTotLuQm/vgfa+pXrVdB9S9udxSu88KWK5Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ssSemCju;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kqRL5kN8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2E606A333;
	Mon,  9 Nov 2026 19:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A2E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ssSemCju;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kqRL5kN8
Date: Mon, 09 Nov 2026 19:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794252026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KWnbpW8U8aRa3MplkVaafabfv3H+gZ1D7AlDgbRTrE=;
	b=ssSemCju9TxnzTs+rc7zK/SBKrxelSioRCA65qRNlg4QmVykbop0AuNdjwEbLlHMJWXQ1b
	MwQ1oyWjstHoGRyDe7o73j+Cc/0c0MpYhQjj6oeBZxbNzrpTNtQAlr7nPrC7IEYxnppG/x
	sqMpf5XMjBI/4FKox/72q6pGxhZzQabRRlpFxGfvswfdST9+VwlB1AyHYz3iNeRLMkV7Xn
	S03RcdIQgGB0sK5blxdTm+7B+CtJEqrgaCDw9WnbX//RAJ/pLs1IiDm/DX0Qt31Ztt6nvZ
	jptFcT/dTjsvfIZU5IPxYVsahN4nhbsIr8dLiMDxoJMYo7P94/l4ptbMATR3+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794252026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KWnbpW8U8aRa3MplkVaafabfv3H+gZ1D7AlDgbRTrE=;
	b=kqRL5kN8ebEmL46SJYwMBQ+2UKuxUEvyrHoVSjJ1lhr97wk4Mp4/8pF77ZbE+0AEYIUSIE
	ZUsUZKAwDoLk7dCQ==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Reject cross timestamps for invalid
 AUX clocks
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261031122218.118921-1-thnkslprpt@gmail.com>
References: <20261031122218.118921-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179425202512.2093942.12722118554452285267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     67f1969e29b692ab3cfcc97ba175b9109212de00
Gitweb:        https://git.kernel.org/tip/67f1969e29b692ab3cfcc97ba175b910921=
2de00
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Sat, 31 Oct 2026 14:22:17 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 20:15:58 +01:00

timekeeping: Reject cross timestamps for invalid AUX clocks

get_device_system_crosststamp() accepts AUX clock IDs even when the
corresponding timekeeper is disabled. A never-enabled AUX timekeeper
has no initialized clocksource, and a previously enabled one can
retain stale timekeeping data.

Return -ENODEV before calling the device timestamp callback when the
selected timekeeper is invalid.

Fixes: 9aebde8af6fe ("timekeeping: Add support for AUX clock cross timestampi=
ng")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261031122218.118921-1-thnkslprpt@gmail.com
---
 kernel/time/timekeeping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7d7a737..806ab91 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1600,6 +1600,9 @@ int get_device_system_crosststamp(int (*get_time_fn)
=20
 	do {
 		seq =3D read_seqcount_begin(&tkd->seq);
+		if (!tk->clock_valid)
+			return -ENODEV;
+
 		/*
 		 * Try to synchronously capture device time and a system
 		 * counter value calling back into the device driver
