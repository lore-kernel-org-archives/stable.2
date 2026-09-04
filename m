Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538E3B47F0
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553945; cv=none; b=TR0Wc7jaUyYSvIZnJYR5HBslQ7BnojidzqFnNyJ/TPyQS/CH4L2w9wzrif9JeaArWornhKxYPU9tS7scVO1DSC11mfaD9pSRYtPiyeuOvIGu3qkUMZ/AAwLw4hgnWugja5aVJZ3VwXGkwjPKJzGOv71qOREPAmFoqx//97jcy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553945; c=relaxed/simple;
	bh=cKK+q46aKF7uI5u3uZniB3WdUB0jFcn3OOvoUbmqavs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlq6FLRA0VukgNwB/mRsuocHAIucNU6X0icX69counXhIgdEcnM3wEfKoYcw1ovdY26uAHwUq9k0ayRBcAIaH0D8+KXZPeHHYO9M5408Wf3ZoZhG7bCEBWWtKIMobJNJjFtCU5596vtIlMgKdbGM/tj4wfWu+39IpEVmcgOy7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsZb8YlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsZb8YlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB5E1F00A3D;
	Fri,  4 Sep 2026 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553929;
	bh=sJK/XxTNn7At+QYyw5K9QU+HJ9u+gEkWLHwkeJ4YxFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsZb8YlKV9Y+SkQa6BZT85MIDlCfDbXapOMqQV8WkPjjZBkXaOzlS/IM+l8Z7uTO7
	 IKWx8KCqHfV8u8LoC2Fg2yMzgg7ucsN+xKm26Le2EDaO+JTHwP1BPOsFay7XcOyjUP
	 LauU8BmYW7ntIY+uSY/J2bKj6kfvFVw93DCFY3yZxHu/4yMV4E0QOKn+w+Z3rVwNKb
	 GbY+nxLCbXUgoTJax8m9iY8/U1yMwdk/1j2f5HWWlxqAe8jA5jgbMkf5l/IukLO9LR
	 xFMY/CY4Aj1GeFueTv04T0tuKBr4ko9Ts9NMtuFW951xux6HOSvpOfK+fVs5oer/jk
	 oPmVefvNPxN+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: typec: ucsi: extract common code for command handling
Date: Fri,  4 Sep 2026 16:32:06 -0400
Message-ID: <20260904203207.1547529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090308-uneasy-legible-48cb@gregkh>
References: <2026090308-uneasy-legible-48cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 584e8df58942338602c70686b451b5c3093543a1 ]

Extract common functions to handle command sending and to handle events
from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
the same way.

The CCG driver used DEV_CMD_PENDING both for internal
firmware-related commands and for UCSI control handling. Leave the
former use case intact.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240627-ucsi-rework-interface-v4-6-289ddc6874c7@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ sashal: Reduced backport -- upstream 584e8df589423 touches 7 file(s), this
  backport carries 4. Not backported here:
  drivers/usb/typec/ucsi/ucsi_glink.c
  drivers/usb/typec/ucsi/ucsi_stm32g0.c
  drivers/usb/typec/ucsi/ucsi_yoga_c630.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: eb4573cf2fd8 ("usb: typec: ucsi: use UCSI_TIMEOUT_MS for sync command completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c      | 44 ++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h      |  5 ++++
 drivers/usb/typec/ucsi/ucsi_acpi.c | 36 ++----------------------
 drivers/usb/typec/ucsi/ucsi_ccg.c  | 24 +++-------------
 4 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 34b6965ee30b5..2fade504b6235 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,6 +36,49 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
+void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
+{
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(ACK_PENDING, &ucsi->flags))
+		complete(&ucsi->complete);
+
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &ucsi->flags))
+		complete(&ucsi->complete);
+}
+EXPORT_SYMBOL_GPL(ucsi_notify_common);
+
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
+{
+	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
+	int ret;
+
+	if (ack)
+		set_bit(ACK_PENDING, &ucsi->flags);
+	else
+		set_bit(COMMAND_PENDING, &ucsi->flags);
+
+	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
+				     sizeof(command));
+	if (ret)
+		goto out_clear_bit;
+
+	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+		ret = -ETIMEDOUT;
+
+out_clear_bit:
+	if (ack)
+		clear_bit(ACK_PENDING, &ucsi->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ucsi->flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
+
 static int ucsi_acknowledge_command(struct ucsi *ucsi)
 {
 	u64 ctrl;
@@ -1413,6 +1456,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 
 	INIT_WORK(&ucsi->work, ucsi_init_work);
 	mutex_init(&ucsi->ppm_lock);
+	init_completion(&ucsi->complete);
 	ucsi->dev = dev;
 	ucsi->ops = ops;
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 44c788b4a8b38..655c62586d88a 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -4,6 +4,7 @@
 #define __DRIVER_USB_TYPEC_UCSI_H
 
 #include <linux/bitops.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/power_supply.h>
 #include <linux/types.h>
@@ -303,6 +304,7 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
+	struct completion complete;
 #define EVENT_PROCESSING	3
 };
 
@@ -348,6 +350,9 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 void ucsi_altmode_update_active(struct ucsi_connector *con);
 int ucsi_resume(struct ucsi *ucsi);
 
+void ucsi_notify_common(struct ucsi *ucsi, u32 cci);
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command);
+
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 int ucsi_register_port_psy(struct ucsi_connector *con);
 void ucsi_unregister_port_psy(struct ucsi_connector *con);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 0c88d5bf09cae..ea6a47e3c304a 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -20,8 +20,6 @@ struct ucsi_acpi {
 	struct device *dev;
 	struct ucsi *ucsi;
 	void __iomem *base;
-	struct completion complete;
-	unsigned long flags;
 	guid_t guid;
 };
 
