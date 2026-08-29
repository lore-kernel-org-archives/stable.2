Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6934887B
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788035735; cv=none; b=EyYZo4wa1KFMvt1cUSLZI1DXOh5hRDnZ/GY4cO4Flz9m4+3DzSsfEwN/L07JM92utYIxsz7GBEKQ5lUaOEHjGuHBx0j12xfdH5HlosbH4CDvr+ULGXXHMqhdJ7KFUkac6+BOlXqhTSGEKub5AoVoK8nt5Pvc/LE/QlfRXpy1dQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788035735; c=relaxed/simple;
	bh=26UloDN3pckdO1GiQm553vAEBFScY+P3R3riomFFHFo=;
	h=Message-Id:Content-Type:To:Date:Cc:Subject:Mime-Version:From; b=P3b+3FvrMSF/vjHdaFPOmbXxS1YxsmPTJnshuPubN2Y+Dmh5dqg0CM7F9hmwbYTDQ1zhMwMJdPfGF+G22bpMsFJ26o2zBpCKjSVNe0PDaa3vHLd55PcJZr+wUyzc9X7L3qw6wpP79pHgnbbGU4Ltt3AHSGl8ZCD2UmOs+jcp9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=y5fXMTBi; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="y5fXMTBi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788035718; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lFVqAV4JkcIfwSJYin0Cux+02hj1M9RyVM7CgTQPVgs=;
 b=y5fXMTBiQZmyI5BjlaygOLEYtbf4P80sXeMPZFUyanREY7yHs6cdyVObGIwUfj9rouBDeK
 TI4kYzGBAHCzDSPaT9QAPEn0BshgFH0M/XGf9P6xHDJLqeEGfgReRBUHJ7EyLNEAdxV96e
 Wnu9UZiqHCRBHbb+MQKpkrKpBFL/MgtQ3WrHveBFbfYJn6NRybwaieCm63kfrteyOls3Cc
 /Pp9O0G+8QIUjMsQkEWV6OVF3bqPpKNNNuGMCuBFXS97kBUyQV9wzbK+iAYLfvVGg6d5vi
 gIaMOn7Nl8Q1fDaIf7/TwPSvNjfHXrkwPEopMezkYoEZF4WYeqsVGIzySZEG+g==
Message-Id: <20260830-enc28j60-cancel-works-v1-1-4c40f17d401e@cherr.cc>
X-Change-Id: 20260827-enc28j60-cancel-works-62a0e02806af
Content-Type: text/plain; charset=UTF-8
To: "Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Claudio Lanconelli" <lanconelli.claudio@eptar.com>, 
	"Jeff Garzik" <jeff@garzik.org>
Date: Sun, 30 Aug 2026 04:35:13 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a934284+56bd7d+vger.kernel.org+me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAIBCk2oC/yWMQQrCQAwAv1JyNhBzWBe/Ih7WmGqqpLJpVSj9u 6seZ2BmgdBqGrDvFqj6tLDRG2w3Hci1+EXRzo2BiRNl3qG6cB4SoRQXveNrrLfAxIWUOFMqPbT 2UbW39+97ANcJjn8Z82lQmb5HWNcPZsXkA34AAAA=
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net] net: enc28j60: fix use-after-free on remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
Received: from [192.168.9.107] ([111.40.58.194]) by smtp.feishu.cn with ESMTPS; Sun, 30 Aug 2026 04:35:15 +0800
Content-Transfer-Encoding: 7bit

enc28j60_remove() frees the net_device without cancelling the
tx_work, setrx_work, and restart_work items the ndo callbacks queue,
so a work racing with remove can run after free_netdev(). A queued
tx skb is also left waiting for its transmit-complete interrupt,
which never arrives, and leaks.

Unregister the netdev, free the IRQ, and cancel the works before
freeing the net_device, and release the leftover tx skb.

Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Found by source inspection. Compile-tested with
CONFIG_SPI_ENC28J60=y and W=1; no ENC28J60 hardware was available,
so no runtime reproducer or hardware test was performed.
---
 drivers/net/ethernet/microchip/enc28j60.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537e4..d16564060fbc 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1602,6 +1602,11 @@ static void enc28j60_remove(struct spi_device *spi)
 
 	unregister_netdev(priv->netdev);
 	free_irq(spi->irq, priv);
+	cancel_work_sync(&priv->tx_work);
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
+	if (priv->tx_skb)
+		dev_kfree_skb(priv->tx_skb);
 	free_netdev(priv->netdev);
 }
 

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-enc28j60-cancel-works-62a0e02806af

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
