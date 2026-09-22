Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68F541E6D;
	Tue, 22 Sep 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079939; cv=none; b=FDYwD3B9A+PITY4V+MWHBMYvBcr20pbRpdsXUJRDu/A0KAl7LkkDukfP4fixNRPANtVJNRc84penUCShzwVTua33IMndPtqILIjEeGur5TrnDziE2+ycg5WkglOCHcsgKt46IcIP13r11ecB92GMORFTc7ECn4jo44GtL0IWDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079939; c=relaxed/simple;
	bh=iElfDspKaFxZAER9CiupajWCePulqE1zjuuE149+Hog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3RnAKwOEX9fLsIL7oGTfCEROpmN6ED2zt2BSNDghMCW5m8qwfbFeok5rHGLDCYbEr1UqgnnPAEb9S4/jsGENoNrn/GAPT+rMn/jaL/0ixap/isYqgsTF0Ak7U/Ebrs58AhlXRlTXv1fT6ln3YSZy+8JTzNBe/6WPTZILyrUyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivYhLQWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivYhLQWy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF41EC2BCFF;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079938;
	bh=iElfDspKaFxZAER9CiupajWCePulqE1zjuuE149+Hog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ivYhLQWyVYEbwmlrLuRrPeP/td+aPVDq9hrwGfSQkixot9gippoGyPspWcSE9RSsW
	 DcaY9SiQuZwJ4hvCympM3n/KFc2lMoZNI/BINO8yEeNZrs/d2djdDc+COHCfiy19HX
	 bEldzxF0LUx+ja4AgBTp+N3h6+fbOlPeoi8fkxtJLUJY1MV+9AZqk7obqwsgAAOqIH
	 eskvelrZ+WpzPcIfhRWBeyR97HC32Ad8H4mov8LOgXnMoPXRvBM0D0n2O8UYrqpsTt
	 KKpD85DfzCwQNwL+vZMvEsE9cM9ipDyl9To2msZ+UIi9jJunPZKLSm6IdA03trpaKi
	 xUfBRDDDfuzCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F9AC98306;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Tue, 22 Sep 2026 14:25:30 +0200
Subject: [PATCH v5 2/3] usb: typec: mux: ps883x: add a delay after writing
 config regs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ps883x-disable-usb4-v5-2-02c0414978e6@oldschoolsolutions.biz>
References: <20260922-ps883x-disable-usb4-v5-0-02c0414978e6@oldschoolsolutions.biz>
In-Reply-To: <20260922-ps883x-disable-usb4-v5-0-02c0414978e6@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079937; l=1632;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=bFSHfgooHbrl3Ye8+c5b+paG9lzebtfeVEngyUs0qtU=;
 b=GhG2+ecP++TW6Mx/ciG9ONWmZN0mDUjY9xapBQOiaf65R7DE/f31PRvGOus1+zFSnWme3Z/Ku
 7XMuKIIfkUACsy8Fs32Ag2jQVLR0+klfLHPaHZQ+bQI7MhLbfyW+qbl
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

The connection-status registers need time to propagate through the
analog front-end (PLLs, lane training) after they are written. A 30 ms
delay after ps883x_configure() brings DisplayPort Alt Mode hotplug on
the Lenovo 40B0 to a reliable success rate.

Tested with T14s G6 and IdeaCentre Mini with the 40B0 dock on the HDMI
port with a Type-C host cable. Qualcomm firmware that programs this
retimer from an MCU uses a similar post-config delay.

Assisted-by: Grok(xAI):4.6
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index a5696aef054ee..15aee1d613b1a 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -7,6 +7,7 @@
 
 #include <drm/bridge/aux-bridge.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
@@ -184,6 +185,15 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 		return ret;
 	}
 
+	/*
+	 * The retimer needs time after the connection-status registers are
+	 * written for the analog front-end (PLLs, lane training) to settle.
+	 * Without this, DisplayPort Alt Mode hotplug is unreliable on some
+	 * docks (e.g. Lenovo 40B0). Qualcomm firmware on platforms that
+	 * program this chip from an MCU uses a similar post-config delay.
+	 */
+	fsleep(30000);
+
 	return 0;
 }
 

-- 
2.53.0


