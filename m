Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702810;
	b=Wk0CodyD/rXNyGe6jbdGBNt8HCqXfCh7Op6sqcAj4a6rhKkK6QMBB4+h5SalZ6aSy7WP
	 kEU7KwIFWN2n2/g8ZMYdVR9R0X4h4Zkz3A8GvfI+By3Sriwur+HhtvyFFKhaQmAV1BpEH
	 XsJQwO9L2rUypjta8B8bnUPDf8pNJdgT+l8EPDVmM2v1KgxdqHg6HYIp+RuqtA1FueiTG
	 uswIopk8DIsx5+iPfY5AxNQTG7/DTqmXvvugNWkE/aeEIuGqver7+dQzsozbf9Wks1ptH
	 TFhlUkzhguc35MRiaxHGZ7x5SnTFpSa90GkcQexhmKHbwbptnDslabkOOfuXJNtx19g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a+TVj+4Eo0cuLbImvgKBU3zCHqSsK0fiVALfcKdKlGQ=;
	b=hKlEa4rLltXlGd2DRK25qOWr/KdBhcBKMsAtk8cWyBespr11BMce36psVN1hgxv5k9qk
	 Sii7p7At0XJ4vvVlRUOJskH2bWnqwY/Lyz6b/qq8bsbXGGryRcRk6NvmrpaJbTPmWl17L
	 mUEHj12PVbw2hHiPgbs+rn7WvP75gSii+F1y1i6zZsIP4EiiW+T9i+QI0+7L6gSh7DheO
	 eMpixHy9v8jHhBSRZQFTqqR8ZIruraK7IyBKh9CZew0eYlGp6el3wEEivYb9kr8HGFwBl
	 vkgYP1gIUs1xrw6JJj0+RpNIUuIPyKnyympcjBVym7Djs8m9YGxUAEvHe0VyeVBzqyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bqMtcI04;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF94606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 21:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF94606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bqMtcI04
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso1397145e9.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792702809; x=1793307609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+TVj+4Eo0cuLbImvgKBU3zCHqSsK0fiVALfcKdKlGQ=;
        b=bqMtcI04Pu5MSW9kbxQGcCWePH2OxfIiXtLBYdnh7Seuyo9Ha7kw9yZyibB5Rp8p+8
         +uJJX57c4HZiUPJwPgqsh9QF+bSRsy2A6lJRFVN76J5sGZQOm4l+/O2Q4yKLoDg6hOKG
         K3Mo5geiAHPki9CxUGGiOwGbUxHUVJ+B4j6CfSmk6IZJ2FtFyU31hYNw7fyRt9j6Bezp
         f9o3/IoCKyfDj7NAn9jR9Y1pLBeHGdR/RNW4Rbe+lr7SM98dYCf3avjMvhIYJP1Yk/I5
         HfiVahpE7JFWivhrx9+BRGdO3ccbDi7iVo3n0TeklgMs1i7WbTuW+QQIQKS8wON0TVBA
         kVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702809; x=1793307609;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+TVj+4Eo0cuLbImvgKBU3zCHqSsK0fiVALfcKdKlGQ=;
        b=QqKNSGjl/TrTTDH2UTHJWEwrH4e0VlLoMx1gez6Y2unOE0YoPSzdc4Zh3sh5n/XTPl
         Z5zeTNTfDm1H/CUhhzrueSJPfK+F+nD9SMsUnJaEr3qv7llWH2M0ZN59JgyoY1P4/IoU
         JwOmj8wVKWZAFUmNTpwQsdmsNwt3QUN7dKktZeWSozbJX8/yYJWOeUwiAv+N3W52tASg
         KTGB/lC77els6EuSDlYF5C03WBVheaiXQRNhszr2aTa2GnCWuMve7f8hrKzkQk3Dv3Nk
         lPkcfslMcZ5I9NL6FCzB8wIcgTr2sBgC1aR0UO0P7VQkxcukgPngFKdSOQTrON+G2ruz
         3FsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9yJCXQiMfhAMQA/utSSJ60BCsz1JFjEkanD8FXCWuCsLRtHOk+B4NURZtst5VwNE5FwYlXm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXau3/nvtjxMKr6gZYk+khs0f+qNi6W2pZAWHBKnDgIOkGyJWw
	FRTS85JbCCq2LZT4GibNhrS2vLQ2gXa03dDyv4O8AKalzCknHuA7iFFk
X-Gm-Gg: AYBFou0yzHeKi8/H8UcNxhiUvoerqPOaEO8eFv6IzvnyGl5NKVRsipbmr50qnjdbE8I
	TlXdlIFdUHd/o8r3d14GIKtxss1rIiDe69x1htZSyyu4IbaYQmw5Bx3M/ai6xm/0hc1JIy+kFLB
	Dewv1KBdZrTaYPHM/oXSzOJDoSMhTFgJAG8RQuTCHaqmU7EfAhpl1YVqzYa1IIoHzm8GebTfsUq
	yNjp2ySK8uo9pLwxFSRQpwnayKtREZhxhzfGO2taenl+S54yn+onbAJ/lt1P/szneisc3f13zdR
	vWBN7Ff13xbK4L9uEbQPmS7DQCyTPoA7ZwjJC+vUpFYqkIi4TYRRAeIHseA6C0HkSZ86zH/rPmU
	SOu5FJV9p+jT21j98zqOe7EB/sbY76BRzdNluxff+Rd77sm24fFvTuuBKlvWipWj6l33KqrKEi6
	BU2OYASWQAQiheFaa2jsNDe/s1R/tzuj/rP5ORKgov1WU0qKesHrnPeX5rJ9FFdWedOkL5dUA1t
	Wh9bAl/AsZOQ2zeLEpYckYn2xAV8furOVycUJ6Eo9+v3t404KVwl70iRbkSSSg2VJ5HjKmeUrWd
	2C6lQYs8LRqeUWky
X-Received: by 2002:a05:600c:3111:b0:4a2:1a:a128 with SMTP id 5b1f17b1804b1-4a211ed7ec2mr3619535e9.19.1792702808835;
        Thu, 22 Oct 2026 14:00:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b89beasm8702815e9.5.2026.10.22.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:00:08 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:00:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 14/21] leds: flash: Avoid divide-by-zero in
 led_clamp_align()
Message-ID: <20261022220006.6e066670@pumpkin>
In-Reply-To: <20261021123406.3163547-15-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
	<20261021123406.3163547-15-lee@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 12:32:23 +0000
Lee Jones <lee@kernel.org> wrote:

> If a flash LED driver leaves a setting's step size as zero, writing to
> the corresponding sysfs attribute invokes led_clamp_align() and triggers
> an integer division by zero when aligning the offset to s->step.
> 
> Clamp s->val to [s->min, s->max] and return early when s->step is zero.
> 
> Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
> Closes: https://sashiko.dev/#/bug/linux-9d06d7fe-310b-4aee-8b16-0fb49550c287
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/leds/led-class-flash.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> index 181dfd49c6ad..16b3b6b9365b 100644
> --- a/drivers/leds/led-class-flash.c
> +++ b/drivers/leds/led-class-flash.c
> @@ -375,6 +375,11 @@ static void led_clamp_align(struct led_flash_setting *s)
>  {
>  	u32 v, offset;
>  
> +	if (!s->step) {
> +		s->val = clamp(s->val, s->min, s->max);
> +		return;
> +	}

Why not just:
	u32 step = s->step ?: 1;
and then use step instead of s->step.

David

> +
>  	v = s->val + s->step / 2;
>  	v = clamp(v, s->min, s->max);
>  	offset = v - s->min;

