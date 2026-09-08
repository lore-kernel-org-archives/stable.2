Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE34F646E;
	Tue,  8 Sep 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860200; cv=none; b=PW23R51/sJnvElpIM/I7ylHAy8iBeCSeaoYZGNJh4ybKOjI6T2Ve6qeU0SjWDDdsuG6zF2jK1HrTGa9TmHpmlw4ofgSL5K136LwXkpLcG0wnORwDRdNgwXxRp2tQ6Yq3JoUtHD+Pb31K4jbh6If252xo+b6QfXML7FQ9c4IDWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860200; c=relaxed/simple;
	bh=hju+miMB0DwsEai/Rn4SfGeACJ9vRM7dxqY4Nmuz1HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9Yg42nyf0BleR8U37BxQ6Wl8DpfTQIaU1JC3SMGNkLcdTXWxXea7ydv+EavnvBWtu0wsOjp/pWQGJTqse+TccJynjaG73ToA4zRV57pRSH2kd6NsyXgZUY9rtStygzjL67KU6+sFJH9Tt/H2Ii/s8r/FF5VbH0jeFEX2OD6HC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=eNMBG6Jv; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="eNMBG6Jv"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788860187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryfKdL4DfllftOGcpI0AMPFnyaoULNI7HFXLFjKK+wQ=;
	b=eNMBG6Jvm44p5xnQvyl7oqfYvOVgpe569zC+pbT3kwla+IkMOl3F7d6WQzL7VUAVQHSyM8
	eY+Vxdx9Nof/HPPRbFA+n58OJxLwgUufBVP7Qwz9t8qymF37HSJEzxWqk+2WnBw9h5iF1q
	S8XmvY2E532kDgVorz81nkmqDtfL0Ks=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Artem Shimko <a.shimko.dev@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 5.10] serial: 8250_dw: Use dev_err_probe()
Date: Tue,  8 Sep 2026 12:36:21 +0300
Message-ID: <20260908093626.15492-2-arefev@swemel.ru>
In-Reply-To: <20260908093626.15492-1-arefev@swemel.ru>
References: <20260908093626.15492-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 57f83e5dd6a33c4696699954784f8fee789b1d0c upstream.

Simplify the error path in ->probe() a bit by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220509172129.37770-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/tty/serial/8250/8250_dw.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 211dc88ce4e2..629eb24166b5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -451,18 +451,17 @@ static void dw8250_reset_control_assert(void *data)
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct uart_port *p = &up->port;
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
+	struct resource *regs;
 	int irq;
 	int err;
 	u32 val;
 
-	if (!regs) {
-		dev_err(dev, "no registers defined\n");
-		return -EINVAL;
-	}
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -547,7 +546,7 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	err = clk_prepare_enable(data->clk);
 	if (err)
-		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
+		return dev_err_probe(dev, err, "could not enable optional baudclk\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
 	if (err)
@@ -557,20 +556,16 @@ static int dw8250_probe(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
-	if (!p->uartclk) {
-		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
-	}
+	if (!p->uartclk)
+		return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
 
 	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
 	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
 	err = clk_prepare_enable(data->pclk);
-	if (err) {
-		dev_err(dev, "could not enable apb_pclk\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "could not enable apb_pclk\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
 	if (err)
@@ -616,9 +611,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
 		if (err)
-			dev_warn(p->dev, "Failed to set the clock notifier\n");
-		else
-			queue_work(system_unbound_wq, &data->clk_work);
+			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.43.0

