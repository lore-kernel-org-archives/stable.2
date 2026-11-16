Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851539;
	b=Dvccj8A7Z+Ghrw/XWJNMqAZdf1tPRncXOOfNZpLDGIA/Io2tLXaAUh2eE/zu4lVWnTIG
	 Ph9kBly7Bi1zOKi9oPpQJM2pHHCOc7JIotDbld9rmpE04PUKEr21s9jPYQM5vVc+X6xjX
	 qHf8TTGppLIK1j+ul3QibrFXOLKWN56QbXTOl7BuVE45ncA7wgwr75+rQsjKKsmrw6q3c
	 o4xDRvx3Qd/POvxiCGFDsVG01j1M2odfuHGe8ozuG6nrmJtUX2BdJ5UGeMX/ZXQyALIt9
	 XEJifpJZIwaYwRA165G9PutGs/wibHS+ZPVhBLSu1z9YPq3v4fK9JyPGgxJBQU9b5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wJ8TnT2XfhDoFSzBoirS9TeHlGIUWbru6eIu+8n9Klw=;
	b=t/TgQAWQx3MzGLto2wBEjkgcABkcANpiPb2EL6I5DB87WLvO2fY7AtGdlGaQjrN33hef
	 jppCpjUA7pueKqD/0OeZnv2yPezQjE3wRzjv6aO1pGqCktRLB6/dHx1XVGeNHztaOQoXU
	 VowtTJA47iJbnOtv9oiirgrk4P7R00gyU56JYcPfx3TkcBPncu9QKcenBVyU0nPgSv826
	 CUbuh0yglWe3yLlDSGb0dIny0uUUoRK2n0TZjg6rxqvoG57m2tXAT3IYQ/+qQ9eJNIg/4
	 jQgrRdFPQklaH0yTWp3D1w+7NL7UghsQOWWtCnjXFa1GCGWXD8Prj1KtyJ8HilkgApw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RDOf8EIy;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D52606A8AD
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D52606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RDOf8EIy
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso3487714e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794851537; x=1795456337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJ8TnT2XfhDoFSzBoirS9TeHlGIUWbru6eIu+8n9Klw=;
        b=RDOf8EIyDdPhIhwkU2Y+kks81uAo3qI0dVnrzE44118r05BQIWANGKQxYwZzuOX3vD
         zwNEJmtE63iju1pVjGWF1qU7xBKYcDB/bbsbsjpJ+8qc/knq6XU0HAUSZUmLJe0wm7w/
         g3OIplPwGclz2FdxlBa+hCMd3/BvncIvoq0zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851537; x=1795456337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJ8TnT2XfhDoFSzBoirS9TeHlGIUWbru6eIu+8n9Klw=;
        b=law8f7A592zwo8P1KbIRq7QGK2KbLzgC+bfiwfVjayrqbaaWJEwXXag2zXYrUcSwMd
         0Mka6A3QOJETg6zdGswURyOvJ0UeZi6OHVa1Ll82gBALi9p/YfWXgexriinVdcXjA6Bu
         qcRQyvm1xAp8NdLdKLaSgeWlCWjurh6lQs9AcuutJFHMYyjfup9zxfT9YLFUPxEd5uOE
         erQrj7OWCOiuOMTatA7oxEpnq1fLCRIDiDB49tX0ghqOQpMQr6GhBLI6xTyw6oKb4EFJ
         bF5BhbphhfQgCjhK8BHLAgHa/3gw9vzd9YOQwX8xvdHr/E9ufngqVZ5KRhKO1Jg/JsvG
         cspQ==
X-Forwarded-Encrypted: i=1; AL+hErEyWh7E9ZCPymlWyZY3lIcEeVOsOqJ1UME0Q5aIcjODM5eFins0MqloJnGTN82o+mRKeu64vTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rmOFWgj6gWGcrx8LHHrWaKWy7yif0iNIShr0yp8EhHkikLWTN
	wsO3uHc0OkdraW1VFrxqplIBVAvQzhSM5Xaf78ZVs22cUBqrLNPYDsa1bD9udEqYRQ==
