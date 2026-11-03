Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704966;
	b=rHibYXy9rC7vtB2HoPBfoRETFn/Zgt4YfgAAF+A+Lbbs5tHmpe4wYoEilFhkDFwVDqAR
	 VeQYNmhlUfOb799sEOZmx7NFG1nilV46ro/hJmESkCKjqAlIQxRNQCyylU94lXAJNgTmj
	 BslrJrZyZ31tGta0rSQtqXFxFwXEJXEn/I5wtxu2fDclEA+8AQBvvJC9HB5dVN7tOC8wx
	 sb9BlHzi2R8LyF+S2CZGLs78aNusAz4dlDIOCKG9F4+CkX2ID2ie5jTWjmWUQKTiRH/9x
	 nSWznQa8SF90rOHHgAhOPj7RNoJc5PGENJ5VcnJHMd1kYt3WcadKxtWiOMJXaoW3ErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704966;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Im2hD/3RPp585O4FNz8w013aAEGmolE3drO5PuJAwxI=;
	b=itSo0WJT7Uvp2BnWbeCX/2Cv7L6HHe3qAfp/eYzB28HPEKJx3CKi/n/xgAkeWT9eFEnV
	 KkJ+M46epEdRfq3qi/Gr2Xa/goaRlw+SMDMgR1DNgEZ7Tl+rceiv/HbadRJDanfsKdyf9
	 DDEvGVjDyoPAWur3HvWzyUJEwNtKGQJsWJUohZAgZQr3+Dr0U9myxQBcbDYHPxd3ST9VK
	 6V2f/8bVawiItkgESdEbDnrJxZJBkbQ+QFiSnt0wcKBK9LheL8kcL/cUGyN4FeR5LFdap
	 OlDiQeAImqSpfwfSkPZ7ChZML8dENE5l82ftBKTSb16u5zuUHmOYSklLtb9gxeoIVmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="mpQ/H7qb";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F85606C59C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F85606C59C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mpQ/H7qb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 19638C8F458;
	Tue,  3 Nov 2026 11:23:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 685516046C;
	Tue,  3 Nov 2026 11:22:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9B9810328267;
	Tue,  3 Nov 2026 12:22:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793704951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Im2hD/3RPp585O4FNz8w013aAEGmolE3drO5PuJAwxI=;
	b=mpQ/H7qbmCeJCsVUAv6mUbCuYfblkczMBNsSOQkUfNvgj759C8FjqB4FV+lT4PATF1vIUq
	4gSGLJ7S4Z1H1wvRqHsb06gyBkHzGz7wj+bDgDmcQRQxL2sGXlkc1MQzoRlJzc0Vm+a+jF
	rjEQ0zpOfvj8qLHi8CkxQ4RXb1VnIxD0LlikBV+nmA0Ljnt5KAiJTjxCTOrnigwxkYdp5W
	2MYcQ6l4aAQpcWbPswrjdU1w2f+KW7/ZSvWbRyetHOSdeqBPXSuqMwTMfXn9JVL0sC27ow
	OUPAfqhTxi4k2zVBP86GI1wEXclSlyrSARiuc9aZ9sjKDntfL09dICGY9ZwscA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev, 
 Esben Haabendal <esben@geanix.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Liu Ying <victor.liu@nxp.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
Subject: Re: (subset) [PATCH v5 0/4] drm/bridge: nwl-dsi: Various fixes
Message-Id: <179370494317.651381.10938572686386767972.b4-ty@b4>
Date: Tue, 03 Nov 2026 12:22:23 +0100
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


On Tue, 27 Oct 2026 11:33:48 +0100, Esben Haabendal wrote:
> This series brings a few patches fixing horizontal sync timing, EOTP packet
> behavior and hsync/vsync polarity selection when using DCSS endpoint, as
> well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.
> 
> The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly from
> NXP vendor tree, so I have kept Author unchanged, although I have modified
> the commit message. Let me know if I should change Author for that.
> 
> [...]

Applied, thanks!

[1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      commit: 8dad0ebd822f54102aadc6ca4f0f8777112d175d
[2/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync override
      commit: 54a88d9afcca66221d14f438d0960472984968ec

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


