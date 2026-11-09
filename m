Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252028;
	b=DsTGpmYUjnVOLLHyv9jdjk6lGD8Dt3FBbBqf0ZWQzy0q1+L1NO35cgd3roCouUEFhD5C
	 IhpX1uybjIXQ38ZXy4yOdnZulBg5Y+OpEtb09feq/rucrVM0Lyd+yYFw0Rwht8oYF0bjj
	 5F90GhC/zn4J3AWN4wtHg4VSIGQ1OdFcvCiIweM41oWWNeISHlm0mDXemGqMtTyL1QXoi
	 QhBgl+79N+YDCXLDaqwGZdh/PU9JzvpaBpvT7UCBc/YAIzkKWGu1QoM14cxQefVglD6bO
	 UdCqKJwXJR+TpwsCAZfIdXIf/4q2Z2G0/81uUrCXAEIMRq2zbTnAYKRFVzLnOncdtGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252028;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=p6Q9ouKwJMNfNgLS6mMWkxldXEVgpvb7zVco2VuX7+w=;
	b=OqzGVsTAzUCtkY7ZMOkpp7OhReLyBR8aISR1JQpPdfU6Lc3Ai78+ysmAQE1KrflCkTvJ
	 p9XxEwFpdN+2MBHvwSnSdG8RqyLIeAdXi/qNG06H2LwdH0rBcZXJUFXm2e/yDkotb9J2w
	 ecR6lDzp98XyX2NpB+qE77ErdORZhJaKWu6sFxUkUsyEqHo4gcFzVVtbZ8u5xXUiapUqp
	 qgXfQPWz3EsLPjxllDld3+6CMhJA1GdsMo48e614DRfN/ikaDkN9/WWBV99JvMPcfo6Jf
	 CP7uEExy6W39ySJwZKm4ND5xp4b5o4KRpcj55mK/N/cTNx2ct+w3b+vmS3Ixxf7GYKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mEB175Wr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DQRZZPuK;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C6606A325;
	Mon,  9 Nov 2026 19:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C65C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mEB175Wr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DQRZZPuK
Date: Mon, 09 Nov 2026 19:20:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794252025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6Q9ouKwJMNfNgLS6mMWkxldXEVgpvb7zVco2VuX7+w=;
	b=mEB175WrkUNblnyTdp6CqNCtKvco9Lh9nsOn7q/rAo0mruRAeDuNxpwejBfasTCa5VoIhP
	L9ZhL2lCMvyVfUgEKdO0mhUfz05sTHTEWWErQaAOlPUK7h9MzPLg9kruY2PczaU+L9gyJ+
	hkbb3jKPGtH9naQlQMcbfQOCCDRsrwTSFSuS2On7Wj9TDJgkB5+JvnXumypKZaQjtKAynQ
	fkKMc3/tCSeaxrbRmPj1HLVzZ0KlZM4ML8ZxCXtPluqSFM9I3tMECiJY+HosgaQNhKAxzJ
	rU32GRj9UVV4mHRQf+CviyRbRrxffb4PEYzIEYbfY9cJSdNI/bCzN87ihUtWtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794252025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6Q9ouKwJMNfNgLS6mMWkxldXEVgpvb7zVco2VuX7+w=;
	b=DQRZZPuKb/h31yVgRtxSj/pQfkltgjSTDm6MaTZbQzcn3RSzcmdMS5y82rUdI5SaOeP0At
	RrqZNaJv/ZL/hqCg==
From: "tip-bot2 for Avi Weiss" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Refresh auxiliary base before
 offset validation
Cc: Avi Weiss <thnkslprpt@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103090605.1292660-1-thnkslprpt@gmail.com>
References: <20261103090605.1292660-1-thnkslprpt@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179425202341.2093942.17209822413876572867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c1b96ba87e3caaa701d6dba254e58db7cc3c99be
Gitweb:        https://git.kernel.org/tip/c1b96ba87e3caaa701d6dba254e58db7cc3=
c99be
Author:        Avi Weiss <thnkslprpt@gmail.com>
AuthorDate:    Tue, 03 Nov 2026 11:06:05 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 20:15:58 +01:00

timekeeping: Refresh auxiliary base before offset validation

timekeeping_forward_now() can advance an auxiliary timekeeper across a
second boundary without refreshing tkr_mono.base. The negative-time
check in __timekeeping_inject_offset() then uses the stale base and
rejects valid ADJ_SETOFFSET adjustments with -EINVAL.

Refresh the derived timekeeper data before calculating the current
auxiliary time, as aux_clock_set() already does.

On 7.4-rc1, a valid negative adjustment fails at the first second
rollover. The patched kernel accepts all 12 tested rollover adjustments
and continues to reject invalid negative offsets.

Fixes: 2c8aea59c206 ("timekeeping: Add auxiliary clock support to __timekeepi=
ng_inject_offset()")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103090605.1292660-1-thnkslprpt@gmail.com
---
 kernel/time/timekeeping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 806ab91..be72cfd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1778,6 +1778,7 @@ static int __timekeeping_inject_offset(struct tk_data *=
tkd, const struct timespe
 		struct tk_read_base *tkr_mono =3D &tks->tkr_mono;
 		ktime_t now, offs;
=20
+		tk_update_ktime_data(tks);
 		/* Get the current time */
 		now =3D ktime_add_ns(tkr_mono->base, timekeeping_get_ns(tkr_mono));
 		/* Add the relative offset change */
