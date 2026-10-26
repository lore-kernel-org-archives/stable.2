Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987365;
	b=fpTriOEaNMtm8t8JEcryA3SpjsHUVdpdf2iJmH4g93zHEdTg8nmhf5xfs1KmDoqRIWNM
	 edXqJBaW5iejzXubqFr3pzSYY0IrdMIkb3v5nm4wFsES5xgAP4pm/gIphmC/5ZcDPe3QK
	 jObE31u2MbxtQPsJbxTzGcZLW+mPQIqbq2/ka7hocnOSy8NcrxiWdUZjSZvr/nLJ7nU4S
	 jH0tG7688PizX9lRhQh9Ob7IK9Dw3h5xHFyRKI++CzbE859HHf6M39Gqx4YkvXBNw/MOB
	 d3WJY4Hkp8fQRQzoT7cvz++UQOPBRXRRo3p79URTrZeAQVCbOlmncstj5T86KJDjM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K2jKhwM+YQiKdSr1TcQzqEzMoQpUEpx9bgQiDQX0OfY=;
	b=iBCAZBOKMw662qPwA5Hs7dlVlKhtdqOI+gO7Woek+i3RYTCMw2ASRxTyBEMiJ/XnAvz+
	 +fAy+mxIcYEX2nqh7GfH1Ofb+f5quiQfi1Xvzms5aZcTACPMHDvo0GElftexTkf5Rp+hk
	 0UPTM76i3B8HiqU9IYjiTqMl+pkb/+kCiepdnG7F4l0S9mpzhZslAMAWZ1C8r8tX9Zv4W
	 HM44Qw8a3xQOqAMXMIClDL7RBLabWu26VCWUFeswPOOtBcTumrv9ZhFHB8ugZyiAkieXI
	 LG9YgsqWtv+t801hUNpvqEZbAPpzz7sKHbTF2Fa6vmAEyP37PA1djdXvkiVmfzZnRDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayyPxwWM;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2A606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C2A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayyPxwWM
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e946155442so21473195ad.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792987365; x=1793592165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2jKhwM+YQiKdSr1TcQzqEzMoQpUEpx9bgQiDQX0OfY=;
        b=ayyPxwWM/lb+H5VABRhht0PR6vZEeUivf9sh2Rgba0uC+hcvHTu/6mrShgE43B9ZT/
         kMs218fUY4beR83h7cZSyjRDyrIsJUF70dAmMY77n2GZ7zShdhLZofVUAk4UCxtWJFnO
         x0vswuv9993aAFPfzJM9bDcFhz8jw8VEIr3g32fettpVMclgL0mMHLxjWO0iv6YiGhmu
         RtvYkwSdBW0zd0sZeheju6ID8IAOSSf8yfkDe8DJCalQFyrQ39ydaP4S5yjQ7P/6aHa9
         nAVcmEqSej2jmssIaA28ZVHJTo47vL332VCVpSHKoNrOMFGVtzVQsfrrEGpE0x/yAu9P
         lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792987365; x=1793592165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2jKhwM+YQiKdSr1TcQzqEzMoQpUEpx9bgQiDQX0OfY=;
        b=rnhbgyxG6uugOk41t819L6hb2bHJr/TIB79seGANhkM/UvVtTqr9aAYWMq5WSeOTwk
         uwBrdgAWUoH/XI+6Pkhb/uF2s31BD9Nc0CaSdWItotGhx29e/46t5TcBW8lTMa5EjLYk
         eSOKvhrk8JYCJrkdCQFEqzjle3Ezchd+A/cdByD4wLu6xhPgTmFZoI1kZq3zAP9zv8F+
         cdOpy9DQIZtOZZn3PQW6JnBRM+xGQB2yrpc7b5GA4CNlT7oT60Hz5Iy4hLekggI8RbfI
         Ecrmt1lZm3vIF3m99A8xGjbdhcgIESNDcOCqNOtiw9ZoE5MwcysiN8fzxyea4VRbR78F
         gqag==
X-Forwarded-Encrypted: i=1; AKwUvBwhB4zGzoY14BvLuSpUMchKCI2gDOMTEr9wKLUgH8gt8X+YNxuoJ7v42nJtyLzcQhvb1HfUtsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaESK0AWgvVYVjSjCj742xHKF3SJrLet8bxktR3ou2dSyTVrLj
	rYWKkKutEqnD56uSgLjz8EFwbdOCXkJpOFIpZW3ks8KJgR6xEwj4qVdH
