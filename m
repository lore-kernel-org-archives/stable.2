Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79944C50F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253467; cv=none; b=N7l9GXZt41mmbHML0eAspVlLE8l+geRoAm+lb9cwAqZxPcNcuXT1QAyz/G123e+wmNlqTGnZoU7JOKgNIIF35i84DR9V+EJs+N22wlBHAMugtQxPbeC57HAtBIMqCOOp8AvNX1fHnBqNckN4MKXi8l1jBzkkA8sjOtJQnLjmYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253467; c=relaxed/simple;
	bh=B+iy6kp9ASXr8Q315XpH1lU+dHe0l3ofKkdBIdlMNz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNS+8xb7t0ECCpKTE2xRiy9bg3Rw7AW8rYgfiPxvDH/qFQa/mrfkq4xRDhsQfADI/gnu/f57j41ahz3VXh6BBjyGCzin9Ddg6CPOm9K4PorwOeus26/18x4R60ZTQ8Ip4RtotsOUGqLaObpTjXXsmc9rzzkBIil5o7YmUEr33Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QikZo11i; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QikZo11i"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so5969269a12.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785253461; x=1785858261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVqoC0PvlsYqdavWQBkILSRZgUpiUZ64ta6tc5vlUjs=;
        b=QikZo11iiDLG/MEEmJkm2zY4QoSViMFJBglWVlQz5YI+EpB793c8cj5aLbMmrKoPZg
         RDQxzWJCL2/OsaiwzPDDImSZKqreqrvOmFOBEg/dsh/S87/ja/q6Ibd9BpK+z1nCnDAZ
         WK/+SNPRa3LTli0ZObk0JtwtReCQ8L0dZo28CrNSPcqjNu5V1t9Yen+/oU+uyFHFch+H
         SeLSa4ucHsZ5TLpkkfjI9K6Cy03yKAvvqpyYcoTz6QDAEUuWY7x2n+fDv0A3rRWjgt6+
         uy2K60r66AurJUgQ7RGRPIhjB+Zp9oHSOXYGUOdH4hdPR4ZFhFNcEzZOncG+mjtz5GW6
         6O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253461; x=1785858261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVqoC0PvlsYqdavWQBkILSRZgUpiUZ64ta6tc5vlUjs=;
        b=Y3EhX8Y1RsGsPHVoWEUrGxcyRufFh1OauZu5aG/764UxZ6Aqb5vYPUhImtC352DLLS
         I1gWahYsjCg2eUUYTi2sdXP6f1UGT5Dw2FO4wKhQdunLxrk6fB4x2SVLnPhh5qOcd8iG
         sHnSPC+/r2dYv7hr22jRA3G3puRdaBB2RtyyHHxyiZSc8BIemaOyF1p0b1uqZSiN0uCz
         +R8OzWJ9xxJrHW8Ivfq5djV30fYQ+P2ksrOnZU00LrwrIE4skVswKUDHgeT5LlpmBHu7
         yQ/Ux/wmzukwfJtvWipB81vbHT38su2WJfGSWtk/61cmxCDklnAWXEoUn/bVuAsIVSvQ
         ImTw==
X-Gm-Message-State: AOJu0YzdnxHk8SifdsaJjWtJOGu9AFeceXBviuD6MtsjxtjDL6g3n57n
	lvNZP9kwbzwvXD5Kzf5mW//LrV1w4AOqC/ly9pzgTvwARJnh+2sJh3dZVr0DoYsuGJg=
X-Gm-Gg: AR+sD12uquDgy0Mq2qasMmRJJQ5CEbCOJ5St109ixnpMQyviRzHkBWDbXEVc2m0Y0NF
	SN6622I8RplEkGi4WX7MADwC8Rl4SAYSGKF7M2YJoL1JGq/WgJy21C3+OwDExu/zf6ToMEuB5m9
	yXDN2LSR0qUdHl+81aoUbSgSX8fW/m31ySg94lo6u0jCMsJX9luBItqvQMAQvgHAsxcr03kS0yd
	Vest7D2u7bnDCK1ZuKEldS7XAVSc5ozcT1QXbk/ZdUnzJxZBeWabELIG3mcHXdp2G2ujSqnXYNV
	13A2iryBt7OEqUrkT8wMyfJYlcNvdlXFTnIcq7ajbfAwJNjk5SyiRjz/X2SIR+a5lUoIvyv5NUl
	w27E3PWZ5QrxthdqAadh2b2Iinyd7B4x7Z6DVZl5WvPWcCLpVNjDiTGxyctDGhMKURBt1OgIa4u
	Zn6BYISEGwyEJDWVjxjD1DxamjX7kFmw==
