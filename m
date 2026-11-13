Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547955;
	b=nQpP2AbUxFV2uAgSSCBJQVFv1V0nvByyOXzyZzPFNEpGnHuBjxF5JVTHRJkswe/YvHGL
	 g0TBRLT02zyvLjo0k4tP7R3Kr4OwRl1a3I/+msxK4HHlo0Caa3k1HsxLm6LmEn3OsbxR0
	 ySm99FGmD9vvA2FKus4cUaNn5iB76x0/j+6tZHwDxDieXE0qZEOAvrMggaFDgHgwggM9N
	 zuXoLmOGRfaLaRtpBE24XeMCxewsQWDxhXqzfDHyYY/0YDUYrN26wcl83FruNBKTEiJo4
	 IblSBvRY8jRl7WU1nKZFrcODN4r4GBdcL/bzg/Zkx00FUasce5yu/WYGT3XVuYNEmeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547955;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CIXe5LJ4qzFLroExPsOBA24IMOj8Guk7Wz5iq+3EgJc=;
	b=czKI5cX0pk9pF3xIQxzh+fHRUvW8W0QI982BMoVwG5rHHVf70DZVW0STKCaQ4HBC+LGq
	 6Xz7Yp6/BslYox2aHjlGo41JFUqqoYDDG+DgT/Bf3vGuOE9yPiPfbHiRzw93ZEVuxCR+y
	 bIXq0FmXCrayaZ0rF3X/GV4hNHMmLpi0gv5o2bzMHxQm7fV8U5wdlgXXU7mF+AUcDfsnF
	 /ZaIGm/DqfRmFqM/TLPDE7mupRnaC1t1bM9bfA7ADCQswZtcoK2pQt+yBtDX7inrg9W4Y
	 wEtHxHM5KgacyevQsrEWJpoAJAL6yhUfYjCGVf9TWS8zz6/JRcZfba77LTGGm6Q/z9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.170
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCE606A336;
	Fri, 13 Nov 2026 05:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45BCE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1246013|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00493924-0.00066682-0.994394;FP=3278358288537443492|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083032240;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.k13i.Ms_1794547944;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k13i.Ms_1794547944 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 13:32:28 +0800
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
Subject: [PATCH v2 1/4] pinctrl: bcm: Fix off-by-one and out-of-bounds access in fsel_get()
Date: Fri, 13 Nov 2026 05:32:18 +0000
Message-Id: <20261113053221.3131068-2-wangxiaolei01@kaihong.com>
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

The FSEL field is a 1-based function number: 0 means GPIO, 1..n_funcs
map to funcs[0..n_funcs - 1], and n_funcs + 1 and above are rejected.
brcmstb_pinctrl_fsel_get() indexes funcs[] with the raw value instead
of subtracting one, so readbacks are shifted by one slot: value 8
indexes funcs[8], past the array end, while 0 is reported as funcs[0]
instead of GPIO. The setter programs the mux correctly, so only the
debugfs readback is affected.

Map 0 and out-of-range values back to GPIO, warn on the latter, and
index funcs[] with fsel - 1. Tested on Raspberry Pi 5 with KASAN: the
"alt8" readback no longer splats, and field 0 reports GPIO.

Fixes: 657cbf9b24ba ("pinctrl: bcm: Add STB family pin controller driver")
Cc: Jonathan Bell <jonathan@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Cc: stable@vger.kernel.org
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pinctrl/bcm/pinctrl-brcmstb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-brcmstb.c b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
index f46b27155c3c..2b942ca7196b 100644
--- a/drivers/pinctrl/bcm/pinctrl-brcmstb.c
+++ b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
@@ -66,7 +66,16 @@ static unsigned int brcmstb_pinctrl_fsel_get(struct brcmstb_pinctrl *pc,
 
 	val = readl(pc->base + BIT_TO_REG(bit));
 	fsel = (val >> BIT_TO_SHIFT(bit)) & pc->pin_funcs[pin].func_mask;
-	func = pc->pin_funcs[pin].funcs[fsel];
+
+	if (!fsel)
+		return pc->func_gpio;
+
+	if (fsel > pc->pin_funcs[pin].n_funcs) {
+		dev_warn(pc->dev, "invalid fsel %d for pin %u\n", fsel, pin);
+		return pc->func_gpio;
+	}
+
+	func = pc->pin_funcs[pin].funcs[fsel - 1];
 
 	if (func >= pc->func_count)
 		func = fsel;
-- 
2.34.1

