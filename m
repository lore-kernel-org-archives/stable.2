Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2528495AE3;
	Wed, 16 Sep 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587414; cv=none; b=Tx18vN4aEAPogyJ413FOrqhD2SAWoz5PejVFkIFdpGsl4+9mzVjUS71yRZfRnBUJM6x9HcXuTtf+a+pMZz8lQhxaNS7/IoNUEVFo4YVo1ZdVa9NUZpMzNuTSh/nZsOw5rx8pG6aGlJ/Jy/KMNBDlGE80QQnBd4JRg1cC0z7SdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587414; c=relaxed/simple;
	bh=JQb7VN7D52q9ySt+RSTPP0oOy5LMHg+rfhWRb2KNeoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELST+nBRyffH2Wu9G6bd3r0RNMQouJC8tI8U4QxDiLAsP4dsl8zI5XWwX4AuZuX9V981tKYWJ2bJhOohDd8DMfvGNUa07e6krVCUvvYPEHPwcBj3H/g4uFA11GATL2c7Wv65i56JpxSxqjBcCIUqviPEW5auaDSap6QRc1j8yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9AIhFCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9AIhFCH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10A1BC2BCFC;
	Wed, 16 Sep 2026 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789587413;
	bh=JQb7VN7D52q9ySt+RSTPP0oOy5LMHg+rfhWRb2KNeoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u9AIhFCHnC0J1+Ot0Df4b2nJ29Fz+BEBd9WofnOhKgpwm3QYgey9EyoJjr242cIZ1
	 bu7R8xPMHeWXQNvZtTgWNmzQTe9Ec4X6dJH4TueIWVi7N07y27dCVcnrGUBw8FFgY8
	 +l2m9jR8w8kMlZMpv9pSw3uTLx0Si4Tf3vQE95WEuwCuGolYC0jA6vICD1hhgTu9KL
	 9Or3KeB2sH5vFbKjPItqsSzn/car642yEEBfg8ypnGB1O/awZ7qVRIcQX77Yt0R1ZL
	 QWrH2liUXe1IIPLzN28QxMulsItHHRugh99ihDW4ipxMu+Juv07Sq5EcnfS1M1dump
	 6+hwaH7TT6CmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0969C982D0;
	Wed, 16 Sep 2026 19:36:52 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Wed, 16 Sep 2026 21:36:33 +0200
Subject: [PATCH v3 2/3] usb: typec: mux: ps883x: add a delay after writing
 config regs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ps883x-disable-usb4-v3-2-8f19386456d0@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789587411; l=1571;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=QjUP6gScoHtaAUdZ8JeHXSs4MMhjRv1uTt6ick8pHTM=;
 b=RgNl60w7fXBKWIxfqO9UOL0xF6daFs95uSanJEz9VOR+iJOs6v342z9ihGIxVNyk1sgJRt+SQ
 9dMHJi5RZ/aDESY2MQGHdGuCVcDALp5sXC96hCf3IUw4T5qBlecXJ/d
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


