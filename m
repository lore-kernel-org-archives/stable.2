Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711880;
	b=DSWYjLDxEMmou54+mbIkX2ONhIAcpOunimwtGFiVJkJ9QQ42nVnuf+XNDk+cPrxvZa9l
	 68UeYzm2T11YN0mfzNeMdtUiR612bWiWa9fPAc5Od8hXx4GbDIPHp4XdEAupr6P3MeQ4+
	 Jl91gjySszA1V0almM3DdL5SupSgSP5DGR0suLWHtiIPb6WGK656H5sseG41Ir3IGI39r
	 BMmxtSoJ22uVJBsMBZ5MohTSdBJF6xwyGOUEYEOxKfkSPOyEZcdQR4Q3g5+K4B+vcxkKl
	 6yru8lYnVJBLqVM53BY0SKqLzxhRGGIoqw7Yh59iqHLjHg3BWxydbuUGkEFrtGkU+dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711880;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=KmttJ85pE90PdDzWLTROu9/Of3WqCJlijzaY0DqI8Fk=;
	b=Jlg8pvKNVJfyuZTjy+0iyFsnim5B+1gn1EYC2ueXY+0GtMaZrMMaXw+0hUay7ijuD831
	 b08U0OwebEhFBjNuN2VOLWovKPN+GRg9f78yPpdsGMJwSgbUZs9trxLbBC2pPfOiyA+96
	 oWFogGIgBJmfzTlDZW7F+Ruww3Cc9K6xFw8WoX5MzfSgORZ4QiItVJsbobSyomclVQpfG
	 y+5fun4oe0ktcCBIe21jjSCQWda66mJDL/CuGxayC0wkDUHhqrTMC7B7Z1FLTazdXAkH+
	 YDuGIcSilZAvPHN9YWgM9tzdeKg03yfWbA8Wo8DIQOebEbgTNij9geS07mP8SYgaFGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PXvk6PAp;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C276082BC1;
	Tue,  3 Nov 2026 13:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C276082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PXvk6PAp
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87835C8F463;
	Tue,  3 Nov 2026 13:19:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E38866046C;
	Tue,  3 Nov 2026 13:17:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5338103291A0;
	Tue,  3 Nov 2026 14:17:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793711874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KmttJ85pE90PdDzWLTROu9/Of3WqCJlijzaY0DqI8Fk=;
	b=PXvk6PApPG7W6pEWtlWuob97UJQsHqW1FMANL2d3hQbQLED6rseULG94RH19p16BxZmjAO
	niNxyzgUAAbayQb+GBaBI4I2c5sGkzXeY2L0lRA5wb/gwAeO7j311jKR6R7/LSqBS0MwvH
	TTssnqN5+Uu7TEWjx5VE3PdC+lj2D/PVU25ACBDEngaR6h7ZMN/Lp9t4PvwJ4cv97WNnqI
	GBHdNXSaNSCpawOgXpBSgv7D0gWLD7BXCpVSN4oMHSrfUFczlU4W1ASF1oRKHNWZcG/NIw
	8cDHl+PjoPlbvBsxZP/taFrZlV7LypoDgthoQrKtIkSphhd7+4kqKy0v2MFvWw==
Message-ID: <09ee73ca-3ddd-4a09-a5b8-15556e76b8b3@bootlin.com>
Date: Tue, 3 Nov 2026 14:17:47 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/3/26 14:15, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
> 
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
> 
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
> 
> Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cleanup paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

