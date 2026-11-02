Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660464;
	b=c/Df8hZj99wBB9netOeI8jTVGzeo4EOTUsjh3gQ2kfzlojvUWHvdr5ntAztqlsWlNxtE
	 CxYv0PWwlX+CHdwVqLPomMViPweaRNxeB3NBI4Fz41E1AackhBOIJY/Y3UayHMeVWAwd9
	 2no/f/bK1VFgblY5JB12gJiwg+QUh+fpEvstHaTB8PnbxlKcOEqi/QhmX6AG58otdLyQ9
	 +69fD2ZQl/lCv/FW4p3n+o4Jr4F/btkFk8skdG7mq56oLw+CUSLCSc6OwEwBbdEXqehXF
	 ae3mtkLvF2C+7T0jSZ51RHzVlehBEOTPfNdUm0P+znV++fm24EnIBblkmJdEJbkZlzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660464;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	b=5jglQHLAyaHeej0DkuLvr5bcBccw8x2upiGRmcEr5WKA7VxKvNBUU3tBgUQ99Bnad9lg
	 ftHxIW/gAiXuH7pQbF/IdDA/DrTyHvTh+wM5NoDhiHHwmUyCarA8fjoQAd5KOsog/4qpw
	 mdXZ38/5euA6+jWKajxMl52+u/L5vgcdN8gYR5eO1RWeR2JRf5L9fKQQGpR5stJDepQ6O
	 DzCvVTj9GxSDvitihTSnFMqafHJ5MVBDJabBieiCEjCafsofWYrgqWor/pX7V/RGl5cxr
	 5qYyZy8aZla4bwBHuOqqfRQQNJIY+TPzZlL0r4XrTNgZoCB0YKhQhEWnNQq8EnOadtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i63YNQDY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4A606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i63YNQDY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FFE1F00A17;
	Mon,  2 Nov 2026 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660464;
	bh=pEsErr8/B9QW6r/vBViHOeVO+a5kU1j9VPBmnw9SyxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i63YNQDYV1Hfey7lvI0BMH2xhtqQdVjKDSB/CB5Uz8Vfu+1WH3IA5yuq1iuqLRYU/
	 eCSPJ4Gct0fYPYSvgiFBFUlXBbyk94w5ZzXENQ2ODNqzhnW3RDwQ4/qs5HCAhSOUYl
	 lsCS5VcLz+bVREMomO9pCQGW4p9Uz/OvuVvmQzwK+S66TFu58ivvU6SmaT/Xtz5Mm4
	 2AeHyiM2Ux56JZsS+lG28QrBCEnxnMIOnMt4mrRWVoGRWc5PBcyovUM3orwWQxEuZF
	 vy9t5cA7MALhfZNiYbY81TqqXzcSCDAdmDtdJPPQV3AtmS474XG93JfXQmjnqnr+BD
	 uWTJPzS+i93qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] media: usbtv: drop redundant device reference
Date: Mon,  2 Nov 2026 18:01:01 -0500
Message-ID: <20261102230043.2412225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110228-skimmed-freefall-ac5b@gregkh>
References: <2026110228-skimmed-freefall-ac5b@gregkh>
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

From: Johan Hovold <johan@kernel.org>

[ Upstream commit dbc6798b80481a20f9aff671bc4d529eae63c9e8 ]

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: cb705f75d03e ("media: usbtv: fix null-pointer dereference on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/usbtv/usbtv-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-core.c b/drivers/media/usb/usbtv/usbtv-core.c
index 1f7620cd2996d..4925113af9603 100644
--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -91,7 +91,7 @@ static int usbtv_probe(struct usb_interface *intf,
 	if (usbtv == NULL)
 		return -ENOMEM;
 	usbtv->dev = dev;
-	usbtv->udev = usb_get_dev(interface_to_usbdev(intf));
+	usbtv->udev = interface_to_usbdev(intf);
 
 	usbtv->iso_size = size;
 
@@ -119,7 +119,6 @@ static int usbtv_probe(struct usb_interface *intf,
 
 usbtv_video_fail:
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(usbtv->udev);
 	kfree(usbtv);
 
 	return ret;
@@ -137,7 +136,6 @@ static void usbtv_disconnect(struct usb_interface *intf)
 	usbtv_audio_free(usbtv);
 	usbtv_video_free(usbtv);
 
-	usb_put_dev(usbtv->udev);
 	usbtv->udev = NULL;
 
 	/* the usbtv structure will be deallocated when v4l2 will be
-- 
2.53.0

