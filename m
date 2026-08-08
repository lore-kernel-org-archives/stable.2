Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CD3E49EA
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191884; cv=none; b=nPesUPa40Fm9qcczILdOL4nj8fiHLUMiLs0LxjX88PKISg1g/+ej+ufjZ1havp+bb5/2wxeOnSmX1Y9telEq7QIZyPFmPLheHT4mGeMj7WTYXagkTqaUUxavWFOlsULHCv+Wb555Je82Iv7iEFxztS5ScP3RxFYiGOL4WZf+PM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191884; c=relaxed/simple;
	bh=lELpf8Qvj2JHXzcPUsvF7tjmAK7XFrjheBsIKKvTWTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/KfoUtnX8dL7gLttmojR8dbw0YA3vFsBfMVtp5GIPOq3NUBjto9MGtb6EKEdIKQLiMrT+DsNzK+N9GA4LetotSEsS7WcoGOUlv3Rz4AOBiZ70o/m97nHWKySAtsMweEe9BZU2b+B3A6+fH07HJMZnIuw0MJkxXhSZ9Qd5B8eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY8g0Bq8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY8g0Bq8"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso355844a12.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786191882; x=1786796682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5h/jAHWXWXDOWdVoAFfHtjsJVJE0oZMUnASj9to5Sqc=;
        b=aY8g0Bq8uBRCvzrB1/UYz3aQsgbvdqzz1T+Czh8x1IcUg30rd5t3nSgDiKy45fKZ8N
         UF0aqsTtSdLlcJdMLyKfwZ1Sumi/aerZ0ju5aZ44yGsakFdSAuOGI7IsnZ+mHSD71vvl
         Rpk1W06AZIqk35WgLY0U4gKnSpUTWxYS0XkVyfZZIGw+I5oYmW3bcNATFhi18giurma6
         Fa4I+ZyRl62GcwYvRw72OPBm+oq1MUVKnC4cxcG0g0W0CFn5UtiBB16QEbRjZHPsq5yW
         8bd0b1rEZ2meJpu7o9hf4zehUPNIFPFyM3sKPSiGEAvzVm/uuBzYomWJh9cBEvuumtnF
         Q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786191882; x=1786796682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5h/jAHWXWXDOWdVoAFfHtjsJVJE0oZMUnASj9to5Sqc=;
        b=lSNIPO6VzS00UD5QTolBcr7nyOifVGrk66wKqKG3XKCNaAkdMSvGcX6SX/HhMWupCD
         oAjquNAYUe3B4a9JQMLidHQDcoEdVjH91zPHi/J4uqOqiAAsrHtwWVnMJ1gfXgzQCUs8
         P6tdgHAobQpY6k0pq0dWwmPGALB3s8VAtBm0ISglrH79gm00cb+CFzfU2oV6+Cvs78hy
         wuImw5x9qNqSJ9sTjC9hxaG7tnCnc1Ttg0z3Kape4Fq1Ji5p/D36R9AUfz0DfZVgdo5O
         O1lyXVWUG+noJH/W2l6BPt0NHRIBLtiMfBZ+Z/sNzzwXgK3bNqPGfmW/Qf3rw2F3QQBQ
         qtsw==
X-Forwarded-Encrypted: i=1; AHgh+RpUexAOBOHNrJXvyoibLCaKVx+p+Vro/xutZamETJlJ8VBa54VfWBgF8qs2HEAwHx64K/KeBcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Zg63dLfbEgB0wLcUkDSaAJ6x+sMRqj0FGxoyuQ8hfG1LN62R
	su3KpJQRhIro7459Wmb59m0aQdqeyVR5EvpFPWQuu/ib47tShEHCM2pY
X-Gm-Gg: AR+sD106zi7gcEHAt75dMpxMpt1UwM9YQrQcEoYgatqVLaZLmt5UHTxME58yKgR303O
	FeP56HuYCrAJprXIj9D8ZMRsV6moDn1wxvJNSyt7CxDR9Z4oSKUBqwqosPltUHTOoQLVofYG+wn
	wZ71APFeYueyyCsuIQ3eA2Cd4nbFE/xf3fQ1hI4PXmV5u5yIE+QxWTbfUAtNDablkjv8qnNypl1
	8psgutjpjlSwFtkCa/Xn/31fPnrAtojnN9i2vsxhjG6e7zvbQ/R1RmPbcBaIniwpam/yK0oWxJ4
	DXHYuH8cimPIjPOupst0zoOVKYq3My3L/dcGww0qhj8wnTBFi0xt3jF5cB61giKgSllsTP8aMH1
	q/ZIGY0WAvhs8BhcjxOsLLHsUBvkX0ut7AUBe4av9/kfwAB7UbQVePYxDZ70VIIOxFbSvoCnRZ4
	8XSuM2wiq4FaFLJ/e70PIotc8Siz4cz5Ano06WZV4PFMX3ZCLaLsOQwwLj8Q==
X-Received: by 2002:a05:6a00:c1ca:10b0:84e:915:d7eb with SMTP id d2e1a72fcca58-84f2e0dbfb7mr27063894b3a.37.1786191881768;
        Sat, 08 Aug 2026 05:24:41 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm2145040b3a.45.2026.08.08.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:24:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
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
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/imx: dcss: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 20:23:54 +0800
Message-ID: <20260808122354.2825209-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dcss_dev_create() calls pm_runtime_use_autosuspend(), but
dcss_dev_destroy() does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call before
disabling runtime PM during device teardown.

This issue was found by manual code inspection.

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 7fd0c4c14205..51398852cdc2 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -240,6 +240,7 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
 
 	of_node_put(dcss->of_port);
 
+	pm_runtime_dont_use_autosuspend(dcss->dev);
 	pm_runtime_disable(dcss->dev);
 
 	dcss_submodules_stop(dcss);
-- 
2.43.0

