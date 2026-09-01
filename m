Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C9351C35;
	Tue,  1 Sep 2026 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264358; cv=none; b=XhzvJjCER16ojKpCnOO+a0i2Xk9WDFzP3Ipou0VrO/CS+4x4awH2jxu5OugJJn01mQP/nBiYEQO4twJbORl/OnItJIBTG8bMTc/sQuMuhE86osS4uMa33xH2sKNo7seDEpBAwCJgYWHRfQwjDGy7Ctxyoj51Cm3IhAcA6fH0DfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264358; c=relaxed/simple;
	bh=hqNsVyT1ce7UltfNhnjqKRw5Iucodxcv/GM2+qbA55Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=n1dRMl/SbTK+Gmy3YLjI5rL5LbTp+vWhjlJoITWD+egF4IDK3GEHrXTV2Y5i5pea8dBYJm3BWO24gNkaLntPGr9i0D8zeYM+o9RreGsrAd3xm/6WYigqx9SK1oH1KKAgEHta4xKwnIzzD7vmC4mCG9HFJ6ejeCNYfBMEaVHdZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pILYdDDJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pILYdDDJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 932C71A1936;
	Tue,  1 Sep 2026 12:05:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54A066053C;
	Tue,  1 Sep 2026 12:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AE3011C7927C;
	Tue,  1 Sep 2026 14:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788264350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hqNsVyT1ce7UltfNhnjqKRw5Iucodxcv/GM2+qbA55Y=;
	b=pILYdDDJ9NJLKEaRlnHOrJRIjiq2y/DqOSpuUMRUxO9AS8gEXDo+vmeApCz9gdj/u7lek4
	Hs4SF5XZfTZhtC3nRu8LunOCnj+jcfi7YbiSi9De+x8c+dlvRecPN97CbTq+QbMfQ93y2t
	MIqxUYI3Cvm8JuNqGEAX1JDebtoXviZiNuNXR6qR7BBiCQrV592G8sHFyk7oOSSIRcZ8iW
	j3D5/peM6vN2f7E6/mtenfdj/eUqwqQiaAHYX4W/eTJgs4v5b0MmDl6XjitfXYAtZlitAd
	K+gAUydfYfj3r4behEUTtC/qiS6La2YV6X7B23JTfUR9FN6tE0Gvyl/LlZHcwQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 14:05:43 +0200
Message-Id: <DL3YSY212CKG.67P3E3DZT0CI@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Herve Codina" <herve.codina@bootlin.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Linus
 Walleij" <linusw@kernel.org>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Marek Vasut" <marex@denx.de>, "Dmitry
 Baryshkov" <lumag@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
 <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

On Mon Aug 31, 2026 at 2:21 PM CEST, Esben Haabendal wrote:
> The error handling of sn65dsi83_reset_pipe() in sn65dsi83_reset_work() ha=
s
> seen a couple of changes that seems to cause a bit of confusion.
>
> While sn65dsi83_reset_work() has implemented an early exit if
> sn65dsi83_reset_pipe() fails since it was added, when a commit from Maxim=
e
> Ripard switched to use drm_bridge_helper_reset_crtc() [1] the
> sn65dsi83_reset_pipe() function would no longer return an error code, so
> the early exit was then a no-op, and even on sn65dsi83_reset_pipe()
> failure, enable_irq() has been called.
>
> When drm_bridge_enter()/drm_bridge_exit() resource protection was added,
> the drm_bridge_exit() incidentally was always called, which is the correc=
t
> approach. But only because the early exit in sn65dsi83_reset_pipe() was
> never hit because sn65dsi83_reset_pipe() always returns 0.
>
> In order get back to a situation where enable_irq() is not called on
> sn65dsi83_reset_pipe() failure, which should help protect against irq
> storms, we need to reintroduce a non-zero return value from
> sn65dsi83_reset_pipe() on error, and fix sn65dsi83_reset_work() so that w=
e
> always exit the DRM bridge critical section with drm_bridge_exit().
>
> [1] commit e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_=
helper_reset_crtc")
> [2] commit d2e8d1bc840b ("drm/bridge: ti-sn65dsi83: protect device resour=
ces on unplug")
>
> Fixes: e17fadff7ab9 ("drm/bridge: ti-sn65dsi83: Switch to drm_bridge_help=
er_reset_crtc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Thanks for having sorted out this complicated situation!

Now all patches are approved, so I'll apply them next week if all goes
well. Being one fix and one feature thay'll have to go to different
branches: drm-misc-fixes and drm-misc-next respectively. As I see it, the
two patches are orthogonal, so that shouldn't be a problem.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
