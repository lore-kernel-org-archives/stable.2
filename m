Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0523CF698
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899348; cv=none; b=X/6UVzipELt/Re/QfiZ2XVa0yDZonbHWIPTeFVoX3Tx6ppEDKjdLL6lCUBv4ussWhbKNF9UsqmampVgtgROZmB7XIOHuzpoCmKxYkQuiNX93EhsXYYlr/415iYdY3Rf6nRb/gZs8cz9xz9DUGAElJ0RdQdB8cPRuHuIaLFb9d00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899348; c=relaxed/simple;
	bh=pN6HPYj8rgpgCZ536OcBznzjQHlM6JH7IBNXpCmtsPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETjKVmBL+WbfHNsN8jr6fwNKUI0gow5O3CVR4jaVRf5FaYtJN32dxcM8/MHocPE+QY5u0NPOWLg11keSwJsPU2zAJaQQ7MpkkHZDMQejpjcWCiqn8QjY3mepUJYJ6u4O1m7FWPQiQcF4hS8aP16VQm/wh8HWhKWKaf6es9JP4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy2ZoHmE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy2ZoHmE"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fe45db360so80032f8f.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899343; x=1788504143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktRMVezOHSXu+KrKQhXPWvOXAM5roEQ780FkS0ZUNoU=;
        b=Zy2ZoHmE9bPRGgA/zVEbKE0zeNGvMe7s6MV7AMBmLYGSgaoPj999n5fciHkQDjdL2o
         bgy7VsgfpZRTxw+uRdH9eSBSSTvY/b9sSgxz5k3b3VEp7rzIx/e+/TjhVg/5Qlu4iUdN
         eRim4rwmkT+oS1y3a8pObamAU99gMIMKOumkd80awTLiI19ZcBvqyWffqfGoEgPIjqRN
         IExDlTlcrgThnFWcjrMhHs8HF7DbLevnd5D1tnMmqgoUpNP1O/BjwezBErCW7RfF3EpT
         6FLBzRl8q996yngtcydnYSfQg+n9FNCQOMesffC4Cq4u6W0yVT3Uls4dpJ+Pax7PIaTS
         OIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899343; x=1788504143;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ktRMVezOHSXu+KrKQhXPWvOXAM5roEQ780FkS0ZUNoU=;
        b=h3uFdk5hsbYXftvr8KE8FGU7iZevS2dyvpMBYBYoRBpu4d7Fkv8A8jxcfj78SeWME0
         wIkLVEKvEIkl1uWRulaF0X6qChOhoYf3wHjAcSbyqDyPVDOzhXCqYa0VK7OcV9hg+9sa
         ap3B1LSonTo44+hxNCL6mr+W2Z9FWTZHn5ur7peNJtJeioTYBwxuJEb0o0Pnm6pILgEP
         fOHn01EvSackIcLKS4gCM7XhutGt0UVrruZMfQlGIY/rz8g8p3qItyHQHnF2bjaiJJ64
         3yHLohGIQbprPb9gyJM6UFMAUZmIXaAv7JNIo5FDFyKxM8HizBrvheF3Hb9ID9sqsAjn
         hKDA==
X-Gm-Message-State: AFuF++kRulHZGJDP950r6w1EZeAT8V/Emrk6OlAZOflcCw0/5maMHb7P
	Lcjbqw02g/EN7H2VT5bytM5nLlFCpen78dIhixef6InV8MShjj3eUOFqBnMrsWVdQCk=
X-Gm-Gg: AR+sD11VlxXFPKsZlDrbk2btGLAZe7qqflsyEjQfKHJCXY/ieE02C2oOw89M6C3BeDN
	Myl60FAdU0mF+ygFkCyKhmc2QZmNf2RCojwB7ULuTq88HabTqnOPK5Ae9QXUYyE5U9GKIRXEC/B
	MdqtZ/lSVslF/5sPmHK45vESzoeeA+NXyQEux1zYlKiS+6ce/APNhE3S6/ZsKIlxZt4ZGKb9Bkf
	VmuOUbvHgdkuG8llqBeHp3GaV93rI5g0Hj2hjmX8B4CbqsqJEMxB2EYEeDomayEJK5x6HTA9k2j
	WnyTH6DyVv9tD/aBGFfd671PEX+QDUJnI13V2JEfT/H/5hOWTYilDtltGIIuyM3Lh59n768c6Gw
	EmybPLZKsnHNv0rQrp/mtxByBlq1fnhSwhaUpE8iAhbnPqIFnmKrtSdhE95p+ZtDrddmOyFjgdh
	Zx+wsdNDUYcjQIj3/h/G78kcM0pOCBncbOxgTuUKA3PERnxRxgoQd+rBmGUacSpAj224A0ztCgL
	plBaWZ9oiWGVw==
X-Received: by 2002:a05:600c:3103:b0:499:cef6:104c with SMTP id 5b1f17b1804b1-49b91c39a77mr31949355e9.1.1787899343257;
        Thu, 27 Aug 2026 23:42:23 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b945816f2sm33472195e9.8.2026.08.27.23.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:42:22 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Archit Taneja <architt@codeaurora.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358767: prevent overflow in PLL calculation
Date: Fri, 28 Aug 2026 09:42:09 +0300
Message-ID: <20260828064209.4314-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the tc_pxl_pll_calc() function, the expression `pixelclock *
ext_div[i_pre] * ext_div[i_post] * div` is calculated using
32‑bit arithmetic, since all operands are of type u32 or int.

pixelclock takes the maximum value of 154 MHz (in accordance
with tc_edp_mode_valid()), ext_div[...] takes the value 7, and
div ranges from 1 to 16, inclusive. The maximum product
(154,000,000 * 7 * 7 * 16) is approximately 1.2e11, which is much
larger than UINT32_MAX, leading to an overflow and, as a result,
to an incorrect value of the PLL multiplier.

Fix this by casting `pixelclock` to `u64` before the multiplication,
ensuring all arithmetic is performed in 64-bit precision.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7caff0fc4296 ("drm/bridge: tc358767: Add DPI to eDP bridge driver")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index e3a57f8228da..39633f618664 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -640,7 +640,7 @@ static int tc_pxl_pll_calc(struct tc_data *tc, u32 refclk, u32 pixelclock,
 				if (iclk < 6000000 || iclk > 40000000)
 					continue;
 
-				tmp = pixelclock * ext_div[i_pre] *
+				tmp = (u64)pixelclock * ext_div[i_pre] *
 				      ext_div[i_post] * div;
 				do_div(tmp, refclk);
 				mul = tmp;
-- 
2.53.0

