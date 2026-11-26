Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665280;
	b=BbqhtCHJpT8NW/bMceNT5/sT91Bj1QHCj0bZX4tvWAdNbpwAoP9aEOTtKFhIv2+blPO4
	 z6z77VB/XpVJy3k1F+sV1OnNoGQnVCE9PhCYKfR2RDto4Pc591srjnkd+c+spQB/m1TF1
	 d0GytRxAZCsuhxEjXNmfy7gTz8dAXoYe9i5qh7aM6jxznAsaQK11JebWHfRgbxlR1hC6g
	 E/ZatDo0/89ywZDImcYbDC+ERZnpp2fzXjMEDhPNPYw1h71fThlkr95p4guHLtte7BzaC
	 5RqId4YVO3GX2BPnU7xNcWy7FeSREDws0HMCM9MFTYk+Sv7A7EaxHtEC6nb6Y/DaGhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665280;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/YX0PP4Zxh16j/BSheyi86NeF15fh1qBY+KjbTX1UYo=;
	b=JI3qbMi9eUo8NwgpvjcgPN3mPxjkGgNR0JEjaC0g50uF1rXWToFq05Hz2qnrfaFWI5FI
	 Y8ETpP967VNSQsijx50DAfFRaKM86/xnz9l5gtyMmUD3JklT1NF32TbtmHYRzY3q7o3PH
	 FFxUl5Vvq3E2N0LULFCtujsoQNxYbownmbyDwZyuUHy4QzKN71ejm3sDbwsOWeiOUvCPM
	 XByx6Ey4btNSTWoebzyoUQuxZ6pyHALH+7cayxk5ImRbhR77JZAztQfq9l+b2mN8bTfMR
	 Ms27lIpenVQcMBA1U8Oh411c7QBJHWyze+aDKF3ora97/qLPpUomQBS5icIgK/l12Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.101
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2D606A33C;
	Thu, 26 Nov 2026 03:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE2D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1255369|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0101656-0.000535806-0.989299;FP=16590024859856888869|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.kASpfNp_1795665264;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.kASpfNp_1795665264 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 11:54:29 +0800
From: Xiaolei Wang <wangxiaolei01@kaihong.com>
To: linusw@kernel.org,
	florian.fainelli@broadcom.com,
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
Subject: [PATCH 1/2] pinctrl: rp1: use raw spinlock for gpio regmap
Date: Thu, 26 Nov 2026 03:54:19 +0000
Message-Id: <20261126035420.1836760-2-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126035420.1836760-1-wangxiaolei01@kaihong.com>
References: <20261126035420.1836760-1-wangxiaolei01@kaihong.com>
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

The rp1 gpio irq_chip callbacks run in atomic context: irq_set_type()
is called with the irq descriptor's raw spinlock held, and the driver
itself also disables preemption/interrupts while accessing the GPIO
registers.  On PREEMPT_RT, however, the gpio regmap is created with the
default spinlock_t, which becomes a sleepable rt_spin_lock.  Writing a
register field from that atomic context therefore attempts to sleep and
triggers a "sleeping function called from invalid context" BUG.

This is reachable from ordinary userspace: requesting a GPIO line with
an edge trigger through the GPIO cdev ioctl ends up in irq_set_type(),
so any application using edge-detected GPIO lines hits it on an RT
kernel.

  Call trace:
   __might_resched
   rt_spin_lock
   regmap_lock_spinlock
   regmap_field_update_bits_base
   rp1_gpio_irq_set_type
   __irq_set_trigger
   __setup_irq
   request_threaded_irq
   edge_detector_setup
   linereq_create
   gpio_ioctl

Make the gpio regmap use a raw spinlock so its lock matches the atomic
contexts the registers are accessed from.

Fixes: 4732f079cd19f ("pinctrl: rp1: Implement RaspberryPi RP1 gpio support")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pinctrl/pinctrl-rp1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
index dd0e85c2ca33..99566a25ecb4 100644
--- a/drivers/pinctrl/pinctrl-rp1.c
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -1693,6 +1693,7 @@ static const struct regmap_config rp1_pinctrl_gpio_regmap_cfg = {
 	.rd_table = &rp1_gpio_reg_table,
 	.name = "rp1-gpio",
 	.max_register = 0xb11c,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config rp1_pinctrl_rio_regmap_cfg = {
-- 
2.34.1

