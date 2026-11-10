Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794282990;
	b=17Q9/90EA0Yac5L9mQ3iQQ11D9mMc5Fft5EnEYbl3NqDFXGEyom/3JaQ+3R9O9kdT6AQ
	 AJwfNc72MbMAItAQUiWy5g+bD7FCk3ozUYiinxOWQLGeZTyXtIILNUXCNDrTrvI5Q046R
	 unF9MHGRFlhGBOhhtF+6qlq1Gs0YVHnMlkxidK5nMdzAOfOC7SYhlBhJ2+6KX0VdivJsJ
	 uE1YWs255jAarhjPl4/XfezeDygtrzt+0Rp8tD6ilboWuGa62jVCn1G4ZuoPeOB/Ed4V8
	 0axbpL4wycrL9l8pCiV8vCCs4nDbbloi6nZZ6buhPGkw+VOCBdpI6yRLpuWd+pB0BOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282990;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wkEZeGUNNUJyDN1i17FkxdnHrfcoT/0JG600jD6fu2Y=;
	b=zNagXLVM+/1EjVLePIsHvcxz3dvWbUWczzO39WkrpQbOyLoTdHscjL73ktnABZ236XKx
	 wZBIm/vi/RqsJtoXjJUfeP8WJK5obWzkiujHsUlf0xDBVtnQejq6tzcDF6fJd9XD6r9JT
	 IR+1JDrHasn260botxvbkHecvG6/W+YiSztk2GxSCWQbf+S2l+CaDE4+qUkHIINAK/VP6
	 aQDEr4j+yxxDM6+sT4nk41KZAlOED9EWPokXN6Fr7dzYPQ7+nG2NTR00bxWQ3X8PxTC7b
	 8SrXG/00xVSw24VQbK5IVV9khiw6jNJlk488silXrOamEw1ong7KnlsmuGhKgUvIh0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcJqEVXG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF8606A332;
	Tue, 10 Nov 2026 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcJqEVXG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794282989;
	b=m0A5VZPB6YiIg1z0RKA/LsvZNdtZngfIFnMrn28iYetEj4HPQYnq1oFuaGiNhl1x4iLT
	 dRdrWLhCZ9O1spbHzxHGLmgZeRuh44tOww89yGf6T48p90/JdfvVQTY8AqgOhC6sDOp/U
	 0VYFQ+iAMNKTdy+Zccpu3lTjSHcYWQLZ3bzCR2wGQnfUAdDsIlXcuB5mA8jmzonkd1OQO
	 zSuWcE2el5G1SQjffLqTQdk0Wk36ooh05lDpNXAJlKWkV+Xb5BC7wc6RnCVAqg1zyp7vQ
	 bMyquL2CobvEm+n6Q4P1rjGkTjAmX4gzbrLBcj0oboqIem5hBVHeMzdIfJ5kc9PqXPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794282989;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wkEZeGUNNUJyDN1i17FkxdnHrfcoT/0JG600jD6fu2Y=;
	b=P0IjY6e5vj2x8O4pjqYNWEBU1/6pkNr4IM2x0UDAO45v5rPDvSC6VfogkOywa+BaZZfE
	 0e+wRf5srCeNlLXhRFEGlRcKafp5P8sL2Az/gtLzrqdQ9Q/sBQmfMfsV3BJVU45Ioy7Za
	 rEdybUffIIuErjQgg6pAgE4yATQda9xMh3ywijxoGikwmNkGz3nCgzySEpcchhcHI4Zzw
	 5eQiv6Hyw73qT1Ww26akFe+/9NEoWoNKWYfLB3H25Xmb1VCm3mC7Dg1z580g+V2ohXBk+
	 vDqIhV9ESh9Okse5YrKi6nszgLnUTN+ITWWHQo4LP7g6NkgPSGiC6rNkAtr5Qk/NLOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF5961F008A1;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282989;
	bh=wkEZeGUNNUJyDN1i17FkxdnHrfcoT/0JG600jD6fu2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mcJqEVXGuPDHUnCgIwWGBQy7XGhejPblAHqXWqZHoqdIUyHMXGcYOrRRTCWPaQJAo
	 cNnNRgpjT/WZeU2slEWG/C3W9OW3fBXibrqUG0JBj/72yUbmay2OCstuc2BFjliaoM
	 TUZ8zZFSmR5A4GtKX24p+Ov6tOUgmx5IKOmoozMXeZM1h1VQTdq5MqTa8koAEQf7/j
	 HZrkEpwJ8yoVlIeQTlWQIBWF4Eq5BPiSswVlyTDgNKS1OxSPwo5VHk2SPnIXMYEsQ6
	 P/i/f/vLfvvCJbj60Miw7a4RPO1X4yGDV+DhfG4kX19ldc/rQAzo1uGcw1xavkW1qM
	 8EPjMzzt0DE5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 603B0487E5;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:56:28 +0000
Subject: [PATCH 1/2] can: esd_usb: limit the number of nets reported by the
 device
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
Message-Id: <20261110-esd-usb-validate-v1-1-7ee499b4926d@gmail.com>
References: <20261110-esd-usb-validate-v1-0-7ee499b4926d@gmail.com>
In-Reply-To: <20261110-esd-usb-validate-v1-0-7ee499b4926d@gmail.com>
To: mkl@pengutronix.de, mailhol@kernel.org, frank.jungclaus@esd.eu, 
 socketcan@esd.eu, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794282987; l=1647;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=xaRFfiQi+LE78/iydRbgfL5xgKrJdnS3XrPXYUllshg=;
 b=pFELmjGayKDc9q2M+73NCZukOJtkYOTlUlrwLtLE6l3tJCBXCpfk6w40WpxU6W8QIB66Gr3GK
 v9KnqMm8GcuBA823tfFxrAVElIsoHCmA7Uor2D5b917ySTqYupZT9UB
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

esd_usb_probe() takes the number of CAN nets from the version reply
sent by the device and uses it unchecked as the loop bound for
esd_usb_probe_one_net(), which stores the new private data pointer in
dev->nets[index].  The nets array only has ESD_USB_MAX_NETS (2)
entries, while the device controlled u8 can be up to 255.

A device that reports more than two nets makes the driver write
pointers past the end of the array, first over the following members
of struct esd_usb and then beyond the end of the allocation.  The
loops in esd_usb_read_bulk_callback(), unlink_all_urbs() and
esd_usb_disconnect() read dev->nets[] with the same bound.

A malicious USB device can use this to corrupt kernel heap memory
just by being plugged in.

Clamp the count to the size of the array.

Found by LLM-assisted source review.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
 drivers/net/can/usb/esd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index f41d4a0d140f..f26a8780686f 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1343,7 +1343,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 		goto free_msg;
 	}
 
-	dev->net_count = (int)msg->version_reply.nets;
+	dev->net_count = min_t(int, msg->version_reply.nets, ESD_USB_MAX_NETS);
 	dev->version = le32_to_cpu(msg->version_reply.version);
 
 	if (device_create_file(&intf->dev, &dev_attr_firmware))

-- 
2.43.0


