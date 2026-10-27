Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097385;
	b=CiOUEfnYLrx/n3It3Mgcvqtz95yBc4mHVZC1RYTaWEi1MVymlb4+Cbiw5FJcS4f8g3+g
	 Ez4xVo7dA8x4apAHoXD2DoA0bZkiQML6bRnUN6ATL2p5ezqV2bGICbreBmMgfsSPoIwAQ
	 r4bhVlP/LjuqNeAC01nk353Bg4r2l1Tzd2AjwI8Ux5vOTdlo8cirRCcP96+CpQDdp+9Ej
	 DDRZeg3HoYbAEsUgoDOeOh+SZ8UY3w4LvMr/LZ3CygCrzvwAOhW+l5lYxsWMGwLriVIEy
	 /HaQd6DKdkhZ+g+Z/q8kNJ9d2XVxCQ3IeG484EHilNqVVQdyviTYTCx2CZXv4DMYbQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LUwRNLrt040RUYKYwsW+ZmdCUXc8wphGYCOt5MpVjzw=;
	b=qOTL3CH1sfq10jSTSydgqw8cogejLUJzD2Fko44EtI0ISvGoV/g2kyUt2ytmRA8+ZQJJ
	 aSEN5I18v4HcfSESNFu8rtyA18MTr3xOEWpLe1zL8cHtZcDUzUHRcJTH+H2sF091sBPZ7
	 5V7DgdxBy2v3pYwMnAYmfc7xZB0CPMvIML0VYNDeZvNjNJ5hPDu6Mm6yH49JGKo9BPZcO
	 TZ4HTcSE1xukG+8k3CvTRg0TI3+yHxUv9gXVR4xI16HgC4AG0vjS0lNXwYIjSsncVu+qB
	 HLKcR+uJQyLrE4plQ55UkMexodFl9Q5oOtNeZTm+9cJQjyjGRgL2GDnuB0d4zINDofQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uj5BsmYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5F606A326;
	Tue, 27 Oct 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uj5BsmYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7B1F031E4;
	Tue, 27 Oct 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097384;
	bh=LUwRNLrt040RUYKYwsW+ZmdCUXc8wphGYCOt5MpVjzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uj5BsmYCwof8oqvb2V15wrlWVJP8M4BsjVmKs26WoPyUTD+kNW2dFLPR6WtBz0O55
	 U4sEyOPqWhml2BzDfYKpiVbnBbjW6ybZQgk8q3tqr6B+iXXmgPI60+03TAimzOOsnk
	 E5erRhXpGScD3te+D6SHaWvHarHd4WxYRH1meHmJJCHlY5sPdOOMemWWteGc4TmdRI
	 KkBnTBHst21C5UaGutbiCJOo7/D6yT/0KlYBqAnb9fK84w/xw2VLDplTrw7A+GHexK
	 o+e0p1LwI7GGJoWvkBh23zBUdcHOH29w/xjY6Wk85WKsrbJtgayj19GhBcO5aY7dt7
	 wZmm/Su9x85Mg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 02/27] mfd: ls2kbmc: Unregister GPIO GSI via devm_add_action_or_reset()
Date: Tue, 27 Oct 2026 09:30:31 +0000
Message-ID: <20261027093306.2812695-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
after requesting the GPIO interrupt via devm_request_irq().  This
prematurely disposes of the active IRQ mapping while the interrupt
handler remains registered, breaking the GPIO watchdog interrupt and
causing a use-after-free when devres later frees the disposed IRQ
descriptor on probe failure or device unbind.

Register a devm_add_action_or_reset() callback before devm_request_irq()
so that acpi_unregister_gsi() is invoked only after devres has freed the
interrupt.

Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Closes: https://sashiko.dev/#/bug/linux-cab8bfb6-4077-46f3-a173-ac2e2042cf66
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ls2k-bmc-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 408056bfb2fe..23c774a09842 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -363,6 +363,11 @@ static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_ddata *
 	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &ddata->bmc_pci_data.interrupt_line);
 }
 
+static void ls2k_bmc_unregister_gsi(void *data)
+{
+	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
+}
+
 static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 {
 	struct pci_dev *pdev = to_pci_dev(ddata->dev);
@@ -412,12 +417,15 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 	if (gpio_irq < 0)
 		return gpio_irq;
 
+	ret = devm_add_action_or_reset(ddata->dev, ls2k_bmc_unregister_gsi, NULL);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(ddata->dev, gpio_irq, ls2k_bmc_interrupt,
 			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", ddata);
 	if (ret)
 		dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", gpio_irq);
 
-	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
 	return ret;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

