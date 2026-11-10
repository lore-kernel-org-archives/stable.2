Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343373;
	b=ICXSqkJ9eD/6ur0Eyu8PJqCX/U5lE/YnUDck9JcrdjOxIaixeOxGszqpY8NER7carWVA
	 nofo5gzaJbTk7avZ2taBoov/+SvFslZOq3DY3z37Hmvgk4bOe0kimS4eenL0ST5wipETA
	 7ABxONbBnEzaQa1sH8m3m581YwZVWZb2L5L8bGahvzwHRC75ZBenMgg/Vu4/5LhGkCXft
	 nzW+Tp7sCmi+GoI/brxff5iCAzzAZDJyWDV2FJJ6ZC3kND7n6JB22KcPfvhxflmImhbXa
	 VPIrIgiZvwvkxC26gacgDmbUNsKtt0p1y/vuoEK92vSiqeT0U8pmi8VknNzr7q5Vj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AsZuVqej03Raztfh1F8hTzPJth15otiWTltWyfWXe7c=;
	b=nTamZV/TAS7TA2pF8bKiLyElVFuodkmRNNRglU9tvbt7sNB3hUiO/pxhNsjSghsoFhpZ
	 A9hH7Y6qc5RRbK61Wma47fUpUBEMo18jHojaqP9jcrEE8h+bkMeFrqUoMnOLcfdE+FKrH
	 A3SDSveKs/S/tXpVRBzmWze/k5yXkD2cPJh9QCzvqRIZyMPcbFfY/TQHyp28IVZdI+EiE
	 y2SJAaA1bjCO9Wzj44eSPCbWKYSebxwRd+BquQFKHonQjRZ8OrhVx9mdIv/jyQTNJw9Ok
	 21dWNR1yxg0fW07j9bOfBaHoiZ6dgVUoBt1mfIj68fYN62y9S1yAP8kity0MEHF+cqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2AbVt4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A03606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2AbVt4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6881F0089F;
	Tue, 10 Nov 2026 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343372;
	bh=AsZuVqej03Raztfh1F8hTzPJth15otiWTltWyfWXe7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2AbVt4rwLxFnhBE9uP+4rSTHA9xYDMNPdvfFuNR3g2byhtToKQ9ru9xl/1ngleep
	 fMilShJ2/e+PWf20goic/VhBLRCeGDGpv1lDHpx2PO05ZqurzuMbI6wAsZmMiJtR9A
	 aKve2wTQaDhtRss5vdhsGCD1O5a3hd8DC43XzrMNsNuL4UzyhBjEOSJeYh1HvqE8Hs
	 /7iBuFaYbPbjNeCxL0nMXNDDhKZMZxBLOdo+f0FfPE57pb8s0Hs7wrqjwfvTDSp3F9
	 YaLJiCForMJ3aP5aGz7RUbsj0GitPOj5DpJnMoCujDwISmglk4r4zVY7/5kS1qfhZd
	 rGttUY0sPtZHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] serial: 8250_exar: Clear interrupts before registering handler
Date: Tue, 10 Nov 2026 15:42:48 -0500
Message-ID: <20261110204132.3796786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054802-failed-6.1-33d337816e00@kernel.org>
References: <20261107054802-failed-6.1-33d337816e00@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5bc430afeba5d5101765c1f1a4437a90218b00b9 ]

While now there is no issue if IRQ is fired before we clearing
the interrupts as the handler does the same, but strictly speaking
it might be problematic if IRQ handler wants to do something more.

Move clearing interrupt code to be called before registering the
IRQ handler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240219150627.2101198-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 33d337816e00 ("serial: 8250_exar: store the GPIO platform device in struct exar8250")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index bbca9c501c604..b8efa464f1b3e 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -718,14 +718,14 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
 
+	/* Clear interrupts */
+	exar_misc_clear(priv);
+
 	rc = devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
 			 IRQF_SHARED, "exar_uart", priv);
 	if (rc)
 		return rc;
 
-	/* Clear interrupts */
-	exar_misc_clear(priv);
-
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
-- 
2.53.0

