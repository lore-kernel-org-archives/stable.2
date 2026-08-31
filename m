Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254ED3C0A02
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181161; cv=none; b=Toydze+MvyOqEemrSocj0LLp72+41iPmW0ktGMSd4Nq+6xOpmUV8NDUa7JauaP6pMu1alSs6FQxnD4JFKLxwLjagfbf3phhUlXymb2MIUukhxXWUgTFNGCGMGnsljgIEVY16fdPN5KeUNim4YgKlTbl/I3YKU89V5WLga7Fid/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181161; c=relaxed/simple;
	bh=zVEJj7+DOFqq3G4kfRULfJzpt0z5m/Aci+3/3kIYD6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWC0letUnsuLwdSrsMZoSTM29HPFm2v8nwsBSGC4VWsciBUegKUcQ8L1GPHA3MbxoIb8R7ROQYWRHatGKSsgYGwpWmPMqwdx4C3HGmqojEea6OkmqxdOEEdipHEWqVF8ObgDUkeSlWcjz9w5XS6lB2k+q7Qdo6q34UQTZCLxa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AHXOh1dX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AHXOh1dX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 64DE34E41475;
	Mon, 31 Aug 2026 12:59:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 363C160231;
	Mon, 31 Aug 2026 12:59:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFA6A11C78B96;
	Mon, 31 Aug 2026 14:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788181152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DvoFRyhjcm47mL/nWaDF/hyrkQJFbxdaBV/oadudDZg=;
	b=AHXOh1dXUwQD7BFxAzoGpwkblevqTwsMQhwEnatvi7qExftuK6WWzn3JCrM4VSp26Ja/3V
	07TamZcXjHxysACS4EFW1pnsauqiU9KgM0HKuAX3LdiMyhp5Be3O2yZKE2YhUgm7fgkPmz
	lD5Pfeg9CsiyZBlc+XzqOHvLOV7LuYMP5ruryktxihQwvhgpim/6wDd3z+RU9WAyZRnF/+
	nXfjT/zDW35EdRPTjsWWaHH9x4aXyHpy85Qptk4JicGlYnu2IuBBotx0cCQJhH2Ighl6H9
	1X9m0622sNgz2E+wbsnmaCNHB11qzXUtptONA8sgNq7g5xfU+nnZ3ODle1RAnw==
Date: Mon, 31 Aug 2026 14:59:02 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, Dmitry
 Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Message-ID: <20260831145902.5177d91d@bootlin.com>
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
	<20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

On Mon, 31 Aug 2026 14:21:32 +0200
Esben Haabendal <esben@geanix.com> wrote:

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
> When drm_bridge_enter()/drm_bridge_exit() resource protection was added,
> the drm_bridge_exit() incidentally was always called, which is the correct
> approach. But only because the early exit in sn65dsi83_reset_pipe() was
> never hit because sn65dsi83_reset_pipe() always returns 0.
> 
> In order get back to a situation where enable_irq() is not called on
> sn65dsi83_reset_pipe() failure, which should help protect against irq
> storms, we need to reintroduce a non-zero return value from
> sn65dsi83_reset_pipe() on error, and fix sn65dsi83_reset_work() so that we
> always exit the DRM bridge critical section with drm_bridge_exit().
> 
> [1] commit e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_helper_reset_crtc")
> [2] commit d2e8d1bc840b ("drm/bridge: ti-sn65dsi83: protect device resources on unplug")
> 
> Fixes: e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_helper_reset_crtc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

LGTM.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
