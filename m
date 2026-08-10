Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D5403B0C;
	Mon, 10 Aug 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374152; cv=none; b=HiZjRnlyGZOiVTGYbQOo7wZNURqqZbr2tszkXl1xH1wtqWV+5CC20wibvc49wKCmPENZSGge2iIwp90zyqNOTdlRYbstAG36feDAOhz407woUiwyvxNcx9AHRN3SuqSWJrUAVZ6BDw2OzCZ4E4XL8pz4xEvJJSp9jRIspcMTGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374152; c=relaxed/simple;
	bh=Xo+MtyrhDJeUQ+osx92Xu0boszlkKFQZOj6gEpl3I/k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=R2AM42qx01F3Q64dSVJe3OqQ74OGTB2CyJZAjFQeBj36tTPHkQmMwfS6HcLNhyZjcsPWDO5TdqOXxEdYnS1UK2l2YgwKvJ03ZP+qKjd6CUdmcNXXevJpLARcdQvBTONaUL0djz9FPAjrm5DXBDI28zoVo+93B81N6ziFzRDkrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=09VnhXm9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="09VnhXm9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A807B1A1533;
	Mon, 10 Aug 2026 15:02:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78E7F6033B;
	Mon, 10 Aug 2026 15:02:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBDCC11C4A2BB;
	Mon, 10 Aug 2026 17:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786374142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vPx/CSmFWLjnP30xYUbjzFg3pWTp1Fm1YlnbTUiE0Ow=;
	b=09VnhXm9SFU9Dh7H28A1coyWfChNFyUYIxoslpUv30ADfVw3t64c4O0N1D/P+JzNeGSi0U
	ovcHQhks3Sqi8yYck/IlAOjrn1ZQf4m8fXbuKPh96UFOUH3P/DQEmanu1b66jlyMi9LlQx
	w2I5ro4U3M38v3xn8Rzs0AIIhWXCi/pLyjJYkderNbkP6r3sQc9JPtTSaoE2TXHmX7k3zu
	ZxxVqCUyLTRq/hgsA+vrZ4MQ/ZpmPxs5PflfO1WtY5wkuj1/qUMuSfG93kXWs+Rds9HbBr
	GRqrknwCLXiWXHd6ro8qP1MxvjmfzZ5ZF/gTUybD3n2nC/QTf8QAV4gokgzM9w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] drm/bridge: nwl-dsi: Cleanup endpoint mux
 control selection
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260810-nwl-dsi-fixes-v3-1-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
 <20260810-nwl-dsi-fixes-v3-1-256da9d672e1@geanix.com>
Date: Mon, 10 Aug 2026 17:02:04 +0200
Message-Id: <178637412471.64950.2732024404338956267.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 10 Aug 2026 09:14:37 +0200, Esben Haabendal <esben@geanix.com> wrote:
> Using the endpoint define values makes it more clear that the argument to
> mux_control_try_select() must be valid state integers, and not something
> that looks like a boolean.
> 
> The endpoint value is kept, as it will be used in a following patch that
> changes behavior slightly based on which endpoint is selected.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

