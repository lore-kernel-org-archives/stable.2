Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177249;
	b=je0qZAZ+QLiXdu1nRqecbWpyzkiYdK3POS7MRYW1vlPhAwM2zCUEBwlYDLExPA6phXpP
	 1oc/5HgXcCcO/Uh3BnK8E78/LMxX9fNHKOA3UOv2sXhbDBpfp9ii/4+6YyKOkoomYmHsW
	 5pK2ylILJ6k7rGa9Jmj7AgGKNNnXXqE2ii+L/dqrxIxdGpmqLcj7fk7tJsuPZ0puYVroT
	 Li76/JcjZsUAHy36zXqrCCh1lyP/JV/lv3LUiPFinLZ3vkuTPrcdQ3KMHT6bAgtJWfNxo
	 vH/UDgfbWsZ7hcT0LwctKSIeDACghN90ePgaxJtne6HKxOXPnvh86ThBtaBazkQ68IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177249;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=aI4EIZNxMoprUdCGvASntRDiuaop22syyWJWgaD/hhQ=;
	b=I6VM9e0n+kQ2r6CHqaZev5JhFxJWR2cx7Y33mI1ZzJ5usgfATuZGLFQKlsd5HRhDerCY
	 eGBrFrhKJXjVuXIvKqWohwUx4UH81l02DkvTlBQZv/L2FdlMoFAgavvabAPHMZYltvTej
	 yeEPvx+ps+eCMaEdMYgMcQZSvztKPDVhAFmvJiDJtwhw6RoBgzVNcoK1Yha4pcYUjAf/g
	 vc2H3NQ9irzcTvz2NERMs+jjgfmMrAinyL7ZL+6DUTFm3qb/4uK8U8rUlDRCX4bJvEhvp
	 HjDzpY5C/QsZw8qMNoemDPYH1nVGxxHaDnYZmu71bykCw6zvZeg95n1oznYFTq5wxHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibaCdH5t;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B8606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 155B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibaCdH5t
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4B37F4E41363
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:47:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 208F460769;
	Wed, 28 Oct 2026 08:47:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8341F10329092;
	Wed, 28 Oct 2026 09:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793177244; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aI4EIZNxMoprUdCGvASntRDiuaop22syyWJWgaD/hhQ=;
	b=ibaCdH5tkAp0DtD+75ioGw2Cnp2kETxctuNsXOB/1f1nay7k1cvwX4JmsqY1nPul+r6pmL
	+xYUJ3bEcfiOwsipmrX58FzJMujtPxcdZQgx0e62jgYGWxWsMaOuQeaCaa7DkUDSlU156j
	RqChiRje1hxkPc+iL8m09rVlSIDV65RWyk7KxSBG2ttL//RoEZkrlfb3VeCyQEyHf27n8W
	YhKYs6TdrCOiW/LPPFdqEeysloI1tmjxwaglV0gGQxvLNIkzy5iaNvYFdQ03Q89YPySJ3Q
	3L71qUtIKbC0scW3ARix1+I3BQphT+k1m287ChvM9EFu5oL2AlyGCfrNWWDseQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Umesh Kumar <ukumar@marvell.com>,
	Shashank Gupta <shashankg@marvell.com>
Cc: thomas.richard@bootlin.com,
	maxime.chevallier@bootlin.com,
	gregory.clement@bootlin.com,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 3/4] i2c: thunderx: Set DMA mask
Date: Wed, 28 Oct 2026 09:46:51 +0100
Message-ID: <20261028084653.6458-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028084653.6458-1-paul.cercueil@bootlin.com>
References: <20261028084653.6458-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

Without it, MSI-X initialization can fail.

Fixes: 4c21541d8da1 ("i2c: thunderx: Replace pci_enable_msix()")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 3959f23fc440..2208337e649b 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -198,6 +198,10 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	i2c->hlc_int_enable = thunder_i2c_hlc_int_enable;
 	i2c->hlc_int_disable = thunder_i2c_hlc_int_disable;
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret < 0)
+		goto error;
+
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 	if (ret < 0)
 		goto error;
-- 
2.47.3

