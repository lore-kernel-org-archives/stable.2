Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F753C8C7D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025134; cv=none; b=BfFVKzBIUSz7+bwgL9EfNDWa7KcoN95eAHLfkgQ1gO8MHB0vghIqCKu8k2QspJFxaxKTGP/+IbR4KDD8DPbCUH9SXyTh+C7ZlkG5hjEc12m8nXwumZpbgg7USd4x6Td4pwDzPXktfAdJQyEKJo93tOEya78Ao4FnXjidQPoTTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025134; c=relaxed/simple;
	bh=y4M+GiiOYFAbubXcx8JwJgiGbmU6qKcM43I6y3YE1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2tFQBDj0XHl1ZhXUdsXmHxoWZcEod5qrht4BGsygE1SlVYLIFVamdRxq9RgGE/PTVaNdGBSwEuYhZRTNj032hKlMqMH1wI3vz1umLV8wJTWaW2H83FOG0ZFFUsUXmLYU3v7ZotxFmtKr5yPTSt1h9VUTxntnuciU6n5+gNujvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZVVR7vz+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZVVR7vz+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-486955ae01eso1030619f8f.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789025124; x=1789629924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0jIRTzqzV3q4uOQGdtY2jprNAQRxNJzHauEVeey+qw=;
        b=ZVVR7vz+fNzbXU752CHVPXm75Pib8lX6CWyVjv6Q/eNRieB+9rlysRGb7fzHaNUR5s
         jclmeq5LlaUOak9KiPPcE2e13AEWglmMB37BFO12uhaS/ef20SBiInHi11IO7L5OF80T
         lyY8uI/9FfkHKqZHPhr7dPCWpfFQJZ6n0nmdKKfcaKUWUClKdV7cMPSI2xOP+Tk0DhSr
         ga48S5IotygD3kAYMM9M39nWcAcBLPLqTM3tmFhcE04q7CT+RHKSrNgSfmrAfJ6UDGy8
         S6HKJ1puPa321EwrdMt+3LYnKxbYIPBDIOM4xzmLoLgv2c9iKj47UYDTumeX6gFCXOV8
         iJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025124; x=1789629924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0jIRTzqzV3q4uOQGdtY2jprNAQRxNJzHauEVeey+qw=;
        b=BzRTeBA37ggai5JzpyxUOTMdMAQYeOb/wR3u2fWa6LNOgcelbdSQIX0rWpAK1KRQnZ
         +rsaylVDGPIYFx3W3cDHamLTJZxrfPAg64E8KldCwOvemU87luQRZB81HCuiQBGtz4bA
         IXV/pAd4CAqe6XO66Dy4d6iSJq+riJje1b877gunGq8VV2zE13Bpjq09t54JPUMDB9/6
         bS4+vCYCjxlZyqumIKkPwojoxiBMqkAleqx3PyzwoZpuPcQCE6fioTWyx0MoaJXjs4Wa
         P4ZGiGDm0T5sm/ncSORqU+tE4vGB6BBua16/2jxnmcbxjlOEObW9J92Uj9NGp/jNOnfv
         d+9w==
X-Gm-Message-State: AFuF++nCe878uaWwOo70PSwemMRGL+BztIDIWIW8hCl9xq97qSVoUkjt
	leBPOtaMOkmUtXdHEqzUFT30A0htPBb/K/HSezTiKEY8J8suBFxqwOKdBSyB8aXan8cZqgiuklL
	Y9HDZe4c=
X-Gm-Gg: AYBFou1SBvZUkq6R6IzbUrUN767hmtjcZ8jeEtQQt9ETjFooIzEF2mTdc/i9tNfyXiX
	eWDx5zi5O84fdLaFjGKAffFuseHENpNY9sMPz+gs/fc6Ndtx7wW5cdlpjEI7J8+7dTAOx8JHuD9
	0he6RIkvO1uB0mTuyhY4H2WFdG0BLqVe8T9zjVyN+RM4uXH0DH+7WVjYIOKw+56qs8jNf5PTX9x
	f9LG0S0uZYF25ilohNKHijoCbJsesN/Vo4gZhaZQFSn2vSsOwDuL1NxsOKQkJDAv7z/d0scUJ5Z
	+Thg/xxxiBs42e77t48g9JB8jpV9/ONbj6TT6SOtNWcCVDUkE4AGS6IoLVK1L4DaYT7kDa/mFhv
	AojRHnmISJhAnKQ8jYLcd9e/XUnmKGarNdoXEyKphjjrqLH/IhgeDMPLB2Jb/qOLjMA9b0xACMq
	YY51n+0vdX6OJufkTq7oCXLabbc0oUjMp7Mfqlrix3B42cgxzfX0pwmNgr+ugBhNsEdETPD9aS8
	m2k4Xc3YPeZHyhCBvz1IpZ4TA4j
