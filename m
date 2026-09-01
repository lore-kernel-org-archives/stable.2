Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFD3A9DA3;
	Tue,  1 Sep 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256112; cv=none; b=TDpJIw3xq7GEI2XDxAR1GRLPAbq3FyJxpzkQ00wu7JZHr+eG/6KPnZDRjlvHUuc6fIESKUttQCYT9cEbAypOERiwVMFwjmHnVwUT0Kks9UDj8cBTY0vrkofPC6pzANWbi/9CLx58vVsI/8MI2Yb/1vGbf6LadhHE9hMm0eHCIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256112; c=relaxed/simple;
	bh=zCaVx+noSQIufB6b3Syv7dBaChvR25RRoHwo1evmOc8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=S0E7/RK6/xyurpoAEyzzRaeNBOw104IHo6MW/XlIuG6+JlkwDRKRnVLq2jfM3ybQCF1miUGUDibvwPRmF4fHHr+kqGgTzzbbfdfEfIquyGRCF6kS2oldRlAiHs4IJ3mwR1Ul7w2XAqBBUqIvoQamxUpXcedZlRsnUN2sEyMunXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ymSFr5qq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ymSFr5qq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DEC811A1931;
	Tue,  1 Sep 2026 09:48:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A68976053C;
	Tue,  1 Sep 2026 09:48:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FD3611C7925B;
	Tue,  1 Sep 2026 11:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788256105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=95mEIBuy7z2wnWxzkNx9JJx0GxackAytcnMN6Df3vCc=;
	b=ymSFr5qqggE8n9GgQNHyVvfxYKJFYBxmRFihxkph58XTPfkkb9UVvsyfpASeY2sTWOuwsx
	VuDbzeHSe+yFvHkKwx8mwO6nJqqytc4fXq63QcHSQQFjrM8o7ZEIIpVsnwssq/tuTmagsy
	5zSoVeJUGQNQpiqgZLLJu87SZlwHJ285fRZYOTVWmTblW1jL9zJQGfjn+h1ecWw2LXlMiz
	x1/LDKzAhleT49OPdPg7dk+0Oudu4dFzfbYNVDKLGVqDfQJf2ZSoAjOhhUrs7KwCVtbh7N
	KiNGsBOrca+XZZd3+tlrPlxp6OVPLZINGxr2/TCBqZSrU1AQiX3YZSF/kwHHeg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
 <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
Date: Tue, 01 Sep 2026 11:48:16 +0200
Message-Id: <178825609646.149491.2880661575829864139.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 31 Aug 2026 14:21:32 +0200, Esben Haabendal <esben@geanix.com> wrote:
> The error handling of sn65dsi83_reset_pipe() in sn65dsi83_reset_work() has
> seen a couple of changes that seems to cause a bit of confusion.
> 
> While sn65dsi83_reset_work() has implemented an early exit if
> sn65dsi83_reset_pipe() fails since it was added, when a commit from Maxime
> Ripard switched to use drm_bridge_helper_reset_crtc() [1] the
> sn65dsi83_reset_pipe() function would no longer return an error code, so
> the early exit was then a no-op, and even on sn65dsi83_reset_pipe()
> failure, enable_irq() has been called.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

