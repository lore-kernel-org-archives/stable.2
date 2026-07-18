Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B1221721
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335882; cv=none; b=UsTXouvQHY+1xnJx6CrpLpuprS0DUerVbtkP00J+RpgdRcvrV2BPCA99fVVGhibkxLKSMehrZi9iczJXk13mypz6JdANMwU6qI48SdY8womfwjZ/RSrwNR9J3RzynpCl1fq3HTVeFryAWpN/7lFQSKtsn0lRpCJ0FcIlHKRxRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335882; c=relaxed/simple;
	bh=jtktJD5XNe1B9tZh26AIV4tmldvLzlR4iiyAGre+qAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbL+FtIXinYW7jgiz5sq1G9SENeJYY/bDiwdpZm11q0H1aJcFcfMPjDoAI3j5IEFcQS2AibhhVa2WXp2C53+AhCeg+8iPJ7yk5hxSDx580MPjdpZEa/DhXMHdB+obpMCSrKcw+wsExKgpMBMS8l3WTpBGxJxB937n9iDNwNMZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyFt2kyL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyFt2kyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD471F00A3A;
	Sat, 18 Jul 2026 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784335881;
	bh=QI6hVWAEj2XkIZfjLS3X725vcL4iGM3q/2xxl+iDuCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eyFt2kyLyI0GnHTxOz/0KfHPQOS7XarASnNCu7rXp9Q0tXUNgjmeSpY02ft86Wgsm
	 UrFVTmCgdEq1em6H/On+ipc6a6hyfWlWqKkJtibFGnlUrCmDUuep1cIgDpmehTsbAB
	 zzGIYkCV8ujRW/3Gb9pzJYQ9Dp4zHfvb//Z5Y5Y9DR5F/MP0GBQyu9s8mcKYLyPjdR
	 7F3i1cKGYhWsxlsUuQtW8xK96pA95XhRXd3D9H2xbu+GmcnafIhOq2TQLuCkj91qj+
	 A4B1vQJ99D9BcUHXoKckW7W9iIT+CmpEBRf5Aav5PS3msDl6lWOueFOVT7v37SESV0
	 VvqsEcsUzC8Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] serial: 8250_mid: Remove 8250_pci usage
Date: Fri, 17 Jul 2026 20:51:17 -0400
Message-ID: <20260718005118.2484504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071458-transpire-rigid-ad0b@gregkh>
References: <2026071458-transpire-rigid-ad0b@gregkh>
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
index 2cc78a4bf7a19c..8ec03863606e4b 100644
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
@@ -291,7 +289,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port uart;
 	struct mid8250 *mid;
-	unsigned int bar;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -303,7 +300,6 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	mid->board = (struct mid8250_board *)id->driver_data;
-	bar = FL_GET_BASE(mid->board->flags);
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
@@ -316,8 +312,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	uart.port.set_termios = mid8250_set_termios;
 
-	uart.port.mapbase = pci_resource_start(pdev, bar);
-	uart.port.membase = pcim_iomap(pdev, bar, 0);
+	uart.port.mapbase = pci_resource_start(pdev, mid->board->bar);
+	uart.port.membase = pcim_iomap(pdev, mid->board->bar, 0);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -353,25 +349,25 @@ static void mid8250_remove(struct pci_dev *pdev)
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

