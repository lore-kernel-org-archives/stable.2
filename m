Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345912;
	b=BcwixaR6alpW1Macxv9KHmGYYXMs5n9KDnAfugXlemLvkvgcEsQv4M8zhT9h76dYfmyI
	 WPT4O2BZOm/XnntAxwM0o51vkewryeJgQGgZN084kcz5RMIaKBBhNQ5TO0+5RwPZ7Plng
	 afCIn9CXuLlMRzfluJ2yJV9XkiWuE2/5vSgKFpEe8uPqdOy7XBn3KykA793DG8APmmiO0
	 bQ6o7R5U1YK+gAASeYYtjfWTE/VGRo3CfPyUJuEQkzDKvbc6KrePdg/GRIGsHF2VzIH99
	 EDT8y/VpqwGB1k8FW2QduxjqM1OIkbAQbp6Vxr/f1MRkt+DBl9diJb4vqgHsXh0rzJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RfRnLgB0SlnG9y0dKbqP4PrKxcHlVC3Mo27ZHcVOkYs=;
	b=jWRLa4lUrpr1NsUmqBzKXw2dpHYkMIdChwuByqVCwcxYMwdEoIVggGonWqAtdpeT8Ptj
	 WUv1Z7LzqHKAYxXeIImuQ4uz/cCtwBmwvR0Rspk2FENG4E9o2M6pCjalhBQ7PbV1K2g9I
	 aSG2vB91c+vkKTLDBTTwQV4H5EfKGTOqFzxZefAOGgiIZnVfudEPMtrDOseygw5MB6BPx
	 nQZORaCzua4OL7bhyux6PONg4ticQGpyIBIELJBaPakpysqINTxEJT7+0P/neDBeq6nfC
	 0BTGlHA+qUBrn557QdOjuuZa++hcksA9tCKhq66xqUM5kAzslJ7Ln/gUOy6kzK1jaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1CxA1ij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733E3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1CxA1ij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7657B1F0089F;
	Tue, 10 Nov 2026 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345912;
	bh=RfRnLgB0SlnG9y0dKbqP4PrKxcHlVC3Mo27ZHcVOkYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1CxA1ijfGCkk3JlkIgRqnu+7/VqyxEgZ/SWgmLzhCwOr4IQxgmFftVUHlky1mPLE
	 Saz977Ih41TY3pYdETDCc8zj3GfNOtgHzT3PxkW80PAIReIxP8dL9WLDjz3Gpx6tA7
	 p53HtayeFHR1n/w75JvuD1ts6g16S+LUZ66UA06QeLogYDDL9ReiVqPGAvFKKQciEo
	 m0WphcVI4F/9QYNLWj6c4Jgp00HExM/VZxlMwMwsaQXGjl5LdGWqwLyMUjG/+Ufm/O
	 0KEQ2WutOKxJxKjC6WLPpXcdGa3oZetIyyN/GrFGrjZh4GRqgjnjgsD0+U0Er8/W1T
	 RtIK4u9aivhoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: 8250_exar: store the GPIO platform device in struct exar8250
Date: Tue, 10 Nov 2026 16:25:10 -0500
Message-ID: <20261110212344.3907258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062214-failed-5.10-33d337816e00@kernel.org>
References: <20261107062214-failed-5.10-33d337816e00@kernel.org>
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
[ sashal: adapted GPIO lifecycle changes to the existing property-array API and direct cleanup in pci_xr17v35x_exit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c48417ea9e30c..72f13829be6bd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -168,7 +168,8 @@ struct exar8250;
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
+	int (*register_gpio)(struct exar8250 *priv, struct pci_dev *pcidev,
+			     struct uart_8250_port *port);
 };
 
 /**
@@ -190,6 +191,7 @@ struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
+	struct platform_device	*gpio;
 	int			line[];
 };
 
@@ -435,12 +437,11 @@ static const struct property_entry exar_gpio_properties[] = {
 	{ }
 };
 
-static int xr17v35x_register_gpio(struct pci_dev *pcidev,
+static int xr17v35x_register_gpio(struct exar8250 *priv, struct pci_dev *pcidev,
 				  struct uart_8250_port *port)
 {
 	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
-		port->port.private_data =
-			__xr17v35x_register_gpio(pcidev, exar_gpio_properties);
+		priv->gpio = __xr17v35x_register_gpio(pcidev, exar_gpio_properties);
 
 	return 0;
 }
@@ -522,8 +523,9 @@ static const struct property_entry iot2040_gpio_properties[] = {
 	{ }
 };
 
-static int iot2040_register_gpio(struct pci_dev *pcidev,
-			      struct uart_8250_port *port)
+static int iot2040_register_gpio(struct exar8250 *priv,
+				 struct pci_dev *pcidev,
+				 struct uart_8250_port *port)
 {
 	u8 __iomem *p = port->port.membase;
 
@@ -532,8 +534,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
 
-	port->port.private_data =
-		__xr17v35x_register_gpio(pcidev, iot2040_gpio_properties);
+	priv->gpio = __xr17v35x_register_gpio(pcidev, iot2040_gpio_properties);
 
 	return 0;
 }
@@ -602,7 +603,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		ret = platform->register_gpio(pcidev, port);
+		ret = platform->register_gpio(priv, pcidev, port);
 	}
 
 	return ret;
@@ -611,11 +612,11 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 static void pci_xr17v35x_exit(struct pci_dev *pcidev)
 {
 	struct exar8250 *priv = pci_get_drvdata(pcidev);
-	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
-	struct platform_device *pdev = port->port.private_data;
 
-	platform_device_unregister(pdev);
-	port->port.private_data = NULL;
+	if (priv->gpio) {
+		platform_device_unregister(priv->gpio);
+		priv->gpio = NULL;
+	}
 }
 
 static inline void exar_misc_clear(struct exar8250 *priv)
-- 
2.53.0

