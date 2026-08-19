Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024944E647;
	Wed, 19 Aug 2026 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140325; cv=none; b=hQEPdD+836UavRZ2F3yPT7KHlSXS8XYFBnjNXNYftHE0wYY+j7NBn3s73vPk5NTKt3ilYfWALOx8uuAl2a9aT7fBKZNP5G8M5qZJdeB3aBbleVkCUt0uu9I6nfBPipkMpg93ioeT8AS3Y42OEp+NgROm3VNoxOUicr0ZSYRyFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140325; c=relaxed/simple;
	bh=4BQ8Rem1GcCr2m6cvd19kMnhjAigiWRdwEsPLjXw2BE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VlG7XDzgMCGJtkVAdAtgm/m0Ye7i69dJqqvsmoJEg2RbpIp/t6MI5qa0iohhPTJuI3zSK4CrHIrjaCnn4UF4dQCbg/2OKYAY9SbHdvktTerr8OR/xWPQtsFm3Ywb1IFR1lba5h570rVK7Dh2ZDAi5yLXsAKir5EPQvLprbPoNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JQ/5QVO7; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JQ/5QVO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787140277; x=1787745077; i=markus.elfring@web.de;
	bh=l/PD7ycGWQX9RJMDP4B4h5fye1wKofoRoqVvFLSbUxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JQ/5QVO7fvYgruAYo5I3X7zhd6KppqGKs93BWUL4MrlSn60r9X1chuZs5Wg2HJ5U
	 Ee7oIBGS0SDcgFArdFacQreQ3wOGrFfzA+atNhTiAYODjebrSK1cowZMfqcrMbRiR
	 YOecLSZTK9lT9Z94k9ZHsP9q2lyJ2jeHCPsQq9F+35e5Rf9awpOkC9V8kqLKJMrkO
	 GEprk90+D1tn6ZXTdb9wBpeAQM5bx+koW8Flz+CzGzmfyy/9dA7cH5shdMH9haY2/
	 0EYJTUKfNq63ECD7XSRy0jfB1GRUXBgsTJ6JsR3Ax240sgRTzHabEh+LWhk0yU4JQ
	 wX8D2yKw7N5+y5g7cQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1wsl311MNG-00zv1q; Wed, 19
 Aug 2026 13:51:17 +0200
Message-ID: <2f0fef87-4377-4a01-a210-8d55a0b67a9e@web.de>
Date: Wed, 19 Aug 2026 13:51:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Herve Codina <herve.codina@bootlin.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Walleij <linusw@kernel.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PqbSmZAfU2hsJ4P7RDmAn//XVb22JwjD/vYLhZruAxrMrwVJEEM
 PHfJSypAYz7kQR25P5mrlop6f2B12u6ZXOtqT5QFKhLJX7hvWD9z3543VgeWkspt3ypl4S3
 ywJcFQ1VwYrUraQsj5hKAXlKUrkqQpkGMGzxUybu3DQTqkP1GM58r8R3KNjSjty0OqPRxy/
 vkvh5SFp2eyKpoJDcEXWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hWHvWYUhDK4=;mKS43rjdYauiIRKWRx4lwhOhIPA
 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
 =

> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.

          have got?

Regards,
Markus
