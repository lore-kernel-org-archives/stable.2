Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE353CEB84
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024918; cv=none; b=AsP4wUFLh0KFho8dO9Q0ccMvlH0KL/T0SqEPqG6TbFIpb0MuSBcnKovNT6LY5PNDWAL/6CRAToZ8G2Y1chHjIFTSAEVCGKMmpjdSX72u1/78+zc+TyhVjJ9WC/LEPMw1+UeClYPTQ1Kqkmu9g3OeACI14CKeDWgmXS0Yer5h2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024918; c=relaxed/simple;
	bh=13beGC572KzSfoTA6Djn5DbZXYf7IKoKOuOCcxag/CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLSwuhDmPJeP7owdcHL9TRwt+pdj5wCunZ7vtltVLV3wR5Erd0XcLxZeKU+StBkY9hKJ1jHpaniW5fSaNSGPfaUQOv+gtyz4aH4h11zXrYH4fu0ZVTnD6QJ3imxLZnh/RqJmvXgvw1UjyrNFaPg9Q9K0QA6dedAZHDpPYxk2sJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pSS9ENmL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pSS9ENmL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4843e397f74so412213f8f.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789024912; x=1789629712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBWbvgVSsyhXVBg2MSypFeNWsM04CSfgVw/srqLzCR8=;
        b=pSS9ENmLkxiPuLG9z/xPyNW1aUIMeEVq9zXnPOerKBEv241lTBS5KSx+GNxfkqSYd2
         zkkEs0X+wWuspTqGVyulm088Q15mFstOgpWGuBoFk4lUKet8nqdBrTHWHPbxFrP4nN5C
         qlemefAfmI+cR6WTEOBzm1N/i1NCaN6kMVvmQah+KlOCkVHRCEYFqcR6NzHGbO6ohYlY
         HQeugxm4qek5AuTw4Gi/cUBjADlC7Wcu1TYGldagpGIxo0XvE3iYBMBKdG6nbBfrw8dI
         TP5o9pkqK7DQzgxCC4SXsm5z5UjNpgMGOWGHOOMnllIEyUuUx5ukGAvMZ7cJ9s9SETc8
         Wg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024912; x=1789629712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBWbvgVSsyhXVBg2MSypFeNWsM04CSfgVw/srqLzCR8=;
        b=ZSoLx8r31TbCi0GdLwY9rmiEAcGfWmWhAEo+AWt0Hy0P4H4ZhfW+9gUrMGV+5HxLRZ
         cvJu1HEgrPLb/3MVsPNDoMElO6hyV9BHT+H90g6Jx+HCbtfKZn9VM/rPZihSG5honsEw
         q2PdxB2aQQO6DXLMtL1EfV/LLKFEsyvDnPkuhpOHHv6MuV+CVWACoH3Vh8bQ2h+poTzG
         yG/Qm3K2hp6XsHA0XAwAhdiidQtgAU43NytjRLnW7Q6uYCh6Lj8fO1RBZeLj7f1pwvzj
         u9vjZ65VZqdqBps1WeWW/k2VUZcOSmmDi8i8y/GtrDDjBE8pFBjD0LdkUiySMrUD3f/K
         hOsw==
X-Gm-Message-State: AFuF++ltNiDTS+DHMX6cAlurNKj+dVkyjsIEfKyc78JEXNKbH0GCjFkC
	hDXQ0ptZh9oNYtAnC1HIRSsSBX9HG69+8bNNV3ip2dFBC50fapvHC9OBk4lUHzxOYfzERW78MO6
	AmUUoDJc=
X-Gm-Gg: AYBFou19GiDzHsDLT2f/uRF8Nr4118j3lQPmtD+baKtqwy566JH13+1cvgslbWdlqlx
	XY+TnncSaqmHh/QDRpCRD6GBGFUqESPqFzZbIwpU6tcv0eE4VrtHxW8qmXwtMiRd3aVf87Uos2b
	sbN1m96cH4hTE5FEHZ6Eh311hVjMslXnfStaXmoq/X1zmUNYoykpdSVDyMyq3SgNw8P2LIdfAx1
	rk6pwFfD7niuKgLUIeSAHU6LxQdYU5ktCDO69BvfbWUviUtjZJeS4OqsEVnvktpAol39vtRQs+X
	c/v8ortID0wK0hPabG9QUhbTG8jmotUAIP5dupzvV0E764252oiKsfMEkTm71WhLHMQEKqEQHs4
	8GoIUr6cGSwABJMEbOpOb3ASxWlWXDy3AC2rwRnQrU6ZVJavga7vKnLqyseZI1rAysMy+hubPl3
	j0ssGl2Q0fxjkZEfcVdl0IMc3BXsZqmNqSD8FZPTWFr67rQvxQwNjnapCdU7LF09ql5KN396mA3
	kcsqOkdMSBT55MUe9aHgBsb+ZteAQ==
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id ffacd0b85a97d-486e0f6ce92mr2725177f8f.16.1789024912542;
        Thu, 10 Sep 2026 00:21:52 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm51668875f8f.4.2026.09.10.00.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:21:51 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6.12.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Thu, 10 Sep 2026 09:21:39 +0200
Message-ID: <20260910072139.313775-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-nylon-handoff-edb8@gregkh>
References: <2026090928-nylon-handoff-edb8@gregkh>
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
index 2bfb0ab9c93c..39a6a31e796f 100644
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

