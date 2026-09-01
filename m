Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672E33CEBD;
	Tue,  1 Sep 2026 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225541; cv=none; b=hXS2exUn8jksH/zMh8K4uMytqsLv6d1Qpds7YxyyWnoZeD427pEETWHbDrLqFGXxYDw1LH24K5nEV0x25VCiPqSbPuucn+OxNzA2wlK1hrhXVJ2hyaCGv33bJW7A40UtOWRt/Zt86PcOMUTPkpX5uEx8z9HSH/UkEpMXeTbiIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225541; c=relaxed/simple;
	bh=p8nIpbpyiaG388Be9/KJrxTpGbDEHmqCr+KR9sCE9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+2+4FazA/pKk+E6CdRomMBFCVXOepdzcR5Pnn4Hr7aL6iZK68GvyY6YlWOdZmYDYnIOa+u1VYp2dWjEQJ/7ZOenDAekFCC0U0qR9/fQGKFqTd0EgaK7bo/wKT4nO4hy+S48M0vMpGaySgtbk/AJnC5de8I9s2O7eYNez2VLFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbutCuWH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbutCuWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788225537; x=1819761537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p8nIpbpyiaG388Be9/KJrxTpGbDEHmqCr+KR9sCE9vQ=;
  b=JbutCuWHVMsXQXHpS3d7o8zTyRkr6WC8BNUT47j0Vlvl2P1xdXJoABRz
   8sjZJBQOBRDZct2cytzrJJ/hU/9/r8QoTbfELmBrcusQF+DwI4KsvYJZ+
   owtbs2EzuEpZZeAqzcPILKVdLseysX62d0j4zGbC3ehzxkqtO7O1eipvY
   iISfF1uQZaEKFmJvRZoW7hdWzr1tKa52zdZqs2O/XVB71WMcKYLGVH85Z
   YljdzeQJ1oiE9oLZHCvWeRHarG5TI61hr1nRfdvvxIUz08pSzN6Y0N+G5
   t/Yc8pF+x6ii81RZ6WvQq3gwmkfFRNe0URL0vkic1VnuHsZXf1KDZEtVa
   Q==;
X-CSE-ConnectionGUID: dIXmibiNQrWWibji7fC8XA==
X-CSE-MsgGUID: R0ROBxxoSTWPh2wXGb/5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91155357"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91155357"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 18:18:53 -0700
X-CSE-ConnectionGUID: mWznGrphRYmgSsFb1fdAAw==
X-CSE-MsgGUID: pnbh2Y7YS82O+JvYACfT0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267630766"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 18:18:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	JB Tsai <jb.tsai@mediatek.com>,
	stable@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: mt7921: skip CLC records the driver does not know
Date: Tue,  1 Sep 2026 09:18:40 +0800
Message-ID: <20260901011840.416787-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7921_load_clc() fails the whole firmware load when a CLC record
carries an idx beyond phy->clc[].  Record types are added by firmware
over time: MT7922 firmware 20260724 (linux-firmware 20260810) ships a
record with idx 3, the slot commit 9b80bd9cab40 ("wifi: mt76: mt7921: add
regulatory wiphy self manager support") assigns to MT792x_CLC_REGD.  A
driver without that entry now gets -EINVAL from mt7921_run_firmware()
and the device never registers.  Every stable branch the validation
commit is backported to has a three-entry phy->clc[], so this firmware
takes MT7922 Wi-Fi down there; before the validation the same record was
written past phy->clc[] into chip_cap instead (UBSAN report in [1]).

Keep the length checks and skip unknown record types, as
mt7925_load_clc() already does.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2515420

Fixes: 9417c5818a01 ("wifi: mt76: mt7921: validate CLC firmware records")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
Greg: 9417c5818a01 carries a 2022 Fixes: tag and will be picked for
every stable series with a three-entry phy->clc[]; on its own it turns
the current MT7922 firmware into a probe failure there. Please take the
two together or hold the earlier one until this is in.

 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a118a301564c..264f7dbdfa78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -483,12 +483,15 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 
 		clc = (const struct mt7921_clc *)(clc_base + offset);
 		clc_len = le32_to_cpu(clc->len);
-		if (clc_len < sizeof(*clc) || clc_len > len - offset ||
-		    clc->idx >= ARRAY_SIZE(phy->clc)) {
+		if (clc_len < sizeof(*clc) || clc_len > len - offset) {
 			ret = -EINVAL;
 			goto out;
 		}
 
+		/* record type newer than this driver */
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
+			continue;
+
 		/* do not init buf again if chip reset triggered */
 		if (phy->clc[clc->idx])
 			continue;
-- 
2.43.0

