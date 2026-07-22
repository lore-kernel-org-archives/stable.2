Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64B40BCC1;
	Wed, 22 Jul 2026 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695514; cv=none; b=i3dq1JnYZ7VOg3gaEAdOUgghV39EnFWgITbPcAUlcLV2FuldWGzrvOu91pitWxH+UHL63uQmqGLu9GLi5adwGQeCXlwMR6vm6ZHf1otweVbMWYiO5Qu989rq/FexF22N177FW3glzbZLPFRocPncmmNPMHpXt4UAFZI3FZHq36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695514; c=relaxed/simple;
	bh=XTJM4JXyv6n6bIOLiPXZrk4ir73+PuI70tbzz/gvMIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTt2YlCcEmbXHYim82RtYaEWGQG7i4RXVMHMFYHSnLbdFVNVluXz/PlHEfmG/v47Wr//pPc19ks+Uyj4UIt3wCjSprqR5TnuYHi4lRlcpbSZXbHw8jOC2s6ap7SoDG4gHDMwPjHaTvdYJA7RmFK5GRaRwV/DeMeIJ91WuTi/T4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lP807RNY; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lP807RNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8u
	L9wxmTDiGmPX7XiQPtB/bhCd/sMQuICx/Pz7FrusI=; b=lP807RNYsY1zpww2VF
	Jzds2NenyYQwXmRaWqgw2l+GjG5kNWwobpc8gyEHplEUZE4wO8xZ4y029MJjhLBu
	ffeyvBR+azi3ndu1OZewiP6fxe5KRQwSnT7GMG/BRM3II/wDVZvn73tDHIDUPaP4
	s+BdNrI5mBiOG0bSuWwbTxALM=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB35_ehSmBq0f2bKw--.61647S4;
	Wed, 22 Jul 2026 12:44:28 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: sre@kernel.org,
	marex@denx.de,
	hansg@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: bq25890: Fix power_supply reference leak
Date: Wed, 22 Jul 2026 12:44:16 +0800
Message-ID: <20260722044416.1623621-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB35_ehSmBq0f2bKw--.61647S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7Wr1DGFWxGF4xGryrXrb_yoW8ur1xpF
	s5ArWYyr4UXF47Ca1Utrn7ur9aka4fCFyYyr1xGw1vqw13Gw1DJr4xJrnaqrykGrZYgr4v
	qa1ayrn2kFsxuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkhLbUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9gxwe2pgSqylRgAA3+

bq25890_fw_probe() acquires a reference to a secondary charger using
power_supply_get_by_name(), but the reference is not released on later
probe failures or on driver detach.

In particular, failures after bq25890_fw_probe() returns successfully,
such as a failure in bq25890_hw_init(), also leak the reference.

Register a device-managed cleanup action immediately after acquiring
the secondary charger. This releases the reference on all subsequent
probe failures and on driver detach.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: d54bf877fd87 ("power: supply: bq25890: Add support for having a secondary charger IC")
---
Changes in v2:
- Register a dedicated devm cleanup action immediately after acquiring the secondary charger.
- Cover failures occurring after bq25890_fw_probe(), including failures from bq25890_hw_init().
- Thanks for Sebastian Reichel's suggestions.
---
 drivers/power/supply/bq25890_charger.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c1c12a447178..119d651712a4 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1389,6 +1389,14 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 	return 0;
 }
 
+static void bq25890_release_secondary_chrg(void *data)
+{
+	struct bq25890_device *bq = data;
+
+	power_supply_put(bq->secondary_chrg);
+	bq->secondary_chrg = NULL;
+}
+
 static int bq25890_fw_probe(struct bq25890_device *bq)
 {
 	int ret;
@@ -1401,6 +1409,10 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 		bq->secondary_chrg = power_supply_get_by_name(str);
 		if (!bq->secondary_chrg)
 			return -EPROBE_DEFER;
+
+		ret = devm_add_action_or_reset(bq->dev, bq25890_release_secondary_chrg, bq);
+		if (ret)
+			return ret;
 	}
 
 	/* Optional, left at 0 if property is not present */
-- 
2.43.0

