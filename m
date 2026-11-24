Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528719;
	b=4SaPTIneJGIs5gQRfej/2icxOMuaq88TzmC6ftmi2ueE2JRye/VBjG6sSYdCke3pzf7R
	 WsiZ3Nn+RtFRQD3RHm8H1LP2im9DU/T5NaZXvK0pi7xeeTmt/i7ECCFiUPSRH5vvpoMBH
	 SxtP+7EOlNTAeDKh+lDcX8aZx5cnwn5FLpL2TMF+Q1rOsrwz77Juh/6KC3ZLzrSUoe0eS
	 yz9LGUBqz/+CVCGf+V2h74CZYY7NLbJvQ1DQAt84nDNj2q7r8xxBwBbdY8sVQYiTp11B7
	 +C429jvVO7NmDFiMRmx6qJQcvuaOgpXCAS/fX3/LfDKGkr/1r7AC877vAkyowH9QNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528719;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=JbC4PGXeNQYt83pxY8JXiDjUk4U9HQ0DbJyhggtLv2o=;
	b=Gc85hKnyh/U954aQKI8ZK7Qwv6xA9Kk10SJMxmQx2W98Vl/3jx+x3uH7Lalv7nWCxZvw
	 dG7WgkDelT9ZaeSL9UOl+2yY6fwVs9fpEgFSE3lTOPKAB1wAdi8CZ2GqMn6SMi3gwJvTH
	 QLye9uVlIZqCq10az2ZMAGhfcI6HNFjHfF1GjfOQ9pQ13EEkl4o3tx7qbLDoOEVu/k37H
	 s7t24zGnVWE3wLRznqRgrlNC3qkEdirXfX+wqRSEw5GvtSxBz4XMjj9bFDHXSXjjCHEPQ
	 GpF9J3JuOKByeYFBxBxfsLToa47Gcs3uxu+7Bo+DZ5NdFUFurSGZ3nh1CB4AXKht77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=NeTFzsPL;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFC606A31E;
	Tue, 24 Nov 2026 13:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEFC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=NeTFzsPL
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb99;
	Tue, 24 Nov 2026 21:58:31 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: adc: ti_am335x_adc: Fix potential use-after-free on DMA unbind
Date: Tue, 24 Nov 2026 21:58:28 +0800
Message-ID: <20261124135828.2274815-1-liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa20dd9dcc803a1kunmcddb6b51342489
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUNNVkIaSkJCHRoZGEJDGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=NeTFzsPL8Zf+hyGjMSnEq77JuiyIi6oknvOZrAk5Ulb1zoWYs/Dh5i2CHZkvRnetknfFMuo6+/CTc+74o/Shcz1tfttNDnoXCkjjnFfdcMz29eO5QRp7tUj9b6Il+sFkIPROFMdKG6ZVXvMBlHEzsGqpV8KDgXKj+vWSR7mnfOA=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=JbC4PGXeNQYt83pxY8JXiDjUk4U9HQ0DbJyhggtLv2o=;
	h=date:mime-version:subject:message-id:from;

A channel reference does not keep the DMA provider bound. If the EDMA
provider is unbound first, ADC removal accesses the freed channel when
freeing its DMA buffer and releasing the channel.

Link the ADC platform device to the provider so the ADC is removed first,
including when firmware device links are disabled. The driver core drops
the link on probe failure or ADC removal.

This issue was found by our static analysis tool under development.

Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Use dmaengine_get_provider_device() to obtain the supplier device.

  Backports need 61527d7e6998 ("dmaengine: add dmaengine_get_provider_device() API").

 drivers/iio/adc/ti_am335x_adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 0c3e0e9e8364..c7f8bafe0f4a 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -546,6 +546,11 @@ static int tiadc_request_dma(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (!device_link_add(&pdev->dev,
+			     dmaengine_get_provider_device(dma->chan),
+			     DL_FLAG_AUTOREMOVE_CONSUMER))
+		goto err;
+
 	/* RX buffer */
 	dma->buf = dma_alloc_coherent(dmaengine_get_dma_device(dma->chan), DMA_BUFFER_SIZE,
 				      &dma->addr, GFP_KERNEL);

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

