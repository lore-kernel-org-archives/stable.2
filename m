Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344866;
	b=vqSI/WO3bd7OWTaEYDvXrkqawkICi7Hj6X8lrE2MG+7Ni73Un6e34y5OzAx0djVoaw/X
	 VrfRsiRc/INu56IucD8/Us7eNgLRsZeTEJBNbF0JP4osGnPdeSw9Kltl3NKduMjAc6jbW
	 2WoQAf0QRpHspcCTSefeAjkCEsY9xvsWPKwd02N27D41QsNeE2V1sEw6nNwCcEbL5uRnH
	 LoDDh1q/wTOpj2EDhITfMbSy9o7Fk8+R4mwhLsGJGCthRcQyKbwYxIJFTbrJit1jzUCY9
	 gToXydnrsRJx6Puxr2eGqKoyGUHJOJUEBzIJIAjOv4PFznDrL9EUyuFb/MQt4DYTgzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SwNDXWvY61sIhRbsn4aW3DA1SpN7C+L1Y9iOhEs2Wlg=;
	b=YUhyhc7eZh3b+NPV/nLc31r1KvRGBl5aoJiZvblK5TLRBXYBs+ZiKm4Rk5I0dWGTpr2K
	 OCaatU89BLeDBBmtWjxE8XpO1iHnL8ZA23QcOThRloKUKDb0/EOYTG+Q5OAPcryRiSZ5V
	 x2FVxKisu+8mkMIWyPioy5rLe76r0GEuLvQbMsZS5VghScV+lGiOuadcoykug3ZS1fA+K
	 Tl9BMrVvk3heh97aVF8OChiWn46Z/TGJ/pYRRAlzT2jvZ9UytERMZ2sUtt0N00BKulQ5m
	 wvUw/sN7+XxDAQ4PQyieemawgUx4+p7+kiQv89YYdP2tsmF8onNWa9OVtDjk8SNSXVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ix/F46Zk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD1606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ix/F46Zk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9901F008A2;
	Tue, 10 Nov 2026 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344865;
	bh=SwNDXWvY61sIhRbsn4aW3DA1SpN7C+L1Y9iOhEs2Wlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ix/F46Zka1MejgFGLOLsPIXGFQ0B1vJkpsiqqkb+R/3wEueNr+/yiew3QaTF9dXX2
	 fl6EAlPY6FxjDRIzYSRDwkuI2RT83ub93RWu2JIUZFJiAIDSUfmHcHCfcvyHMgvk1L
	 vUapGJR69N9fwt/LFzvw1tLrLtycpbuRWvf28dhOPGYS4oBTk1iymsrFBlYK5vCnT9
	 ITZsUFJiOqsuH6L9ccxr+ep+EUsp0uopPm3G08rNRhM3oO5Ex24gao1iS8Effx2DYY
	 7A9TCrSuO8TiXC5/r3tI8Bh6a1Mp2UTzzrCcUcY8FTjxZvLU3i+wdZtumicU/Wqa6j
	 JhEXMNjnzsY/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] serial: 8250_exar: store the GPIO platform device in struct exar8250
Date: Tue, 10 Nov 2026 16:07:41 -0500
Message-ID: <20261110210731.3853158-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110210731.3853158-1-sashal@kernel.org>
References: <20261107060524-failed-5.15-33d337816e00@kernel.org>
 <20261110210731.3853158-1-sashal@kernel.org>
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
index b5275cad4a69b..b531d34b06387 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -168,8 +168,9 @@ struct exar8250;
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port);
-	void (*unregister_gpio)(struct uart_8250_port *port);
+	int (*register_gpio)(struct exar8250 *priv, struct pci_dev *pcidev,
+			     struct uart_8250_port *port);
+	void (*unregister_gpio)(struct exar8250 *priv);
 };
 
 /**
@@ -193,6 +194,7 @@ struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
+	struct platform_device	*gpio;
 	int			line[];
 };
 
@@ -447,22 +449,21 @@ static const struct software_node exar_gpio_node = {
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
 
 static int generic_rs485_config(struct uart_port *port,
@@ -547,8 +548,9 @@ static const struct software_node iot2040_gpio_node = {
 	.properties = iot2040_gpio_properties,
 };
 
-static int iot2040_register_gpio(struct pci_dev *pcidev,
-			      struct uart_8250_port *port)
+static int iot2040_register_gpio(struct exar8250 *priv,
+				 struct pci_dev *pcidev,
+				 struct uart_8250_port *port)
 {
 	u8 __iomem *p = port->port.membase;
 
@@ -557,8 +559,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
 
-	port->port.private_data =
-		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
+	priv->gpio = __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
 
 	return 0;
 }
@@ -632,7 +633,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		ret = platform->register_gpio(pcidev, port);
+		ret = platform->register_gpio(priv, pcidev, port);
 	}
 
 	return ret;
@@ -642,9 +643,8 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
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

