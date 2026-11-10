Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296940;
	b=Fv4qdNy64CkEx6KxHNbeh7wuXzlHLcOU1tAtrbrXL3WGTrDZk5AvvD4LmFYJxmprsnd7
	 huiiJGhsEAcpKjrxwrrOZg0Knl+h0YaN1vhYBLpvNNS3iz1/Y5ssovxx/EXD/ok/9Eyvc
	 rjtZNyUQ4eun67Szzlp3dOxAxQfxU8931Fdx1KvrflXebvcdSsZuaMTGgAysDEZ2hFwOw
	 2vXozIIx2r67VQJa5hmO6fCSuARxSHTNQLag1m0nUGtHZiLhYUGRNQXFrQSQOedT+Cx+5
	 ImAEg0mQmssVXqf4MmlZ2uyX+YRmJQ9Xc1Eq8cF9K1eOyoO847cEIDZ2DJUpUO0jfag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296940;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=cp7X0c4WXjjo9mje1g5wweHAAKqgSx/hmxnwsgmzy1Y=;
	b=deRki0Uq2IKiFY1zrwDEH3CO4j79p5LbM3JXcSezzCtJVTxqauI14AbaItf1eUnCgrpl
	 de+I2a3TAfmg6RBsExE9JZ0Fm1hW4y1xm9dSbUTf/YnhRYqlXvP5+6Ob1ADjUTgDmO8gY
	 OZgOjDBmJa0Fc3xaE1fDov725a1H2bkJQ8OCDY8AP/V/J/FcdlFd+AH6JcJNTLS1P1Yaa
	 jfaUIEfMWDsR1+xi9MMQlZEGXKeFXHFo5iYKxIGZKQeTBxK1Y+U9A70MVrPQPivX7qwBG
	 AHSxtJObA/R4HBU3qXvLkTs1NXdBMBDfGCnYUHDXrzOtwBlFWeoEvEwJ9epsXEhUMMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=urXJOpg8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CC606B537;
	Tue, 10 Nov 2026 07:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3CC606B537
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=urXJOpg8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 904B84E4153D;
	Tue, 10 Nov 2026 07:48:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6740060012;
	Tue, 10 Nov 2026 07:48:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1ECAF103293C1;
	Tue, 10 Nov 2026 08:48:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794296934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cp7X0c4WXjjo9mje1g5wweHAAKqgSx/hmxnwsgmzy1Y=;
	b=urXJOpg87txNoTM8b6wAa7VK8IhU/G4A7pDT3uu0Ono4971w0SPOdLaj9/MvUgAgfD8rPf
	QgzBmO5zy4aXms3tzImzik5lZUQdoiLNtrqmQt4VDb5g/V25cvxvkaFAmHZcOF8QzjzAVu
	ryxE6UOdir/pqouhVxARXWzqbZL8st0f9LyiQF/gueMuQNQaxu2cjhc1Iu4mSDN/oNOIKu
	ioYajZRM//NRFSHQvjHhesdQvE6qABluQFXQSIpqR4kA2SFqau6eVNJqDlpHEX7OazZBdW
	4hKoM7bWBZrIpEaCBDCcs+scT03+NRa2BHiNn8fijWoaH6l6uSNUNbFz2IzJPg==
Date: Tue, 10 Nov 2026 08:48:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: aiyengar1990@gmail.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds
 down into the past
Message-ID: <20261110074853cc5a8882@mail.local>
References: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 10/11/2026 07:13:47+0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> For an RTC with RTC_FEATURE_ALARM_RES_MINUTE, rtc_set_alarm() rounds the
> alarm down to the start of its minute, so that it never fires late. When
> the alarm is less than a minute away and in the same minute as the
> current time, the rounded time is already in the past.
> rtc_timer_enqueue() then gets -ETIME from __rtc_set_alarm() and expires
> the timer from the irq work right away, and the hardware alarm is never
> armed.

This is the expected behaviour, userspace has to handle the error
properly: the alarm can't be set, set it for a later time or stop there
and don't suspend.

> 
> That loses every short wake alarm. With a HYM8563, which has minute
> resolution, "rtcwake -m freeze -s 15" sets an alarm that expires in
> software before the system suspends, so nothing wakes it: with the
> alarm set at 17:55:00 for 17:55:17, /proc/driver/rtc reads back
> "alrm_time: 17:55:00, alarm_IRQ: no", and the system stays in
> suspend-to-idle until something else wakes it.
> 
> Round the alarm up to the next minute when rounding down would put an
> alarm that is still in the future into the past. It then fires at most
> 59 seconds late instead of never. Alarms that are already in the past,
> or that round down to a time still in the future, are handled as before.

Never round up, you are going to miss deadlines.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
