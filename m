Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695309;
	b=OysmsBWvj/fSNHsodVhLO/R9HHjpVeS2MV059qM6bwgLrBP16o6aWAwcTcKfYuqP5fHe
	 LBmZe38WGtBerpK3glVLJkUHr1mz1Yc7cMghxSnDZzavc+RGIxVC6vxeq/t7QobMiKoWM
	 PjYBKNV/COooFRN3AkbgNynHbBTywCG7ohHaPXFqsCujbhMxzE6km1EfDnvrFmONbvsAj
	 h5waJToX3Dj+2nCgVNtiJGTaxWoGsIWmx6mE2fDtPrKIcYH8QBdtBGgRFL+1cfPKJK7Pv
	 xhWRky+HB2tZdhEnFW7am3Xz73aYnPbXv/vgwkvVxLpQVCQQ2NW2ax8TKCHc8ByL+MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695309;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ud6v5GHE6dsI1x/I4CFKihcxQnNViSFQqXvqAAgVOTA=;
	b=0IoUujt4awvkkcAvwA1UcWiJDn2pUfNw2M3h1fCZ6bTlJa0UtgQLV9Wzsnm2MPCAuG1I
	 cXSxx+u+w7qJTPOZ+FrUPL0pnxEyIFC8/HQ5NSBLpWaJ6tFZ4PmYciB1bxHP86jjcaHJQ
	 f3teId1ydsmM/8Lv9fyVM4DZAw+7NOzX6wRuSNBEvyvNyph0CkOoBBbN3qXTgcJhULd/7
	 OwPgIzkZMe3igAVz+wJBcHcCjGoOnPdpxRimL/Sv6ag6uzs3vJ3FKTcajjRvxZHCMzKVI
	 8cJzvynI4K1PIn6hoxoqEsggSm/L2o/fsZO3H+eoc3kQCqWzCvjtfjPF7SLuuPsQTaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=I8BBDUse;
	arc=none smtp.remote-ip=115.124.28.196
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450D606A944;
	Tue,  3 Nov 2026 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4450D606A944
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=I8BBDUse
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695298; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ud6v5GHE6dsI1x/I4CFKihcxQnNViSFQqXvqAAgVOTA=;
	b=I8BBDUseL0i+33h3JxBigIVT9460MrC0LgHh9lnVEa/v96qAHbhMuheUKhFAMs4hDx6VmH6MnfH3i/qT1aFbBRoE0NW0fSWHaoHWb1HpF+Q4ysHuDJbB8knnFMJN28ehQOWNGo/j9Jg43dLKyoclzmt1n+O5oLx95TW5oSvvmcQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.150449|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00102743-9.22839e-05-0.99888;FP=11030220451923834514|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvUy9FF_1793695298;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvUy9FF_1793695298 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:38 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: tegra-kbc - check the pin numbers from the device tree
Date: Tue,  3 Nov 2026 16:41:34 +0800
Message-ID: <20261103084135.426629-7-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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

The row and column pin lists are read straight from the device tree
and used to index the fixed pin configuration array:

	num_rows = of_property_read_variable_u32_array(np, "nvidia,kbc-row-pins",
				rows_cfg, 1, KBC_MAX_GPIO);
	...
	for (i = 0; i < num_rows; i++) {
		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
		kbc->pin_cfg[rows_cfg[i]].num = i;
	}

The helper only limits how many entries it reads, not what they
contain, and the pin_cfg array holds KBC_MAX_GPIO entries, so a pin
number from the device tree indexes past the array into the rest
of the driver data. The later configuration check validates the
row and column counts stored this way, not the index itself, so it
cannot undo the write.

Reject pin numbers the array does not have.

Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/input/keyboard/tegra-kbc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index e6177f2bdf8d..f086ccf1a075 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -522,6 +522,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	}
 
 	for (i = 0; i < num_rows; i++) {
+		if (rows_cfg[i] >= KBC_MAX_GPIO) {
+			dev_err(kbc->dev, "invalid row pin %u\n", rows_cfg[i]);
+			return -EINVAL;
+		}
 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
 		kbc->pin_cfg[rows_cfg[i]].num = i;
 	}
@@ -538,6 +542,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	}
 
 	for (i = 0; i < num_cols; i++) {
+		if (cols_cfg[i] >= KBC_MAX_GPIO) {
+			dev_err(kbc->dev, "invalid col pin %u\n", cols_cfg[i]);
+			return -EINVAL;
+		}
 		kbc->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
 		kbc->pin_cfg[cols_cfg[i]].num = i;
 	}
-- 
2.50.1