X-Received: by 2002:adf:e00f:0:10b0:485:ac35:5c5d with SMTP id ffacd0b85a97d-485ac355d0bmr6295306f8f.15.1789025124165;
        Thu, 10 Sep 2026 00:25:24 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm48309362f8f.3.2026.09.10.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:25:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6.1.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Thu, 10 Sep 2026 09:25:18 +0200
Message-ID: <20260910072518.322125-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-giggly-entitle-58ec@gregkh>
References: <2026090929-giggly-entitle-58ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The following out-of-bounds read has been observed by Christian on a
GXBB WeTek Hub:
==================================================================
BUG: KASAN: global-out-of-bounds in __clk_register+0x1b70/0x2418
Read of size 8 at addr ffffd66320cf88e0 by task swapper/0/1

CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc5 #1 PREEMPT
Hardware name: WeTek Hub (DT)
Call trace:
 show_stack+0x14/0x20 (C)
 dump_stack_lvl+0x74/0x94
 print_report+0x164/0x4b0
 kasan_report+0x98/0xd8
 __asan_report_load8_noabort+0x1c/0x24
 __clk_register+0x1b70/0x2418
 devm_clk_hw_register+0x74/0x15c
 meson_clkc_init+0xd4/0x20c
 meson_clkc_syscon_probe+0x5c/0x94
 platform_probe+0xbc/0x17c
 really_probe+0x184/0x844
 __driver_probe_device+0x154/0x35c
 driver_probe_device+0x60/0x188
 __driver_attach+0x168/0x4a0
 bus_for_each_dev+0xec/0x180
 driver_attach+0x38/0x58
 bus_add_driver+0x238/0x4c0
 driver_register+0x150/0x388
 __platform_driver_register+0x54/0x7c
 gxbb_clkc_driver_init+0x18/0x20
 do_one_initcall+0xb8/0x340
 kernel_init_freeable+0x49c/0x52c
 kernel_init+0x24/0x148
 ret_from_fork+0x10/0x20

The buggy address belongs to the variable:
 gxbb_32k_clk_parents+0x60/0x400

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:

Memory state around the buggy address:
 ffffd66320cf8780: 00 00 00 00 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffd66320cf8800: 00 04 f9 f9 f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9
>ffffd66320cf8880: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
                                                       ^
 ffffd66320cf8900: 00 01 f9 f9 f9 f9 f9 f9 00 06 f9 f9 f9 f9 f9 f9
 ffffd66320cf8980: 00 00 02 f9 f9 f9 f9 f9 00 00 02 f9 f9 f9 f9 f9
==================================================================

Commit 7915d7d5407c ("clk: amlogic: gxbb: drop non existing 32k clock
parent") dropped a non-existing clock parent from the gxbb_32k_clk_sel
mux but didn't adjust the hard-coded num_parents field. Fix the actual
number of parents of that mux by using ARRAY_SIZE instead (avoiding
similar problems in future).

Fixes: 7915d7d5407c ("clk: amlogic: gxbb: drop non existing 32k clock parent")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://patch.msgid.link/20260623201956.1324992-1-martin.blumenstingl@googlemail.com
(cherry picked from commit 628b6fee9fca292f12d07f0f1bcf1edefa949d81)
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 6f3918f0a782..8af08853ffe5 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1303,7 +1303,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.name = "32k_clk_sel",
 		.ops = &clk_regmap_mux_ops,
 		.parent_data = gxbb_32k_clk_parent_data,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gxbb_32k_clk_parent_data),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.53.0

