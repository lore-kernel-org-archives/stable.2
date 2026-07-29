Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3963A8743
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360236; cv=none; b=ehUENJdK+cPIdYX5D7592Apr7ZbFvyA9ufVtwLKawIXUPVJb3sV7Rhw5F7QGzu/EW2ENj5wCkeK5Gl0WEON+yjCLPYlmWdO/B/dOI/00wzOwGVsj7op6OmdwhCnWuhlG1hFSqBJQZ/xWUoHjkpgX2+m1bzSAXQCF+vxqErpFU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360236; c=relaxed/simple;
	bh=8TcLqEuhiRWay8MoJPDYXynmF/1c1+bp9mARDOmEbX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjN+pkt3VeWbiWraQVCRMnJoW+ODZCtoZQqff+XI143WzSiwj0quzs2yE7iYJ6tW/uky5UyjmnfIQ+b6Cz4ec93cotUi/6X+WDpOQGFRFI3QBFKX9TbWyq/SYDkEIMmZNFzViw8ddCYYvfvCHWOGPbqOqgyO8EP8006h7aJsq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuDiz/8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuDiz/8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF81F00A3D;
	Wed, 29 Jul 2026 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360234;
	bh=jj2WSZRARwKkwPZX8m+VJjrE/wOe9mR/2rub+RpwmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AuDiz/8XNTRMeHIdoshdVZrEFA/LT21RUgSx/HS9KnNbxcw9hmuac+CyeNxp5uumt
	 r3Y3XlKe9sUC2azzM5lJ9bBM6p0DxR5+tsW3845gBHzhlmI8oNVJac59f37CzPwRnp
	 6ilU8JI5hW7HC1AoM6tCv2j/YmrL7joPt5rzwELqZKKCSK2pbCANMhWbRZSeb1mauz
	 yFXkB6BdLJguzkaXq0H8TnUoCD0XaHIeqjG7aL/hLdSlzkPzuFnIagCMUuisyCNt7g
	 KhmVcEDHV9F59crrGcEnDvsEYXzCD9FFll6ihYuLqmkJMBtrl1aJoU3eXdxK1px6L9
	 8h3rkc+7/qQzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] i3c: mipi-i3c-hci: Fix handling of shared IRQs during early initialization
Date: Wed, 29 Jul 2026 17:23:51 -0400
Message-ID: <20260729212351.1210709-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729212351.1210709-1-sashal@kernel.org>
References: <2026072102-gliding-bloated-dfaa@gregkh>
 <20260729212351.1210709-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit c6396b835a5e599c4df656112140f065bb544a24 ]

Shared interrupts may fire unexpectedly, including during periods when the
controller is not yet fully initialized. Commit b9a15012a1452
("i3c: mipi-i3c-hci: Add optional Runtime PM support") addressed this issue
for the runtime-suspended state, but the same problem can also occur before
the bus is enabled for the first time.

Ensure the IRQ handler ignores interrupts until initialization is complete
by making consistent use of the existing irq_inactive flag.  The flag is
now set to false immediately before enabling the bus.

To guarantee correct ordering with respect to the IRQ handler, protect
all transitions of irq_inactive with the same spinlock used inside the
handler.

Fixes: b8460480f62e1 ("i3c: mipi-i3c-hci: Allow for Multi-Bus Instances")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-14-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 13 +++++++++++++
 drivers/i3c/master/mipi-i3c-hci/hci.h  |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index f2529315445f13..1eeab337e5e533 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -147,6 +147,8 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
 		amd_set_resp_buf_thld(hci);
 
+	WRITE_ONCE(hci->irq_inactive, false);
+
 	/* Enable bus with Hot-Join disabled */
 	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 	dev_dbg(&hci->master.dev, "HC_CONTROL = %#x", reg_read(HC_CONTROL));
@@ -537,6 +539,15 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 	irqreturn_t result = IRQ_NONE;
 	u32 val;
 
+	/*
+	 * The IRQ can be shared, so the handler may be called when the IRQ is
+	 * due to a different device. That could happen before the controller
+	 * has been initialized, so exit immediately if IRQs are not expected
+	 * for this device.
+	 */
+	if (READ_ONCE(hci->irq_inactive))
+		return IRQ_NONE;
+
 	val = reg_read(INTR_STATUS);
 	reg_write(INTR_STATUS, val);
 	dev_dbg(&hci->master.dev, "INTR_STATUS %#x", val);
@@ -776,6 +787,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	WRITE_ONCE(hci->irq_inactive, true);
+
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, i3c_hci_irq_handler,
 			       IRQF_SHARED, NULL, hci);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 32c8aecde9f76f..5502ab0a3535df 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -46,6 +46,7 @@ struct i3c_hci {
 	void *io_data;
 	const struct hci_cmd_ops *cmd;
 	spinlock_t lock;
+	bool irq_inactive;
 	struct mutex control_mutex;
 	atomic_t next_cmd_tid;
 	u32 caps;
-- 
2.53.0

