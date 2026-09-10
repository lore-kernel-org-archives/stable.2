Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF81330307
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025399; cv=none; b=Qt/Io4Vr3F7B9ngA8WXyL6u+eH1rvajDTJd4epsbT0o6hcKIemw1mGkye3ett1tuvY2ka1Dng+UFawbMWk4e38acoJVTbvv17HO1STZVN5XVwYIwpyXE9n7HaB0PE2MmTffdcmdiVy/I6713yR0Z7NbWwzL+wF24zSTro9DQxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025399; c=relaxed/simple;
	bh=y4M+GiiOYFAbubXcx8JwJgiGbmU6qKcM43I6y3YE1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVo3h2H5SMNW7Fd19EM48wlumOLQgPvQ6u0oJtHUH9SarQuD25rFA1Cgbb9gchv1+3NvDq/jJlJQRYrlsNUQJJZVFbSW9rzyYjp0MAStL6UMAdHp879unufph+vmhLezR2r0qlyKzYvGJhdvFffUsHH6rlMufNAMysHzPlDTYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hSZhuve7; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hSZhuve7"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so1067315f8f.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789025396; x=1789630196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0jIRTzqzV3q4uOQGdtY2jprNAQRxNJzHauEVeey+qw=;
        b=hSZhuve7qB79GtcHKtYp/yzy8d7MPHU+Ddar3WL9kdGbKfO/xcghGjKZ0IHbVZusH8
         7HUWJV52PEWjkixaHbLhPG91O8YKSXsVULKQbjzpfVSQGeF+9Eo7ct8sbEu1NslYIlWX
         gB3sRe0aPjpgo4T0Gm4IY7kClxEdO3atWxW5YgIPFfPwd0OGnBaANCPvKjs6aXBfU9QR
         /JNs3VLrBWXxLghFZPq53Mp0gFVgwNPassWl3/fqYzxUijrh21YJ+A7JU6GnwmxjuI5f
         6wXAHh2r6A9bPpca/toJ/RMLzn1TrCPLdvftBN4ABQXmCmIxOIhiDc7v1e37ZgNXLyp1
         8uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025396; x=1789630196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0jIRTzqzV3q4uOQGdtY2jprNAQRxNJzHauEVeey+qw=;
        b=jWEuT+KQ8JZpLdqZ9fM38ZzVKP+GZuOYAY/9o7VjYa9iyLR58BA2MUpgPPuCBzorX5
         +/uz/LWYtkfx3PPCH3qOQxBGDzsZX5Z7kyA7UATVncJidumlLPSzByI2l5yJzn95cpMg
         vdZ3NVcq7An07Jh+O72WfAmd8+5I4JQWf6SmCIAeou2Cv+Si6EGnW2EbECI8InlFqAhB
         02YBM3SxSwE+ApMoedc8d5FuJu1wqpY2F6TMu2t8YaMRLbIVryH4eaZXOBq/tBaXB7AN
         XqpueVIYweIvVlOHIQ5C0eo67yvymzBGID9D+scWAnAqxGxj0wJlwmqqvGa1VxHICOny
         hLUQ==
X-Gm-Message-State: AFuF++lZDWIPvSnca8UCRUElTe5lQTAQWFce9SXyhO0+KV5+DD3PHT+o
	VwKJ6DyYg9emUYzl3RzOkQvjdtwq2WZkmYymq13rctQsijAdJpZbRs+tfm5YTyKjqXrf+skj7aZ
	9yOZ9Mac=
X-Gm-Gg: AYBFou1zs6T6IQrjmuW5Q1bvQZ+if8Rc9wDH+VmYNCZnC7Gc+rJ/9DO+H4sJ9TcTW/8
	iExGZfdtjZGZxPM4PBF1CS3UmwOBXgoBQxjm+WKnzpCK743yvkLCTtvmKL50BG/iiD4yfgbgpwv
	jhCDv+DK5IBbUvZff74iSsZCVwJEW6JrBc6WqdmHI5KVnpve7yGgIMmL2GVbBtFvkn/NN25Gn35
	pP4qW5jJmLHeGyk/7OLLR4FBjj7gOC9bxk1fw+bOn9cZvlzzDNlT9waEVac2TyhwPTHQ3umpnr+
	nxQqXq/Im3Fk9c25NwPxmxav2PseTY1nUXl4L68zlMaW0T5MR+Q1vIz3pWt/zPOX9FQA4jurJ35
	p+x7kTmIQRL6kGb6hiRaUxdSB29Y0hOmYTs9l6Ik5k1YYFiVxn9s9x56PoaO04uvoneivL/NMo2
	boDchc5FOT5JeIbzTY5VwPGtg/sadCPwz3KmeOzFCv07I+15opzI5iOOp5ZONyvNR2llsGD80G0
	qiYHkDqN/e6w2pjfw==
X-Received: by 2002:a05:6000:4713:b0:485:892b:bdad with SMTP id ffacd0b85a97d-485aada981emr23994207f8f.12.1789025395849;
        Thu, 10 Sep 2026 00:29:55 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm44551660f8f.5.2026.09.10.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:29:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 5.15.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Thu, 10 Sep 2026 09:29:50 +0200
Message-ID: <20260910072950.341030-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-unguided-jam-8517@gregkh>
References: <2026090930-unguided-jam-8517@gregkh>
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

