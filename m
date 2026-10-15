Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75252CCF2;
	Thu, 15 Oct 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072480; cv=none; b=co7s90B4F3VKmVCt+zqzlR0DrF9l+BW+yoAgJA1BorqgogZ3XXIJIUpC2M+1iJ+mQPBly010wdJ+WaP8q0l+h5+Qfxo65Bn0Fj6CiSgkBy2xt2xDDKFCD18LWIIE8D66gsOuIsf4UPK6HYl/+M5EUgI3HQfEp6r+KVYOgIG0z80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072480; c=relaxed/simple;
	bh=jcr3hcXF3u3svi3ckB36Neq+4hq8CeUYrsmP3pWsk2U=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Jj+/AUX61WxphZVM45Sf5hqwt3qjQe6zk4Rm4PQVDPEI+cfMjLkt0gJcnuKpClp0Ith2WDPrAh/hc5R5ykROj/LXIycezNSGFwdMtkBLx7vLiEQEeUk5dP7RJZgtbXtxp0lnMo9jbVo64idg9B7Pkd0D8Q5l/gnqrTgYcshXJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EMkA/ZDL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EMkA/ZDL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 59F601A1244;
	Thu, 15 Oct 2026 13:54:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AB1F60360;
	Thu, 15 Oct 2026 13:54:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1975C10328C51;
	Thu, 15 Oct 2026 15:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792072475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=maMH5Fod4vZVX3HmYKZEz0nNC0LYDiozVtyLLS/u0qU=;
	b=EMkA/ZDLeagEDI3ajGhxx4kS3Bx//3J4Kaxy+doHdskSBRQaD+VsZBbNtMnL9HVn8RqXMP
	xXfbJt7B1v+uq2WGXnnYvD0uVRggBgrHmo81bZPqM2bl3tY4DbZWBC3kpCcLEfodGGfViN
	QY/RtJh/d0pbYIsOV7b0+AUlSOtH2L3AqVoBbhwX41CNN0iBYGhDBdzfMurnXS6C/Ua9SV
	mmMFeSu2tN8NWl1YlGP68rqUSKQPMujPK0qvpnCmAI3+XFRczmaQOApmm2xEUvbFvNnN9h
	/IGMxTPGijy+VFYOCch+38ngNy3vwcv7w+8SL1N4NcNfg806+K9gCT5/ITGrFA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND v4 3/4] drm/bridge: nwl-dsi: Correct auto-insert
 EOTP behavior
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20261014-nwl-dsi-fixes-v4-3-b9138ea5e12c@geanix.com>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-3-b9138ea5e12c@geanix.com>
Date: Thu, 15 Oct 2026 15:54:18 +0200
Message-Id: <179207245898.1117464.2418224573274872689.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 14 Oct 2026 09:44:44 +0200, Esben Haabendal <esben@geanix.com> wrote:
> In order to respect the DSI protocol, make sure that auto-insert EOTP is
> enabled according to the NO_EOT_PACKET flag instead of the
> CLOCK_NON_CONTINUOUS flag.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

