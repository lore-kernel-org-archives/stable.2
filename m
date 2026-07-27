Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA23F0765;
	Mon, 27 Jul 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155200; cv=none; b=SpjHTgIsl/fG5x1ygDrMYMEdpQ6XoEAnZPQEe8gfMpLQxGRCm7mgWxwMX49l7wJC2Z52lD8cZABp/1lI0cyT56zUtxQDcKxxlnZT4iO5Q9LM3AS6SlqnuvBClinOsKh1QXZ1omMvsN/Q+2exoVmu2u1i7HPgxRK+dpLMh7kxz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155200; c=relaxed/simple;
	bh=62mgVsJ2dYNrHLIGJ9kWmnuEcPoeuF3rfWB46ScPy3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p3ginY0Aaq8Krpq7qqRgH/YeMlaFmRWOIEUXrJ3xaTSPzOeAcyDlhj0xfVmiJTaga5hhyj0EmjQCEaiVTvCzc14/nb+7ewEHIgEoFNsPGnH2VDOC54Iu/lMptcL8tiKBjazJ2jIj5wyGEvMvJp4ID01AKpOwkT0iipMZt5xA62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oh00JIb+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oh00JIb+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 24CE91A128F;
	Mon, 27 Jul 2026 12:26:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8F84601BE;
	Mon, 27 Jul 2026 12:26:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0636411C1330A;
	Mon, 27 Jul 2026 14:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785155189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GUZiHDzoHCdjvlSjxmdvUu+FeJFcDfBAY6V5zWDXZXY=;
	b=oh00JIb+NRl9yOum0Tuy1s8nyIeOd5gtINnHw/OJ4jr9rRiipIN8Vd08Q6y2Xk8w6OXOxP
	J7M76i6zqzkFUBFL0iBibAQWjIL9T/IgPHwQ1zfpRPS2QENgS/h5p3xSuCMABlbHa67mad
	rt1uiD66e7HheiBjecIkhiglqbNDUF7eGC7HHDO4LVxh5fjqkgHlghFlYVSLPr29/om1mv
	Hnr7nahF+X6qmIxd1OVGUUcl9E6I7InrWUDW9ucrEMBDDgJgKxeWxG84/MLkADDVRJazfd
	zLCq81GJ/Pnxy0truWlE7N/yOAFgBbfi2vPP4S41w1BTxHveNakPGGE/TMJRPw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Johan Hovold <johan@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260717090819.1630965-1-johan@kernel.org>
References: <20260717090819.1630965-1-johan@kernel.org>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix i2c adapter leak on probe
 failure
Message-Id: <178515518380.953715.923452681644592637.b4-ty@b4>
Date: Mon, 27 Jul 2026 14:26:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3


On Fri, 17 Jul 2026 11:08:19 +0200, Johan Hovold wrote:
> Make sure to drop the i2c adapter device and module references before
> returning when detecting a malformed devicetree during probe.

Applied, thanks!

[1/1] drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
      commit: 09b195a7bb23df56269cd2a95d01ba3a5533af13

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


