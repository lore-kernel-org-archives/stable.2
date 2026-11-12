Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794474028;
	b=aiu55mTc0b/jTQw2YTGcN+OnuS0MHqyhQOcLgZN1AT91CbxBGbLuej4hem7efXLupSxz
	 FWwpyaschWdh+Vx0Z9ZB6Thzgv0y8st6zNzRDezNHaTP77zaf0PhVHtwdWs3eY8rsjRmp
	 g3a/u9RKWhJBqO4BrtLGEUYzAxqU4GN3ad7xyfb4Fq3eEfLQhLFD4XSenrmqPP3zWX8X1
	 7nUKqv7NqqIFShY1b5IdyEIG7nN8FZ/A2uvN/YlEJ1cCxaXtw4vIcZlP2MQsEtoWFy4D/
	 vhAYUeRkmPZAnb8aJqOcbqz5KrX5iHPYrH9WFmi6DjqDuIeEEwsHjjgQ06y9qrq/Twg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
	b=gdwdVvd6mum245mtQ/kMfP8hHu0LMqUw1TZJpIh2uACAxKS7NmIXc+dmgQI1AaUft/wR
	 pWgzLgq5JvvanNMd1Y2hPhUv5oHj1jyotYckauF0aQ9BP78JsmBSU1DL2WYuESR2yBsuI
	 HgOMIpXN4noZtuIb6cB4qkwxruAbgkktCZmjizmwoHJd4DvpGouyHYWTyFna+nf9Gw3Ul
	 PYdaC8nh6pDz4g3JjbGs5Er1xDGNqiZEoInhWi/0ln5SYcSqUmATeDk5M8jk5N41NJifj
	 thpB6tfDxYa28YTRVV8FaoikV2TS3ipMxqpkqqFnthyLsXaLO0XBlEq/i0nSbZxsKjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkxPwo4U;
	arc=fail smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA549606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA549606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkxPwo4U
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ae10409ceaso1674181fa.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474026; cv=none;
        d=google.com; s=arc-20260327;
        b=CCzZuyANe0pWoU/C/zOB/PLSoe9yj6DJtx9meSjVBSZ/QkgZNNJIWU4lLPxmgBf2Um
         06GUCWLIGRv4Vd2Jvmsbn9V+eHZ0EtVdchwX5kG/yWUc7mnu1hYhMHl74Pkw9bQrxyGG
         10awQ9n1MCqk/MrJ+ZnfGFZDq/9gONMcr3UMROiWO39v3xCxDIOCrGqIaErmEbvENyd+
         cXR5sz/MKFqs8hJkRA1LYYJf7HWBsAxtu8YsshQMvrvJUMClS/lbIDEOX8GjB8WbOmSH
         6miYJ7a+zGK+jYRGO1hX/Io0GB1XZqtk2S03dSjQYbFG3EDlM150+rl5Gg7ndd7Wl6jf
         9Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        fh=51qLGP0zXVVQxo6MdArD9V+FO215B3xCbdmZoRhxfTQ=;
        b=Bx54ixzMEH8ol751Vd9OcnPs+64spHrLkF32UMSJG0FrPSUKSV7HlJ3n2+hUWZRrKg
         AMiMmrRSOlpGWx9aFpP5CmuDjS6MfgkNRyq5lPnSylo9O/Xt/xJVl35dSnXWifid+qfG
         bmaYSWSo9grNZoi5tUc7SiLsKKKRyr5AFIzPr5+oqhvgR7s1Q9P/XUCnwGVWR+I7dng9
         vWbDTdOvO4ERY4cYWVinmhmtSFMQF9Sq7J+lM/quU8N7pG0FQ+MaHqNVU2MOZdc4PuC9
         gHsafnfle0Ru7dvRFDk0iBXHy60FFc6KMYyqKjOgZ7qlBuYt/HIK/HxmUseMKPbbcj+9
         7Ukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474026; x=1795078826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        b=AkxPwo4UuvS8Fx3lKXS3acYjGFs3MoZbrWOg9QuGvCP9brgnlVOKm22vtGKmYXzlk/
         ZNkafoCJyRM0UfvHLil42Lvr2GEjep4oX8zR3S22ID5KKsL2bre1R3k1mxmvPj0Dm1Kf
         un/tDjSprT/xwYUWIoh2ThkQ7lQNzu4cgzcNoDs8xJ8UkmUFPmlM8scxu7yjNQ6m6Zsx
         gpoNv75Rla/J8/Ik9NVI3JsAGiROHf93tJp20uA79HJJ7xak01ga7+DWTUhkK+z8212y
         qazeHq81hwYnOk8UGeKY5C63lHfdxAvC/YpiAYDsAuHWPx8sqkBS70/b+KXaqTSSWahN
         JLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474026; x=1795078826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDCejDW8VBxWNNPFAIfF39q0jltnN04sCRzvotswVSc=;
        b=2kwmq41CFf9Dq+kkitIT4BJ7ZYyJTDeKXZUMhu9sXD5dKEZuLrxxoxbtshKJVMko5l
         Amk24sI5LUtK8TtUx/CsF2LoHRPGOAQ25kX8dXlioYCxiLppVtbCGmg64UZcGgXOywmz
         0QpDHarOFixvE/aaDPdAh0h00Rne0u28OWxPblqm83UjYXpfZ7RHGrHdu7wKKa8O+Awz
         E4LOXRxS36uJOSiG34VRItT8HaJapCih5pwp+zGKkiy5Uja4VBy7j4u7sVZn7lqf+IDz
         d7eCfHPJchGVcYu4tJY4Gvi4jiEy51Zh9e89pqVvKQBsFLlATe2R+44oMC+OksDwidb8
         Z8Zg==
