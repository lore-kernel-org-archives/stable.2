Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705858;
	b=xGOrutp/GpVLVqUFZpel7qvPLf+LjQ0evdfQMCXO8P8IQyiItiwrJztT8XhDnpQmEVNu
	 fLPjiqTQNkxEkFoALnpp+7r5yUfKxE7b2wvqiBd+6kQmG8mAbiGb/FBhp8ntd2S2HOmaZ
	 ISNXo0tbyoHK0lJ1QDDzcLFKndhxIBKbTHZpwGHv/d71oz65kBYDtP5WOSKxRMe2Mkf0z
	 lnJ+6pLlsm+akAkqe+ZulAyI7ypBTw9WO+6wT7Sis+Gt1Ggz9ZWqVyEUVUQt4IwiFviXQ
	 nVHXFi0lT15cVO2Jbx2lKrzVpW4quxzZywwb47yvBnse+5264JS32A1Be1JoJJpP3OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vIdyXwLZifmGt4o6JVaV3X/92JzlrO56OTWNnBWXLeM=;
	b=RkD0A0Sy4qsXsEPmGrKSp1k5FLcPwEyBLa2pHuRYTg9GjxzfDWVvpc1RyjejwA66MCOL
	 +pPMYW7+LBxffAG/4b8IDLicDOOwoe2dv+Vhe3nCFg8hB00VXmU9mck//2pAo2sR9YKxs
	 yN7GSErBuCrnWyHqnedy6X0OPOL/hI9HjcXBNsAoN0/pRIF+PVnlr8D7RaAUSMwC72Sxt
	 BRwrWsKjUjs18O9i+CVXTpbX9wE9Fh0/qWhkx4m0nTc+PAw34f85EzYvg9G1ih2fo/2MV
	 sju4XzFNL6XM5RwNcDJW7tEcUBXBXZisvCJK0WsHpIX3wJEwPNAwXTjKllVkKUnyJVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzQClwwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378D606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzQClwwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB4A1F000C0;
	Thu, 26 Nov 2026 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705857;
	bh=vIdyXwLZifmGt4o6JVaV3X/92JzlrO56OTWNnBWXLeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzQClwwELzuc35r7ZIVmoDr0n9GWlfCsmxstKK43v9jm7/UuZOeMxAPQ01usrhVdg
	 DHRpkTTCiT1cemWA9tmpk3gJeYlripEq7k+go6o+AOlwfgRsB2qmqVYjhTf15fJQVz
	 cVal3TpGNIqAIdgiSpl2d08nlLJkLfwsl8/dL7E1pu6C97L0CSHkux0ZDsjqpk1vph
	 Lw86/hR545G3c/QFwFla3Y7wlLjarIMtrU0+31ZuN7oDTKa+PyxBCOV599kjge4owB
	 Em96hZjDuJk/8ZTflSpTlX1KCElgnQ1zhnLtTeFwWHIfQChWmkbJij/OQIYODr1yt5
	 ruMX5Zy2kXC0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: ad7923: add the AD7927 to the SPI ID table
Date: Thu, 26 Nov 2026 10:10:55 -0500
Message-ID: <20261126151043.2335512-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112501-chamomile-occupier-b81e@gregkh>
References: <2026112501-chamomile-occupier-b81e@gregkh>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 594157b4f3f64db5833dee679194c33a5968f92e ]

The binding describes the AD7927 as

  compatible = "adi,ad7927", "adi,ad7928";

The OF match takes the second string. The modalias of the SPI device is
made from the first one, "ad7927", which is not in the spi_device_id table:
spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
the chip information. The module is not loaded automatically either, as the
uevent of an SPI device says "spi:ad7927".

Add the name, with the data of the AD7928.

Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adapted the spi_device_id entry to the older positional initializer style ({ "ad7927", AD7928 }) instead of designated .name/.driver_data fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7923.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index acc44cb34f824..46e1d64c294af 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -367,6 +367,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{ "ad7924", AD7924 },
 	{ "ad7908", AD7908 },
 	{ "ad7918", AD7918 },
+	{ "ad7927", AD7928 },
 	{ "ad7928", AD7928 },
 	{ }
 };
-- 
2.53.0