X-Received: by 2002:a05:6402:a5ca:10b0:69e:9213:11b with SMTP id 4fb4d7f45d1cf-6a0349ec6e2mr1041065a12.13.1785253461681;
        Tue, 28 Jul 2026 08:44:21 -0700 (PDT)
Received: from localhost (mob-176-247-26-234.net.vodafone.it. [176.247.26.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb594622asm4573764a12.26.2026.07.28.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:44:21 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Grigor Tovmasyan <tovmasya@synopsys.com>,
	John Youn <johnyoun@synopsys.com>,
	Vardan Mikayelyan <mvardan@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: dwc2: gadget: Exit partial power down state when changing USB pull-up
Date: Tue, 28 Jul 2026 17:44:20 +0200
Message-Id: <20260728154420.2021519-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; i=flavra@baylibre.com; h=from:subject; bh=B+iy6kp9ASXr8Q315XpH1lU+dHe0l3ofKkdBIdlMNz8=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBqaM3FFIxZ52DW+l5DVb8R5uXZTXBCixZJH5yrH thUlmkLyl2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCamjNxQAKCRDt8TtzzpQ2 X65rC/90A/JWtrbWO3amiFS3C69FigY24thsO2QSDfyfhnA/9Hnzss5k7S91fueUhsk3QHIQa2e fsEg8vjXEox6ALrpoHK6H/mAOF9HbbmOyz6vrNWiYGyo9W5A7dN5b36FeHut1X9M1a4WkbnBV8S yTfBrbmfYBDrAbj65iRbPXfmVFvZBgn/dFXX5V3yoXL8IapBlV6YS1GSglyuDk1p3jeUfRKbloC 8ecpO+vMvK2SOn0bpKoJwPXhubO/VVHpKu8KnJo1KjGoKgoDMyT9DGChOX2W5wYylYa3KFJQCdc sJxzGpd+e75/0ru266yJJ4MBlBvJKA3giuZKxMou9vw3SIEiMNta77pQAK4mGrUBP0fiiZ5SbYP N/FoV1yijn6+cRGr1H697PdWuhYxu3pAIPTyC5NbWaPZAXAkNrdBafQbnzN/zjFpSqL4jsOP6R0 GWJh19Gvpn9Y6P75rGaXJI0YQkVTLzaSOQ5akz8+5xIIdz4hJm8jc51CErrKU4EvbCJDE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

When a USB host suspends a connected device, the DWC2 USB device controller
enters a partial power down state where controller registers are not
accessible. If the USB gadget is then disconnected or deactivated
(e.g. when a gadget function is unbound from the controller), the `pullup`
callback in struct usb_gadget_ops is invoked; if the controller is kept in
partial power down, the register write in dwc2_hsotg_core_disconnect() does
not take effect; as a result, the USB host keeps seeing the device as
connected, even though the device is disabled.

Properly exit partial power down state in the pullup callback, so that the
USB host detects a device disconnection as intended.

Fixes: 97861781daff ("usb: dwc2: Allow entering hibernation from USB_SUSPEND interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/usb/dwc2/gadget.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index c8b02c27d27d..102169b40419 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4680,6 +4680,7 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
 	unsigned long flags;
+	int ret = 0;
 
 	dev_dbg(hsotg->dev, "%s: is_on: %d op_state: %d\n", __func__, is_on,
 		hsotg->op_state);
@@ -4691,6 +4692,13 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 	}
 
 	spin_lock_irqsave(&hsotg->lock, flags);
+	if (hsotg->in_ppd) {
+		ret = dwc2_exit_partial_power_down(hsotg, 0, true);
+		if (ret) {
+			dev_err(hsotg->dev, "exit partial_power_down failed\n");
+			goto exit;
+		}
+	}
 	if (is_on) {
 		hsotg->enabled = 1;
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
@@ -4704,9 +4712,10 @@ static int dwc2_hsotg_pullup(struct usb_gadget *gadget, int is_on)
 	}
 
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+exit:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int dwc2_hsotg_vbus_session(struct usb_gadget *gadget, int is_active)
-- 
2.39.5