X-Gm-Gg: AYBFou13w1s+Uw7GxqzEpLhwB0ueJgiPUHyJyBV3uEFUtNv7onUNTmv/UFUNguMe8Mg
	WtwccyBxWNH/YxnbbOls+ZtFdTruZuffRGT61XBfvazixBjbMz7iBDpOAHVow9boRVuLRDIeoN0
	vPdH+GwNEM4JeuPWOvNI1OMAujx6yqf1LfU6gS2dPMrv0fHZxp3O5JQWwhaq6on8soIUnMPTgdJ
	8+c7HqQjLhIxZUqgwe9JfshNhB77YMam4q8FyzD9eJiVp2xuQSHWUebWPc9b6My5quc7ytxOWIZ
	8I/z1NOskQxLdLOwww5+07cTNjTr5/j4FGVFbA2MAqrGGLwsyzjAU7tuM6Uyg91NP0eih1tFgBJ
	4LvzJl+THbC1K+1U3WiQuyT2l3uhHGA8N3IuHi1d875SypaRGf9/sJnTvB4sMXKcfHVdopA/P9b
	CHRatkK8qpcfrmwbyAkAd2adMtb93vZ5cL9F8rsrRLcGvwyhPjuwwhNGAFjlruaZPloClHSEgb/
	CoLCfoPpQEwb32PAVia9fhOLpsGW5Cj1X4Wc8EIjw7wVg0HyyHW1C5HPKmWhvL1CrepFUQxDe5z
	NLcQqYYCj1kZZ+2j8Y4=
X-Received: by 2002:a17:902:cf12:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ea9c63efcamr46730195ad.17.1792987364597;
        Sun, 25 Oct 2026 21:02:44 -0700 (PDT)
Received: from xiaolei-VMware-Virtual-Platform ([219.142.21.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b22416bsm10626705ad.72.2026.10.25.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 21:02:43 -0700 (PDT)
From: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
To: aisheng.dong@nxp.com,
	festevam@gmail.com,
	Frank.Li@nxp.com,
	ping.bai@nxp.com,
	kernel@pengutronix.de,
	s32@nxp.com,
	linusw@kernel.org,
	s.hauer@pengutronix.de,
	sudeep.holla@kernel.org,
	cristian.marussi@arm.com,
	peng.fan@nxp.com,
	xiaoleiwangxiaolei@gmail.com
Cc: linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: imx: scmi: replace custom dt_free_map with pinctrl_utils_free_map
Date: Mon, 26 Oct 2026 12:02:30 +0800
Message-ID: <20261026040230.22338-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>

pinctrl_scmi_imx_dt_node_to_map() kmemdup_array()s the pinctrl configs
of every pin into map[i].data.configs.configs, but the driver's own
pinctrl_scmi_imx_dt_free_map() only frees the map array itself. The
pinctrl core releases maps through pinctrl_dt_free_maps(), which calls
dt_free_map(); the duplicated configs are therefore never freed and leak
every time the DT node is parsed, e.g. on each (deferred) probe attempt.

Replace the custom dt_free_map with the core helper
pinctrl_utils_free_map(), which frees the configs of each
PIN_MAP_TYPE_CONFIGS_* map before freeing the map itself. Its
signature matches pinctrl_ops.dt_free_map(), so the driver-specific
implementation can be dropped entirely.

Detected with kmemleak on an i.MX95 board (FRDM-IMX95).

Fixes: b755521fd6eb ("pinctrl: imx: support SCMI pinctrl protocol for i.MX95")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
---
 drivers/pinctrl/freescale/pinctrl-imx-scmi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
index 613552e35070..8cbd66950848 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
@@ -153,18 +153,12 @@ static int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static void pinctrl_scmi_imx_dt_free_map(struct pinctrl_dev *pctldev,
-					 struct pinctrl_map *map, unsigned int num_maps)
-{
-	kfree(map);
-}
-
 static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
 	.get_groups_count = pinctrl_generic_get_group_count,
 	.get_group_name = pinctrl_generic_get_group_name,
 	.get_group_pins = pinctrl_generic_get_group_pins,
 	.dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
-	.dt_free_map = pinctrl_scmi_imx_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int pinctrl_scmi_imx_func_set_mux(struct pinctrl_dev *pctldev,
-- 
2.34.1

