Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5538E121;
	Fri, 17 Jul 2026 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279326; cv=none; b=TihwpeXxNbN5KCWc8SCVgUmUHoEcUVaUzQPjeU5XMDZqAHgHhkXAMMxSUIDpfwcOHcAO3iXb1JJMMylEONnYtKXTQL7tSsegIDZoRljiXl+45XWY47X8DU1fi8SOrTqVAoEOKcfv8bGhqsbBp8C9kWsz1QGcwZZpaqiwe037itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279326; c=relaxed/simple;
	bh=KduvpV+n5nrMeojxiRZ3O+c4wVnEwquVrpeZYegA4vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9tdT/VHjoJ3tc0L+6gg9jmdmb2xG14YT+IhS440HWaMUq+E8ZXZcpzXlZ9Ot8ilpCMIFCDD9+F75v/sDU82rYoJnT+sXrVbO6197YaC7lq/Yt3Ze/D/eUeguc+YsNT7G/ZAL8zhqOKdAWpHtXUxNaJ4PNiYay9cnZCovAvUMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZdv50Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZdv50Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EEA1F00A3A;
	Fri, 17 Jul 2026 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279319;
	bh=bKfzN4EqpiMbnxR9DAJnBuN7lXi1koJJ0p28NYfMO3o=;
	h=From:To:Cc:Subject:Date;
	b=NZdv50DlbHZyuy6BjoPlyaM99G6qYR29gTIr9Gq20rgr6deIlatrV58vnUSN3W1QZ
	 UGuOG1KAl5a/dL8TCkmixyuGLiH6uFaZQTKJBK6N9khEI5HE+tOnh/0vkB96YdQS3l
	 dXzePX/2RfsxvdbAZ/1kEbzjZeolPUEkpi+1dXHDXILtQDe7kFeLg+puo5XL30CcDX
	 E+cPXTAQlmVBDQpXA21RUUPBftOLC9foG+HITCnd0WAT+56DpKVvi7HJ/7mFGf7s6g
	 HYCOlnggoBbJI5aMVjIu1QG4wzlzb4GC493S8JkFTcOKmWJedMS7G1yt+nzLZUcli5
	 JwrodjBjsp9Rw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wkeYe-00000006qIU-1aMZ;
	Fri, 17 Jul 2026 11:08:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure
Date: Fri, 17 Jul 2026 11:08:19 +0200
Message-ID: <20260717090819.1630965-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the i2c adapter device and module references before
returning when detecting a malformed devicetree during probe.

Fixes: 80e2f97968b5 ("drm: bridge: dw-hdmi: Switch to regmap for register access")
Cc: stable@vger.kernel.org	# 4.12
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 17d5caedb32e..9eb6cf8a321f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3389,7 +3389,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			break;
 		default:
 			dev_err(dev, "reg-io-width must be 1 or 4\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_res;
 		}
 
 		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.54.0

