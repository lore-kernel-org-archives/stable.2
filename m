Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AA3346B4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984856; cv=none; b=QvgkUYbSkZcpkAi022/u3Bh4Y1b3lP/3fNvOqC1MGW3lQqHnYgISbMkQqjtILln5a44kNmdSlVZOS/+SlUMgYnK//9huxcyi+F97nx+aqgJbh4Pu8BLaa8F+z4t18C71X9IoA5G348O9Mbjpp/EV6+ouQUf9TkQQ5KHCxH68GbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984856; c=relaxed/simple;
	bh=yqTSMl5xbJ6/XG2x9GkVPg9AXda0FBBM50TD5AsO1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpRbCnSH74qkSAO+afOAiR+5KTxe3+A29RcVAFfELF919WCcOzvDkiR6biWjuJo3oP697udq8AAWcIqB0T/UWazIfOIf4zNwhG5d6g08bWkrNlmm1ujsNwjWwW9YZXzy7NID/Icrlk94U8L1cWR7gOsTk5pIS8YnR51NHMU6PNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sr7tBiF8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr7tBiF8"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so5327045a91.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788984854; x=1789589654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=guZfSRNKXMdPmVg1h6Pr0fhBzdAopq3h34A4o0fDPKo=;
        b=sr7tBiF88RtiMjGuOoCP4kTTzsWICTImlq5hJtF6YfGVGNxP/cDQorBgHRWP5Lv0p9
         uCAz4gwcWFs1ARc6YDWGN3wgCxorTg3GxPnWH4/q1uNHnRw3VbLQLv4pkS+lHMkHWYYR
         3PeFSz40aCdEyWhwqAFscPf2hEcOTvZVKznahICweiEZWZk5bNZgEob6chmAZrFn5HzG
         9xugdS6qcqbXC/6LwbqWY5ceKJzVamR5ZYk0m0UAJCoLddqjfDE4gEZKAvJ5LhFd1Unu
         4SgHtqeuDSVc35YscTaGimCAF3ureb+f/RdMDssK8CPrrGw5UubZKAy74Co+eMVCx8Lo
         C8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788984854; x=1789589654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guZfSRNKXMdPmVg1h6Pr0fhBzdAopq3h34A4o0fDPKo=;
        b=QRjxeOR8nb4hxf8xch3WRP7v1f6sgu0Te3IHWFpCTgxv2KfB3+YyzmtQRIrvI5eh0q
         AAEwLPywa3OuI26oAGsTGEMfIcoPMqlrourgBNB4nNAhnJzog8t9HakxSJpan6oxz/uw
         dyYG3QommH+4GQJ0RsbWHW886TcmV8+QEYlPy2cBEFjV9roejuFDxWc+3Yz81RO1THd1
         oIfGWMAAWzxTT7OOBnpT6V1faXDgu5eQumx1f6X+xsYcaNK6X5pLJePT5uaBYADPh7PJ
         vC4TWxG4vERJPtd52/LrN9d3CN+QBAjL8tz+R35T7Z5LycG01iIy2tGt2pfNYhX+r+E1
         7ZoA==
X-Forwarded-Encrypted: i=1; AKwUvBzUp/yLu5Z3uv6fARMYdQpJ5KyLkwiC8wjUNAFllZH9WbY4MBhxxMFadk9frq1wcigCRzt+PVg=@vger.kernel.org
X-Gm-Message-State: AFuF++kRziWN0kdNyr+r12Gx2R+jIqJKJavyLXk/F3lupk3yCDmYVETw
	vf480xlnZkfUR2S8kSDdj/iHjbLezoNRv1FXxFClHCaZqWHb/Ibn4cCU
X-Gm-Gg: AYBFou0QoUKwkfNC+ge3WapyIhosmM0SrVL7JMO0YKlfaDXv/rQqs3JKHbxt+KA5Ujw
	ZsN0psiWCUimpqs47cvXgg1+lYWplhDzX6F+MKul0ZSdWIXJpAD8z8urTcfN/fE8W75vnlhglsw
	fOyGmqmsixcv4WfnJR2EZbmflErEcvQgexayVEYwQXu89aWOJwsghF5/2GD/opmE3bXrjMTdUof
	ZiPFir6wyAw1mDdi7g7/CW7rb4Acg/1kdsm6T35oqISbQQ+tULtfZhSKJmuJJVcLpxaIGcyO7kJ
	PRfUGVP+XRJKcPwj5li7hbAM9Jj00FtM8rV5CsPE7TCbwS+fyCf7XCz+WQXdB7lR5CRuO888vbp
	ZThy5SCASEw35jgPsc75FM3GnEhGB+ouKnFcc5J+k6GKGXYC1MOdP2AStw8xpd/Etx23gSA5gBI
	WWTEkRN9XgzPCkJhqpPDTbeuM6i4LSYGV1g+TAutz0ZWWAcJJvJ5okHcgCp+QTafBh629IWaJRU
	U5ioMEWYuTzmwYXRGMaou49GfBWsOQT3jS0LyrbRWpt7BFG
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39b261ba63bmr56325924a91.11.1788984853726;
        Wed, 09 Sep 2026 13:14:13 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a803:6c49:659c:692c:9416:2f0d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm46840513eec.26.2026.09.09.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:14:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com,
	dri-devel@lists.freedesktop.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay
Date: Wed,  9 Sep 2026 17:13:46 -0300
Message-ID: <20260909201346.937343-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
between display signal output and backlight power-on.

Without this delay, the backlight can expose unsettled panel contents
during display startup, resulting in a brief bright flash.

Set the panel enable delay to the datasheet-specified minimum.

Cc: stable@vger.kernel.org
Fixes: 1b2a9ec82099 ("drm/panel: simple: Add Raystar RFF500F-AWH-DNN panel entry")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..70e37ff12c9e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4354,6 +4354,9 @@ static const struct panel_desc raystar_rff500f_awh_dnn = {
 		.width = 108,
 		.height = 65,
 	},
+	.delay = {
+		.enable = 250,
+	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
-- 
2.43.0

