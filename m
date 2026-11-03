Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714182;
	b=OnbQxYT11NxHoekB+4AQ7BDTHAFBlDV7HapNOLC6p1f8VXsSto3HEGS582nUQdLQPEZj
	 3GYCY/kTwBRTk9YXfE6No7WYdBqtzOpdc7dslkusYcy5vnqU9kkIRTZ7lYGwgYXBTXvVL
	 QkXPwZtm97wgf/5RwQGKS2sflsai1oIPlBwnEyxqYtmO7wwQtMUBafHw9OKeLQjh/PWN0
	 NWf7oIQT1PRxEYQFrCXsGiYFGaE/bCvDgIcq5CigsseED/XnzHOpDY16UvSRSWRlwn+WT
	 p/rrg5uW5UfD5YZ7zcJEriRgwD5gI/pj8D7H1/LAkQ/PHfZy2/y3VneH7WDo+ZOWecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714182;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=IWTHRSzeGW5fpCXVav87N82FYLK03Zsl6ESEIn+XvdQ=;
	b=3uVXO6wKIGnG9NJh6MO27HJTow5LT7j6mS6uqtuLfF1e12B8Rxum9Qi6bzw6X2GS6EG5
	 6OfdkpXTavBeuT+7sr5ypLt/EybOcrtVLLOP+iwEJdaDp2bhITNeXuJedejwMKCCDkNzT
	 J225IVHXUoQ7quE3A7scrXWlqzClrnVV55sQJxsSEOT7A+zOxDcZ5rUqw9EJSJ2n2HXDf
	 OPWJ4NcsUp1+/O5jDQuK7gzFfHI6a8XN/BH9LSpsSVTbe+OrcQUoaewU4mGaNPJBeCC9X
	 DDBXrfltDHN8+U5FdLd0g54q8+Y1cMwxVaTOqVzFrSlYkCzGKp1oHlFiJ9G6qb5CdcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2WprqqPW;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F1606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1F1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2WprqqPW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B6E564E413EA;
	Tue,  3 Nov 2026 13:56:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 721F86046C;
	Tue,  3 Nov 2026 13:56:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9856103291E2;
	Tue,  3 Nov 2026 14:56:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793714176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IWTHRSzeGW5fpCXVav87N82FYLK03Zsl6ESEIn+XvdQ=;
	b=2WprqqPWwIE4yMtpFdjcdwLq29XhBfaKpiYIEBYic/gByEZ+zv06NYLU+a5QT47FTvvXw0
	B4tzlkM4QQu8XwHRvp5uyInplg8m64tUM32MzDmXxc1a+aFV4DbT2pcUJ3v4gFAwIaOq7H
	JzR7FzHplqg4p53/K9IZCWjljox1SwLknQErThZkivVwvstHC7JSJ2uQFPt8ly3bKLd5F4
	sVwlQIPReYAvCji0ZfBLwqg+zMbCBjkSNf5XAPVZMUgymzjCjGXa1ly4+jnX0up9SKKRMF
	7kI+GWt1lAdr3JBtQ6yrECS1EBVtaExy9TtMr07qQGl9JNBw4WyPJx7Kl17MgA==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 14:56:09 +0100
Message-Id: <DMLMLTKB2QCE.3MTSUFWC3G8WQ@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Julien Panis" <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
 "Francis, Sebin" <sebin.francis@ti.com>, <stable@vger.kernel.org>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, "Jyri Sarha"
 <jyri.sarha@iki.fi>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Nov 3, 2026 at 2:15 PM CET, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
>
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
>
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
>
> Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cle=
anup paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
