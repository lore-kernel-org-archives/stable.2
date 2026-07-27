Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CC4156EF
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158146; cv=none; b=Gq9beQm8i0fU36AwzD1QMW18zha+/grkAEE/nSjs/bhPX0g/5BQUs1ZiDpCor8TW156e8wkatIv/83NbXA6rfM6K4ebJnHG+BTQf2TD+lt3TkuUpG1UD7FhYM/nF+Exj9M+F/mCKA5M/Jxumzy4VsKM85g0r+0XU6O2Ed64Z8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158146; c=relaxed/simple;
	bh=HJHRiVCoSpzMM+AzL9YdHPDdjfH5DZvvT/nmLNqxqHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GHYzOuJGvNSej2MKTXmafGoJjcOq2SY6QA1s9NVylZViWUy6PZqY5hNwHoMcSW2QXgra1szw/R13cmn2b68R0rEV/P5LpXwIM5aT5Z+226s8XzV7nSiwEa8nXVdkHfaHVsCAmicG86H9aVUcZl/ABc07C7luY9EVeRu8nvo925g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wgiPxlvt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wgiPxlvt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 040104E40F96;
	Mon, 27 Jul 2026 13:15:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3DDE601BE;
	Mon, 27 Jul 2026 13:15:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E843311C133D3;
	Mon, 27 Jul 2026 15:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785158141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+AKAgk1c4hfgPjkvF/RWXS6gIzcWVrFw3/oAzOXLFfk=;
	b=wgiPxlvtxim1VfeqOC+3oO9tBUgXutTBv9ehZB4EwoPNH1S4B7ETjmGDNL4GXvGUJudPQl
	oxreFJZ7IuhICzZtokp/GJlZPXVfuvx1hzJ2gXEYDC/4OmelpHWqBSTVMrROlQX7kTAR+x
	uSAcj3z0q+QNHn2Z3iJzhb9C6RCWCt0q9Qhjjm/WMlsxVnDS2kofjKEnk6SCWi7hBnloOH
	A6vjTtFeDfMRO4nv4Pxe1eA61d2/n0lI2cPoLQc5MeWF778sJWyGkZmylF13n+6d66QX1E
	/e1tTQSIHRhsIy6Bk9qeJ+ViUAhIWc+EPOSNPp+FRVvgnUPe2cYi/Fs1YoJ8aA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Johan Hovold <johan@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Message-Id: <178515813651.1048304.12416793429567874295.b4-ty@b4>
Date: Mon, 27 Jul 2026 15:15:36 +0200
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


On Fri, 17 Jul 2026 21:48:36 +0300, Laurent Pinchart wrote:
> If the probe function returns an error after getting the I2C adapter for
> DDC, the reference to the adapter is never released. Fix it by releasing
> it in the bridge .destroy() handler.
> 
> There is no need to test the ddc pointer with !IS_ERR(), as
> of_get_i2c_adapter_by_node() returns NULL on error.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: display-connector: Fix I2C adapter resource leak
      commit: 6a39ca1286dd97ad02bb8e03bbb65ee05368d778

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


