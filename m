Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AE53ED0A;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079633; cv=none; b=g+3RDk0olHTPq1ZVFX60ap4eh30KSuIFayPLJJRLeLmeBZV+uSY0Ri12Suh9etDEUjnviUMQjVTngA3pou1cIPlsn4KzITye+Lexsz9RjTcxFEbaV43glmyfW8P6hWbNZUi1LxfmvfVVIqGhVJQDwuFH5XsSUlq8YwxsDYtLkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079633; c=relaxed/simple;
	bh=OjSrRvdB6Sb28ACBgMcMc/tOR88zWDlxdM5cKCVe3Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZdzjouyjI5TY5AhNGipR9M3we3Aa4wTE6BTiCk/oJdYqETz+t/5CQseXPRLgkd4ctwSIuOwigY2OqfgXGLCUIWD9DeOrmFZGA03iHcaYM81IwtStrwHTCazzGLOgWSjrAhYZsvnEmNIzb4M/2sBSh67z9dNm4Nt7TxVCLvmfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNi5+m+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNi5+m+K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B48D0C2BCFD;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079632;
	bh=OjSrRvdB6Sb28ACBgMcMc/tOR88zWDlxdM5cKCVe3Wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iNi5+m+KHfs04mCgFbBRAxiHkA9Biu0wG8BAxWuc2qqZr9lmcLW1MH/E+Mx/jWmuB
	 TVj7+3XMxVeszdb3GLyvZZC5hCCnFdJvYEwDuFCRkS/r2HSACczaJBc/0PS7bzpBXN
	 U72oPAyb2nsJKVsh/WXp/cv25PmoJDzm+SXsfsCa0+3RVVk4KRFy7UiE3RcCBNrE3c
	 S/DcPPQhMlLCIqLhZXWr7fCHs8mdNQYZEZ5Iloi4tgflgyJyAYi+ftqjnbbo6dng6q
	 wC5VQcAV6vGghQAHpFhUj42kjhxrrRnj3uv3HZ2HQ2TYpqddA0S65adGl23X/gNs5s
	 UDP+oCL3Pae1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973F2C98306;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Tue, 22 Sep 2026 14:20:21 +0200
Subject: [PATCH v4 3/3] usb: typec: mux: ps883x: disable USB4 on incomplete
 USB4 platforms
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ps883x-disable-usb4-v4-3-0a7b5b70cba3@oldschoolsolutions.biz>
References: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
In-Reply-To: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079631; l=3472;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=1iyfmiUDL9sgFDlX61zRTpyxAquXyuctxtavKjTdzIc=;
 b=J0IUqClEUZPz1wWom/lQCMTO4v8fyoIfQF/bbD/d9SuXRG/vyp8zSbreuHbgUP3MVqnOqEMvJ
 x3waPJ0VHuuCK2otyRIwSyjXtCTf42dUM6dCdz72OG7HzVNCfIFrHjy
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

On Qualcomm X1E80100 / X1P42100 platforms using the Parade PS883x
retimer, hotplugging USB4-capable docks such as the Lenovo 40B0 can
result in working USB but no DisplayPort output.

When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
and forwards it via typec_mux_set(). The qmp-combo PHY then selects
USB3-only because no classic DP altmode SVID is present in the state,
leaving the DP transmitter and AUX channel disabled.

Reject USB4 with -EOPNOTSUPP on platforms whose USB4 / DP-tunneling
stack is not ready yet. The Type-C stack then falls back to USB3 + DP
Alt Mode. DP altmode configuration continues to use the existing
ps883x_set() path.

Use a machine-compatible table rather than a DT property so the quirk
stays inside the kernel and can be removed later without creating ABI.

Assisted-by: Grok(xAI):4.6
Tested-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 15aee1d613b1a..2ec57cfe748a9 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/pd.h>
@@ -42,6 +43,22 @@
 #define CONN_STATUS_2_TBT_UNIDIR_LSRX_ACT_LT	BIT(4)
 #define CONN_STATUS_2_USB4_CONNECTED		BIT(7)
 
+/*
+ * Platforms where the USB4 / DP-tunneling stack is not ready yet. Rejecting
+ * USB4 here lets the Type-C stack fall back to USB3 + DP Alt Mode instead of
+ * negotiating USB4 and then failing to drive DisplayPort.
+ *
+ * This is a temporary, kernel-contained quirk (not DT ABI). Drop the entries
+ * once the corresponding USB4 support is complete.
+ */
+static const char * const ps883x_disable_usb4_compats[] = {
+	"qcom,x1e80100",
+	"qcom,x1p42100",
+	"qcom,hamoa",
+	"qcom,purwa",
+	NULL,
+};
+
 struct ps883x_retimer {
 	struct i2c_client *client;
 	struct gpio_desc *reset_gpio;
@@ -63,8 +80,21 @@ struct ps883x_retimer {
 
 	enum typec_orientation orientation;
 	bool in_reset;
+	bool disable_usb4;
 };
 
+static bool ps883x_should_disable_usb4(void)
+{
+	const char * const *compat;
+
+	for (compat = ps883x_disable_usb4_compats; *compat; compat++) {
+		if (of_machine_is_compatible(*compat))
+			return true;
+	}
+
+	return false;
+}
+
 static int ps883x_enable_vregs(struct ps883x_retimer *retimer)
 {
 	struct device *dev = &retimer->client->dev;
@@ -260,6 +290,9 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 			break;
 		case TYPEC_MODE_USB4:
+			if (retimer->disable_usb4)
+				return -EOPNOTSUPP;
+
 			eudo_data = state->data;
 
 			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
@@ -389,6 +422,10 @@ static int ps883x_retimer_probe(struct i2c_client *client)
 
 	retimer->client = client;
 
+	retimer->disable_usb4 = ps883x_should_disable_usb4();
+	if (retimer->disable_usb4)
+		dev_info(dev, "USB4 disabled until platform USB4 support is complete\n");
+
 	mutex_init(&retimer->lock);
 
 	retimer->regmap = devm_regmap_init_i2c(client, &ps883x_retimer_regmap);

-- 
2.53.0


