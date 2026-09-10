Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842C33986F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025304; cv=none; b=G7K4d56ofwzTkT4mporx+4UxlMIrj/B7uPDmwfrMwiILV1sjY/W9TaowP6THhqDazUbRvPXWn3mrtQ3nQothWo8o2O3LTdcK4xuZkzgtvWTX9qwKCli95L+Ugtr7sA+FcAgrufKmfHnY9jyHKLMg6QV0QEuk/BoAYkbodRpBjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025304; c=relaxed/simple;
	bh=bfD5ZhNE4N/aizHNYrarJqR1znB7R8NU4xCbHf/9IWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5JnH7aJZ25OOyj1aO/UgmbReub722D8AgE7+xBJiz6S/D85heD8wDfhAspZ7S+WdJocNFQrGw0wZvIJvROIzR7pd9Nm53CyX04ruDyg2U5b72pszKV0Csm8sTpJeIJl+3YkvsYU49Dw6I8a2x/tZyF3eEIezE78xCYzqosdx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I4IFgxOt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I4IFgxOt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so17863225e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789025300; x=1789630100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hf0Vxg/RVuff+NE1o7hBeSqcBx9matMTMP/dNlfdEJU=;
        b=I4IFgxOtIynX+8nrtbi6PXkNMEGrc0wxfef375tlJQGBmcasvE6xgcEIZrgyqIH1zp
         bTl+HPP/bQ2AOJ0PIg6d9QjOnxcLzqVGX7WcLxryMlixh4p6zalOdX/iM4ePywZO+PvL
         fg3/rq59EHbDibsdqoIG/8RtWmiA0BQQ8zq/8iJNW30JSQcdL2WDYUjA9sngLQ27HnhO
         +hbQdMisyjOE5lyAGCEKa4YU5Q3mtV1TKviIz2LFL4+Yrn4kqBd9x9QtlZq7hLkcNL+C
         dmlH4CgVeg9tQxoAwVzgGGqTCVGZ2NmgKUaBB0DuIGYYIYw7kWnmIqnyk70ufmIEKbdn
         Egew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025300; x=1789630100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hf0Vxg/RVuff+NE1o7hBeSqcBx9matMTMP/dNlfdEJU=;
        b=QmNKtkLzixFLdQ3FsgooaB01pMeTz65pKQTGsHehscF0R/27lognUhlywnvzXg05/r
         a46HsIadJEtjVk4ALibfUOKWevpko4QzvVKt8oKAZi9lspg4ibsqhEZpQhEAkfQqSVPC
         VgfjRZcbKG5az86NkiYdovodvnxW+o2SGj0y3a0pnoXgQC8/eaqJllYr/gV/e9Si5UBO
         xiiuGHYkGjq+DEUz/m8VS9sw4Jh58hu2WbvF9FgON3feKplp43sXm8023Cb7xofmOtRE
         i55eIzxr2QLKw/fH37ouOHwzbLYD85yWOELErpYad9tWRn8y+8IjZ1JR6sxStiBB5F2K
         kukQ==
X-Gm-Message-State: AFuF++moGjUxw+nbcJMAgTEqbq7I3QobUE6o0tRp+L/Ugk0BbUwTi1mn
	/8DFT9OmIYCxbYQyUXJvF0E60T9xnr1z7NcgfWuKeZLp4zXmmt1e6ojFuf4LvWFFIYvbuJH6WXt
	CcF8f+Sk=
X-Gm-Gg: AYBFou3i1D76TaXvyOPJjtGJcX2xM2xx0pi0yrvVJaEuCo7I8N0TSCPCCSsYUf+AhtN
	gcUI495D/GW4lLXlXWxxFwUTmYhG84P5DXeWUfcUQorpvmxt5Os7y/4pOoWePVKlj/Ubg5oiYmF
	raoEUHCnHM9EN8HjOf9eJK42HuOFjg1By+nFFXfCsKTbWY46wPdRrUIQHMGvJPsVKPUv4zWnOHV
	8ha4in1qhgRsSpVxp6eZfEEmB/dr/SoN+U32YfbnCC3IC8xNDoihTjyk/hM9t94tfnPtI2G75+j
	suA/dylXhnjMUSyY24ghfCTaGHEZt5aMT1hmg3TNLJSPbF+sTUaXbR0CHMNtxpxXSQoXnhfyjO2
	t69GfWBMcmXxpVM4xLmctFc53ZDTDBVqe6je9W5FxZ+LK1BlDvt+1/UZnt6HVjRfxrvPPKfHrAE
	DPP/dQbv7Avg2k1aQz2fDQavuTtsDUDlbQM01siRRQkhifFTtCEWOS9mPW8zCzztbed8TIRDSWZ
	bmvTqJzgFj0TF/Dfzf1FUKQczR3
X-Received: by 2002:a05:600c:4fcb:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d26db4274mr30720015e9.9.1789025299675;
        Thu, 10 Sep 2026 00:28:19 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be5b72sm46629625e9.4.2026.09.10.00.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:28:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 5.10.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Thu, 10 Sep 2026 09:28:14 +0200
Message-ID: <20260910072814.334323-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-shopper-footsore-8dba@gregkh>
References: <2026090930-shopper-footsore-8dba@gregkh>
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
index cc99a828eb4d..d6c4667dd42e 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1302,7 +1302,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
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

