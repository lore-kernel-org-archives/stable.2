Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046581;
	b=L4cWbI8vNoCOQRdJKr61rhHhGMEbq2lC9XB+uuOI0ynIuFyNJ7JySOXafEnPhduUKe2e
	 0L7JNj6/9NJ16XVP4WGHXi5VzW9y9Flw9QpZk/Voa9FsDgsbSAdNwbo7UbhDRE9wDnWpp
	 PL4BDytNV1fnp8kwJGqX8A9bJCjy7APBTvoTf97xHmQr8KRq27XJiF+6TaR997nf9xwfC
	 pxMDWIQk25fseV3LnTOBgEjd2Un0VVmT6HK+pvkZ1j151st1OBWbrV9MPYDF+7Md0CGMj
	 pD++g9XYmh0Imd51+/luil1Rebud4wmzHrQ3x34I3vqNDKmS/32asWjopbJ/epkLTOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Txc3E1PcXQlFNp7c7FiKp/5yHJpupSAoBNaMzkRlDf0=;
	b=jX+nGPgcaae8hNSFIf3Ll2yHRN5Qcy2Dmk8ssO0au4rVnjwOu+4X5n7NRemk/0MONJij
	 sazImq4Na8jdpncYzYDYs1LhT6WB1J8t5ciQihE+uSgPFNA0izoSMzj/lKwJZVozMxO+A
	 I7NxxsDcvNqHKzsXqwYRLnnkfAc8a2E7LPpXn6Z/C/WAwtpaMlzeSET/i6wLYQYYBVNtd
	 +fMRi0brQBDq5qJx29mzyA6CGeD2jgr9pfUZu8LlpaEMbN6poAmU7oQqoj9bK+eloXfTD
	 04FdqhTsY02waAljQo2iwwBmDgyh9Gym/Ri7lY+IqX1PPaE/by2uVjRaxxOKenGUSjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e/rgyOv7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7477606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7477606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e/rgyOv7
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0dba37a7fso12879397b3.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046580; cv=none;
        d=google.com; s=arc-20260327;
        b=M0+SiqE9sb5Zb3ZfcOCzuXjD3ZHevG7tLBGBC7XK5QLsp2GFEp7hAbP1t5klGRBtcb
         c/gFbX5AVWm4d42KF0//+l03tYDBv1Wif7oowIAXngMD/x+PrsgkbHOkoUki0yAl44pX
         neSpIAw9YMAZaKL2hyG9MEjtyssqVQ7l9Q3f8lwQoT/I+s8oZ5ubs86UvZmOVgbDepDE
         nEHhxEA9ZgLVWTZJbqIO4o1o1XOuELALvwGPLxmxjb23R6tPHURe2Ap9MCRWTekNnB3b
         uJkz2G0PIDK2ffs/iP1zMmupXznoOEhWh7QQnJVakYL4onQkE3A5mAWl+cRTQveKSjiI
         eWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Txc3E1PcXQlFNp7c7FiKp/5yHJpupSAoBNaMzkRlDf0=;
        fh=dGIvdKGqEOVbRKvW8BUQBi187l0ER4FdGtI1pDFhnBg=;
        b=ZJtQl2kgOe0DJUIk5jQnjCq6SYfvtAEeZeVrj9EIH2PpLEMgbAfuNRyGCoj0EZGG6S
         OU/H5YYxSf/2+ChC8nRY/UdUk/8JMqxQnlJ/YOtU8w42s1OnwAQ4rxaAad453IrgY0NE
         pQlWXO90zkv4e6C9R2+7RLrpsWtva60EqOcukM932jXkwBs49rdGpgrmUqoXguj5maGM
         L79Li9g0XWgIvB/zhygaIZE2WKxcfEyk1LboqMMd48XT8/Wc4Jew7GwWov6O6kMb1pzi
         BpLVRx+0ilK7aoQKRRBDsGE9wiEQSl47FyK/pW8bne+uY+kKKe60vGVO/CSwoChL3jET
         BixA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046580; x=1794651380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Txc3E1PcXQlFNp7c7FiKp/5yHJpupSAoBNaMzkRlDf0=;
        b=e/rgyOv7rFiYubkj7ia7wUAH1Z/153ARimvVm4yKP14CRR4nDhDwUiuERCKRbOd4zE
         ZDmWtn+b+vAz4ylq9BL86ZLvtJsnHGFYTKqbzvRwLr0u0CT45W5JVwBVAtlY8SvjI6Sj
         ZCt2mKMEFw8eApyfRFoYGDQAkuIq2Kvt/qzHBVOUmAN0+FYUYKcMY+Xs6rfib1+avwqF
         NHBlDuncErFAUgaR+ncJJ+BqJ2kAo+yXSNTWwWp9MxbZqF/jai/m0mxDrXcvvgiK9i0H
         7iMyc8db+tR1Eph9yeb3ysIu0bxF7SPlvDmWEyZTq+oW7BSb6UeAdurq756pHTKp2KKY
         Xpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046580; x=1794651380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Txc3E1PcXQlFNp7c7FiKp/5yHJpupSAoBNaMzkRlDf0=;
        b=AY/RY+bhIeYevD8WIKdVkwXxqRBXw9K7XERVLz6e1gLzbSBrohk8J5xEbcDZa3OVlB
         9frJa1Y9FiAMJ3vbT6Yz0QQJ3ey3JXM5us3JisW3oMicndR+BQvj5fCubfyNfUj+Xpz2
         QnO0bM9cQyay01rOv4+aIpax3G4/oePiTTNETYY87xC8R6RpRvNYWtqUf2jVHm368A0d
         syFBjfzGHZnu76+lRK/8g3gD1+QbsFDEAKaLTmIid9ugDGW2z7Lcs6nou//PTu5RJpB3
         +2n3LEPyNGpAmj5PVcY93D7GM2UrRxRQyTkYVprRPIVAdnAu+MKZEAkKnP7j7sWdc7dV
         vc9g==
