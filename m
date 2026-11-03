Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741425;
	b=LHR9FMIAOXnWvv8TW1mOxzNXApT21lLy0H5ULhc78IhDEt4xl6ikjU1lnY91B4oGJLmI
	 sSoCN7BZMvI054gn9jrSF9NsQ/fuGAeaLWc7nJQWIHENIGQh6xh67kKNt5VLLiPCkakv8
	 kYu9d5r9A1lkEnjxI1Z9pDYzXn4yBHJXF46OdW007noBKo+Vy9HqMUdQjBrRwevJ27KUc
	 cPJLM1m+W8MVOef1IwPjhHVGhtD52MIYryXgEO8GpHBqhQGLpqrKiHMiH841fPXYod5xd
	 p9lJpnQeU7w/phRL5ep42zXBA7amU+c00J5qI9DFrJ6swuDv6w4R8gzpH+AvBvXIZlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5+T6hAU/9V8EZO2xJdzsHZ9zGf6V77+ijPXZ3E38fGo=;
	b=Qb9ITIcUyUW3jdezkCxIEWEhsb2QzAg2szuGwXy86aU6JmOpLyegnnMKvPGwhImuFbNi
	 8wXzT5C6rXb15Rqf5U2voag23SOJKDcDcTnq++S1NyPZdQzYfVWmIfaZK1idHRqSxnpnf
	 5B7QnG9yOGwzieWw/wEyiZXSJl27yRAtVFCC11JAr/0u54Bh1LmDd25SDo1RrG7+uTmpY
	 TmsDFgEF4qzD9rz1JRdKrKUzvJLAo9TtZ/jqJqIvx3uhX2F2tNYjzK00OBAEdrTqNkNer
	 JA+VBwn2h6qH3BfNdxcCNYi7pN+gOUMVe5K1fj8Kz3mH6klXtVxEAMCXqbghs1loKAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqAcwnFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC69606A328;
	Tue,  3 Nov 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqAcwnFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A91A1F000C1;
	Tue,  3 Nov 2026 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741424;
	bh=5+T6hAU/9V8EZO2xJdzsHZ9zGf6V77+ijPXZ3E38fGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqAcwnFcAgL5ya+ZJZNr9RgiKu+nnlDWHOxf0A20vKXXpt2Ok2UrgeCUqLm45Tjhn
	 NkAqo8wpzveOdyM3gnpELkN1JBHPz4dlto51RCvWp52+72a32ytg1PwV5nDoLDmUe3
	 BTxJp6dBJdLqUoYrJ6OskG+4vdSwjvXeerYgRAmU2Yt8I2yGsF0FcY5klTbrvrs0SE
	 x7oI6oWjI481dFXuZ7Nj17np+1G6S65eGNpJDu5YAp5qnJHuLugV8aH5usSQLBrUgg
	 sBIP1BiHm0iZ7nADY/oLc311e8zBZ3PRIy+6pY2VOtIAAo3L3cI+vPfQLF561ptGX6
	 E74pmeWKaQaXQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] pinctrl: tegra186: Fix out-of-bounds register bank index for AON drive groups
Date: Tue,  3 Nov 2026 21:29:07 +0000
Message-ID: <20261103213002.1673560-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

The Tegra186 AON pinmux controller has only a single register bank
(nbanks = 1, indexed at 0), and all PINGROUP entries in tegra186_aon_groups
accordingly specify bank 0.  However, all 51 AON drive_* macro definitions
pass drv_bank = 1 as the final argument to DRV_PINGROUP_ENTRY_Y, causing
any drive configuration read or write on an AON drive group to index
pmx->regs[1] out-of-bounds.

Update the AON drive_* macro definitions to use register bank 0.

