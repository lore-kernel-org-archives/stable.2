Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064074;
	b=iBt36GF/1pgPmxPWBYAfM8pmGWMdfw4bk7yaWn+DgjW/v5uN7X4gghPcHmJgE10J0CqJ
	 sKm1JA5uDf/bcz3QYs6IcgtsBppFIMNCO75TALETsawx6OumXUeV8K8f7HbbtMzt2MkUF
	 5cyYKzSTrCasFo1pty3nTGQFwwUy9RhadwSW09Gxia+8b3Lcg4wD7/vmDwe4UCv1xtq9/
	 Ifdbiu03ZM6J86RKXat7tw3Z8SO8o+d+Bl0nY4hfsAET1R6yD67+nE0dfVFBR1EAcHqxL
	 M1bKjuAf1FKnl3NCNPAm0v1mdJ3OiRqOi6RUtprQlWIk1V+R2djpHfclc+LB7MiSYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064074;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SIIbZJRteDk7lfiVpVQ7ZVtmuUKJZZxsXp/vVISgb4o=;
	b=CWfxgOJjtiXcrcZa4IxiPlnyOoW/FP9f6gkNbB8aF5r2gbZDl6bveK/NgURbGBtgfOyO
	 Ajl61iZy+vlyKmBNtUkEYy0XrzVz0gQAEcVoVdd25QUVv84Ej2P+nWkBR2FUnwkZ6Eg2w
	 HIRU6zp7ZLv+pLcQeEYgkkOsc2KZqpKKPcW1cximYIpQ7iK1Mi2uLqCzSbhD6KY4QJcnZ
	 wqdnwDxA/px5nAjPBtTb1u8Y2ZFlje+nJwjhgUjSxDG7Pr9hVuUIenEuQnP2PYcMQaV0Z
	 hmumCowF+g2EgqQQc8IVzXcVm2g8+0PBhHX21Mxpoa7tyu6hhddXSjQvbUnFjHS0wqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fsOLGJzS;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD999606A9F0;
	Sat,  7 Nov 2026 15:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD999606A9F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fsOLGJzS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fsOLGJzSPi0Ebi+TD9FCGosq6BXI4skxpBf7ZiXhkL7Gob9MGD4H6F7sKaQM/njU48uZZ4ylcH664
	 iH4jD1dlqeVJeN0/LmQsEkftCwi45qzrmnKKZaWLXLcGMJCZMfaGAIdiF1XU63qXNcZGZKOVnkyTVf
	 iqtTXDzvQQ3ZQwII=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aef3ec5283-8385e;
	Sat, 07 Nov 2026 23:07:49 +0800 (CST)
X-RM-TRANSID:2ee36aef3ec5283-8385e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[112.0.144.25])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26aef3ec3728-48d1d;
	Sat, 07 Nov 2026 23:07:49 +0800 (CST)
X-RM-TRANSID:2ee26aef3ec3728-48d1d
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laixiangwu <laixiangwu@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fpga: altera-hps2fpga: Fix reset control leak
Date: Sat,  7 Nov 2026 23:07:47 +0800
Message-ID: <20261107150747.1152-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: laixiangwu <laixiangwu@cmss.chinamobile.com>

alt_fpga_bridge_probe() acquires the bridge reset control with
of_reset_control_get_exclusive_by_index(), which is not
device-managed. None of the probe error paths release it, and
alt_fpga_bridge_remove() does not call reset_control_put() either,
so the reset control reference leaks both on a failed probe and on
every bind/unbind cycle.

Since the leaked exclusive reset remains acquired, rebinding the
driver afterwards also fails with -EBUSY.

Use devm_reset_control_get_exclusive_by_index() so the reset control
is released automatically when the driver is unbound or the probe
fails.

Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v2:
- Drop the enumeration of probe error path examples from the commit
  message, as suggested by Xu Yilun.
- Add Cc: stable@vger.kernel.org for backporting.

Link: https://lore.kernel.org/r/20261103014240.1194-1-laixiangwu@cmss.chinamobile.com
 drivers/fpga/altera-hps2fpga.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index f2f125068..6d9798bb9 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 
 	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
 
-	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
-								     0);
+	priv->bridge_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
 	if (IS_ERR(priv->bridge_reset)) {
 		dev_err(dev, "Could not get %s reset control\n", priv->name);
 		return PTR_ERR(priv->bridge_reset);
-- 
2.50.1.windows.1



