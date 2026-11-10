Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342067;
	b=UWLHk2Cq6Ulv755QR4pt+OODry8/r1haBBOVK0XlJSXt2SiEkYWas9cTE21w2+O+G+Rv
	 EHe5DHRa2l8Oy/YDQWIxktj+hhOlToZgGSEHTBOUPTbO6cxabKxq5tM8DJoXB2AlskaD/
	 IyQ5IlUCCh+77OTnRlUV772GPgsgjqdPmwuBqHoGOVfL0sNR/1G9zcNQp53a7z7xWt1Q6
	 JpQW2ltKKYKB3JC3L3a5NED1OnCAqc5AvR7YRiPcPuUOOF79kdRLUXdihLQVJWsCPIh7C
	 YL3LH0dnRTc5zh4rgMgkuNcC4ecnt75onJY1EIfBDb1LZ7+7OLWJVNUvW6pTjovvwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OnSG3k2hqxkxZB3IevfH7sBqErCAgQcjtQFeoWNFTTo=;
	b=S/NoHmBk/dxGnoa60MQ3Lni/bRfA5FwkFfr+qwC0DK+1nn0PX8MJWBiI58fsJWvf350b
	 InY1EvDwxKj7wS7dCUyxFUxfS1Coxv71vHqa+zcVINzttjjbjKROuBOJU7MQo1aBJSKSx
	 YWTP1fjhrOc+G549KiMl884IRyV5go7ElHZysAoF6V1ZJVtrNeLkQ6JYBpnPFyI1EbLYy
	 H9nRSEvXlbs2YVpWK0kYaYzMjBomgFrsgn4If4ASZGFIHjkF5tZ/y63MV33u69g51qYwV
	 SkLJFhIGYhU3qNDyiXPWTZOKTQoNaH2QoOiB323uIPGk+uqLqG6TvE98W9V3poWfnJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9rYHFmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232B606AE07
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9rYHFmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678AF1F008BF;
	Tue, 10 Nov 2026 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342066;
	bh=OnSG3k2hqxkxZB3IevfH7sBqErCAgQcjtQFeoWNFTTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9rYHFmXQ2QuOT1w/dPIP25J7vvQwyZ6iIgYdKz2hKB0mVgRB63uf/Wi7ahu/LuAZ
	 B5ZGcOjO4+TR5TuC0oDjUfJ2NWzx63lNDrcdCgeEaqVJ/byIcFtUxANXeBNPCNOWt1
	 b4Z7mXP7oKKxZE3Ua2votos4DSIcmiJcWHJCa1zWeEzoTxamtnwHTw3zgsZUjea7vg
	 22IpzusVi4MCI55nMXsWmFwJ3ZHX03rQRS1hF9TnMdnR2GR7622XgsvFIU1/fp14y0
	 U4/RVJ8s2TUnQ85Zt3hFeU49pS+7s3FVzrzD/05a/9xWZzfUjbhHB7DuR6gefQm5k0
	 7+NGyaiNr+YMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] serial: 8250_exar: store the GPIO platform device in struct exar8250
Date: Tue, 10 Nov 2026 15:21:02 -0500
Message-ID: <20261110202051.3754797-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202051.3754797-1-sashal@kernel.org>
References: <20261107053424-failed-6.6-33d337816e00@kernel.org>
 <20261110202051.3754797-1-sashal@kernel.org>
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

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 33d337816e00994daaf670243186d9e537ee090d ]

The GPIO platform device is registered via platform->register_gpio()
when port 0 is being set up. It is stored to port->port.private_data of
the on-stack uart template (and from there it is copied into every
registered port). pci_xr17v35x_exit() then fetches it back by
serial8250_get_port(priv->line[0]).

But port 0 does not have to exist at that point. If
serial8250_register_8250_port() fails for port 0, priv->line[0] holds a
negative error code. The probe still succeeds (it only breaks the loop),
so on unbind, priv->line[0] (a negative value) is passed to
serial8250_get_port(). The GPIO device is never unregistered and a
bogus port is accessed.

