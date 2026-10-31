Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456094;
	b=fRNPYeCkowBwAcztNVUk7qsq3ZARWXb7MeKyOhffr1kTCTC58baaSuMNfCqemA7lsh8P
	 QLNTVoYn40/C5wAoMGrV1a6M1PaJrn7UiVHMJBGOhrWH/q3bqSUMMZM9s3UhNTsX7L8MA
	 97tha6hgo1eHcsp/ANHYHcOQK4Hv+9CsfnMBwVBKqr58VapfHorqDLsMyrLnkYRI6lP+U
	 kVq1ga57gEeuIk952b2IV3oGmngyKUNOJ/haUyeCWp4WgSe8UkQZtqBfpUj4uwX+mQiWT
	 9CApkooQJfxzah+uyNhLIwFKafVmaW7ZzO5qjAznrGInog92DmJTuOI1p6R8qBbjzuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456094;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=dLfGjB5/bNYF1bkGN6xxoI/qGxpyUkDnj7InTq3oPOQ=;
	b=10W7YUdJBLdI9FLqOfbyyrVormvHi5DzjsJKWEGlahacbRzaphltFFF7D16IlDO+Y7a0
	 goaTIvDAHoLbiNhFibWRg57bejZdXhcHDUqU6cXQhw4Fxz3iB7Koh9eKqsxFwlEmekqYv
	 T5FivBsyRASlItktFGKcHSOG/+duzZLgAKtxCBqmqwiXxpGusn6VyDoyKwcf029tGGuf4
	 fTK4Je/wcIgFriOAMR21imHL7MOID3yaBXKQkpAhxXb+tmw42yxCteu4m67Jmr3Gug1O5
	 MNXPa6h3+NGrrWZ0gd0zZWrvXTLelgFwPOAphsjXVY6v2ut75IRzm1wKoysqY0UtKyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=JrifTBuS;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB4606A31C;
	Sat, 31 Oct 2026 14:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=JrifTBuS
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53071d15f;
	Sat, 31 Oct 2026 22:14:45 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antti Palosaari <crope@iki.fi>
Subject: [PATCH] media: msi2500: Fix potential resource leaks on video registration failure
Date: Sat, 31 Oct 2026 22:14:44 +0800
Message-ID: <644df9eff4356d494f87c344f7c30c4f0e092eec.1793455789.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa19250193503a1kunmbf44fc0a86af8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh5MVhlNGUxLSEpLSk1KTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=JrifTBuSX+iWlihjLRDQVtFNWG8S5GE/OSLzaUgkkt4DlF1RKrZEsTMohZaZ23cS+AJCl5tNew8fgDGhI8FG+S6l077I+b+lP7pX5Fvs+3ypFxi52vrPDaDAuH4JBow1CyrFXuolNR3yxoOmGjScJcCk+Y1rturtmGGysimEv2o=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=dLfGjB5/bNYF1bkGN6xxoI/qGxpyUkDnj7InTq3oPOQ=;
	h=date:mime-version:subject:message-id:from;

If video_register_device() fails, probe skips cleanup of the control
handler and the registered SPI controller before freeing dev. This
leaks control allocations and leaves the controller registered with
driver data pointing to freed memory.

Jump to err_free_controls to unwind both resources before unregistering
the V4L2 device and freeing dev.

This issue was found by our static analysis tool under development.

Fixes: 2e68f841a5d1 ("[media] msi3101: use msi001 tuner driver")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested drivers/media/usb/msi2500/msi2500.o with x86_64
allmodconfig (GCC, W=1). Rechecked the complete probe rollback.
No hardware runtime or fault-injection testing was performed.

 drivers/media/usb/msi2500/msi2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 282256ab812a..2a2773722172 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -1280,7 +1280,7 @@ static int msi2500_probe(struct usb_interface *intf,
 	if (ret) {
 		dev_err(dev->dev,
 			"Failed to register as video device (%d)\n", ret);
-		goto err_unregister_v4l2_dev;
+		goto err_free_controls;
 	}
 	dev_info(dev->dev, "Registered as %s\n",
 		 video_device_node_name(&dev->vdev));

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
