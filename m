Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342065;
	b=bAkH6Js9InDw04lHsnYbcWIwaJVNYzfLJpYY+rC3KHIpFLI/TNrvk88PIFlagWmBvZx8
	 5fIwusO0jraQVo/npRqBVcFBk9iNMmSjS31GMylDWb5YBQg7e4If2eZIrgsblBi7risxE
	 Gtb91KpnDfRc/mANJM5sWqdlra9corqB1axnCUrygWKR4/S09uRxP+BdQT2/9ndAKlxVP
	 Cw5ULQj1h3jnZMQ3TRVJiuyvjlHyUu7c/l9PoA+gbkZcgzuh+lEN/2B7eJLS7tWZKq5K4
	 gyOJ1zV0TCwed4sIaI3GL2+kE3T4/uAfvbUob2Bv2YJfiiySnWhbN6PpcqXdgP0i5Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GNELTu5guZidZ8LwqV4JYoqQ9DEFhV7fZSDG6rgLupY=;
	b=HS8PWFmVVaOHTs843qLJGu35PRSO3UoZVPef3+bOxUbCVU8mUA7WRJ/VkiCYOfHUhaGc
	 i98IPg0moi2FtWz3UDjlUichnkDdtpp04t3k0NSGuGGA/J/2vQ7pFb2QAlQ7usNmVuN91
	 ecyeMEGCUT01I+jy3PAHRbQs2luP2wyugl7EfDzlrnVInCPQeFTaQmUyYy2PSn+UtQQuV
	 AEU2BfInnRNdHVN+zBKWP0HSMcF1eqmRlQrvRKtGlLcMuuMzKBMdX0aDoaoPCe+AYbOxO
	 Cbr6P8bG30y72RQSc7850Xbpsq+7xziYVdyN+lqXUGPhIOdg8DZJRWtmnRxsl4Dk8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfuYbqvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F860A3807
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfuYbqvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F581F008AB;
	Tue, 10 Nov 2026 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342064;
	bh=GNELTu5guZidZ8LwqV4JYoqQ9DEFhV7fZSDG6rgLupY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfuYbqvw6RayQ8mWn9ANn9cPxirHbGOuttImhFMBpnrlkYPNbJHoqfeCOsA9B3wVZ
	 ev8Sfl3atcC/QNtOrlv1KJaL7aXdzSqdQX9RWRSWXtXyRfNRJml6cKlVQ0XcSeGTnq
	 oCgwlMTfXDzR2KD5H/ATyPD/rX4lVRCKAK7nQFDVwUa2xtkPPFFUnplhne/emXwFwc
	 Hyz1Hve54nzYNMQ0aYW8ZIi++EHdjUuGhYCExJ/ZCuZyUnycamT0QWNUvGoHIQSS5u
	 d++TyIizZwjOlqmewzrf5D6JZgk7uyzk6IZXn/+GN7X4eKY7tyDlZtQ9fjMcPORWxN
	 kGkyNncOwDp9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] serial: 8250_exar: Clear interrupts before registering handler
Date: Tue, 10 Nov 2026 15:20:59 -0500
Message-ID: <20261110202051.3754797-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053424-failed-6.6-33d337816e00@kernel.org>
References: <20261107053424-failed-6.6-33d337816e00@kernel.org>
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
index e79ee33d432c9..95cde2c001118 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -722,14 +722,14 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
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