X-Gm-Gg: AYBFou25yJDlPIHDSgP59KNYuqEOglm18r3ailAsdL9qtCDQHQ7tU9HBQHJndSmDhHd
	Mp1iDyhj+p9BXODARknGL6st+hI5GPouI2OwielCqv3sHWHo9ABAAI9c3g5SoDqI2LYs16Xzx4v
	2Ywh1rnW+dzbb88LK00Smv7JKn88ufW35rdyIQfOz99zfy9/KEPuzGyoHHmkMFMjjdJKRFOBa2p
	WQ3IdUU9djYkZEclfCQ+Ovlkx/vsTG3SmlnbYhg8GOqsg8myzPKXI6RCDcRySZ3Yjd6ASW8Uf3X
	15INK6Hiyludyb9UJsVUpC52pAksqzC8ZMuzln5Bqsw99zYvIfUMz8xT8AdHT8RIRIyGXMCwPSo
	xCbza7S1X0TCOnJNufnUjRzeGvoti8ru+SZDYgR7hzB9Ng7LKGF+vuXRXK9NwYxx1OIzD+gAYKq
	lz9vMpOqHPMd5chczL74dzN9z6MuIwwV7houSPokeA5wnYfCDRNRgBVjpplNvC/bwPmEiCgxeTa
	K12Y1rzkwWwAoKkFPFy+kWNKlnhzhaYB9rNpGrFewtTsEFkuQyfccPUF1fOQKy2aV9lB3d1GHHl
	cI98cD3vvZ+vT+9D5S8bAI27wfkId9aqwslIOSM/0C+M7urQIbIJCpgH/0nQ7P0IQQ3ACD6BlI+
	4hG27iQ8RNQ==
X-Received: by 2002:a05:6512:31c3:b0:5c1:4f6f:564c with SMTP id 2adb3069b0e04-5c1709c5b64mr4239145e87.39.1794851536662;
        Mon, 16 Nov 2026 09:52:16 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171333630sm3391252e87.19.2026.11.16.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:52:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 17:52:10 +0000
Subject: [PATCH v2 3/6] media: uvcvideo: Use bHeaderLength for payload size
 in stats
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
Message-Id: <20261116-uvc-shortmeta-v2-3-62d4a8176fb8@chromium.org>
References: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

uvc_video_stats_decode() does not take into consideration extended
header data (e.g. MSXU metadata) when it calculates the payload size or
decides if a UVC packet contains payload data or not.

Use the correct size (data[0]) instead of the minimum header size.

Fixes: 7bc5edb00bbd ("[media] uvcvideo: Extract video stream statistics")
Fixes: 25738cbd72db ("[media] uvcvideo: Extract timestamp-related statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 8bae91af03ba..ac8e0c3a0c71 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1016,9 +1016,9 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	 * their first empty packet ?
 	 */
 	if (stream->stats.frame.size == 0) {
-		if (len > header_size)
+		if (len > data[0])
 			stream->stats.frame.has_initial_pts = has_pts;
-		if (len == header_size && has_pts)
+		if (len == data[0] && has_pts)
 			stream->stats.frame.has_early_pts = true;
 	}
 
@@ -1047,15 +1047,15 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	}
 
 	/* Record the first non-empty packet number. */
-	if (stream->stats.frame.size == 0 && len > header_size)
+	if (stream->stats.frame.size == 0 && len > data[0])
 		stream->stats.frame.first_data = stream->stats.frame.nb_packets;
 
 	/* Update the frame size. */
-	stream->stats.frame.size += len - header_size;
+	stream->stats.frame.size += len - data[0];
 
 	/* Update the packets counters. */
 	stream->stats.frame.nb_packets++;
-	if (len <= header_size)
+	if (len <= data[0])
 		stream->stats.frame.nb_empty++;
 
 	if (data[1] & UVC_STREAM_ERR)

-- 
2.56.0.679.gc527c65306-goog

