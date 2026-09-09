Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA1241CB7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967097; cv=none; b=BUei5nPysPQHmpYUU/sevsxrfqZ9lfdG09UxB0IG2U00E8H/cY47SrFQQ8f3khRPT1K+8cQouorPOTIAu+QnmpBa0SmIKJl40e9RsHfF39H4oz4eOlsOrKqlfhvGD9vRfd8SQOgBOnPrLfJBiDA+DBKx1oMgFFTxM2Cr68VmAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967097; c=relaxed/simple;
	bh=3wuqr9vNRklNGYAqPGea42KPfC57cwb22htpaSCXS3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HKdzwkoBwaH69YQmWWO7vINCPbozsWW81KRRWPkQ2PhnhjPM6O+0r8/hOXy/g8gyY306qwrjalrzdwGuDvfHAzACuKtT+bmvgWs0Mc73cTVHHCrqNtdWghftAcGLvL7yz1U8qfTPgfNtQOkoYDj4m2GqFeftSZuUNEXlKkbUaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q1l8UyG/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q1l8UyG/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0BE921A1A65;
	Wed,  9 Sep 2026 15:18:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7BCF60448;
	Wed,  9 Sep 2026 15:18:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E950E11C7AF57;
	Wed,  9 Sep 2026 17:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788967091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1PCBbAvhCAgCgY+6h0CZ532jsXluV759Iw7EiPk//jc=;
	b=q1l8UyG/4i2A1VqF6jsr24XAGtNTldS2doiPZJVGJC7X/2lsIWTMx1PNu0Ph79uYVyjrl6
	jZDIaZNBtMLurEdYZ278cgt8aHoCU63TtuUD1UWG7OxbOknWxfmw56NheSp2q77PzMzXNB
	+pbU1F+2Rg3J5HTQ/NJvmwE/VWZWAQxH2YgRnAhgOO1e5KrZcR74g8VAVGD4r3gaGuXMuq
	i9f4ye9wZXvwx3FTOXo4+jMyvW90gmfj68KbMCyaYP8+4TmusKmCF2Sjik+y5r96Ka5M/Z
	E3oyzPWc+CCtDmWDi165mXyKnX2h61p3P+xK19+XyUi2U1MzWUheT5VYpjEd9g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, Esben Haabendal <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
Subject: Re: (subset) [PATCH v5 0/2] drm/bridge: ti-sn65dsi83: Various
 fixes
Message-Id: <178896708574.1558311.11016151891645500704.b4-ty@b4>
Date: Wed, 09 Sep 2026 17:18:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3


On Mon, 31 Aug 2026 14:21:31 +0200, Esben Haabendal wrote:
> This small series adds support for using SN65DSI84 in single-link mode with
> output to LVDS channel B, and provides a fix for an error-handling
> regression in sn65dsi83_reset_pipe()/sn65dsi83_reset_work().

Applied, thanks!

[1/2] drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()
      commit: 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


