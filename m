Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11773B6C1C;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365931; cv=none; b=uelUM5VMYUv3yM+G0j1eKSlk+oI0xfuBX1GVSmhJ3clTSr+RPpV1uSpO76PfJMEKlVjNpX/nDPjL57ws5Gdj+/uxTNVaUvMiwRqzdkkmxYaX7pFJA0uuH/xuoJtgbhH87FZ5bAsHzL6GLYeEIauLHw+2Gbq26Qp2nQVBbpGzj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365931; c=relaxed/simple;
	bh=koHbA//Hd+oUKb54XBErlAxnAOsqGyqZY8Sh/PB5Tdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7Jsaq9PediICep6YXAzE9DoTAe/Y3buwYT/y1G/yrJojPgI65cwkgLa6oHZG3o1ZiZ4kZ0XFWuBSczEYytPqkvRUWGLMvkLUlQBYyr+YI43FNWZWSDWSSYfSK+2UdfZjU0RnfzfcNggf8Pf5Z+mn3Z2areDGx8sRAu1IjDZRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO+OA0+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO+OA0+2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CC20C4AF09;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789365930;
	bh=koHbA//Hd+oUKb54XBErlAxnAOsqGyqZY8Sh/PB5Tdg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PO+OA0+2YAXDnl9S4oOMmfvGmP9rny4vxyBg29gGjC5Pn2le9YBX5Z7/NfeaNOT9G
	 4aF9DVGFGo3PrySO81q19JaO6ZcbmXInswFif5/3AE0gkmNdiGr3iR02d2IfB8vDgw
	 9oh6hn45Dw3iusV0gmOLMZFvKOESvXngLTHiTPjcusMLrTwM1z4F9AqP5CXCY1gvvk
	 o34vKk+uvZUV41Ey9pgbp979ZEFS0Hyn8VSyBsRq9aaaNuMb7sBgQjjOXBc/PxKF04
	 JOmTNc2Z10nVqKxUfgm63Eqv+2DJ3etJdYNG8TGIgfD3NDvs53pGZt13/SrfHMdtjs
	 z3Wh2T7S8tKOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA8AC88E6A;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Mon, 14 Sep 2026 08:05:02 +0200
Subject: [PATCH v2 2/3] usb: typec: mux: ps883x: add a delay after writing
 config regs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ps883x-disable-usb4-v2-2-523c32b4e4d7@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789365928; l=1571;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=D8avNZp7mg36tQCbaHtlJAlu07OwE/RGBF2BKM3mSKA=;
 b=ykLpnS2xe9wbd3cF9M/OrCl8S8CJDgPNPAjC/pE47LWBVSQ2IbnFEFHljr37A5Y1aqSrqUsCk
 R7MAKqOmctTAaDkeiV0Jp+pwabScLgh/rNUIlMs7J7vjx/Ysi7GALBJ
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
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index c185d8897e3a4..e93e958065f6f 100644
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


