Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186851;
	b=g1A4cd7P4EgVUe/5rpqfkFf1stEX7O/e/Xzm7HlPnHWPgkLcf3G5Q9N5ru0IlZlRARP7
	 JxCsGi7GBhf8vVhxRqTeu0Ix156klNnhU7kFmE5PjzUep2kXt9BDzp0mCBReOiUxJTXPp
	 gG6rmbfT/g+wflVhzOMR6bXkkZijk8QFuCbxd45Oph2NG35iKVRw1poWO2CC6bdbnT4hi
	 edRrTvgvjKYiOvicymWUgDEJprfule6weO86qUFfJvdxYZicbVIwbndZkDXk3hlS+qSnJ
	 u5zvle+JZM9V3yVTNnJlRAkOtn22qoKRfohz0wUNVuQgtUoQqMdPry6Mxno7tmbz1+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
	b=kAMAhodIUA2p7t4y7mVVPUc4zfCa+U058Scjerwve56h9Q3FxdG/m+3IiNMlsUGYUDq1
	 qBbImT6YQQvWkSXXp/vphVoYG10+KleiVjBET4QqHJiYZHno829fqqGzBWXvt0Vzew18l
	 wY0R+0m+njvf3/vWawqlPoWRy/4/rR/e6U4ikFSVHAcRC8N5c9AQCFe1yKKElGObZLI7J
	 7YPMd2MFmjxqn7BwRltnxrwoDy4RP5IfDS+FOq/evGf/QUs5ZS+x6Un1Td4YsuaDf9atc
	 ZLMS0EBTHMIvdDFChEwWUhZgAMLMmIX89hm+d69ZeR7OKububmt2QBNupFCsAFzPoUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiD8fojx;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CD60A2635
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579CD60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiD8fojx
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so931931a91.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186851; x=1795791651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
        b=TiD8fojx05fpXLGJd9ptfNKTEs7T1NdcBKTFQxZJA32CsSSfGN14cPiJwznki7FzKp
         sYCDFhKNdWYAR4j94D8GcjDNCD3r8lxF7c6NGErd6hf3MVTC4WMkKuYsQt94gqQkhUWr
         MihaNqOWjJWrvDn3GNcuFd/k3TpcDgEwbCcAexgxqFVfPteP1mQto3nS5rTd2nRu7q2i
         vwj5dSKkcafKqAkZ5ZT4xxEyZVhWUG7rFjQnGJhDXSj4eRarZxEVEs4iTAyccpGEboey
         mVjWfAifnh6mriCsuGm7lUCAenCELKxMHueLVQEBhyQFBVkSr48bN1OLLzzzvdHUMILV
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186851; x=1795791651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
        b=Kg5JGwhTDDvPxqUVzPGLEflLuh0yDgjPaeJPFdfX5kH332y/45CITK1iIIytZp7WCN
         DcXA3l5UuzMUXMPq6+jz8m8S+4KyLPHzihFr/w2LPcgH1jfeQz6D7/12d3Z6ues8bmPj
         cBDrFwYETB57mcNSwQjubhCj+0OuQMBzPlqgGBPawPF0OtCRgrSnukriyrWvMZ7mYdS+
         qr6uNQ9CQ2vc1JefseGdvKNCpM/JOcVp1HGcl16mbSXCTC8YH4A9YmbyuacHGjKbSSEg
         TVg8Jh9PySdjErwUEm9748KTaNwAIsK2XFRRr2U+u218r92PY1HwdJYK3ut7vEaMqBSp
         kkMw==
X-Forwarded-Encrypted: i=1; AL+hErHbfmLPcFQT19dykcNa6LJtsVQIJak9crXjYBPOZvWhQXaypysz27HFCJis4x70qkTxXOC42jc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zA1bXFgu0El2eh4UC6Vr8GFR6njofjlD9DoClqajhMj1TlFkw
	k+yvGYKFWbn4bQyF95yMHM9n7+9cqZlQcKXlAVBaYNeD9kmOb0GWFURF
