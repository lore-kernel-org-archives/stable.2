Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB337A840;
	Mon, 10 Aug 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346393; cv=none; b=FvRSggRSlJyUOwY/dgRYuuw2g64KI+kTe+yRrmV88rImEtmsUnNbYXPO2cLugoAKmwrNBN3lLhDTnSu+TB5Fq+TybBg+awsPE5ZHxcfiZnjM3LkklDD8mhvwEZOz/CGzjkDUozwj+EjHn/VDid7piJPoxv757LWniNm30nfyfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346393; c=relaxed/simple;
	bh=ADbcip/7+ws/P910Sgn2HvCEM8tB4gXcTCDY2lBAYnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtjgnP+ET6SdwxxqfoxFxxKt16FSA+/dmpDRmuRFzNTSke+U+aBv69EryjKRSY1UTxtkEK2s5x6ie+CC2EhSkZbMQ104RY/LJEewffgWVi7UrZZNBoj0z5p3kbe7A8jvcp4z1n+KCNZSO25YAaQUil6kp9pblyx9nG5bz4hcx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=U3N7n9l5; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="U3N7n9l5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786346389; x=1786605589;
	bh=ZJSCfXp3hcwIl+jbWgDlNmbsCfx+Kvs7P3NKbUEI0gg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=U3N7n9l591S9trMRfqQ8/wyBQ+NDJpCKZFLrUn/+dBiRFlhpia5LeC3YhlE6N7skq
	 A1zyhG+GnxLFTaZBpdtAftAblnLFEwQY8RzcN6RiNVsh11HOlqkywj47e+MPqZt3Ck
	 HyhAmN+iTOQREYdQ1sKAcqnCOQVQM5fIG1zvL+RRsXRV3bxXLhOhwjAgsWZ4o05apk
	 TDwFAvLD9K4S3QRiyp0dBkVw9LgOqwVyQdLTotjcCkMfU+MD2sjdAbxD8YyVOsxgGA
	 iaiDETAvAuO7jgFRWYCHi5141zEXmCp2z8vLGazoYWSK1DUP5U+dPIjaoL+WvDIAje
	 7ZBC9na40S54Q==
X-Pm-Submission-Id: 4hJR365Wxrz2ScNb
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:19:41 +0200
Subject: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346382; l=975;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ADbcip/7+ws/P910Sgn2HvCEM8tB4gXcTCDY2lBAYnQ=;
 b=t9VdwYSBeo0Zyjs1jvJ28ES768Rf5d4vyTyfpV1720IcKxNymqvXUUNzCBBTCwPVDaufHUtUI
 dIR1PsMOxDHDmeZAWkjlb7wmhPhD/jDb+UQVWN8PPiol0CBaryS//AX
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Propagate the error code from drm_bridge_helper_reset_crtc(), so that
callers has a chance to handle the failure.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 0ccfff401b2a..475224c5a5d8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return err;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)

-- 
2.55.0

