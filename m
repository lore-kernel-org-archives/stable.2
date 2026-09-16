Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AB41834B;
	Wed, 16 Sep 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587414; cv=none; b=Y/PKooFjOYB5Qp4cLeyrYpH9flNrExwd8JMcdoPDcRXKPLciHsBRDUxAy/GOcaf/EJkvW6W63VSO3rbCjKsZJ3M1CY643hdR03R5fLjN80S4aUI/0a5aWlSEEpQHy2t/y90Np7IZ5JzbtC3fce3c8nvI9zmrCu23Gcym8bw/x4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587414; c=relaxed/simple;
	bh=2qxTVfGn6dl1TaHgUSX2Fgd6ae+3OG/BYVvwDXz02rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJ7pM6yFgdJhgPf2EdGHRigmX8spKx2maOI1yjTtbKiV85gpEHJvqF3OJeZABH6F1Ovs/oEcCH1STUsfsSXk8QM4GRrc5FYbalSXDlwGzpgFqcBG4Sg6YIb1+wkTonq6dAWl2Z2JnPtVy2shEVc6ro3dn4kJAMRfiEtNrrOL3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acNvwRyy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acNvwRyy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02015C4AF0B;
	Wed, 16 Sep 2026 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789587413;
	bh=2qxTVfGn6dl1TaHgUSX2Fgd6ae+3OG/BYVvwDXz02rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=acNvwRyy1RCCyRme3LqnSW1PXvLbVQ8yMoGjbuoE64MkeHILauo6Z4zu2hqPhMYUE
	 55dwW//5rmiPX4tyET5D8kG8QU+MHYlQ9t+hLvaEiFOKuagpk5PEFVnQgNhtu+sSZg
	 ScMMr8Q4Q+bvCKN55VXkrnvHQxlLoJj/SBPE2d+VxOGZTwF2uZToMlVNK4wFsr88H/
	 wzzvKUpnRafdS/6rUrHGTQndtbS8O36MdOJy7xMRvLE1hTpt0a1DQZ/np4/1Po+Hhk
	 3trQ+nTVXsFFZQghDQIXTEwyPW/09alTARpt1ECXyNQHW0rdwK+DnYK9EA/Qxhipe/
	 jTLYGLgMumRCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841FC982D1;
	Wed, 16 Sep 2026 19:36:52 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Wed, 16 Sep 2026 21:36:34 +0200
Subject: [PATCH v3 3/3] usb: typec: mux: ps883x: disable USB4 on incomplete
 USB4 platforms
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ps883x-disable-usb4-v3-3-8f19386456d0@oldschoolsolutions.biz>
References: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
In-Reply-To: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789587411; l=3563;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=LWQBlYVaxNpRJx4oDZ05Vzvdm0+zYNn5AZkQ3g0e6Rk=;
 b=uyr1eY8Z9C/Flb6+h8Zmsm4E8bK5Ifflx2QqC/p8x+7c/i6YeF3zverIVSnZGzKKExZVNZ0sf
 ykyGcn57XHLB0wGoN9qUmSHk/JDeUNtyLcbU3PjX1d0krp9sla30JUn
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