X-Forwarded-Encrypted: i=1; AL+hErGRobP9dFG+JCq5Mx0+zuASqqatjGCCRFk3Nq9w6js57SCmJPqbrDfnu+MNlNRzlbtScL6fMlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j2ZfPQtsQSRyvI2GfoTrNCg51+RVkYoYpUQETjpO274bgV6Nz
	WBB6cIT88QqRaq3Z71SRjV0/IqhF/9hTGA2zTUyR16+f+Bn4C1Lu0ekEas4Z0NnBEt+TsGoGVHW
	KAIuUlwL5NHxP01wX4xJoH73h0/wi4wiibUrFikMT+A==
X-Gm-Gg: AYBFou3fgxxPrYa3b1NbrXD5REhVXv3ktkh12g647AmT+6XhXph6h2kwtNeEBJHG2pC
	VStk2ytY2fdlhT1m8BirZfCJv+pA1mCz5JtUcisWCZ2OlU2/+Td4K0seXS6B+NzOHFOGuJ583Um
	DZxN4Gr8kWI1F02dKp0ormazhspX2XjIIFs870iZdA3yVyTwFGVGAXsIQ6qmB5K3XevH+Oa3EnG
	IxyJ5u6Q3NKoMMnxAiozUqmYmnFejnUC+S52i5M5e+NtlzDH3P7D7a8hDevMFiX29WDAIcacr5B
	+ZfvQIvSnfH8BR0GjgiwPGh6MLzE1LdzCfNPJIYS4fxjdDRxO95iPScW7nsuwZf9McU0/nKVPsB
	6FozdWUsmhvVpjRD7zIMjHqENN0gUTfRM/GGlPdJzd9BDwDfWM2q9ssSQVRY804wDDOjt2hcBNc
	/qPkA5YZddhvGd5+GV
X-Received: by 2002:a05:6512:3e01:b0:5c0:b5c:4084 with SMTP id
 2adb3069b0e04-5c15d54dd2bmr1732485e87.1.1794474025804; Thu, 12 Nov 2026
 01:00:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com> <20261110074853cc5a8882@mail.local>
In-Reply-To: <20261110074853cc5a8882@mail.local>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 01:00:14 -0800
X-Gm-Features: AclHuK9eG45v9F6I7GV15HBzJqSwgKITGyUk_trjz8yzMuRHSrXtJn6NP2-qWxI
Message-ID: <CAEy9hNWaUB2rFwXFP=pmLv_Gj4Umz2CsDpN7ESJimOsVq2RzLg@mail.gmail.com>
Subject: Re: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds
 down into the past
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

> This is the expected behaviour, userspace has to handle the error
> properly: the alarm can't be set, set it for a later time or stop there
> and don't suspend.

OK. One detail: userspace gets no error in this case.
rtc_timer_enqueue() turns the -ETIME from __rtc_set_alarm() into an
immediate expiry and returns 0, so RTC_WKALM_SET and the wakealarm
sysfs file succeed. What userspace gets is an RTC_AF event right away
and a disabled alarm from RTC_WKALM_RD.

I checked that on the HYM8563 without my patch: RTC_WKALM_SET for 15 s
ahead in the current minute returned 0 in 5 of 5 tries. rtcwake only
checks that return value, so "rtcwake -m freeze -s 15" suspended with
no alarm armed and did not wake up.

> Never round up, you are going to miss deadlines.

Understood, please drop the patch. I'll fix rtcwake instead: read the
alarm back after setting it and not suspend when it has already
expired.

Would you also want rtc_set_alarm() to return -ETIME when the rounding
moves an alarm that is still in the future into the past? If the
immediate RTC_AF is the intended signal, I'll leave the kernel as it
is.

Thanks,
Arun

On Mon, Nov 9, 2026 at 11:48=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 10/11/2026 07:13:47+0000, Arun Iyengar via B4 Relay wrote:
> > From: Arun Iyengar <aiyengar1990@gmail.com>
> >
> > For an RTC with RTC_FEATURE_ALARM_RES_MINUTE, rtc_set_alarm() rounds th=
e
> > alarm down to the start of its minute, so that it never fires late. Whe=
n
> > the alarm is less than a minute away and in the same minute as the
> > current time, the rounded time is already in the past.
> > rtc_timer_enqueue() then gets -ETIME from __rtc_set_alarm() and expires
> > the timer from the irq work right away, and the hardware alarm is never
> > armed.
>
> This is the expected behaviour, userspace has to handle the error
> properly: the alarm can't be set, set it for a later time or stop there
> and don't suspend.
>
> >
> > That loses every short wake alarm. With a HYM8563, which has minute
> > resolution, "rtcwake -m freeze -s 15" sets an alarm that expires in
> > software before the system suspends, so nothing wakes it: with the
> > alarm set at 17:55:00 for 17:55:17, /proc/driver/rtc reads back
> > "alrm_time: 17:55:00, alarm_IRQ: no", and the system stays in
> > suspend-to-idle until something else wakes it.
> >
> > Round the alarm up to the next minute when rounding down would put an
> > alarm that is still in the future into the past. It then fires at most
> > 59 seconds late instead of never. Alarms that are already in the past,
> > or that round down to a time still in the future, are handled as before=
.
>
> Never round up, you are going to miss deadlines.
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
