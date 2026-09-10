Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC83CE497
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025071; cv=none; b=NzmNFoHfMHHnIFJ0XMHffXyuL3LfuWfUIpBiCF0m3YtB3bjmi1D9Z2vhf9amA7+PBHO7sO/n3hX10GQHTd9pguzA65CNx2o4zPye7fdsTxZSkA6jd4s9ebaxtmBTrsxOr9XI1Y9DCn9Gz3U1i/2IoKY+lEMBln5TSaZClH1fS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025071; c=relaxed/simple;
	bh=2D2Un1V1JSqgiWzh/uwYnUooMAFtmFWbwkDJhb/afvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKJmIqEWB/bN7ToRFJCB9BSKY9Ezpul9Fr/x1ulrgnbmpxhBm1N7HOeUdbah7nfPmVwzjzo8uPbL4TGSei7bFtY0XigjKN9J/Cs4M8JTKvhpPgvieGcVHBTpJtln2ZHfk2V3qTJrqERAvqi5aYC+3izqo67oLouuMR4mjd8JIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JUAqcL21; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JUAqcL21"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369ef6so7298175e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789025058; x=1789629858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPxNHkZ825vy8qHU6Jaj099Tz7xshHGr54ytMScKCjY=;
        b=JUAqcL21eCVhlFS2va/VgEv6637BKi1IWWVpuLyyzIcwzaCTwot/2OCb6Ab5C1qIAC
         IAke5T60Lw7fg6zpq0eE6uHiJi2dkNvoAPYxDRsvUyErggcvhi4ai8I/IE4/WhnzuMeX
         kh0ooOeRUQ95NqTLcmTARVJG/NrFLVV30BA5cO3wjT+9EG10OrIQOB8e4pwHHYguhqIN
         xXSth/UQn3yheRaa48k3REdRzjTwwnpgdxK6BhKT5KnRajr5UAg13f6/wUimdW92/YYB
         YZUEaUN2MzRJKWYO0ch27NfPdZn4PTzOIVScYWYq68KBbFpCmo+wVX9zFdx1lnsm/ZOy
         o0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025058; x=1789629858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPxNHkZ825vy8qHU6Jaj099Tz7xshHGr54ytMScKCjY=;
        b=SB0Jr/8rE8hhD5mI2tG5eVJFT2K7kd+HxHNPuIMqkjXIZGKbLIv3sq+5G3v9xePObY
         Yv5uz4DF+Z57P9WNV23LRFh08CVhmo8DQpPGEX83jmFYMyyJPISaivN2Tvgy2l+ttbJp
         s/LvraVxlpBF9eu4ymWvjGqZF5rKztWcqABT7vgc8DJW+75oJrhIrEfWg8DhKDeTpWjr
         IIUaVaOYn0S1fJywEU+/TMuRMpHkdcekPZeYmbu4ylNeMaLfkl3g+xw6tXfgGwCZ4W0e
         FPj916X2bgjI6sO8Mwt4BpmVayf72USirWwmJgtWX9HszB6IdA1XZlhXWSQaFPn/6k29
         pfvQ==
X-Gm-Message-State: AFuF++lwyO1ncpQv5/Hpl4+7qHxM6Mr3x1QE1ZEFiyQdb16+6jvDJqyz
	p7RM47JXj9iQK7aQNA86byabnHOhRXwlUI92HdWcSGXHHWeMgbB3MYVNV8vfnKytLoKYLCy36yT
	CjadsKP8=
X-Gm-Gg: AYBFou1uSFuQAxjbQTWFuxDncdIsuOJyckdLRLWrA2+tVUyZA5FRdfj74u97zPZOfgr
	ENKtsOp//5bYcVBCGB4jJutf/tfeYD5pylJ9UO843qzgpAHAxqVG9+DA5SnD4hBNq+DPzRyzD83
	HLFxkH23HGI3XPVfof2dyA67WnoYmvS8MMAXY7wS9gaF71INzYefGQqdtq9WWV9XxcJ+RUY5aN1
	oKOmUrJk6xW7kjf/F28toOAagLV/ScOLYX3fYM0aUPU5qPJLZpxtPY7ORIHwE/ovTojjhCnr/+P
	sM1hizX2yJdCHWfg1k39VP+MYRTD0AoaX1mLOC9PABVVkF3IaZ41A8Kax0iSuHSYpJjuKkfXSlu
	9yo8jtoP2dF1pGsZ8Tsjnh2izaPOas/kl3Ppez+3Hg5kFpYCI/NdZe0k+QNdYkcrD7SFIBgKjXK
	SVu/y9TqUJ+O6j+dCcHQXs87SYpahmrJClM62kUwsK9ga+dhyR7P7Zc7HK1cYjIES3eTm3gPi//
	FxjNeBFg+AKGOLYQA==
X-Received: by 2002:a05:600c:1d9a:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49d258ef83amr119431425e9.6.1789025057742;
        Thu, 10 Sep 2026 00:24:17 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bf332esm47937635e9.8.2026.09.10.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:24:17 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6.6.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Thu, 10 Sep 2026 09:23:47 +0200
Message-ID: <20260910072347.317012-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-playmate-skating-2109@gregkh>
References: <2026090928-playmate-skating-2109@gregkh>
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
index 00eaca92b388..a6b46ad04794 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1305,7 +1305,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
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

