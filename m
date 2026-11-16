Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829053;
	b=duXIGtWFO/8nWn0GXJ70lPvPvX8Ye0THonoxaZ0qbJ9yZiScvKZvcjjg8uqdERN/DHeC
	 o+nGp2aHqHtbKlxtc2dZAAmhASIQsQqN1I7cKFGjvyYCuWAesPiTu+CAkcJq3fGg7EtTu
	 Ls6QRieIJtMoIFT6wQUumGjy9WCsmMqGXQ9QC5CMVnyXKTrC4r379r9w2kTT6O4SuKAsi
	 /OcQAdZSXOMZxMZDyHIc432YULotpBuktP91qpFiNYH4qyqb3Mo+Y4BuE6vKGvgkjaUOF
	 uBJrcrxu1iYLCJFXY5+KlUnX3RuEcIna1iafDzLl1jQ/20IIZNttI+hN5kvicWgfoNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829053;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=tlxQbNS6YQ6dC4GW6OJCCMzPULNSrAZH+Tzi4oNheUc=;
	b=q/imXXog1b8jcumSO2MVEdcXAMK9V/PL1Bw/bD2219LnAIcofRLytr6fQLYQwueFQ2Sr
	 09RTalEwruDjAieCq8mhBbp9IzGPnZLHbBKja5zYRtPWUBRb6U8y+sGDGEYwAWkV5ME8m
	 etp6MilIzFsxMaCQRNo+rd2QztzM7UwFTnd9xb9nDOxKHK7E1U+6bOikTVVvyt9WJz9Lk
	 ZMsWbfpstIYWKH3cPZG1vMtlLvsCyUnPvx9l7hM05IuSTaV29FMZgsTEmka4xqPEnCehm
	 upvVid7hye4K2sTOVntzIKJukFEmyD8NTiR1FPb/4i2NvXOyQYNvWzNPVEvB1c119Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="n1/8+wKk";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CB606A32C;
	Mon, 16 Nov 2026 11:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510CB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=n1/8+wKk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 967CF4E415F2;
	Mon, 16 Nov 2026 11:37:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69FE16023F;
	Mon, 16 Nov 2026 11:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84F1011BC0949;
	Mon, 16 Nov 2026 12:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794829045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tlxQbNS6YQ6dC4GW6OJCCMzPULNSrAZH+Tzi4oNheUc=;
	b=n1/8+wKkaYL+fR3a+f5O3cXaZsUZ2LP2/kH6EvLZuqQciO/HWmnBxlP87Krgwjab+hEo1V
	e28S+wm/bNgiSHEm2F7KjKk1AMq4ZWsEFKVfUHNgsNRo0u5ZQfb7UAYv01CQQdl7L0Gbvj
	COzUiq+IZRAA9xsAQGHggG0PYOPK4moR1QCsdqoEgNmoNTePnttnK6MIV2xmsgKNJi1fdb
	EwEFueQfCrqePqeGDKKjFUIX9P3qES5mYvaoS0DEGA/OJXgV4gljcO9Fntx7Xxkgh34A41
	88c6abrL3RTW0XiqpxzYjlVWUqthJqiBD8LqmW0/ft8dQY3Tfm6QPneSjtOS1A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
Message-Id: <179482904036.190319.14137028928687094984.b4-ty@b4>
Date: Mon, 16 Nov 2026 12:37:20 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3


On Tue, 03 Nov 2026 14:15:33 +0100, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
> 
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
> 
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
> 
> [...]

Applied, thanks!

[1/1] drm/tilcdc: Fix suspend/resume drvdata
      commit: b4d01c788bfa50dc65ffb5fbc9db4135004c0e01

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


