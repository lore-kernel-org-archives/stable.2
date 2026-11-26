Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705701;
	b=vQb0+Es7/z8xMNVNb8tZzO0EMi1YGg9P7f8zGDBmGwtWhbkQUs0161aoQDKSkeTwoX99
	 TPadXSotvpNV5N970VVSGGDGcH3KCLu1pU1g8XA9ZYhV6bIe/OgdypidXBrziezMxvmv5
	 WMiw3idSp/c/oYOgxEL+7aSuAmI5dHY4M4ktMgZe0c38Ys45h/1h+M0gyeJ2X2jiqEcia
	 UzjYZV9Vz1YboVhewpNAw0D7c45NwF03smF0bH9lmubzJz1XiQjWaVk5/goKWCxwXTJaw
	 u0eAp/4T4hGgPhiFKKDAZyklr97lyLkiELixjciNDVt68oH7S3Klr+TddBUUSL30AiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kgQTlE9VHhO9Y2ga+d8bJChGw36z6vt0BJN4+fl/xWI=;
	b=DqTVOwl754zKIw/yxyZgU/7PBxaX3Q1ZU5RelfOnC0jrxOBCUR6Pl4QtU7ZEGtXzYhpm
	 fStO2DuiPaZN2YbW/MK4hYHhrYF/C6TR5cEZx0glEPUwK8LNoQlTyvy+pCs/EeeaJNLYJ
	 1juX1+pURCjEypnR/+13tBZDNUOtiKq04HltjD47u5v0gYy4GaTilEd6+wWiHM6RKTBP6
	 +Si/EBYYPJcDwlhpXUQA0szGXOYqX56qVIq+9QkCynTBM+HuRY45GerCThXa99G1kFKBm
	 A00ydN6vuAeC+gJRq9gkhj1TJMaGScIyBwwunZ+Y5iEJ1LrKMe0IpWkn1A/XfZ7+5ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdNuidbl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA704606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdNuidbl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905801F000C4;
	Thu, 26 Nov 2026 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705701;
	bh=kgQTlE9VHhO9Y2ga+d8bJChGw36z6vt0BJN4+fl/xWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VdNuidblVokit5YxTIBoWS1U6MNG+Bs7ReqtdSD/j3WctXhSnjQmhFt+hyFZwswtE
	 VgwT/5tWoCbcIxPtSLXlaUvhEpfNGQNT+YISyNGPxzUDKjqyMjoqEfjAtazrVCoi7v
	 +J7gK4G7MM9oRUuR3/qLf9owfUfjBP4xOOgO3GNPqDP2GJeQskZ4SmzGJHB6AQj26Y
	 GpfW3Ka+MP0QFRL03e9Q1m+ZYfvaDA7Ga/ckL9cti9tAryO7Vdtboi8i03vyvI6rVz
	 Ydiqt2ZdRv9RF2SRlH+3qU+iSyiHlOqPP8gAZnZdn4c4ntC9tKriK81H4HbinU3HF6
	 rQpKBur/sCbcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: adc: ad7923: add the AD7927 to the SPI ID table
Date: Thu, 26 Nov 2026 10:08:19 -0500
Message-ID: <20261126150805.2239312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112501-stylist-frightful-2d5a@gregkh>
References: <2026112501-stylist-frightful-2d5a@gregkh>
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
[ sashal: Adapted the new ad7927 entry to the older positional initializer style of the ID table, since the designated-initializer context lines from upstream are not present. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7923.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 0369151c7db1e..241dc91647688 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{ "ad7924", AD7924 },
 	{ "ad7908", AD7908 },
 	{ "ad7918", AD7918 },
+	{ "ad7927", AD7928 },
 	{ "ad7928", AD7928 },
 	{ }
 };
-- 
2.53.0