@@ -69,29 +67,7 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
-	int ret;
-
-	if (ack)
-		set_bit(ACK_PENDING, &ua->flags);
-	else
-		set_bit(COMMAND_PENDING, &ua->flags);
-
-	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
-	if (ret)
-		goto out_clear_bit;
-
-	if (!wait_for_completion_timeout(&ua->complete, 60 * HZ))
-		ret = -ETIMEDOUT;
-
-out_clear_bit:
-	if (ack)
-		clear_bit(ACK_PENDING, &ua->flags);
-	else
-		clear_bit(COMMAND_PENDING, &ua->flags);
-
-	return ret;
+	return ucsi_sync_control_common(ucsi, *(u64 *)val);
 }
 
 static const struct ucsi_operations ucsi_acpi_ops = {
@@ -110,14 +86,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
-
-	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
-		complete(&ua->complete);
-	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(COMMAND_PENDING, &ua->flags))
-		complete(&ua->complete);
+	ucsi_notify_common(ua->ucsi, cci);
 }
 
 static int ucsi_acpi_probe(struct platform_device *pdev)
@@ -160,7 +129,6 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
 	ua->ucsi = ucsi_create(&pdev->dev, &ucsi_acpi_ops);
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 8d69bc5bff20a..ba5c7fecaca22 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -211,8 +211,6 @@ struct ucsi_ccg {
 	u16 fw_build;
 	struct work_struct pm_work;
 
-	struct completion complete;
-
 	u64 last_cmd_sent;
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
@@ -564,7 +562,6 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 	mutex_lock(&uc->lock);
 	pm_runtime_get_sync(uc->dev);
-	set_bit(DEV_CMD_PENDING, &uc->flags);
 
 	if (offset == UCSI_CONTROL && val_len == sizeof(uc->last_cmd_sent)) {
 		uc->last_cmd_sent = *(u64 *)val;
@@ -582,15 +579,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		}
 	}
 
-	ret = ucsi_ccg_async_write(ucsi, offset, val, val_len);
-	if (ret)
-		goto err_clear_bit;
-
-	if (!wait_for_completion_timeout(&uc->complete, msecs_to_jiffies(5000)))
-		ret = -ETIMEDOUT;
-
-err_clear_bit:
-	clear_bit(DEV_CMD_PENDING, &uc->flags);
+	ret = ucsi_sync_control_common(ucsi, *(u64 *)val);
 err_put:
 	pm_runtime_put_sync(uc->dev);
 	mutex_unlock(&uc->lock);
@@ -621,16 +610,12 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (ret)
 		goto err_clear_irq;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
-
-	if (test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
-
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
+	if (!ret)
+		ucsi_notify_common(uc->ucsi, cci);
+
 	return IRQ_HANDLED;
 }
 
@@ -1344,7 +1329,6 @@ static int ucsi_ccg_probe(struct i2c_client *client,
 	uc->dev = dev;
 	uc->client = client;
 	mutex_init(&uc->lock);
-	init_completion(&uc->complete);
 	INIT_WORK(&uc->work, ccg_update_firmware);
 	INIT_WORK(&uc->pm_work, ccg_pm_workaround_work);
 
-- 
2.53.0

