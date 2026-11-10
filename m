Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344864;
	b=svbjv+kdoTF131bJo8PomgAYdICsH6wk2xCmg2ZsKH89auI05Usmt2gEiKe5Ho3iA1/j
	 XHV0Yfsu2vc7jGU66O92w79js1TpqtUGXEOmMvx/fYYBwOyans0Y8S5JdpQrMLFJbQRnZ
	 hftdKaVBQD2HFjmThRvra7hzAa2wMrBqStjqTfDftZaT+6cuRxRvn992YNfiPQPWWDAzo
	 smQD78gaaywIjZNXF1XAteVKXgj+0NPF8EOq/NeWffXm2nbznF4tXXTUZdGY6hKeptJ2h
	 hdGkM84PV2Co52CKKBGYgAooYp8oPTG4kub1MkE3++aHRxRy7pzlP0TmnBfHNyPufvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qa/HBxBnY0nomQHt12g9ZnwiQxV61kzwpddXJG/5eGs=;
	b=4Aul0+7Yw4iN1JFKotR8rQAJ10HPzKJWUk/P1waDrri7KpMW1pvWmdwxSqDKaEE/Fh4U
	 14z/wmgUZlXV14TeStnn9rednDTrIh64XIF3VG78vKIwAqAikmhi0AEhnIQP87Dsi5sD+
	 jYIzM5nqBG3OuE1+0N+ZxzOIy0e9qggtORK+4nZhrvau/fo/ds5g1vD8wM8UdBQHv9lb+
	 Fg5DdOhaTKYGv7JA9udSnKLqF2bD2TRultJpnKMPrv0PISweP6cun60mzN8gvd1/tEaez
	 fhswUpG92ImCo8irsthEYSJ8xMT2MmOtMUnecqQMrK17SRHAfNUcxcEWC1j++HhQ7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vln4bqXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09308606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vln4bqXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2646B1F0089F;
	Tue, 10 Nov 2026 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344863;
	bh=Qa/HBxBnY0nomQHt12g9ZnwiQxV61kzwpddXJG/5eGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vln4bqXdzkhycS/c8FwFYsJej4k1dOid1oR2otPs9Lye0VrkAH4Gqh4yDe34B9E90
	 kYndR5QHuorOKCROxfNSjqJ160EzUIjR++aWjjkA+q3fL4I4BWEeGRdaN2KbwpEh1x
	 hoOQGydy7zSjYOSF+MHqAzAF+pXLNMDG638GIR6dAt9OVLBj5coRWAM0fXKNbqLydL
	 Fcdmy6Evw4KZUf7gWkqadS5+tPifRuPFBTg8tmEUbaQMCo334/OoovL+uy9gNhhZn0
	 atqqiw9WOPSrLvJ9kAQI0JcsEfVq9ZGnK2ZIjN4eSqk7dDbS4IUPt5L334w+5ExvvF
	 ByKIL39yiN3mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] serial: 8250_exar: Clear interrupts before registering handler
Date: Tue, 10 Nov 2026 16:07:38 -0500
Message-ID: <20261110210731.3853158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060524-failed-5.15-33d337816e00@kernel.org>
References: <20261107060524-failed-5.15-33d337816e00@kernel.org>
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
index 89054dd594d51..8672c8d06a89e 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -719,14 +719,14 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
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

