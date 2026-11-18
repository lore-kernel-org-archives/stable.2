Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011849;
	b=TKEY6UXdfP3vc14JLZVuDBwick/DI2kbogK8YvS1Go30cKUTH8SmoNvpF1sdwnQ44D+J
	 qbTKaoOrxdMQrRBt9uDylQYoQNEHRQjQXhu5J/p1g/ArakViwHJCI6R+80K/qDuxe4AZ+
	 6QG18kRMR+MMGsmsCcoEZoUTAa1NzjWGghqIohlXNi6hEyybgYa2uFCczkgeHW3C4SIyi
	 1caDwt6sGwQEIkUFDlshOd1gbotQXBZDZjTmwo7AzS7R917yPxxAgKTllgVQvbZe0Ibzi
	 T2qMzL0h3HbDDmNxzjRz+T2xK2Ed9Jwyt1wSMe9X6UOnGuaP9cgvPzdaM5jJKXnMdOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011849;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=qcG22THrX1tBMFAvrDOfvEwAgm6z3zDwUorQZyGxp1E=;
	b=IRRPGGBuy5GwHyV8dLH20TW81PHqiBDkHbm6HcJA0u4rzB0lhD7WPAfQ6t04uuIRsiBs
	 LtNzPt4CAjn005TDtJnRgtZr0aEttNfdijfkzPAFPWYXnr/cEv+jdZ3CiR5a5u4LefHKM
	 0r+EtYyufa3Is1etGDGHogYSwYxWBDuajB6q0VCJ0zvRkbo+1m/tw+bsPtb5mRSPAuJNC
	 /GzKGyLHouAPedKk3VFERSWdm+LnLB04xYZha/uRGP2sbu6uu5toT+PdzkpzEdUZrduVs
	 C49tJjOCdaS16ZPFzCU5QohUs7z1v8FvkyLIHM/8LGMrvMPZkCmzy47zg0tu0Z4bg5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P3jKiZeA;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FF606A32F;
	Wed, 18 Nov 2026 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832FF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=P3jKiZeA
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d79a1;
	Wed, 18 Nov 2026 22:24:02 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-i2c@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: tegra: Fix potential use-after-free on DMA provider unbind
Date: Wed, 18 Nov 2026 22:24:01 +0800
Message-ID: <20261118-324f82bd41-i2c-tegra-0@mail.sdu.edu.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ef0b100403a1kunm01520eaa1a13db
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh9KVkwYTENDTBodT0JJGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=P3jKiZeAgwDA1ZgAVhnFZvBg0T8mZO4fQa6+REDhUANGT8mnxnmlLAm/FhCHFoy78l2zkSGfrhCIwHTxAMKiv+H7u0CnyAVUMPOP7WZns9vFtdyeAvuw5nxIM4WZRhPJcJAl3bbkH0nJXt4g+7uO0+E9CgFEHda1VG7i7tZ1x+E=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=qcG22THrX1tBMFAvrDOfvEwAgm6z3zDwUorQZyGxp1E=;
	h=date:mime-version:subject:message-id:from;

Unbinding the DMA provider can free the channel while the I2C driver
still owns it. I2C removal then accesses the freed channel in
dma_release_channel().

Add a managed device link after DMA setup so the I2C driver is removed
before the provider, even without firmware device links. If the link
cannot be created, release the DMA resources and use the existing PIO
fallback.

This issue was found by our static analysis tool under development.

Fixes: 86c92b9965ff ("i2c: tegra: Add DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/i2c/busses/i2c-tegra.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 76d21bc51c61..306658e40d4b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -731,6 +731,12 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	i2c_dev->dma_buf = dma_buf;
 	i2c_dev->dma_phys = dma_phys;
 
+	if (!device_link_add(i2c_dev->dev, i2c_dev->dma_chan->device->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
 	return 0;
 
 err_out:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

