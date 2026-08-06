Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330BB3CF678;
	Thu,  6 Aug 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029668; cv=none; b=NR5KCVwKHVF1GaNWqlzU79jgwubM59dL2GkQEUGM8XjToIM2IBovf9CnEEnDoLjdrmSvQm5CYgOtUQwJ7XZkZpF3J3p7iDwPn/bloqXGv9Zy+oPwGA97rxxH0fobrXKnUN1y72OPvohPJrGNJBLEjT4XJHPG5aDgbBYjCk6XGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029668; c=relaxed/simple;
	bh=Sb1NY9V01dgoEXrZxpCG9/auJnmA5P6O6bfCDLm4UnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3g27WpCmDRspSQ0LMRHdX8VHbWk2UFC7bZjRMjUjCvmbdpwaUnJz4F7sE1wguKO8sJh9dQayezMU0obBv988syDNufASZ3PsGQM5oZ3AnZH/jHP0KmlhZfFZ8QODNbJH3YtUdtU8RFcEX3j1gjzUdKbGYgIt1tTIUKNmGq9ZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GnxfxLTu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GnxfxLTu"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 490cb5b5b;
	Thu, 6 Aug 2026 23:20:37 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH v2] mfd: da903x: cancel IRQ work during teardown
Date: Thu,  6 Aug 2026 23:20:31 +0800
Message-ID: <20260806152032.894-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260728065557.1517-1-getshell@seu.edu.cn>
References: <20260728065557.1517-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd7a97c0103a1kunm1104d3071001
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh1LVktIGh5IQhkYTxlCTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GnxfxLTu9VYID1N5Sawlup+KC0o5E/QXcr587+/u/qPiz9Zx6YblxalOq0rrU4PeZUQmspJuf3EX75BjoLbPlnQTnG6x57/p3uzcbSscCw+uQqwbrddonNzFW0Zl2CDZVVqbr6+pX4msPsAik0cJY6qS5xX+fNGjXvaWEmjzvI4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9RiJcmxpWB5jybv13xnn/ti2B+Zn7/fJmDEx4MBtReE=;
	h=date:mime-version:subject:message-id:from;

The IRQ handler disables the IRQ and schedules irq_work. Releasing the
IRQ does not drain that work, which can continue to use the devm-allocated
chip and notifier state.

Add a devm action after requesting the IRQ. The action disables the IRQ
and cancels the work before automatic IRQ release. Run the same action
before removing child devices on normal detach.

If da903x_add_subdevs() fails, it removes already-created child devices
before returning from probe. Release the action explicitly before that
cleanup so the work is stopped before child-device teardown.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author against the latest mainline tree.

Fixes: 26b8f5e1e2d1 ("mfd: add base support for Dialog DA9030/DA9034 PMICs")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/mfd/da903x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index e86b39de3303..f3e983bd21b0 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -421,6 +421,14 @@ static irqreturn_t da903x_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void da903x_cancel_irq_work(void *data)
+{
+	struct da903x_chip *chip = data;
+
+	disable_irq(chip->client->irq);
+	cancel_work_sync(&chip->irq_work);
+}
+
 static const struct da903x_chip_ops da903x_ops[] = {
 	[0] = {
 		.init_chip	= da9030_init_chip,
@@ -484,6 +492,7 @@ static int da903x_add_subdevs(struct da903x_chip *chip,
 	return 0;
 
 failed:
+	devm_release_action(chip->dev, da903x_cancel_irq_work, chip);
 	da903x_remove_subdevs(chip);
 	return ret;
 }
@@ -529,6 +538,11 @@ static int da903x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&client->dev, da903x_cancel_irq_work,
+				       chip);
+	if (ret)
+		return ret;
+
 	return da903x_add_subdevs(chip, pdata);
 }
 
@@ -536,6 +550,7 @@ static void da903x_remove(struct i2c_client *client)
 {
 	struct da903x_chip *chip = i2c_get_clientdata(client);
 
+	devm_release_action(&client->dev, da903x_cancel_irq_work, chip);
 	da903x_remove_subdevs(chip);
 }
 
-- 
2.50.1.windows.1

