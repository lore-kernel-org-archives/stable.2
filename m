Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F1233936
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338421; cv=none; b=Kv1FkZt1Lx1NFB3fA+IWSt56bHB/5dMEaaJ0N0L31Ii7M0l9nVzn8TtA4VPNyTsxXLtIxmVsRxnSAs2D5QjVSA4za2mC2Zw1QH5AcVgWQi2j172P43/6LE9WacVs/MUMspEVXTKEBAMVuoct2DjW1WKWfD5wDB8MEVMxOQzA9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338421; c=relaxed/simple;
	bh=AbJozHv/fNNcoyyGmfY0RUwwSka6Da4tgHmCOwu3kCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBYc1O8exADEKPoE4CkEwnLYlwzlNkzVFdxrchOGBt9ZmHS1TB7IgdxGtNagq4A3VnHjBa0Vsb5Z6zpyJ1dkao9zVwqGbqXBIGjJIMV5FV7oH4HQBJF/wKTs1qeU2qEyLc6tfpWbcIcdSUsUR8ub2CnZ10EVaPqjAG7Lbo3xMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2aBduEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2aBduEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81E41F00A3D;
	Sat, 18 Jul 2026 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338420;
	bh=nTtB1KhoBIRuNsOE5V4IdnEtIgUet/uPc/NWhtHzU2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m2aBduEX374b2rTejlB5YmmsCbJr3mK3ava+l3HM97h5w6yVeddlatWEyAzXmZU+e
	 GUv1Ef6zT5bf4YsMkSI0GPaU4dpzqVfy5wXjD+OywtT8lLXJYET56RW2ZfsQUQdbLI
	 3tw6hNkDarXH0ziIt1W4FLt7EUTVA/6iASqN7zp3MNgkmRLSouH9S7IH78o6omDHau
	 nS/yGwlQdpkYmU6tFkkGmOAJooN7Hr+AtXXlav1JVu2MbU7BGJICy5hNboLeJLkeuS
	 bs/IPL2vclpqdyq4NNbuu5AnKmkTJJ7PjT1urzgi5iMUgEcYK/TWdKyIUm79X7Ua7T
	 iPVTcF5iq2tEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: 8250_mid: Remove 8250_pci usage
Date: Fri, 17 Jul 2026 21:33:37 -0400
Message-ID: <20260718013338.2621443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071459-sulfite-malt-aeff@gregkh>
References: <2026071459-sulfite-malt-aeff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit a136abd7e7abe0f1247f8ffde6cc7c8ab09f985b ]

8250_mid uses FL_*BASE* from linux/8250_pci.h and nothing else. The
code can be simplified by directly defining BARs within the driver
instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230915094336.13278-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index e6c1791609ddf3..220857a45ac2d3 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -12,7 +12,6 @@
 #include <linux/rational.h>
 
 #include <linux/dma/hsu.h>
-#include <linux/8250_pci.h>
 
 #include "8250.h"
 
@@ -32,9 +31,9 @@
 struct mid8250;
 
 struct mid8250_board {
-	unsigned int flags;
 	unsigned long freq;
 	unsigned int base_baud;
+	unsigned int bar;
 	int (*setup)(struct mid8250 *, struct uart_port *p);
 	void (*exit)(struct mid8250 *);
 };
@@ -169,7 +168,6 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 {
 	struct hsu_dma_chip *chip = &mid->dma_chip;
 	struct pci_dev *pdev = to_pci_dev(p->dev);
-	unsigned int bar = FL_GET_BASE(mid->board->flags);
 	int ret;
 
 	pci_set_master(pdev);
@@ -183,7 +181,7 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = p->membase;
-	chip->length = pci_resource_len(pdev, bar);
+	chip->length = pci_resource_len(pdev, mid->board->bar);
 	chip->offset = DNV_DMA_CHAN_OFFSET;
 
 	/* Falling back to PIO mode if DMA probing fails */
@@ -292,7 +290,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port uart;
 	struct mid8250 *mid;
-	unsigned int bar;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -304,7 +301,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	mid->board = (struct mid8250_board *)id->driver_data;
-	bar = FL_GET_BASE(mid->board->flags);
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
@@ -317,8 +313,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	uart.port.set_termios = mid8250_set_termios;
 
-	uart.port.mapbase = pci_resource_start(pdev, bar);
-	uart.port.membase = pcim_iomap(pdev, bar, 0);
+	uart.port.mapbase = pci_resource_start(pdev, mid->board->bar);
+	uart.port.membase = pcim_iomap(pdev, mid->board->bar, 0);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -356,25 +352,25 @@ static void mid8250_remove(struct pci_dev *pdev)
 }
 
 static const struct mid8250_board pnw_board = {
-	.flags = FL_BASE0,
 	.freq = 50000000,
 	.base_baud = 115200,
+	.bar = 0,
 	.setup = pnw_setup,
 	.exit = pnw_exit,
 };
 
 static const struct mid8250_board tng_board = {
-	.flags = FL_BASE0,
 	.freq = 38400000,
 	.base_baud = 1843200,
+	.bar = 0,
 	.setup = tng_setup,
 	.exit = tng_exit,
 };
 
 static const struct mid8250_board dnv_board = {
-	.flags = FL_BASE1,
 	.freq = 133333333,
 	.base_baud = 115200,
+	.bar = 1,
 	.setup = dnv_setup,
 	.exit = dnv_exit,
 };
-- 
2.53.0

