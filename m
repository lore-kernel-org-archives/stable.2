Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887A3921D5;
	Wed,  9 Sep 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945340; cv=none; b=MPPSHUcmXye8KHml1FrMEpIZ8WNeVoL23uE4bkKz/A9D0ziRkkF1SI7OeyvTaGqqv6ISk5P5VdM4JtR7etHctPd7XTeGl7l6HeQKXiCrDxKwP+kR5GIetjhr++zvKdQOTaebr5hNq40cfwJtmWVvu4VtzeXcWmyuyfPeUDRX2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945340; c=relaxed/simple;
	bh=Tp545e+vZhGG09eqJxZ3JJ9psJ5PrcqizN1ltjgOeQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TEduEJjiTmQZxKxLnCXTNXxVIKrRyu/n/a4e8ykBZ4RxRRvrBk+ntCAbQntb606lTnphaEzozput7KhyQ31f9rox3A3yUjzS5IS/zd6oJKajftAN2P93U7mR5AWETzy9DQsUdWu/OtHzbMJAxp7x32ijm1R6J1SjlCPkpe5vy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kyvXj7KG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kyvXj7KG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8E0DC4E415A5;
	Wed,  9 Sep 2026 09:15:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 557E060448;
	Wed,  9 Sep 2026 09:15:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62D6711C7AF75;
	Wed,  9 Sep 2026 11:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788945335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Be9teADg7Yx/fENXWg5y5jLFgv5ZSSIpuEqGiq03lCw=;
	b=kyvXj7KG8eWIRinyWnysk6EGxzkgWFKQ0d+sTkM2Mm6daaVeadIMazmqvW6LteYPu4zNUw
	S6v32JXbMU0ZLqTMz7V1UFfzC7u9F2SpzNQ9iYnUwKK5dRnhDOcziOxxg2CBhLZ/f8kW/S
	to86epEqkDEgYJKg2fJ+zlG7HMZl9+c4Lm2YTHlqJf6QLgV7xzSakHiIr7pHk6J+jv/YHP
	OYQZPEuZBTNDO/Og/xAU7kHJ2IVw6OJftF3jdWv+JG4qmyv8OgvrNPqrPR55daKQGuEh/Y
	1MSRO5Uc46+poXDvFYIpcUORqASk5eyc5o+pEy4bei2WdxgWa1UEzQ1Uz12YdQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Leonardo Costa <leoreis.costa@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 tomi.valkeinen@ideasonboard.com, francesco@dolcini.it, 
 leonardo.costa@toradex.com, stable@vger.kernel.org
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags
 via atomic_check
Message-Id: <178894533018.1178686.9521893040126546313.b4-ty@b4>
Date: Wed, 09 Sep 2026 11:15:30 +0200
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


On Mon, 06 Jul 2026 10:24:17 -0300, Leonardo Costa wrote:
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: tc358768: Enforce input bus flags via atomic_check
      commit: ed761e0693950fcb4f6b0f60387a3961b972adf3

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


