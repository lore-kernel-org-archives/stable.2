Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506830;
	b=Assnra6oPAW/uU40Pvajs5UBmFlgqPbDpAw3uq288Ziy5PuC2VsGumR8V+WVd/G/yW5V
	 sPHORDRaYQ79lM/qfFmwqxJ27CxMuYt6kMhvkkfo9dOgibuGTkmecjuYjTYRCh39zkzaX
	 q/GENRDMJBwhTOYMkxJ+MH9xFeuv6PRkQMZZ0HQH/7dRcQhxvCZWKCmlmvd7WjLlWZo2P
	 3CqjNYjBtRe6st31XQKejvApn2sKblPHQYne9Asxr+C0P2WE6A6Dl19Wbx+Zk8nRqpHM9
	 A57QrQxRrKSyN52crJo+RR0uNsp7rLCvW5WNxJHdAHH9nyy+iHSO3PaGliFriTDgk0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506830;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=MvXYGUokLQK9Dpvt3WU6+mLNEmr/sUmdQTAq+bivxy0=;
	b=3narDKk+bDoECJZ1kKjG0yE7gdS7NmuCuSlq09Tzkw0cpgG9NQH2iSdynXBiizZYXgsx
	 DAebDAqYXJMLw8ZqlnY8fvXIpemAJ24FoiRPmYoz8LR0wvB+clE1WBFQJKUBzmxyZOvWI
	 QoD1I+6AsZ014Cxed2WQd4jC+Qfqg2ZRbemkvE1bwzq8yYsSKjw8tLrDmPVQniLeMJ7Rv
	 4Gum4yFV5gNeMyWYkp58MQQcTnZORhquNyC/L30TBb3TKEaQKB9X5qJsX2qYH2HDvvsLZ
	 gf44dpKOwzvWZYMHLygaF8UzYFM4ALl3D3ged5wHLQyNKwyvfpPG1mCr9KZdEPbSGzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="M/jU848e";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE63606A334;
	Tue, 20 Oct 2026 14:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE63606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=M/jU848e
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88898A1627;
	Tue, 20 Oct 2026 16:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792506827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MvXYGUokLQK9Dpvt3WU6+mLNEmr/sUmdQTAq+bivxy0=;
	b=M/jU848eDL1eex6rULHc6nDPa68O6M5l+EE1eZ0Ug8fblu1k+y5bUGC/N7wJ27yor5iG6o
	Xfm+yAJqV9L46bXxiGAm7B2tkRESGRoMu1csK9E38oZGCM8d0k3F13LFZ+HqMTxFRkeXTn
	9e0K57WLLFfUgB2VK5klk+54Jnq/RL3m9MYiYjVFgqzSJSO7AcY+ajEa4N5cvO9I2Fam9O
	6Gv2F4GO6xtNpYHJ6d1OIH4+jqm0ZGSwipEfFN0pjNW7MqEAIvqsearnQsvABzNrndqh27
	V+TvaCWHFTHph/BWH/SmXpULWmO40JvGJ56BYRsjQvJPBhhHmkEEn1wz/v+Fug==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:33:40 +0200
Subject: [PATCH 3/4] usb: usbtmc: add Rigol DP800 and DS1000Z to the packet
 I/O quirk table
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
Message-Id: <20261020-fix-usbtmc-short-packets-v1-3-903f4d029193@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
In-Reply-To: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steve Bayless <steve_bayless@keysight.com>, 
 Guido Kiener <guido@kiener-muenchen.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Rigol DP800 power supply and DS1000Z oscilloscope families also
advertise 64-byte bulk endpoints at high speed. Replies are cut off
after the first packet, and writes larger than 64 bytes fail on the
DP800:

  usbtmc 1-1.3:1.0: Unable to send data, error -71

Tested on a DP832A and a DS1054Z.

Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/usb/class/usbtmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 679ab5908e203..861913b9de918 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -60,6 +60,8 @@ MODULE_DEVICE_TABLE(usb, usbtmc_devices);
  * device's packet boundaries are preserved.
  */
 static const struct usb_device_id usbtmc_packet_io_devices[] = {
+	{ USB_DEVICE(0x1ab1, 0x04ce) },	/* Rigol DS1000Z family */
+	{ USB_DEVICE(0x1ab1, 0x0e11) },	/* Rigol DP800 family */
 	{ USB_DEVICE(0xf4ec, 0x1220) },	/* Siglent SDM4065A-SC */
 	{ } /* terminating entry */
 };

-- 
2.53.0

