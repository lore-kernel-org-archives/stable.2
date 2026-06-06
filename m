Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C842FF67A
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748326; cv=none; b=beQHDkkyBX3j+Uc1MSqjLE1tpW/7TfXREOynSBaOfS+pFjhaE8mC62J3jmFrEKV4gJsRkTSX6SVDx8U/goxUtwzjkW4L6uYGg2+R+l1J3b+IvItN1dtdlG+fsc6If2bAB9QXPDrrY9BabtJ0U43rBTzauMZl1odF64UE8SVHpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748326; c=relaxed/simple;
	bh=+8FK4Iy4JI5qRTFZWCZ80S/zWWhKLLkTzIGlYDpxjZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Efo0o69T/z8L6KDIAD/Qbk5etiG29zUyFkXJST962CKe4Uo43RPvsivpLCzNSj1oniKTaa3p+PyestUp1KfOCSFAqxl1qKqB+PwtgL1Fuyt7o5rIh9Gu6oWE5V2p+gNZlsrkE9OusCLeU+REqjnZT9tFJDkkLbJ8xEsddmTyMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6Jl4Z7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6Jl4Z7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CEB1F00893;
	Sat,  6 Jun 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748325;
	bh=9BZm/TYRSoxKHMp0o2wH1aJqYBM8exDNBjg3z4Vso+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6Jl4Z7sGaD6qih4lkc0QBKS5ux998k77b5e9LUMu6CluvarZewiP9cGRoMDs7Ra1
	 LCrWmdJJ4kLEEhz6aCNuv9y7WmeGSPEOUSWGcH/SbJ87CTO3S/CEMuGl4RUp+lWE8k
	 KixKhDnZOWfiReHwlL6GGNCuJ+ELRMBAG+XLzftaWX8H6pMthUPFJEAaFcGgZjVmNK
	 U7rb7ZX3hIXQbTO1W8+OMd9upu6vulOZ8HPvXc6/GX7/Bv2XW6SGL6eYZJK042WvM5
	 h8C52UCr8mFoWQ6206WTTyn1BzMN6YgIn2t9k4offkUN+CdEp9+QtEQvtTzgZZrNUT
	 Qm2fwbPFNgsMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: altera_jtaguart: Use platform_get_irq_optional() to get the interrupt
Date: Sat,  6 Jun 2026 08:18:42 -0400
Message-ID: <20260606121843.2850594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060422-eskimo-docile-6e8f@gregkh>
References: <2026060422-eskimo-docile-6e8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 60302276caff50f907bc3391a364691ab4a21b43 ]

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211224142917.6966-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ea66be25f0e9 ("serial: altera_jtaguart: handle uart_add_one_port() failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 23c4e0e796944e..37bffe406b18ea 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -418,8 +418,9 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct altera_jtaguart_platform_uart *platp =
 			dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
-	struct resource *res_irq, *res_mem;
+	struct resource *res_mem;
 	int i = pdev->id;
+	int irq;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -438,9 +439,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res_irq)
-		port->irq = res_irq->start;
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq > 0)
+		port->irq = irq;
 	else if (platp)
 		port->irq = platp->irq;
 	else
-- 
2.53.0