Fixes: 542baf77f092 ("pinctrl: tegra: Add Tegra186 pinmux driver")
Closes: https://sashiko.dev/#/bug/linux-a9a7165c-c5eb-463a-b7b1-24a30416b33b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/tegra/pinctrl-tegra186.c | 102 +++++++++++------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra186.c b/drivers/pinctrl/tegra/pinctrl-tegra186.c
index 4a1d6476af9b..3bf1814dbd24 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra186.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra186.c
@@ -1585,57 +1585,57 @@ static const char * const tegra186_functions[] = {
 #define drive_qspi_comp                 DRV_PINGROUP_ENTRY_N(no_entry)
 
 /* AON drive pin groups */
-#define drive_touch_clk_pee2            DRV_PINGROUP_ENTRY_Y(0x2004,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart3_cts_pw5             DRV_PINGROUP_ENTRY_Y(0x200c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart3_rts_pw4             DRV_PINGROUP_ENTRY_Y(0x2014,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart3_rx_pw3              DRV_PINGROUP_ENTRY_Y(0x201c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart3_tx_pw2              DRV_PINGROUP_ENTRY_Y(0x2024,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gen8_i2c_sda_pw1          DRV_PINGROUP_ENTRY_Y(0x202c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gen8_i2c_scl_pw0          DRV_PINGROUP_ENTRY_Y(0x2034,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart7_rx_pw7              DRV_PINGROUP_ENTRY_Y(0x203c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_uart7_tx_pw6              DRV_PINGROUP_ENTRY_Y(0x2044,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen0_pv0             DRV_PINGROUP_ENTRY_Y(0x204c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen1_pv1             DRV_PINGROUP_ENTRY_Y(0x2054,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen2_pv2             DRV_PINGROUP_ENTRY_Y(0x205c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen3_pv3             DRV_PINGROUP_ENTRY_Y(0x2064,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen4_pv4             DRV_PINGROUP_ENTRY_Y(0x206c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen5_pv5             DRV_PINGROUP_ENTRY_Y(0x2074,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen6_pv6             DRV_PINGROUP_ENTRY_Y(0x207c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen7_pv7             DRV_PINGROUP_ENTRY_Y(0x2084,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen8_pee0            DRV_PINGROUP_ENTRY_Y(0x208c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sen9_pee1            DRV_PINGROUP_ENTRY_Y(0x2094,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_can_gpio7_paa7            DRV_PINGROUP_ENTRY_Y(0x3004,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can1_dout_pz0             DRV_PINGROUP_ENTRY_Y(0x300C,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can1_din_pz1              DRV_PINGROUP_ENTRY_Y(0x3014,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can0_dout_pz2             DRV_PINGROUP_ENTRY_Y(0x301c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can0_din_pz3              DRV_PINGROUP_ENTRY_Y(0x3024,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio0_paa0            DRV_PINGROUP_ENTRY_Y(0x302c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio1_paa1            DRV_PINGROUP_ENTRY_Y(0x3034,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio2_paa2            DRV_PINGROUP_ENTRY_Y(0x303c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio3_paa3            DRV_PINGROUP_ENTRY_Y(0x3044,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio4_paa4            DRV_PINGROUP_ENTRY_Y(0x304c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio5_paa5            DRV_PINGROUP_ENTRY_Y(0x3054,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_can_gpio6_paa6            DRV_PINGROUP_ENTRY_Y(0x305c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	1)
-#define drive_gpio_sw1_pff1             DRV_PINGROUP_ENTRY_Y(0x1004,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sw2_pff2             DRV_PINGROUP_ENTRY_Y(0x100c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sw3_pff3             DRV_PINGROUP_ENTRY_Y(0x1014,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_sw4_pff4             DRV_PINGROUP_ENTRY_Y(0x101c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_shutdown                  DRV_PINGROUP_ENTRY_Y(0x1024,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_pmu_int                   DRV_PINGROUP_ENTRY_Y(0x102C,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_safe_state_ps3            DRV_PINGROUP_ENTRY_Y(0x1034,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_vcomp_alert_ps4           DRV_PINGROUP_ENTRY_Y(0x103c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_soc_pwr_req               DRV_PINGROUP_ENTRY_Y(0x1044,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_batt_oc_ps2               DRV_PINGROUP_ENTRY_Y(0x104c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_clk_32k_in                DRV_PINGROUP_ENTRY_Y(0x1054,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_power_on_pff0             DRV_PINGROUP_ENTRY_Y(0x105c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_pwr_i2c_scl_ps0           DRV_PINGROUP_ENTRY_Y(0x1064,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_pwr_i2c_sda_ps1           DRV_PINGROUP_ENTRY_Y(0x106c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis0_pu0             DRV_PINGROUP_ENTRY_Y(0x1084,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis1_pu1             DRV_PINGROUP_ENTRY_Y(0x108c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis2_pu2             DRV_PINGROUP_ENTRY_Y(0x1094,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis3_pu3             DRV_PINGROUP_ENTRY_Y(0x109c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis4_pu4             DRV_PINGROUP_ENTRY_Y(0x10a4,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
-#define drive_gpio_dis5_pu5             DRV_PINGROUP_ENTRY_Y(0x10ac,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	1)
+#define drive_touch_clk_pee2            DRV_PINGROUP_ENTRY_Y(0x2004,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart3_cts_pw5             DRV_PINGROUP_ENTRY_Y(0x200c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart3_rts_pw4             DRV_PINGROUP_ENTRY_Y(0x2014,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart3_rx_pw3              DRV_PINGROUP_ENTRY_Y(0x201c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart3_tx_pw2              DRV_PINGROUP_ENTRY_Y(0x2024,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gen8_i2c_sda_pw1          DRV_PINGROUP_ENTRY_Y(0x202c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gen8_i2c_scl_pw0          DRV_PINGROUP_ENTRY_Y(0x2034,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart7_rx_pw7              DRV_PINGROUP_ENTRY_Y(0x203c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_uart7_tx_pw6              DRV_PINGROUP_ENTRY_Y(0x2044,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen0_pv0             DRV_PINGROUP_ENTRY_Y(0x204c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen1_pv1             DRV_PINGROUP_ENTRY_Y(0x2054,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen2_pv2             DRV_PINGROUP_ENTRY_Y(0x205c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen3_pv3             DRV_PINGROUP_ENTRY_Y(0x2064,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen4_pv4             DRV_PINGROUP_ENTRY_Y(0x206c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen5_pv5             DRV_PINGROUP_ENTRY_Y(0x2074,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen6_pv6             DRV_PINGROUP_ENTRY_Y(0x207c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen7_pv7             DRV_PINGROUP_ENTRY_Y(0x2084,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen8_pee0            DRV_PINGROUP_ENTRY_Y(0x208c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sen9_pee1            DRV_PINGROUP_ENTRY_Y(0x2094,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_can_gpio7_paa7            DRV_PINGROUP_ENTRY_Y(0x3004,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can1_dout_pz0             DRV_PINGROUP_ENTRY_Y(0x300C,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can1_din_pz1              DRV_PINGROUP_ENTRY_Y(0x3014,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can0_dout_pz2             DRV_PINGROUP_ENTRY_Y(0x301c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can0_din_pz3              DRV_PINGROUP_ENTRY_Y(0x3024,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio0_paa0            DRV_PINGROUP_ENTRY_Y(0x302c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio1_paa1            DRV_PINGROUP_ENTRY_Y(0x3034,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio2_paa2            DRV_PINGROUP_ENTRY_Y(0x303c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio3_paa3            DRV_PINGROUP_ENTRY_Y(0x3044,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio4_paa4            DRV_PINGROUP_ENTRY_Y(0x304c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio5_paa5            DRV_PINGROUP_ENTRY_Y(0x3054,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_can_gpio6_paa6            DRV_PINGROUP_ENTRY_Y(0x305c,	-1,	-1,	-1,	-1,	28,	2,	30,	2,	0)
+#define drive_gpio_sw1_pff1             DRV_PINGROUP_ENTRY_Y(0x1004,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sw2_pff2             DRV_PINGROUP_ENTRY_Y(0x100c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sw3_pff3             DRV_PINGROUP_ENTRY_Y(0x1014,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_sw4_pff4             DRV_PINGROUP_ENTRY_Y(0x101c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_shutdown                  DRV_PINGROUP_ENTRY_Y(0x1024,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_pmu_int                   DRV_PINGROUP_ENTRY_Y(0x102C,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_safe_state_ps3            DRV_PINGROUP_ENTRY_Y(0x1034,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_vcomp_alert_ps4           DRV_PINGROUP_ENTRY_Y(0x103c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_soc_pwr_req               DRV_PINGROUP_ENTRY_Y(0x1044,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_batt_oc_ps2               DRV_PINGROUP_ENTRY_Y(0x104c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_clk_32k_in                DRV_PINGROUP_ENTRY_Y(0x1054,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_power_on_pff0             DRV_PINGROUP_ENTRY_Y(0x105c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_pwr_i2c_scl_ps0           DRV_PINGROUP_ENTRY_Y(0x1064,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_pwr_i2c_sda_ps1           DRV_PINGROUP_ENTRY_Y(0x106c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis0_pu0             DRV_PINGROUP_ENTRY_Y(0x1084,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis1_pu1             DRV_PINGROUP_ENTRY_Y(0x108c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis2_pu2             DRV_PINGROUP_ENTRY_Y(0x1094,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis3_pu3             DRV_PINGROUP_ENTRY_Y(0x109c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis4_pu4             DRV_PINGROUP_ENTRY_Y(0x10a4,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
+#define drive_gpio_dis5_pu5             DRV_PINGROUP_ENTRY_Y(0x10ac,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, r, bank, pupd, e_io_hv, e_lpbk, e_input, e_lpdr, e_pbias_buf, \
 			gpio_sfio_sel, e_od, schmitt_b, drvtype, epreemp, io_reset, rfu_in)		\
-- 
2.56.0.385.gac671c819a-goog

