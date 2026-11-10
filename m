Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354533;
	b=3ATjYINU23RVPBchHdpeLja1feyXxLZjoRfmDApiFkANa4dYkN4lvTwpgaMRjrl1YrE4
	 2SoqIFu8bgb2cTP2rCDUaerPbYDdowC6Fbab4eUrPdpwv9Uz0K/CXGBrdkABTw4RRWi5t
	 fK8F8nqQP2JQU9RfY3HeY1aeRYBB47zk6/YLLQuiMqzuXsvEseQ35MD9wOAmiBNrrtpPt
	 /BzlKnj9W7flWDbZrE9ONsS9EdBaDAYK8C6X/kJEI8fKrB8s21QaojKPix10JR7tKpJyZ
	 TCI2uwnA5e0tlFUA8hjxzW/97h/DnwyA7AER1ju/A0cOTjWabuJ0x8aSSLhatrsUyGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PmiFN8JAMxvh1RNGMA+Zd0z5kJig6lVReGRLgvWv6RE=;
	b=uHZTE4Ty8RvLVIdxnOIXc9hzKynjoSXa7iRCx+9bTcHYnuZ686j3OIce0SSsb4fWDUzy
	 drgM1NvFA1PxtFSquxBG5PS5nutf72SoBuNBujQFowrRKpAr7Gl8W4Mc74cyW7An5cB2v
	 TbRU8OJVzOHarMuUYVcm80qxmVpQy2SYDLRLKHHMlyqNYdLsJBMEz1UyOmrl63FeUlHYt
	 pEBsAMlues00VCe3lUW/vCs65PJouD+cC29Wbd2JhJKdWfxv8PPI4QTWktJelQ8a2gqmj
	 D9sWrpQQOMht3ALnpcbO6A0OV2QUFjMm2UIw1qzhxZzMDogo86T/xShmyu3lWmpfeYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeVNe9tU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeVNe9tU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5961F0093C;
	Tue, 10 Nov 2026 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354533;
	bh=PmiFN8JAMxvh1RNGMA+Zd0z5kJig6lVReGRLgvWv6RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeVNe9tUkm6O6HOcmwRf6amUN2wpBd2b3TzkMoa0Os5fMfsQO1eUbWKyCdlVbHscu
	 McdVMX+Jm5lXuvkdDRyNKscrEWgHc6bZj4TL6EeAVegfb9a4M4a7zMWiitXxwCs0s8
	 sY5nElbY+jfI1D6y/i1jT3yLGCWca6bZjyYeLc3mpRd4OfMiqmGNxSlzq36biJb9q8
	 PJKIr0Ufjn6029I/ZxxhiVkTYOq8GYceiUiKY9mhYTSlOwNqPEaQP1wpWP6PY3I+Lw
	 o2Mbz+1OqtQEbhsEF4EPpn8WsK9tyyyNLwPnGH0oqTJR84QN9LgHLvM/5RKRxn7uus
	 Hx8s8QEl6JRfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: adc: ad4080: enable address ascension for chip identification
Date: Tue, 10 Nov 2026 18:48:51 -0500
Message-ID: <20261110234644.182708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050730-failed-6.18-c051d08d9877@kernel.org>
References: <20261107050730-failed-6.18-c051d08d9877@kernel.org>
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

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit c051d08d98771132868abf0cb95b6de95ab3060a ]

The two byte bulk read at AD4080_REG_PRODUCT_ID_L expects PRODUCT_ID_L
followed by PRODUCT_ID_H. After a software reset the AD408x defaults to
descending address mode, so the second byte comes from CHIP_TYPE (0x03)
instead. CHIP_TYPE reads 0x07 on all AD408x parts, so an AD4080 reports
0x0750 rather than 0x0050 and every part logs "Unrecognized CHIP_ID".

Set ADDR_ASC along with SDO_ENABLE before the read. This is the only
multi byte transfer in the driver, so no other access is affected.

Fixes: b66cddc8be72 ("iio: adc: ad4080: fix chip identification")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4080.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index e15310fcd21a3..584f273c6bb35 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -455,7 +455,8 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
-			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
+			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE |
+			   AD4080_INTERFACE_CONFIG_A_ADDR_ASC);
 	if (ret)
 		return ret;
 
-- 
2.53.0

