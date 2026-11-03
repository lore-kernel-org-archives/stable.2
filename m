Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711757;
	b=ZNwlEhW3n7YAuEc0lyssoQZzZIlzRiDJG78NyAMv5kMpLqk+ie9GKCEv6qb2f0aVQ+4c
	 zideBVpPvADOY9Bqh27/jGen/JVpJEwVhDmeR0/xphVUIoeqM9amR6uHY+ZZfL4o/DJC2
	 ZlV0i69auUw3oawHPk51QY37au908xBkoiJ5wxKbZvhAL5TWh9CizyuXDo9Hz1xS1VRtw
	 aKB1WfxLowALl+v+FU4QmYX3PfCmZ+/I6UaydoURR9jxRLug4N/aMQJzJHHf7HwvN8l3A
	 8EfSf7HNeBNJ5qlMTAXjgmq8hkTq40Anq7ZYK40l9at5f1Tr8N4xXYqCdr1oFBoLQMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=BWdEPnHy9dZO7NwE6/7/FedykeHo/CmP2F0AQ+vkyQM=;
	b=FdKi1worPMm/LZAINf5J5j/DTOmTNugH4mJm0oUkBCsGF4vLgKYtqZKL9xD/84YAl6U+
	 g0Lt/UW8cPjIiKHRK90I6xjqtGmlRfjT/qdCFTbcVkxS2Ya3u0aTORUoBpTxnbBAYxP/1
	 raV1A4JLSU0/MtZ1LzhXbXiOdZffrJRp8W9ZI4weXj6d/q8YIMyH/KBnccVNzrJecFu+r
	 G1FOc3CpTtHxjbV8d3Ixj/kEUFP+tTFiMoLbcd582KmNZT2T4yJRLkz66r/fMV1A7WscC
	 YNQUK72qG/JNjR++i7wHSN9cCC6thPLfUO+Tx+djGD83iMWB/zIOC2jKU4rSxpobRGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JD9hI6Ri;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAC606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EAC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JD9hI6Ri
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso399596f8f.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793711754; x=1794316554; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BWdEPnHy9dZO7NwE6/7/FedykeHo/CmP2F0AQ+vkyQM=;
        b=JD9hI6Ripgap8df4Cb4NutOcdUOHIUxZNM2vazmqOK6QRD5I3L/w837qoapEHlPOie
         ky3hg4x2B4E89YYKBhU953cRSWPfHcXjfv4yc/K1O/hzMhBdtlarm762p5PA8tu/jCVN
         qHzsnJW/yjPVbCBKVFZ2nUTdg9rVzXQ9pYFWrnk6naJ3fMqCZlmaEpJhsHL8rZBYCteh
         PGpGAZ3yU8ndQcfVcnecxUydScdX9Ts5EaZfD/u98iRnviFnczKAVVJ9Ts/LDUBkms9T
         wV9lOpgMdpdMffbD3j1zS5Wh3Q3/NWgMm2DOqNYreOzsXZvSn5lguOy81FuJqEzwMa3l
         XePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711754; x=1794316554;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BWdEPnHy9dZO7NwE6/7/FedykeHo/CmP2F0AQ+vkyQM=;
        b=iaAKFFAS8g6QTP+tU3lAGy/oNSH74hcRGc6rf4lWJA1PsYfM7OVwzU9e87W+N3i+Na
         djfg/LrArcyuqSu29qebP1VVYgcylljIs3ChpHvDFOkE2EVnmV3sMLFq5aX9FVNNL7uq
         fyrFUkeYxmZg8LbNQoceJZsoUISUsToSRQ+ag3L71imUqixM0bCU9UVQB0LK3Q1+3I/2
         D543ab20ZX5IWhaefAugh7E8qSid2wsglDNI90GLTK05amCoQzb0tmEKmL5GBiyMg98N
         Dz6zJHboen8jAOh5Galtck8ICnWI8sy2ROEUFcsCLDUqd+YOME/Ev4f+KPNjggjbgPoc
         D1+g==
