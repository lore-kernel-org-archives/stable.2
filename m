Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645566;
	b=z6ujAk7PbgxDU6MKmpQ/znwz14fAXtuPd7Go2/lhfb0FjgrRdjurm1lZuXgqHugpSiAG
	 5/7siETXRgbbY8re1w26BgOPQPewnJStA1a6hIzbrSNL2CQ1/q+mZhDK90HetnCjSUH3L
	 +4mQvkiMyoG1cux5RWdLvj4QhyOdt/XU5qaxRBJlHtrVO3urXCNZTSVh7m3Oty8N3BbpF
	 kzosTZGtQcEYTO86bAvL+8BQ8g0NDyUFvkDccOGFdWXGbjTqxerHHnt5zlJ5l9wjjGWn0
	 vFMZb3CMu9n8vX3/vS/isZ8+Gxu089FhKxSjUB66s6dIqB7DHwjoJWPI6XZxq895lVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=e0tXNRDTjLlVxYmJMtKFA5nP+8zQU0S7H6FRQbO3y44=;
	b=cS4DX5yqlU/n8dC40xqlkYQJSnsdaXFARLAuCfjelYUNH3KNK0YK0hHxqT9Z3h6cvYPN
	 63rmaCjKflDxgNzm3vBX27N/oNH6sO8FtF+eOseLYUEgUxQJfsAQ6/Q2gKRRxmHAZZSBL
	 7cSpwvyzqD+VWbipDD8+tD210s1rkJ+mARztN1FHqQuFObO0ydfl6ZY19h1XkT3Z6PgEo
	 CtiK9OqoOZ/WR5mZHmrz4gv2r0VnL3/zwsokaCQevbmGjfN7rN3eDDl+Y/3k6STGx2jQX
	 N/yi3EBKpXBKb/9skMBqh9Kiy44docDKVKv7ClUv/rL2qnnNG42uVWogTReFpmCzDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QHoChKqL;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C7606A6A2
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1C7606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QHoChKqL
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869accaac2so3790184eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645565; x=1796250365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0tXNRDTjLlVxYmJMtKFA5nP+8zQU0S7H6FRQbO3y44=;
        b=QHoChKqLR3pA5jJHnuuBFlvTiZfnL/g3xs7L8NawHBWJ0IPwHFycE9atDzm1E8pUyX
         CQwLTmfZ5hFFVz+4kj/O5//BHofwcVhwjDUL3qUEFdooYTbdug855fV9sJkfezl/WSPI
         T8SSTDyxY5W4nnjsGuOCUtUuvqNV4QTWAahpieX/uzwaZ9jIcVzhTpcLilhXgT4vg/Wu
         CWJXBGFi1Z6JrSzR8+1TWHfvpReSnJZ3G36vJiPh0xHvJyT0pku74Hr8391CTPaFBsGV
         IVMWGR+WTduC0nmMsjKHH5v1T7qfnSUa7kkv/xLjW495/lpWlwMdBUN0wE0zfySgQsZd
         PIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645565; x=1796250365;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e0tXNRDTjLlVxYmJMtKFA5nP+8zQU0S7H6FRQbO3y44=;
        b=vo/ElIvL+SaThI8cXyHWWB1c2pLyMfWOx87IzvoOQ5/Azj6n1bDETBlSUlsS1UdYBn
         Kq0fV6N11z0QAxXYkJ6oXfove7ulCxdYCK1VqePwbjfALjgsXieTGDFLMc6jzMG6LI/b
         ZYEs5mhR/+yrD6YPNOvx1CNJxMZ7SfOUwwcPdO8U6wbuXIKjQ71I2F86ElVFX7e603in
         KcJgiC1g09d/EycENnSE26gAu8t5d31MeNjARtnye8ryY40TJBN22UjD6dJjYaEfOipq
         syZt8ux/27Or1iU/nFLFKB+HihlyvNJMcT599ZtdIrLjMRdLW6mpQklva9/igixInJ09
         z/NQ==
X-Forwarded-Encrypted: i=1; AL+hErF3v3JuID5tYGd8KLHjrhUr9Y5ud0zGND5OuRLu82AT9VPkO3YReyDfA10EUifYppAHIixYOAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YZtoQy+VYblfQmnIToDzwSbxpaHUNAyMAJXj2Lpd5VN8zsaOO
	H+NM6QS4GD72FSrEFRMTExlGjy8I1Zu4mcrBvkR57ypvpBDTGJKQQDjZv1hWGiIn8+tzcQfY5xz
	Yug==
X-Received: from dlbpv6.prod.google.com ([2002:a05:7023:906:b0:195:d59a:94bc])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e80a:b0:1b3:a8ee:a0e5
 with SMTP id a92af1059eb24-1b5567e6419mr20231094c88.2.1795645564512; Wed, 25
 Nov 2026 14:26:04 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:48 +0000
In-Reply-To: <20261125222549.1447825-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222549.1447825-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222549.1447825-2-elkin@google.com>
Subject: [PATCH 1/2] pinctrl: tegra186: Fix register bank for AON drive pin groups
From: Elkin Cruz <elkin@google.com>
To: Linus Walleij <linusw@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Aaron Kling <webgeek1234@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	irogers@google.com, Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Tegra186 AON pinmux device defines only a single register bank
(bank 0). However, the AON drive pin groups were configured with
bank index 1 in DRV_PINGROUP_ENTRY_Y macros. When querying or setting
pinconf properties for these groups, tegra_pinconf_group_get() or
tegra_pinconf_group_set() accesses pmx->regs[bank], causing an
out-of-bounds array access.

Fix the bank index in the AON drive pingroup definitions from 1 to 0.

Fixes: 542baf77f092 ("pinctrl: tegra: Add Tegra186 pinmux driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
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
2.56.1.839.g22a8290db9-goog

