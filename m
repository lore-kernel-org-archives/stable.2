Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12793B71A4;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365931; cv=none; b=KwodMoBGLuUVtl8voOLouM8SAXzJLY0zyzZe/SlPI46b6xRm07cu4sYt3y1D4yjDnLMn+jOWbWqE4asEfA+CVcTv9+jOTKKBxS3p8uVm1y9BPSAg19CIfUE2A5VEfOsJ55cnHg67/rJ6EtE2zLzmlK9keac/9pDl9DGJje7zNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365931; c=relaxed/simple;
	bh=U1A1gEcdldWjSFjB/80mZnQF0foGfDZaAUpMsrJ03Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzcnEnVLGjCIGTRJ6DkbNLl3gkxS5wMvOwA80NM4Dfp6ig5McADFw2FWAbC7tBvRq4wcepq3L+JWSwnlo5SvT4SaLSxluWkK+/CrOsrIgXGEimK7kzV+rwYQGtY116cLeFJ9HNYJf+zEgtPs0wxBUMyaXNWp+U1K+wkSK4O29qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Zp/l36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Zp/l36"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D461C2BD01;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789365930;
	bh=U1A1gEcdldWjSFjB/80mZnQF0foGfDZaAUpMsrJ03Ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g/Zp/l36gfuUPD0VlEsFgWhe41JzTU8EoiGpbcNamYemNWhb8ZZtU51ImGWqCPuy8
	 if4j+taYzW/6JckovIIv+DeirgjNWWr8FPL1QHNU6yCfb1tD2m0vdKb2j3hpy+ZnPH
	 XWYSzARIlevOdCMTBu29kpQ/xrsWfVfN8QTDoQDS8ROMKdzrpOf8u3J8kAVrI7x5tf
	 4gir41yM/6+rf7cL2OsbaM/b8C6MSFyQ+CThk5sXKg5fKIsSvhU888gWSu3XiF39bu
	 Lh5aqTd9gC1hPB2bJ8Dvvq2J16Qoe60cNW9Y1QfJ97Y4mk0+orJPszi925wDmlAw2p
	 KxsWLaMjCyvkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C8C88E50;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Mon, 14 Sep 2026 08:05:03 +0200
Subject: [PATCH v2 3/3] usb: typec: mux: ps883x: disable USB4 on incomplete
 USB4 platforms
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ps883x-disable-usb4-v2-3-523c32b4e4d7@oldschoolsolutions.biz>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
In-Reply-To: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789365928; l=3509;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=HRk3TIyrVTGkkKEOnXE4mHkcveZPYCjC1Zdr4f5RWYg=;
 b=zCUBwAHzk08hBIQU+5xVnHBwU7lTo8jJiVxv48unaNA89Zf54gJQG8W/uOTJL5i7Vxo1o/zl2
 jMQw9apC7ERAOlTQ9VBSYzAoghBfoDdpePgJ9sXOR0Ik4di7sSAcRI8
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

Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapati@oss.qualcomm.com
Assisted-by: Grok(xAI):4.6
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index e93e958065f6f..02d6c04d45ae3 100644
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
@@ -262,6 +292,9 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 			break;
 		case TYPEC_MODE_USB4:
+			if (retimer->disable_usb4)
+				return -EOPNOTSUPP;
+
 			eudo_data = state->data;
 
 			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
@@ -391,6 +424,10 @@ static int ps883x_retimer_probe(struct i2c_client *client)
 
 	retimer->client = client;
 
+	retimer->disable_usb4 = ps883x_should_disable_usb4();
+	if (retimer->disable_usb4)
+		dev_info(dev, "USB4 disabled until platform USB4 support is complete\n");
+
 	mutex_init(&retimer->lock);
 
 	retimer->regmap = devm_regmap_init_i2c(client, &ps883x_retimer_regmap);

-- 
2.53.0


