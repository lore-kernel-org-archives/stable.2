Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547961;
	b=OkJbGBGffA+e+1RmrDdh9gH5dsQ3iRD34UdbwqpbruxqYRsetVbNYV7B9ureMWqiowJd
	 IC8NBxf362ValVTeRa47xb1wG87ULniMDL8hZn2mGbLKaTDyalZ6FM3Mu80e9mfYdnJly
	 12IuhdMu/QR1WBD2evdI8cA6FBcPFWnPmMyQggWIg+P2x2u5jNZPI88r1bYBC28fJPg4M
	 PJpQvn1fpaixaBvt1tzdt1AqncK+5J3mB+q7vQYYPxX39S2tdtW4koIEbMIoLkAd9IzWM
	 OicxVQMxnbttpzyjmd1On5QrLeG3IbOir3ZTYrC9N4i/xPI8s2WO6cwpv6pahctp5kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547961;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LKJF6q7Ffcu2Nfb1b54xHNWuX2HLIOppHi1zSokMCF4=;
	b=a2ryPcv4025vj203h5ItTAUiPz3EnrUqC+zPasNmoK2ZDkPaE+OEhpL3mFJAHscDAoNh
	 apcoz+vN/MGCN6c3tSK03qd1fVSyFkrVtB9wuUzdTRozfcHLI0ojTWv1gJQQMZKiMhQOt
	 RBR6+0IyYUK6S9ttU6cqcpg4i116IEc/oF6gJkgYVrd9DvPKf15TPytYO/aZegTMOVWuV
	 hPKYpy9XOWDkjhLllWD7g5xArBSCP8MAcYPQsAXsSPT01M/p64PgOKcbkSMVhZQOZZmqI
	 F7G3EBGt/thwBEXiEiDSbnjNb/nrZk0x42V0lp7Ns9IdGKcGkfN3GxvbrPOIpVyIAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD069606A89F;
	Fri, 13 Nov 2026 05:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD069606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09999961|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00779417-0.000499325-0.991707;FP=17112549435448952484|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.k13i.QY_1794547949;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k13i.QY_1794547949 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 13:32:30 +0800
From: Xiaolei Wang <wangxiaolei01@kaihong.com>
To: linusw@kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	daniel@dragonzap.com,
	wangxiaolei01@kaihong.com,
	iivanov@suse.de,
	andrea.porta@suse.com,
	phil@raspberrypi.com
Cc: linux-gpio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] pinctrl: bcm: Use pinconf_generic_dt_free_map in bcm2835
Date: Fri, 13 Nov 2026 05:32:19 +0000
Message-Id: <20261113053221.3131068-3-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113053221.3131068-1-wangxiaolei01@kaihong.com>
References: <20261113053221.3131068-1-wangxiaolei01@kaihong.com>
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

Replace the hand-written dt_free_map callback with the generic
pinconf_generic_dt_free_map() helper, which wraps
pinctrl_utils_free_map(). This drops the duplicated free loop and
handles both CONFIGS_PIN and CONFIGS_GROUP map types.

The error path in bcm2835_pctl_dt_node_to_map() uses the same helper.
The driver already selects GENERIC_PINCONF, so no Kconfig change is
needed.

Fixes: 0de704955ee4 ("pinctrl: bcm2835: Add support for generic pinctrl binding")
Cc: stable@vger.kernel.org
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 725e880ae086..69a92cd7bfe0 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -760,18 +760,6 @@ static void bcm2835_pctl_pin_dbg_show(struct pinctrl_dev *pctldev,
 		irq, irq_type_names[pc->irq_type[offset]]);
 }
 
-static void bcm2835_pctl_dt_free_map(struct pinctrl_dev *pctldev,
-		struct pinctrl_map *maps, unsigned num_maps)
-{
-	int i;
-
-	for (i = 0; i < num_maps; i++)
-		if (maps[i].type == PIN_MAP_TYPE_CONFIGS_PIN)
-			kfree(maps[i].data.configs.configs);
-
-	kfree(maps);
-}
-
 static int bcm2835_pctl_dt_node_to_map_func(struct bcm2835_pinctrl *pc,
 		struct device_node *np, u32 pin, u32 fnum,
 		struct pinctrl_map **maps)
@@ -916,7 +904,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 
 out:
-	bcm2835_pctl_dt_free_map(pctldev, maps, num_pins * maps_per_pin);
+	pinconf_generic_dt_free_map(pctldev, maps, num_pins * maps_per_pin);
 	return err;
 }
 
@@ -926,7 +914,7 @@ static const struct pinctrl_ops bcm2835_pctl_ops = {
 	.get_group_pins = bcm2835_pctl_get_group_pins,
 	.pin_dbg_show = bcm2835_pctl_pin_dbg_show,
 	.dt_node_to_map = bcm2835_pctl_dt_node_to_map,
-	.dt_free_map = bcm2835_pctl_dt_free_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
 };
 
 static int bcm2835_pmx_free(struct pinctrl_dev *pctldev,
-- 
2.34.1