X-Gm-Gg: AZFdTZduxDgigAfvFAa2EtWkz1PbmevRSiq9PuBOLc/Xc1/9ogMK/0t8/ZTIjaTeczN
	fYvdKdPmpT6xh5redzr3Gelf0/lTXOv+7XXDS7G8PC6O9uJsS2lcZSz28LCCxTj/K7rZhGOrbnc
	UOYlsSbei8jfkDl7mTIesPmi3qijk33iWOdihyLQYlVs0lpjtOjiRn8H1yKAFeSFp9fNn63JQCL
	Of696ByiYXbbxUZLGgJwoGCyOi6xR7+MVkTZaXvUd/BYIDDje8Cy/Bxv6LmZBwkhoVR5eILCBGU
	rh5Rn4N5bgB8ILuE2yPhxm2aMlLuUxqFbQGbBq/91othMmNdsc0j3gKo7U7Cx60lPoKu11d5vcg
	CbBcKeWTLaBbPncPfj/eFWDmt4NNd//bi4wigEQfqBxrs9RKuXeLUfCjtFeuXI9h9fClCiQHdBw
	N+SXfpGUvBdcsAF3t23e1yHSkAypnr7jUkl/t0iwKW0Qb9DXUKna7JIy0C4BSbW81XfxzF/wYdB
	6yFFxNpgscLRrLF0L4EUYw4cTK3/2PTPbtKitzGxgpDhbpR0FMLPbmfOaejRdmfrNGQmMGo2vLj
	j0443+o6TdH8gd+FulEKsKL4+QzhUcLtvPxQwm3XVcZbiHMfhO+Epfg+DbwojI7FMmc2
X-Received: by 2002:a17:90b:2688:b0:3b3:cde6:d8c8 with SMTP id 98e67ed59e1d1-3b41c955b9dmr2998636a91.46.1795186850600;
        Fri, 20 Nov 2026 07:00:50 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm7851802a91.12.2026.11.20.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:00:50 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: tda998x: Fix CEC calibration with lazy IRQ disable
Date: Fri, 20 Nov 2026 22:00:04 +0700
Message-Id: <20261120150004.64033-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The CEC oscillator calibration pulses the TDA998x interrupt line low for
10ms through the "nxp,calib" GPIO. Before driving the line,
tda998x_cec_calibration() calls disable_irq() so that gpiolib allows the
GPIO, which is also used as an interrupt, to be switched to an output.

gpiolib only allows that once the interrupt is actually disabled at the
GPIO controller. Since commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable"), disable_irq() is lazy on GPIO controllers that
do not implement .irq_disable, such as gpio-omap: the line is not masked
and gpiolib still considers the interrupt enabled. The direction change
is refused and the calibration pulse is never generated. On a
BeagleBone Black this happens on every boot:

  tda998x 0-0070: found TDA19988
  gpio-537 (nxp,calib): gpiod_direction_output_nonotify: tried to set a GPIO tied to an IRQ as output
  tda9950 0-0034: TDA9950 CEC interface, hardware version 3.3

Set IRQ_DISABLE_UNLAZY for the duration of the calibration so that
disable_irq() masks the line immediately, and clear it again once the
interrupt has been re-enabled.

Tested on a BeagleBone Black without an HDMI sink connected: the error
is gone, the GPIO is back to an input used as an interrupt afterwards,
no spurious interrupts are raised, and rebinding tda9950 repeatedly
reruns the calibration cleanly. CEC communication with a sink was not
tested.

Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 0b966c9844e7..0815ce283f49 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -495,8 +495,16 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 	struct gpio_desc *calib = priv->calib;
 
 	mutex_lock(&priv->edid_mutex);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
+		/*
+		 * The pulse is driven on the IRQ line itself, and gpiolib
+		 * refuses to drive a GPIO whose interrupt is still enabled.
+		 * Make disable_irq() mask the line right away instead of
+		 * lazily, so that the GPIO can be switched to an output.
+		 */
+		irq_set_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
 		disable_irq(priv->hdmi->irq);
+	}
 	gpiod_direction_output(calib, 1);
 	tda998x_cec_set_calibration(priv, true);
 
@@ -508,8 +516,10 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 
 	tda998x_cec_set_calibration(priv, false);
 	gpiod_direction_input(calib);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
 		enable_irq(priv->hdmi->irq);
+		irq_clear_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
+	}
 	mutex_unlock(&priv->edid_mutex);
 }
 
-- 
2.25.1

