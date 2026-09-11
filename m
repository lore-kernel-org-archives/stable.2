Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C88485926
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133035; cv=none; b=asXhqM4wA7IkrtFQjtj6i6Nf6kGJMSwuCzWhJQMXkDN1htR+EMR5rg8PeZ0QJHbOWEJOySqhCw4I+YEzC7zkL7Pz91xZzkymfmgWDGw7lX/CP3O/Po4lO7eJqlVUXRJ4/BFVWotko3w3EWF07tgUnVXrM6UWfehoS8rDjVddmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133035; c=relaxed/simple;
	bh=qpz2ap2Qy3ycSRZrgUKqHGFQhhk7gpL+MfmoSPp40Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jcCLSrYIKItrgdlFCaVqyz1n7q0RrrGby1n6gbzcNvPEm04U/XeImNJdsmh/R+9QDvfDmvj7kzHcZXRQcXtx566ctrqcMOLL/zNwepExaDQzXc+I5A4YpAYFI1kFHtfRdg0rJASMaCPeHh3Bg7wTPHguR7i7nLUw0djYIYr98qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LxGNi495; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxGNi495"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a5a64d475eso6015541fa.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789133032; x=1789737832; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GRtNOlIv6Nq3mnj3CtQhPUwSgfYJDObGyFZaQ8xnneU=;
        b=LxGNi495ExZd1S3ovUUb0P0OhGIH+1Sfpr9NghkgE3oBK/fh/GxQvEWiinbTCiKCXm
         XrUEXUWh+Tks113I4Tnos550L8UZNMpWNPUEy7zVqub70fnLlloAf7IanN8t+vtGKjQo
         z1m7XEejAJGMgylB7IiRIglp7Wg1nqWqz84Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133032; x=1789737832;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GRtNOlIv6Nq3mnj3CtQhPUwSgfYJDObGyFZaQ8xnneU=;
        b=cRVaEESWtKbKF+LbPATL5FwxsPjR82y7M9fGmvhobKvo9RuFdImf0d0idv+delBn3b
         gb2NF0O2NqVCgi54dLr0WTG+u4AfwS50a6NtiVOTQxHBWW30tPAM6I8Pjucana8sua19
         3muDh6ni8lbGik2Z0kSzaKhd2DllB2vQV/kdwYA3vAsX7dFwrJC7vouI2CFpF37eEKyb
         6htEiNA22HS362UDhMQOC0bKsgWGe28O6wFWz2QCHB9RKorYbk/ptoQ3gpi9Vc0jDVOV
         bQfy8e0h9TQy+PN0JsNHlvpw7BiFxz/Gr23hA0smMl+5GXMvpQQdbzWw1So9Q1UtnGTs
         rz1A==
X-Forwarded-Encrypted: i=1; AKwUvBw/iRctg/iGor4JpTQu/E1U6xSMVcYd5EAsMQ06KTHYVwaOU0639HrxOkHLsSV9NawE47boof4=@vger.kernel.org
X-Gm-Message-State: AFuF++k9zUaIsWS9AL0U3OEjybwb/HezzYO/+JnkmW2tNXeYiWKlcqQm
	W1pNFp5HXWOKn19oFwNdC3Ew8LVsnfDM08SmbENlpc6wnnjrGM6Y7mfb5co8q5LD7LRnUeoIlG/
	dsc/AHqbo
X-Gm-Gg: AYBFou0n2TCZWZl8Pd8mvkVhIgKvd8akXAXLs44oqlOzp2rx9thY8jpt1PV0SPwBlvJ
	eFrCkePbIho2tq3kMwq7j1N/xB/mLJj3v3RAeA8TtLK2Aa5+jT3eC0+aYJ7axmPU1wjVhJ/Z7uH
	0oPYc1AUo+vR0u9oJ8sd3RniRV7E8HqnKO5HLTzOhsH7LG7gpcC5gNrvnBMlz3IQayWO8Yw8ccL
	kXFy6k54JIxuTnGze5D2YJJWBcnZy4tSyoiwtM4hGRobMKaFYUGb1PPKYIiMEyI3s2MJEjf40oK
	bDfdFdKpk9MZGo8sc8UMPlcPBiPb0zlSVMSaIhG21FGOvW0g10XQHw0X4c66jrttUwdxfCyV/LA
	RyK+EUW3CaWlmrqSDBZiuQMSN3buj2u5tXgF2MBxxzVRAVZAHfUetaxLu7cLA8/BSJqmCvZ7TuK
	5xrYmIRIzM2jEkc8UYBarjmCyD3mTKDbo933BZcDXHLzfCvXR55ouPO+R3lzIY/KflVEWCwcdhP
	nhPffBooPvgjuIwpT21vyrVRtNHfMU5R4LTQzfjCi/fLo2lrQ==
X-Received: by 2002:a05:651c:43c4:10b0:39d:b5b9:f0f4 with SMTP id 38308e7fff4ca-3a5a50895f6mr3800571fa.10.1789133031755;
        Fri, 11 Sep 2026 06:23:51 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3361f94sm5611931fa.32.2026.09.11.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:23:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 11 Sep 2026 13:23:50 +0000
Subject: [PATCH] media: uvcvideo: Fix bounds for descriptor parsing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-uvc-ctrl-bound-v1-1-7b5cfc68bae1@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOUApGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0ND3dKyZN3kkqIc3aT80rwUXctkQ0sTgzQDs7RkcyWgpoKi1LTMCrC
 B0bG1tQBPMFgRYAAAAA==
X-Change-ID: 20260911-uvc-ctrl-bound-9c1940f06fc7
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@skynet.be>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

uvc_parse_control() passes descriptor by descriptor to
uvc_parse_standard_control() with the number of bytes remaining in the
buffer, not the number of bytes of that descriptor.

Because of this, malformed descriptors could leak over the next
descriptor, leaving malformed data in our structures.

Change the code so we pass the actual length of the descriptor to the
parser.

Note that this makes the existing check more strict and some devices
that are wrongly parsed today will not be probed now.

Cc: stable@vger.kernel.org
Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e289cc71ba98..429f1ab19a2a 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1248,11 +1248,14 @@ static int uvc_parse_control(struct uvc_device *dev)
 	 */
 
 	while (buflen > 2) {
-		if (uvc_parse_vendor_control(dev, buffer, buflen) ||
+		if (buflen < buffer[0] || buffer[0] < 3)
+			return -EINVAL;
+
+		if (uvc_parse_vendor_control(dev, buffer, buffer[0]) ||
 		    buffer[1] != USB_DT_CS_INTERFACE)
 			goto next_descriptor;
 
-		ret = uvc_parse_standard_control(dev, buffer, buflen);
+		ret = uvc_parse_standard_control(dev, buffer, buffer[0]);
 		if (ret < 0)
 			return ret;
 

---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260911-uvc-ctrl-bound-9c1940f06fc7

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