X-Forwarded-Encrypted: i=1; AL+hErEWRSUkPvzQ0wzB+5VEsTQTg9uhPds/r7vxGXS/93sjuH7WZ/omdmhP6zCzAemFeJFkaL7IUjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iA65jjpLUzNXNA+QHTfQGbXnxf/kGWGYiOp9dW1lOgVAC6ais
	+BhStLgoCeRWvncmSg5bS2vB/dpgrn8XDzeySJ8xDYqq1DKFDAdY5RmuuVbZIOZ6vlaBU8ErUbg
	876PCI0gfijGSA+otPQjzUsAxfEmoYeI=
X-Gm-Gg: AYBFou0+mH9S9PGtmmNx8y6LUJYR4Djug4IK948iwPIH2t2YsHSQE+bYxiqdxjyhJV4
	jHGI+JyG6JFOc266XPFl/LrVNkDZyxJXqSSP5yqEAdT3e3uO4/mGsJdIPpdlQoxMz9DF+cclq1V
	9iUo8mSkegE4ID7yN1l+9MpQxMxkZJY9aPstmGJchTD38d3zgWfS1YC61Dhi3NkDZKIC5K2nrgx
	wVb3EG6DOpjq5pgQfmtfszkKThNU/KZ4Xl6DGbaoSmalg82lp0XeK4Cc3+GdTla7fvwL9BlxvIx
	Z6Ffy/mGsjy9OTUw81cTdjcH02S/m3GiFWqL8K0tLNxwlsgVaHpzBIAhHFpVm62LqQclkSuUAWo
	bf4wr7DVPRQoGXmsNWl1mWa28N2H0Bm/4hO7nNlXp5QsXiTY5hJ6wxxm5HSc=
X-Received: by 2002:a05:690c:289:b0:8b0:a252:77c6 with SMTP id
 00721157ae682-8b3418dfee1mr22332297b3.19.1794046579785; Sat, 07 Nov 2026
 02:16:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com> <0597b71f39fd945d531d3e996d982d5d3a3b9a28.camel@collabora.com>
In-Reply-To: <0597b71f39fd945d531d3e996d982d5d3a3b9a28.camel@collabora.com>
From: Sergei Khomenkov <shomenkow@gmail.com>
Date: Sat, 7 Nov 2026 12:16:08 +0200
X-Gm-Features: AclHuK8U4hp329_sClLRJdwqt0M9udYoGIyX3Gq2TqxXtvVHZa2zNAR132StXO0
Message-ID: <CADxDoMSrwDQfFD-VejUvh3shpo6BKjFWMzXUtsoK=t7=AhPATg@mail.gmail.com>
Subject: Re: [PATCH] media: verisilicon: suspend the device before
 unregistering it on remove
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Frank Li <Frank.Li@nxp.com>, 
	Tharit Tangkijwanichakul <tharitt97@gmail.com>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

> To be verified, but its not entirely logical here. My impression was that you
> want to unregister the dev entry sooner, so that it prevent newly open, and turn
> existing fh into a mode where all ioctl will fail.

That part stays first. media_device_unregister() and
hantro_remove_{dec,enc}_func() still run at the top of hantro_remove().
The patch only moves v4l2_device_unregister() and clk_bulk_unprepare()
below the runtime PM calls. v4l2_device_unregister() touches no node
here: it clears the driver data, which equals &vpu->v4l2_dev (the first
member of struct hantro_dev), and drops the device reference.

> Can you do some extra code inspection and report why you strictly need to modify
> the clock states before you unregister the device?

hantro_runtime_suspend() reads the driver data, and with power/control
at "auto" and the default 100 ms autosuspend delay remove() calls it.
The driver core resumes the device before remove(), and its put only
arms the autosuspend timer. So pm_runtime_dont_use_autosuspend()
suspends the device synchronously, the path in the 8e26d4c20ed2 trace.
With the current order the driver data is NULL by then: an unbind or
module unload oopses, after clk_bulk_unprepare() has warned
"Unpreparing enabled". (My reading of the code: with autosuspend_delay_ms
at 0 the device is already suspended when remove() runs; I did not test
that case.)

So two things are strict: runtime PM stopped before
v4l2_device_unregister(), and the clocks disabled before
clk_bulk_unprepare(). The new clk_bulk_disable() does not use the driver
data, so it only has to come before the unprepare.

I suspend through the PM core, not by hand, so that the runtime suspend,
with any genpd power-off, still runs before reset_control_assert(), as
8e26d4c20ed2 wants. I could only test on RK3026, whose VPU has no power
domain, resets or IOMMU. A run on RK3588 or i.MX8M would help.

> p.s. are you sure outside of test build, that PM can be disabled on any of the
> platform hantro driver runs ?

If you mean CONFIG_PM=n: not on Rockchip or i.MX8M, which select PM. On
sunxi, AT91 and STM32 PM is only a default (SUSPEND=y selects PM_SLEEP),
so it can be turned off, but then the driver never enables its clocks:
only hantro_runtime_resume() does. The IS_ENABLED(CONFIG_PM) test is for
such builds and COMPILE_TEST. There pm_runtime_status_suspended()
returns false, so unbind would disable clocks that were never enabled
and hit the "already disabled" WARN. I can drop it if you prefer.

The block itself is for runtime PM forbidden through sysfs
(power/control set to "on"), which root or a udev rule can do on any
platform. Then nothing suspends the device, and it is still active after
pm_runtime_disable(). I tested that case on the board. cedrus and
mali-c55 (2c9b9bcc2569) power off by hand in remove() the same way.

Thanks,
Sergei
