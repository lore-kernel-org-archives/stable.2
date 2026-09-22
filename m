Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241A53FD2A;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079633; cv=none; b=b0z1OHOrTGAUddAMBELbXBr6kIhiQQ/W25XHyz7c35drQnY9El5ANrDMmmiIANejGVEoMAjrc6/VK6mVwINByyqHZIPDfyiZYLUPnjRcEgPUGKTE658h0u9wXQQcnB61KJIaAnCfvV5r90vWav+fwPrEGcYXcqEqfujl0FFXq5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079633; c=relaxed/simple;
	bh=JQb7VN7D52q9ySt+RSTPP0oOy5LMHg+rfhWRb2KNeoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIBOuXNEQxCcowv9cXkKWlxLC/s61L+6qVjAmDJ8/HOaP3WcyvWhFOiu4U04P9N8HyGCwPS+Ysgq1qHJ6os5CxD5OnB3RGrLTo97IaOXGJAEVMjrmG1iOed06q0shysycCwdA5k566rvNUqgXmvuznC2pSCmlVVKYWDChF02GGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aok6KapY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aok6KapY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC7BBC4AF09;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079632;
	bh=JQb7VN7D52q9ySt+RSTPP0oOy5LMHg+rfhWRb2KNeoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Aok6KapYP7ZIo5CvxUrGoimpnAZNq1UWgvyxR3C2qMGfIEQW/RMIqvfqGsH/BQuh1
	 NR1M4I99zVzy+zgWlrxGY8omgo0L4T2bFhDaa3ZyLMaKA9dIfKjv6uWM2Sknqoyvjj
	 TaSxLj52onaSZ1z4XfXMlDqydHW6lDmBe+Ua+QeVaZfaDqDtf9Ks+dScTMKcSANiZ8
	 U3xw8qkQzm6qNeEQ68zOlEHCd7WMIwplPLnDtjiP9+RdM9/uPhT9imJdpJ2TCBS94m
	 LyVYGfrVUnuIwq6bsM7f0D+9u96M34UCyIswmRZeSVkD7IpJzY4outiUMfyhxQuDGS
	 cuNwj3hzL5/oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F9C982FA;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Tue, 22 Sep 2026 14:20:20 +0200
Subject: [PATCH v4 2/3] usb: typec: mux: ps883x: add a delay after writing
 config regs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ps883x-disable-usb4-v4-2-0a7b5b70cba3@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079631; l=1571;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=QjUP6gScoHtaAUdZ8JeHXSs4MMhjRv1uTt6ick8pHTM=;
 b=jogfcruiWItBP+TeH2BypY8axlXi4h2/BDb0m6pYFruVIa27HdoxE87PIGo4BCw+NSVLpM2L1
 K2bYLBDqk3jD3W+TzhZBU5gpc25v7iZkqGKKrIOqq6hFfC4wNXPiR4x
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


