Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047666;
	b=VRWW6KLnPo29tbjCLM5TTcVh8urxsaWz8nghId2zA1prNo5GiniVULbGadMn2056pCsv
	 74lgfbJ1tq2Th7WyajSZ3ikkjEUA6sDpLVqgj6sumyi3YIsh97mG0a8E/QjSUuHm0MU8y
	 HYFYWFVQW3D7fpyuB/7SOY3a7s9KoHOmrM2RnxVcJc0pctDA2hTpb29OdrrC37dFp9dMB
	 Y0nX5vdCZ90VeJqc3sBGGjhXqwF17f16+ZRoNdNpoK3+EWFQiULxkchFWS8Y4M/NaVol0
	 cb8ese0HP+bWS1Ouk5E2+ahjtzG1g8NW/LNTj5lBhgQgxsa8gTN+eWK+61ejdLnmPOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ElnQWFHa71IztobyXNzCucAdh6xi5tFV+8hHsaPVEwA=;
	b=cebhguv+WiJnKC9pXfxG9Ibn+Qi3es87x50XmtSHXMb3jeFxS5vxnBv2HgedSpK9PnXY
	 HcGtPuFT+fPcxwbnqAVbhsNNXOC3Isbrc/i4GpYaEVblxXdeFSKrSbvDi4BpxFOWI+ePY
	 l9CURHrRMedgEIs4ELbFCiYApx7+jnOvPAoOWWMP6HDltx+uzdbYE6WaPQPe1OUSd2Fr3
	 rqVKetrwFI7rxvtwYzvjdCcdt0mMnXpMBuRdwFqznTGjKtoCXf2X0GIb0bUBbUhIMbIFG
	 wSIMZQxucZasR8bZXq78Jl5iH1cjvXAUHwJ0TWSb1M//wiXb4D+fvqSOLxCJp1YqPsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyknddEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA83606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyknddEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0491F0089F;
	Sat,  7 Nov 2026 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047665;
	bh=ElnQWFHa71IztobyXNzCucAdh6xi5tFV+8hHsaPVEwA=;
	h=From:To:Cc:Subject:Date;
	b=dyknddErTyJBdV0ENuNsVcfX3WEw0BXKew3QUXgFcGfAbkgp5x/tBXa3K2c5JMF6a
	 U+aXwj3DnM+TFhYjWdG44L2+j56B2+e1mZF0Q6UIvVjCU7Pba/0D2yrX6Jk4aNWMVr
	 myK96ezFTomoBjfONGohxVWOFi990XtiMx1LaUZQtBlz+WYiusy5u+lCiEF3e0nR6o
	 UNPyC4HGWj4WVUyiItsqi68DJ3sF8eTnmKCOgsvq4E/MwZ9g3n8G3ReNIDzNNSmuW8
	 pMt/kQQ9skO0vYzfCvLFj3RMR2u48t0ykupJyfKNolOaKp1PLsRa4SOssojbm5WvJ7
	 5TWnxEzAaiY6g==
From: Sasha Levin <sashal@kernel.org>
To: jirislaby@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: 8250_exar: store the GPIO platform device in struct exar8250" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:24 -0500
Message-ID: <20261107053424-failed-6.6-33d337816e00@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 33d337816e00994daaf670243186d9e537ee090d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053424-failed-6.6-33d337816e00@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33d337816e00994daaf670243186d9e537ee090d Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Tue, 13 Oct 2026 08:48:48 +0200
Subject: [PATCH] serial: 8250_exar: store the GPIO platform device in struct
 exar8250

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
---
 drivers/tty/serial/8250/8250_exar.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index ad2e5841fbf69..29b2a29ab6f37 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -231,8 +231,9 @@ struct exar8250_platform {
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
@@ -256,6 +257,7 @@ struct exar8250 {
 	struct exar8250_board	*board;
 	struct eeprom_93cx6	eeprom;
 	void __iomem		*virt;
+	struct platform_device	*gpio;
 	int			line[];
 };
 
@@ -1167,22 +1169,21 @@ static const struct software_node exar_gpio_node = {
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
 
 static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
@@ -1279,8 +1280,9 @@ static const struct software_node iot2040_gpio_node = {
 	.properties = iot2040_gpio_properties,
 };
 
-static int iot2040_register_gpio(struct pci_dev *pcidev,
-			      struct uart_8250_port *port)
+static int iot2040_register_gpio(struct exar8250 *priv,
+				 struct pci_dev *pcidev,
+				 struct uart_8250_port *port)
 {
 	u8 __iomem *p = port->port.membase;
 
@@ -1289,8 +1291,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 	writeb(IOT2040_UARTS_ENABLE, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
 
-	port->port.private_data =
-		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
+	priv->gpio = __xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
 
 	return 0;
 }
@@ -1367,7 +1368,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		ret = platform->register_gpio(pcidev, port);
+		ret = platform->register_gpio(priv, pcidev, port);
 	}
 
 	return ret;
@@ -1377,9 +1378,8 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
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




