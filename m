Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.211.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087842;
	b=c1EMGXVhNR+Ld5y0rzV1G1SCpg42pnYZBjqHt7ZxRP0+BuJynpDFw/DcmvMIFRUOe/SW
	 UWulxlf3vQ65U6vSb/CMy4zZVgEvIPmxHE9DFbG8QHtHPT3gcaYDVNUmqtjVP5tQ1K9S8
	 U8FTqYn9wP/La/CUJJcNfh1dAz1J6Bkd4NF2leEt1Yxn6OaI+n183hVpE2m1n4jh8fI0A
	 xcS0wLZnf597IGTi7sg6bMhRYSzvBP9s66018uFKC5C5YvRB2q+JGFiwpY/ykYkSijuAW
	 iLo4OqbK25nwhOm8CtZ3WlbsneTAOJEP09iuD+DY8pmsEP0URLZC9J8+YllWn1WKtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087842;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YLq833Da6iVYeGdT+KadJJm72vxSoeHnYAbiFsDpxsQ=;
	b=FJh3dCCHGHPpCegov5EkJ5LVQELonnB5ORB85a/ReXazdcJz3DVY3/SzAw6F4ODZE1kY
	 tz4ajGQmwiKd1+gc3Ri3qQuNOon5rGCL4suHRVwCYlpysJH5fojLppTK7vkrSpn6uecto
	 MA2rLPcbdZZKlSClG3j4Yi5ULwBqx+AXCsNK3YL/1h5131gAbbBBKgYuvoV1FAjpbxRvB
	 LeF2FhdqBhdrc6ZfAP92rcrZl6yafkL0m6m34Spw5tou6demLGY3ESjP4pr+G71NJ8YTa
	 oEvDpY9vmEcyNmfK+PD1GhCTKyB9Wvpw5uoRaUCGa4hSRGC061AjBtIRFrVsypNTPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=swemel.ru;
	spf=pass smtp.mailfrom=swemel.ru;
	dkim=pass header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=WdApNlaR;
	arc=none smtp.remote-ip=95.143.211.150
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE813606A320;
	Thu, 19 Nov 2026 11:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE813606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=WdApNlaR
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1795087831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLq833Da6iVYeGdT+KadJJm72vxSoeHnYAbiFsDpxsQ=;
	b=WdApNlaReVWiFHY24zJ4gDKi+BvJ5U13eP9wS2Du8AQcs3H+OddwFwSO2ekqbiQy/Ou4et
	ikzVVHXbdXOsBpTAv2AM3zczklWZTEgROPYgxJOmfPW1fJbItOakXQrGaaNSOZEL/fCCxs
	8/XDogI/TrR4ycseRX0I6sHyW+g8EMU=
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm: imx-dcss: Check return value of drm_mode_config_helper_suspend()
Date: Thu, 19 Nov 2026 14:30:29 +0300
Message-ID: <20261119113031.36945-1-arefev@swemel.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dcss_dev_suspend() ignores the return value of 
drm_mode_config_helper_suspend(). On failure that helper rolls back its
partial work (re-enables fbdev and polling) and leaves
mode_config.suspend_state unset, i.e. the DRM side is not suspended.
Continuing to suspend the context loader and disable the clocks then
leaves the device in an inconsistent state.

Check the return value and propagate the error to the PM core, as the
other DRM drivers calling this helper do.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 45a91e43bab1..0b12ce2498f0 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -253,7 +253,9 @@ static int dcss_dev_suspend(struct device *dev)
 	struct drm_device *ddev = dcss_drv_dev_to_drm(dev);
 	int ret;
 
-	drm_mode_config_helper_suspend(ddev);
+	ret = drm_mode_config_helper_suspend(ddev);
+	if (ret)
+		return ret;
 
 	if (pm_runtime_suspended(dev))
 		return 0;
-- 
2.43.0

