Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705524;
	b=YXMvJ+OG+HTGxV5mZeUwtPo+I+e0wl/63rU4666PzLbZLapZk0NwB5gPwu6y9ENlUFX0
	 Nt/hMJBFiTinkXkkbkym/2z3t16JvLuX3CnkgFjr4rExV96+wRtRUkjhCkNztu1tKxve9
	 puYaLt901/d9yvVU+y7Q4M95IFRSFEeZclXo9mC+oiYZX61vJo/V4oK58iZlGEctOPoPm
	 +18KnAhBt7MmUBcdfK7PwwoZiMV1hPJhA2+MVB3yenPku19+CbMwD7HPCSDQKRYQtCaOQ
	 2mJEG6N/yP72CIqEtkGZ2jAo17iJLzz+gIwHezzJL6MiytIW7J2Ec4IQUbpOab+41cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705524;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=7GRooN83x6ErSEZ7eQlsuClOyGITM5JI8kEIIsp5Uws=;
	b=Mh4K6D+bUw2LlF7VwkmokZngxlwX6h4+eCvzmSJicYSmqaGDcF8s5yCz4UZco12JElqJ
	 xqIdYM6aTcxzdRQkF0vC8SkUUvR6/NLifWVm3YAVDn5PbPMre2vZQWpu7bCE5Q6c0848B
	 2Bxgun8M+SgqzbKDJ/1GV0H8I3lxhDzMOlbMAZRaBNIwSSB/a8v52TcmWWAm0UlnQ2CwK
	 HPTqhkGyPab882ltDhzbVE9zRqSalXdXQNcuMAFsDfkQ4/Bf9KdPOYVT+18E3HatLWphC
	 JDKijMAit3vENU9e1UVv/xkkwc0nsHu4OMp6CN9hnU3Jc1vdIrSJz/RBIAvGM4jj2Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MiijHqWN;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA75606A828
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA75606A828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MiijHqWN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4A7131A1430;
	Tue,  3 Nov 2026 11:32:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 009816046C;
	Tue,  3 Nov 2026 11:32:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07D28103291C2;
	Tue,  3 Nov 2026 12:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793705518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7GRooN83x6ErSEZ7eQlsuClOyGITM5JI8kEIIsp5Uws=;
	b=MiijHqWNjmPtcaT8Mf1Kow0VIwehEQcAdcTAs/LazBXh/jPLgJZRoltImdyXMMcMcubQ7X
	9qYDQPMDci3n8J6dIyWh+YZvrvg8PyxYmVmQ+HLltmrNcJj0h66i9j/ZyZJdoxU7l4MbO7
	khAFSdDhHQPb0spJn0euVAphvRrRRXvp2aH6RItyRKHOz5hA/qmqHR5WGdF830y+MlG5bh
	wrRGcQ/q8vPovizKeldkWq2X/nKXlGa2GgYchfuBlSPMwDnAV0/cglzG7W23N64+hjSiVV
	in2IkrAttpBdP2kYAhFvw6aNLDITULCtS7r5iIjDyHhtWNf9bR2QBfVjTIFu6g==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 12:31:49 +0100
Message-Id: <DMLJJB5I34LD.2E1BV057SDSIZ@bootlin.com>
Subject: Re: [PATCH v5 0/4] drm/bridge: nwl-dsi: Various fixes
Cc: <Frank.Li@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Laurentiu Palcu"
 <laurentiu.palcu@oss.nxp.com>, "Oliver F. Brown"
 <oliver.brown@oss.nxp.com>, "Sebastian Krzyszkowiak"
 <sebastian.krzyszkowiak@puri.sm>, "Liu Ying" <victor.liu@nxp.com>
To: "Esben Haabendal" <esben@geanix.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, "Fabio Estevam"
 <festevam@gmail.com>, "Robert Chiras" <robert.chiras@nxp.com>, "Sam
 Ravnborg" <sam@ravnborg.org>, <imx@lists.linux.dev>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Esben, Robert,

On Tue Oct 27, 2026 at 11:33 AM CET, Esben Haabendal wrote:
> This series brings a few patches fixing horizontal sync timing, EOTP pack=
et
> behavior and hsync/vsync polarity selection when using DCSS endpoint, as
> well as a small fix to properly handle if/when nwl_dsi_mode_set() fails.
>
> The 3rd commit ("Correct auto-insert EOTP behavior") is taken directly fr=
om
> NXP vendor tree, so I have kept Author unchanged, although I have modifie=
d
> the commit message. Let me know if I should change Author for that.

I applied patches 1 and 2, but dim [0] reports a fatal error about patch 3:

  dim: 72e5001e5c2b ("drm/bridge: nwl-dsi: Correct auto-insert EOTP behavio=
r"): author Signed-off-by missing.

[0] https://gitlab.freedesktop.org/drm/maintainer-tools/-/blob/master/dim?r=
ef_type=3Dheads#L1071-1075

@Robert, I think it's up to you to agree on having a SoB line in this
patch.

@Esben, can you help sorting this out? Also can you provide an URL of the
original patch 3 in the vendor tree?

Luca

> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
> Changes in v5:
> - Add fixes tag.
> - Sort header files alphabetically.
> - Fixed speling mistake.

Funny typo here :-)

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
