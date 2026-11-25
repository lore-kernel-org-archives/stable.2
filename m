Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623088;
	b=Wo2lCY2K/sTul7mYKX2Mw1pNfDIogTEAUeM+tIvYJJcTTYNjOACiQ0p1+xdyhg+MLIav
	 m9eMlQAuhIu0ytOmihAWLAE3f3ipJ9C78KNzjHNA7doYpFNO2CSRoxK0eRPcEUOD4T/VW
	 8A7nQhiHrDfg0nC/vIpioIvNoTpq91TbDCIeW0rPUD/hRxJzJuWsa4KWLZeprHBIuPEyp
	 uLQVafSBSCYRs4T4dq841uO/7zbUrQSCR1tH0/szfHg3d/82sCpypdeGNbAN7cq7Dngir
	 dtZOgJO5pb5BUXTeFWTpEfHag6WFwNmJTwDjYk8rcRsrDt3HHmHeWE6xqKWlYs8yK6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623088;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=tbs9QZ54tCRQ/HtclM3IabBk9mVStM5QK20RUGLtRbE=;
	b=Umg4YWaV8vupevWzpLjq/STO9h5Hpj86bFBHBIZ6c+JQobyUmIphxErtwDflHCK20BKy
	 E/qyJHulVOYTta7m0yT4YxetoypZkfrxUDlw/YakHJZ44Jlpedf0QPsIu515nSDlyQk/n
	 YTfDTeBmbLVrcZ/mnDlt8vBBqyt6AvnQJGsDItMyGRQT77h9e+j/DMkYRAFUNKFu60+UX
	 Sewh+GJ+5V/BT7yp+uP9pMT5wAgrtZe0Sa/yy7QZ59+gIYnSZbLtOskI3HRBIPOtOR63u
	 A8/RfTBvMi9zDHHUTmBgx06bPlpYIqQ+yNHKHGFC8HUdJiiHVwfRs/Y0hCUOw91TJ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="jt/zlPSz";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43F606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F43F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jt/zlPSz
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 524D71A17F4;
	Wed, 25 Nov 2026 16:11:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2793360480;
	Wed, 25 Nov 2026 16:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A559311E6ABF5;
	Wed, 25 Nov 2026 17:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795623085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tbs9QZ54tCRQ/HtclM3IabBk9mVStM5QK20RUGLtRbE=;
	b=jt/zlPSzPlDxOt36gF1yOUZ/2F9s3nhlFcOFekHfBF2rwocHmQIUzHhziaUu7yrnYFkVB9
	HIIUVK4+XGY57cyTvM330UdV6qXCjGZnpayUdSfJmksDn+TkRr+ne8pMIigFM11FKAS8L5
	SskizWrctJNG8aXAKjms4nMYXFKV9nDguw0h6cJDTLz/lb0raupFm8eWtKgDA+zGnrUvyC
	Vmw2yTQqyfyKZSmL1vvFfq4u3SNeQ1lGshEYfCyhIKMBA5Ft/5pzBQpF6WQS07/NEIVyUL
	kKoZYKjIezPbcWde1OLTdBtAxDiZPGC2e2rEQFSjZq6mBmYetCIIHvvmIa7smg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: laurentiu.palcu@oss.nxp.com, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 marek.vasut@mailbox.org, mripard@kernel.org, stable@vger.kernel.org
In-Reply-To: <20261124112215.12255-1-festevam@gmail.com>
References: <20261124112215.12255-1-festevam@gmail.com>
Subject: Re: [PATCH v3] drm/mxsfb: lcdif: Fix use-after-free on unbind
Message-Id: <179562308334.731258.14637573993541736813.b4-ty@b4>
Date: Wed, 25 Nov 2026 17:11:23 +0100
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


On Tue, 24 Nov 2026 08:22:15 -0300, Fabio Estevam wrote:
> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
> 
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
> 
> [...]

Applied, thanks!

[1/1] drm/mxsfb: lcdif: Fix use-after-free on unbind
      commit: 479e381e77dcde0dfcc9d51e89ff3273da199804

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


