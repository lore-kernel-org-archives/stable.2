Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547961;
	b=3QZV7kSo6ATZMfB27tKmRDkalzcaau6/7tW2XPO6Gx5HDLNUG9RFEAGuKpO0wIWLAmBz
	 B7avIRDh5/hmT/D1oZA8h4hHKA/0L5H0vlqbkzlmLV/uZFV2OgTvWiiYW/+VAb8ehsm5A
	 dY5tJZiKP23H1RwCpsbln16T13aSI6rbM1gw41SlBioRy05mz8uba5gX+JgFYiecZI8J/
	 Kx12PUVycJiN498kv/3GcogEaUsGDEXP9GDinvfQxnOEVa6868ldM9z6c4uxNJJeAFseX
	 xKj9eMRzYTcPc13iGcSOfVR1bP06NvrR3uDmw9BUriX67veudS1NO/Fp1lHdfHwIIUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547961;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1+dNKzClzbvHLPMUhTvsZ4k+mtZkDXxX8lvsXl4r+xA=;
	b=uIx9MFHg1C9ZCmbCd8nEyPnAq2kOno1U4pMv01JN+LbqvQCBj3pIGR3VwR1cukYult++
	 gJ4z0a/Cu0tFT0L08YqwnPyoIC2o38x4WbbEKMQxX6PjGyRB8SIDuYgw99jaJXZrU5Z9r
	 DwfcrAabhLLFDLPBpdXKXfXvDr0DNsmCPyz+UIi2MBt2fuSJoa/iIqmAossVfWnQb6Pf6
	 NWp8p98wlioy/0X/3YoGyAbQmw6hg3hD5DpsI1xldm1lNeU0ye4d1oojeGKU6L9fDT4vX
	 m9SrRZwphx+ctTz/SI1zQigujrNeWRIs8ICNoSP0Ab4FRNgterRJGo+WjcnmRLzA8Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.51
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9A606A8A3;
	Fri, 13 Nov 2026 05:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D9A606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3319117|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0156776-0.00224241-0.98208;FP=17113666552651007620|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.k13i.Rk_1794547950;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k13i.Rk_1794547950 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 13:32:31 +0800
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
	Jonathan Bell <jonathan@raspberrypi.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] pinctrl: bcm: Use pinconf_generic_dt_free_map in brcmstb
Date: Fri, 13 Nov 2026 05:32:20 +0000
Message-Id: <20261113053221.3131068-4-wangxiaolei01@kaihong.com>
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
pairs the callback with the pinconf_generic_dt_node_to_map_all()
already used for dt_node_to_map.

The driver already selects GENERIC_PINCONF, so no Kconfig change is
needed.

Fixes: 657cbf9b24ba ("pinctrl: bcm: Add STB family pin controller driver")
Cc: Jonathan Bell <jonathan@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Cc: stable@vger.kernel.org
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pinctrl/bcm/pinctrl-brcmstb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-brcmstb.c b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
index 2b942ca7196b..e81c5b295a05 100644
--- a/drivers/pinctrl/bcm/pinctrl-brcmstb.c
+++ b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
@@ -180,26 +180,13 @@ static void brcmstb_pctl_pin_dbg_show(struct pinctrl_dev *pctldev,
 	seq_printf(s, "function %s", fname);
 }
 
-static void brcmstb_pctl_dt_free_map(struct pinctrl_dev *pctldev,
-				     struct pinctrl_map *maps,
-				     unsigned int num_maps)
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
 static const struct pinctrl_ops brcmstb_pctl_ops = {
 	.get_groups_count = brcmstb_pctl_get_groups_count,
 	.get_group_name = brcmstb_pctl_get_group_name,
 	.get_group_pins = brcmstb_pctl_get_group_pins,
 	.pin_dbg_show = brcmstb_pctl_pin_dbg_show,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
-	.dt_free_map = brcmstb_pctl_dt_free_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
 };
 
 static int brcmstb_pmx_free(struct pinctrl_dev *pctldev, unsigned int offset)
-- 
2.34.1