The same problem would also occur after the planned conversion of
serial8250_register_8250_port() to return a uart port instead of a
line. As Sashiko pointed out in that case:
  If board->setup() fails for the first port (i=0) in exar_pci_probe(),
  priv->uport[0] remains NULL. If serial8250_register_8250_port() fails,
  it returns an ERR_PTR. In either case, the loop breaks and probe
  returns success. When the device is later unbound,
  pci_xr17v35x_exit() unconditionally passes priv->uport[0] to
  platform->unregister_gpio(), which will dereference it without
  checking for validity.

The GPIO device belongs to the PCI device, not to any particular port.
So store it in a new struct exar8250::gpio member. Pass priv to both
->register_gpio() and ->unregister_gpio(), so that pci_xr17v35x_exit()
does not need to look up any port at all.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Link: https://lore.kernel.org/all/sashiko-outbox-166269@kernel.org/
Assisted-by: LLM
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/03a8b5c71614fc672fef1e55c083bda6c73b5bf3.1791873876.git.jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index aa72d252c6bcb..c15cf3cc87144 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -169,8 +169,9 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
-	void (*unregister_gpio)(struct uart_8250_port *port);
+	int (*register_gpio)(struct exar8250 *priv, struct pci_dev *pcidev,
+			     struct uart_8250_port *port);
+	void (*unregister_gpio)(struct exar8250 *priv);
 };
 
 /**
@@ -194,6 +195,7 @@ struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
+	struct platform_device	*gpio;
 	int			line[];
 };
 
@@ -452,22 +454,21 @@ static const struct software_node exar_gpio_node = {
 	.properties = exar_gpio_properties,
 };
 
-static int xr17v35x_register_gpio(struct pci_dev *pcidev, struct uart_8250_port *port)
+static int xr17v35x_register_gpio(struct exar8250 *priv, struct pci_dev *pcidev,
+				  struct uart_8250_port *port)
 {
 	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
-		port->port.private_data =
-			__xr17v35x_register_gpio(pcidev, &exar_gpio_node);
+		priv->gpio = __xr17v35x_register_gpio(pcidev, &exar_gpio_node);
 
 	return 0;
 }
 
-static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
+static void xr17v35x_unregister_gpio(struct exar8250 *priv)
 {
-	if (!port->port.private_data)
-		return;
-
-	__xr17v35x_unregister_gpio(port->port.private_data);
-	port->port.private_data = NULL;
+	if (priv->gpio) {
+		__xr17v35x_unregister_gpio(priv->gpio);
+		priv->gpio = NULL;
+	}
 }
 
 static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
@@ -550,8 +551,9 @@ static const struct software_node iot2040_gpio_node = {
 	.properties = iot2040_gpio_properties,
 };
 
-static int iot2040_register_gpio(struct pci_dev *pcidev,
-			      struct uart_8250_port *port)
+static int iot2040_register_gpio(struct exar8250 *priv,
+				 struct pci_dev *pcidev,
+				 struct uart_8250_port *port)
 {
 	u8 __iomem *p = port->port.membase;
 
@@ -560,8 +562,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
 
-	port->port.private_data =
-		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
+	priv->gpio = __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
 
 	return 0;
 }
@@ -635,7 +636,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		ret = platform->register_gpio(pcidev, port);
+		ret = platform->register_gpio(priv, pcidev, port);
 	}
 
 	return ret;
@@ -645,9 +646,8 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
 {
 	const struct exar8250_platform *platform = exar_get_platform();
 	struct exar8250 *priv = pci_get_drvdata(pcidev);
-	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
 
-	platform->unregister_gpio(port);
+	platform->unregister_gpio(priv);
 }
 
 static inline void exar_misc_clear(struct exar8250 *priv)
-- 
2.53.0

