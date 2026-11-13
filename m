Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547959;
	b=H3xhDKqnAaG0/iMHGLPB3ZK2D5UfG29dLGyJydPMCvOgWkhFOxGFTXOjJCiEhq1PqF/t
	 MuLEZqJ/V6dVTLF0JYjHyybs/S1c4mY3XuRLRKfqEJRm3ADWUyJwV93woPBrzQkx0N+/T
	 vzXB0FhHXB9hxMWqxCLb3B2/ICMHuho+CQh6pW+jm3ek8XQ7SwChrxVJu7PIaxQeGca5N
	 SE36CVXEr1LqAbvktUb8xwzfThb8MiUNsTTCPWxpWabUa6IVVTYGN1byumCQlc5QYnurg
	 kv5kAHokvPJzmB8qaYRDIBYR2i9wnzw8yk3+9vgKu8D2EKNnwNB5ZHgHp0o9m8rrm8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547959;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gO4fXpmHkGGnhp/y5ktDMWAcVpm6cOdhfAwLKdNSs34=;
	b=sfUdMdvjVpXnuF53hphijzhWNKxFQPGsf2hMiCUOrCgMrNMZV6DoZq5vqyXidtxaguD1
	 TLmuyJk+HPX5Pd6RewsyLuGPaDm+6HTV1CRSbhDGmL2096QigElA8q45cKYSWjatQL/RU
	 djTDXQPRRJO2X8Tq3yWGJROqLVO0GR5gGKy/KotTcX7HKp/p1AVpkfy2KVgMx6mw/uHnb
	 XcxjO+fW6jQ96bFsKbkZhj3MxEh85QljSlOAzKewOQAH5PoyR5y0mfmeDYcd0lblTBCA5
	 vy8OwZjovEdBla7Qp8mjtHUjK+CsIMOoHsLWb+Ak1WIjh/9qYC7bH7c/jrU3m0wgCmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0E606A88A;
	Fri, 13 Nov 2026 05:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A0E606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1082897|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.214202-0.00041429-0.785383;FP=9475219001989795462|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.k13i.Sy_1794547951;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k13i.Sy_1794547951 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 13:32:32 +0800
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
Subject: [PATCH v2 4/4] pinctrl: bcm: Add missing SGPIO entries to the BCM2712 AON tables
Date: Fri, 13 Nov 2026 05:32:21 +0000
Message-Id: <20261113053221.3131068-5-wangxiaolei01@kaihong.com>
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

The BCM2712 AON controller describes six SGPIO pins as pin 32..37, but
the AON function tables stop at the last normal GPIO: pin 16 for C0 and
pin 14 for D0. Both are indexed by pin number, so dumping the pin list
walks past the end of the table:

  A=/sys/kernel/debug/pinctrl/107d510700.pinctrl-aon-pinctrl-bcm2712
  cat $A/pins

pinctrl_pins_show() hands desc->pins[i].number to pin_dbg_show(), so the
list jumps from the last GPIO pin to pin 32, where a valid mux bit makes
brcmstb_pinctrl_fsel_get() evaluate pin_funcs[32].funcs[] outside the
array. The set path walks the same table for any DT node that assigns a
function to aon_sgpio0..5.

Add the entries as pin 32..37 to match pin_regs[] and pins[]. The values
are from the downstream driver (rpi-6.12.y), which keeps separate C0 and
D0 tables; they differ on the HDMI1 and PMIC pins, where D0 selects
vc_i2c0 and vc_i2c3 while C0 uses vc_i2c4 and vc_i2c5. The empty indices
in between are harmless, their mux bit is zero.

Tested on a Raspberry Pi 5 (C0): "cat $A/pins" triggers a KASAN
global-out-of-bounds report in brcmstb_pctl_pin_dbg_show() with the
driver as-is. The D0 table is not runtime tested.

Fixes: 657cbf9b24ba ("pinctrl: bcm: Add STB family pin controller driver")
Cc: Jonathan Bell <jonathan@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c b/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
index 752b78e2c0d8..1720c220cf3e 100644
--- a/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
+++ b/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
@@ -510,6 +510,12 @@ static const struct brcmstb_pin_funcs bcm2712_c0_aon_gpio_pin_funcs[] = {
 	BRCMSTB_PIN(14, bsc_m1, uart0, vc_uart0, uui, vc_spi5, arm_jtag, vc_uart2, vc_i2c3),
 	BRCMSTB_PIN(15, ir_in, aon_fp_4sec_resetb, vc_uart0, pm_led_out, ctl_hdmi_5v, aon_pwm, aon_gpclk, _),
 	BRCMSTB_PIN(16, aon_cpu_standbyb, gpclk0, pm_led_out, ctl_hdmi_5v, vc_pwm0, usb_pwr, aud_fs_clk0, _),
+	BRCMSTB_PIN(32, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
+	BRCMSTB_PIN(33, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
+	BRCMSTB_PIN(34, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c4, ctl_hdmi_5v, _, _, _),
+	BRCMSTB_PIN(35, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c4, _, _, _, _),
+	BRCMSTB_PIN(36, avs_pmu_bsc, bsc_m2, vc_i2c5, ctl_hdmi_5v, _, _, _, _),
+	BRCMSTB_PIN(37, avs_pmu_bsc, bsc_m2, vc_i2c5, _, _, _, _, _),
 };
 
 static const struct brcmstb_pin_funcs bcm2712_c0_gpio_pin_funcs[] = {
@@ -585,6 +591,12 @@ static const struct brcmstb_pin_funcs bcm2712_d0_aon_gpio_pin_funcs[] = {
 	BRCMSTB_PIN(12, uart1, vc_uart2, vc_uart0, vc_spi0, usb_pwr, vc_uart2, vc_spi3, _),
 	BRCMSTB_PIN(13, bsc_m1, vc_uart0, uui, vc_spi0, arm_jtag, vc_uart2, vc_i2c3, _),
 	BRCMSTB_PIN(14, bsc_m1, aon_gpclk, vc_uart0, uui, vc_spi0, arm_jtag, vc_uart2, vc_i2c3),
+	BRCMSTB_PIN(32, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
+	BRCMSTB_PIN(33, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
+	BRCMSTB_PIN(34, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c0, ctl_hdmi_5v, _, _, _),
+	BRCMSTB_PIN(35, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c0, _, _, _, _),
+	BRCMSTB_PIN(36, avs_pmu_bsc, bsc_m2, vc_i2c3, ctl_hdmi_5v, _, _, _, _),
+	BRCMSTB_PIN(37, avs_pmu_bsc, bsc_m2, vc_i2c3, _, _, _, _, _),
 };
 
 static const struct brcmstb_pin_funcs bcm2712_d0_gpio_pin_funcs[] = {
-- 
2.34.1