X-Forwarded-Encrypted: i=1; AKwUvBxQ/bh3ODnjrjc93Un2wosEj6y81WFHBoGjxnl8S05nmfQKTTB9l5rrrjIfPTli4gWxubZ1Uxg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d7quTjafpDtA02eliAQYij8voizQOFgBxWsOYfTjh00LRQZXo
	Ny+7K0Ilo0DohYg6vzUOidG16oTFZR/GN7cGBF+/oF55ca5hAeG35oQVpK7+BbTl0GM=
X-Gm-Gg: AYBFou1YMqFTI+AAfqvspHAf1w29OO2zPBCSykRIJuGcLQLVVng9Xdsp7TGj2tl2kNk
	FeTzkgmJNrmPgL8ZS0sjqMBibmcZY4ZchutpWBaDfKMcGZKbrR5jMnehC+1JEnH5j4aGbrz7pmr
	cTYWGwox6LIP7jdKTpV51odVXUO+STYsyt6h3Sqg9iL8YP3RGFed8H43k8rVyljVLXSnsVcR5oe
	HRlVHA9qD67wQp8/d4LefiHELJA3FPkj1omGU8xsRgjoplvncFfyMVaQFaTHiONnVmTfqznowZF
	rlD2ExBIeosUXqLVONw0aSGkKlY0X+ao/WG4llLhK9rpdqDay/t0nQhZrUA5ji+W8xB79sLlHwA
	z2WATWlySZYIlBLbLdLMuIX0YZ6valFC5ZkFxhdAtpYrK/di7kOeM6FvMFmBNhxE6NYNLd13D6c
	OSA4klKnLb5C0EIqgZx9vS5bkK649PClMovhcXO0A26VnUhB1zOCV10sci3tZzKhB050R8UI8H5
	cNZK53xIvfrT18fZP9m6ZfsDn6Wh/C+XZxG5gVB1CCZgGyIDBP6PJx9+2FFCH2TXyEPWW6iFsaA
	u41TA1o6CV/SIC2oLfswKUAL/g==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr300804355e9.14.1793711754256;
        Tue, 03 Nov 2026 05:15:54 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm302570825e9.0.2026.11.03.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:15:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 14:15:33 +0100
Subject: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHTe6WoC/yXMSw6CMBAA0KuQWTtJhwokXMW4aIdRhvBp2kpMC
 He36vJt3gFJokqCvjogyq5Jt7WALhXw6NanoA7FUJu6JTIW9w6vmLegjG6xtpnDgllnHhgtGSf
 cNcaThxKEKA99//Lb/e/08pNw/o5wnh/uGgtCfgAAAA==
X-Change-ID: 20261103-v7-4-topic-am335lpm-tilcdc-310aec750b1b
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=msp@baylibre.com;
 h=from:subject:message-id; bh=83Ua03s8JK3zkD/3szPivy67tq5SBAM04PktMYX0mbY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX9xqFJ7iX3VgVUBV8RdD3RAGDhS5/5rsnW2t//K2za
 Q8N063uKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIlYbmP4H/GoRuDCwnfbfqx/
 qN1ovHxFEM+kH94x39Jtfef67WDat5jhf9D5o9odOyWnav9+navh7sz4MelE8d/K6Zq3qlrvVtn
 EMAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

drvdata contains a pointer to a struct tilcdc_drm_private and not a
pointer to a struct drm_device anymore.

Note that this breaks suspend/resume at the moment, it hangs on
acquiring a mutex.

Interpret drvdata correctly as struct tilcdc_drm_private as is done in
the rest of the driver.

Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cleanup paths")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..e82cb2686c5f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -235,7 +235,8 @@ static const struct drm_driver tilcdc_driver = {
 
 static int tilcdc_pm_suspend(struct device *dev)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct tilcdc_drm_private *priv = dev_get_drvdata(dev);
+	struct drm_device *ddev = &priv->ddev;
 	int ret = 0;
 
 	ret = drm_mode_config_helper_suspend(ddev);
@@ -248,7 +249,8 @@ static int tilcdc_pm_suspend(struct device *dev)
 
 static int tilcdc_pm_resume(struct device *dev)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct tilcdc_drm_private *priv = dev_get_drvdata(dev);
+	struct drm_device *ddev = &priv->ddev;
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(dev);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-v7-4-topic-am335lpm-tilcdc-310aec750b1b

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

