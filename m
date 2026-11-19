Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102359;
	b=eTxAK/DnwH2IJKmkJ/ZkJ6kAcIl8kG5g6bIpK7Kzo+df0X4DGpZnBYZLHqky8cQbGBZY
	 oqozEUSU2dULIkjXorreJiWVLxat0WM6NCuv90mSB4FOy2y7R3wyAQn52f3LAzwZoJgYn
	 aKCFFwV7jr9T0b2eSjkBI3rrB9Gfn0XovdTst9VZu5D5Py6AyolWl1EgatrkUKABlUi0r
	 ATmFs9ksU62J8931hSHjIQp+2hHNxMKeCkW4Kuc0aJCHLDjVRQ8d8JF3jZV7RnUf42bk8
	 gpHddEJObeSTcjfo2cjf8ylwZ7IlPR3+2ECQMcJCkZ+vBndvP0TaaYZ8iYDmmtWZuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BsLuHizLc3GlxB5hI1TsZDP3spN/v/I/xr4RF7IafvM=;
	b=aDUSyRYB2f9mPb+z6oxBFWbke+46ST6qG80QztY8P/ynJfwIpDE7OId+DXhmfjBZTYt1
	 FEGOGY0uLIJB+9XHNMnJrooeBRsCdbLrQra5RrfQkojeGC4UX72Bq0a5rJO196NvMOft8
	 oFAmDlRuZs9epMYkUxMVSygWExB8pvMY9j3DvAaj2IX5F63hlmNnD2ehxSoxbEISEFoZa
	 a4G92Q5VuMRDIMf2+oCGFYcGbTE5IAxgbbMSp+nwLas+66TEAmg7K9DklGbDhnDKmD2Ow
	 6HP+j1Y4Hw4wdy9sHz2IUX/BVSxnM3UStyi0rAxdDUH74uosWU1ipd/LpNchjOEPLYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy6qf2nV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF560A2604;
	Thu, 19 Nov 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hy6qf2nV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310641F000C7;
	Thu, 19 Nov 2026 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102359;
	bh=BsLuHizLc3GlxB5hI1TsZDP3spN/v/I/xr4RF7IafvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hy6qf2nV6wPs9dnIIEAqyqg2colUxWUMNsgrywbi91vwTXifk/S9u9mxmvSwqDRve
	 eOdQm4XwpMtSoXk8udNOhqslvXaLjHPLhjH/OVAEvspa7bU24n440OjUqsx1Wll4yU
	 4bSjXgngyUzutntbJqeSqcRjvpTeYiHZEzZ5AzScTGY06CXl1Z/0eGwCZS8TZzuUNC
	 ep6UbnRf1ZwDpaE5ZiL7IHbO67VNz/tXuIgjgTLq+DXde0NoiINVGjqUbBQUmmpeCV
	 efNBIeYZ2n+yat7QbR4V9FUuo+Cc3QtVcmkuvyhIlTtikjRv9NTAK6Mn5jTbYeDiPd
	 kbGJZIu02RjWg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] iio: adc: stm32-adc: Detach chained IRQ handler before removing domain
Date: Thu, 19 Nov 2026 15:30:38 +0000
Message-ID: <20261119153151.1397003-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

stm32_adc_irq_remove() disposes of the child IRQ mappings and removes
priv->domain before clearing the parent chained IRQ handlers.  Because
the parent hardware interrupt lines remain unmasked while child devices
use dummy_irq_chip, an interrupt arriving during teardown invokes
stm32_adc_irq_handler() after irq_domain_remove() has freed
priv->domain, and irq_set_chained_handler() also leaves handler_data
dangling.

Detach the chained handlers and clear handler_data with
irq_set_chained_handler_and_data() before tearing down the mappings and
removing the domain.

Fixes: 1add69880240 ("iio: adc: Add support for STM32 ADC core")
Closes: https://sashiko.dev/#/bug/linux-27c38690-bc20-43aa-a3fc-1ddd6f1bb74e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/stm32-adc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 4b532db3db62..13b75475046c 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -467,12 +467,12 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 	int hwirq;
 	unsigned int i;
 
+	for (i = 0; i < priv->nb_irqs; i++)
+		irq_set_chained_handler_and_data(priv->irq[i], NULL, NULL);
+
 	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
 	irq_domain_remove(priv->domain);
-
-	for (i = 0; i < priv->nb_irqs; i++)
-		irq_set_chained_handler(priv->irq[i], NULL);
 }
 
 static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,
-- 
2.56.1.708.g77570a6a1d-goog

