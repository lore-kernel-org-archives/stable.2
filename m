Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012031;
	b=oUcgLhbift4VXmov7Q3WqCCGURganwP3SoYFx1IvQ5ZSB3/EAUy1b7jfhqL3p6cB5GWP
	 ZavtytreEvn96R4C3bso6+vV0sIx5mar4eTeWau2M8TPWh0ac1hDIMAcaNCyqPV3LTXU/
	 VJ36bWLOx2y+4ZWzwpYh5VzYuT03XIyxeH3chCOsyAgg1unQbUy4UPOKqtNXEI0n+/oXg
	 rLkyp+x4N9+6N2XOuNycTk5riUv/6IBQh9SIkSplxLgFCuk/ck1cskL7zUfyTySarGdIC
	 h9uBBeDFz1p1OMFrBWI5kNMEFbyZ1mv+K2h62Xk1uUEF2BcIc03s9G6JvfsWGRfdvvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012031;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=UpWwI3eHc+vu2HtOq57i96kXlseffnJLeJr41+InTQE=;
	b=jnZ2Ra9gpy9DMfoUIZUVrF199CabKHF2BDspBrWyaZyJMCB5lan3pI4e1SCd8reARdoC
	 /Pm5iTRBKaXogGjN8ZRi+DO1mCowzlp1WFj6qkCsl3Xi5utOLlKsJqBqjs+uBYxRg9xBh
	 38MNSYB3ynkH2Ka9zfscjpih0TEhq0QkE2p9nB43WHVQCxzsXsKWKDBoZywgJcd9T7U1m
	 6+hyKneTy5yd827Os0nFRv11SPAbj0NaJ3ldfSLpca6HeO1qxngSJ5pIUVzR8S/vWJahD
	 EJDKdfLhftMIHKYn7/VDtj93/7Cocb1gkLvRkw9zX7r9Sk49YeX/N9Y+Icw4zTmERig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ClUOm9jX;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE96606A33A;
	Wed, 18 Nov 2026 14:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE96606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ClUOm9jX
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d79ea;
	Wed, 18 Nov 2026 22:27:03 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: ti_am335x_adc: Fix potential use-after-free on DMA unbind
Date: Wed, 18 Nov 2026 22:27:02 +0800
Message-ID: <20261118-324f82bd41-iio-adc-0@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa1ef0dd56403a1kunm3beb00b51a15ec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRhLVkMYT0kZH08YQ0tKQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=ClUOm9jXxBA2klnT08cuTgFe9Le6AIFdMGc1gR5tYhEUif7BV4hUOCyRXCke5Za/xTZlJSfn8TTO3zJFbJaesU15WErBErp9/sg2FCxrcjAM6cuUx38P+t5BRC68eS1Ft9Kw/W10r/pqQ61TEim6AjvlSebFmYflUgCJdIob/BY=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=UpWwI3eHc+vu2HtOq57i96kXlseffnJLeJr41+InTQE=;
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
 drivers/iio/adc/ti_am335x_adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index e53c839e87ef..07d6dc7f0355 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -547,6 +547,10 @@ static int tiadc_request_dma(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (!device_link_add(&pdev->dev, dma->chan->device->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER))
+		goto err;
+
 	/* RX buffer */
 	dma->buf = dma_alloc_coherent(dmaengine_get_dma_device(dma->chan), DMA_BUFFER_SIZE,
 				      &dma->addr, GFP_KERNEL);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

