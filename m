Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915933;
	b=MEFjgiJGlhqPZSi4OGnYiEPqzfDg11T3bI3JQhAThjQcFvN6kx8I9wHjVNudW5yhct/X
	 IhHV1crqX9VpKK7tzkV8BZybXDx+LsPONeZ6X5BIEeH6/4RmWyy0BTkkZsDyejbrkZ+kd
	 ncuo0AASWOPCzw7dPLdKcZA4vo0GW6bufol5BNvxxUF4knBGRt76QL2EG9z0HtSStlHPt
	 pqT/tqreBD0DBJnpap4TDSdWpqCfQd1epIk3X2h4VgQXJgDprpyJhCwvJNW07Pt5/bBLz
	 W5lYRxfB7ERs+p9/7lSVC3vsBQPTkF1Cvif/eTtLqs3XStjYMeIZNRve1Wuiaf40oRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xEHiK/lQJsiNqCYdsYnexV9SSAq2eRDbdaxychq8MdU=;
	b=LiGk8/bFs2nu2ClYGbzeTBAYvHpMNpoL6YJx7AJH2l82M9NsUkp554qk5Z2dlzDdgeXV
	 e5+H/wHN6wxzamMSFFDpn9SZzhvxDIgYT45BWqYGvcpPoWvTN//Rs2k2k6Qv2+oypuqy9
	 tDawvw3rDLoLVrhwhl8B1ybXZJy6y6Oeq2PevOdfuM9p+SOMpk+pvrIMvRZhzBpT18ZC2
	 D9s6/8gOlWlc7B6YLbNwSjYSVOYvBUkA6lfOcJycZ4OEOX0J5rJIisDqGAkcEUSqNzelJ
	 7j/q/ea993tWtsjus8O8M3bOblxRePnjT5sWMxWmUsFK/yqGenYF7A+PbLq/NztOKOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PfcSc1Xv;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E35606A336
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E35606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PfcSc1Xv
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso7589121fa.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794915931; x=1795520731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEHiK/lQJsiNqCYdsYnexV9SSAq2eRDbdaxychq8MdU=;
        b=PfcSc1XvKlk/DIZONeZkQIZzT32HbHfJqlE0G+YBOOC3LvGz+JT+4i6XHQBrcch6uz
         qKCHb9TIlE60UCro7tYZgWSpPOoVW9XO1Q6mQggeTMwkLcCKWaKwOxYFNHY4htzNy90W
         EAuN0yNbL77v43AgNHoAsz4l84kSsfLFK2k+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915931; x=1795520731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEHiK/lQJsiNqCYdsYnexV9SSAq2eRDbdaxychq8MdU=;
        b=kq+x3LryWYDBkJ4om4lYs6PW3oSzEW0yawg/RsQUkZ45kdR0SnX8++EwLTA6vnSXgm
         o2z7aoYLUDN/YYNV1uBqc5LrR2fR6VWPc4+MWjzs7KjiZ80oSSZ9VgEtTY9Eq0BviQXI
         Zf4phPscZbN5pAvRLdPpGCJMlmbS2MLGw87Eo3Q3GcAi7b6rlW3jw8Us/QD5VSDP9M36
         4IGbxBD4xahf8hzy6600kd3ceFo2HnNFBYGVZbRdyLG34bxxn8Nov4CVQCfJDnPBGWez
         4rkjV0eUi+v6i02yh9q5jGNVKJYD3vJoaJe0ngNldNa+GTrm+tvim8c1/BbTVY4n1+zq
         82SQ==
X-Forwarded-Encrypted: i=1; AL+hErFhw6TS7YI7d6CQlL7eFiycg3P6wX2ge6QRwelasOvs0ZOsJp9XwFGXZOGpBDV1PXSZrhnWs/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dE0dgBI9BkWjuEpdubSagFHFhlQk1C/hKoAQyoOtcZoM6+QI2
	xynSQl3DqwhJsUx+VIuDAFyL81Yr+sFChO/xeneaqW3oSW+yPaWpDJexJbVFgWWfSA==
X-Gm-Gg: AYBFou2pRoLnUSUD2PKY6xZSILeL8UNgAVi7X43ORE21XMwZemTDB4pjAPZ6RRglF0/
	LcGp7ti0u28QUElYfENg3BLwYCbcl6ihk8fA8BlhX9oDGcG09nq0QlPxjdSqxojNqoox8cx1KzF
	802C7l+tuQ3tBb+SS9DalRCdF1+qZ/7dNrLzUIHasCk7yxWZEWMAoUmIDA5rRT8fnkmUAz4pp8W
	TbpEqF09JbgQZDlUWRRc5Zhpgdb2qKb8Bivqkh90WW7aH2COLsmANEMxJLwfAO+TpwID519FUOT
	nzjZorJqvvNLOGEkoKptpYdAT7u71ozfMUKsDE/syLm35ns0Mq4kist6KaibCITlXQFttvu+bWg
	cdDz9F92aFg6wZLnTYpVPABJE8wovXNrYLo+3pRYRrMHmzrTaomlFtwLedXeNXMNRmgz0urBVzN
	M2ovaQTLOtaLStdQmvnDu+e9RexSt/NR41LArEeDJin39az7q2M3DiLONAXxoNXwL6qfjdjnKEZ
	viOBNuq25tws1FdTIfnbAuskUda08inFI2ZAu5e/ZIVQpvuflN5stzO9L2IDgnVlTnwEY6s76uX
	uUY4Zviv/omqsgHUcwefLTAAR3ZomRVs5ir71tmYgf9sFphYFFBi86dtbHcXcsSJREqldBREmKX
	4iVM0eNFbYUY7RJCC4+PslvxRzVhneZI=
X-Received: by 2002:a05:651c:a191:b0:3a9:7c85:a16d with SMTP id 38308e7fff4ca-3ae5c9c3b3fmr6962841fa.5.1794915931605;
        Tue, 17 Nov 2026 03:45:31 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712d9dd4sm3955141e87.7.2026.11.17.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:45:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Nov 2026 11:45:25 +0000
Subject: [PATCH 1/2] media: uvcvideo: Do not setup queues with buffersize 0
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
Message-Id: <20261117-uvc-dji-v1-1-7cb3cf3b4b5a@chromium.org>
References: <20261117-uvc-dji-v1-0-7cb3cf3b4b5a@chromium.org>
In-Reply-To: <20261117-uvc-dji-v1-0-7cb3cf3b4b5a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Jordan Moormann <service@jordan-systems.de>
X-Mailer: b4 0.14.3

Vb2 (correctly) does not expect queues to have a buffer size of 0
and throws a nasty warning:
  WARNING: at vb2_core_reqbufs+0x60e/0x630 [videobuf2_common]

If a device has a descriptor with an invalid size, exit early before
bothering the vb2 functions.

Fixes: 6998b6fb4b1c ("[media] uvcvideo: Use videobuf2-vmalloc")
Cc: stable@vger.kernel.org
Reported-by: Jordan Moormann <service@jordan-systems.de>
Closes: https://lore.kernel.org/linux-media/c2c00ad1-b21c-42f9-b3a1-e03a0ad49651@jordan-systems.de
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442f..46b807b95d2c 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -91,6 +91,9 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 		break;
 	}
 
+	if (!size)
+		return -EINVAL;
+
 	/*
 	 * When called with plane sizes, validate them. The driver supports
 	 * single planar formats only, and requires buffers to be large enough

-- 
2.56.1.708.g77570a6a1d-goog

