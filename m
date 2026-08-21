Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C522FD1DA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274516; cv=none; b=WfK0h9Z1ShT9D0EQuqZdJUJ+0RtTkyNe+7+5KCc917inyHN8ocbdIp0X7ipA65kCv14MlqJmewYnh5rkcTW6c0jyFtALX29SXn8vev4SctkVk9gAINzJ7O6E8LGaPYdxLPYY6aexHp9A4PtDcxHdKoccmcJo5JfsRTGC6gmdvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274516; c=relaxed/simple;
	bh=wY4uadi2HO3HpucjWOKrMcTP3ow9p1AFLbpJ29zEm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBrG5N2THI+729hz5W6C6XRaFowfARYr2H9CdGeekOlRgfU5S5UGtaPl6P04xPih4ct7xC6tucbAhGRKyxq/L0ELs9YNfIM0DPkc8DNHwknSxmox+Digu0m4ObWrlsvZLHIq+oBaVfiweYMVwKIy4yTJx85rJ70ThvxADOebQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY3HNVo6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY3HNVo6"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso989183a12.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787274513; x=1787879313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRGcQvnKLAeLq/zsHD6Ma8Ccz7ec9Urq2bWU0+6yeKw=;
        b=VY3HNVo6scUFMDi9ENP2a5DdkpPIFV1E7yJfaMsi3+I/TuYLiMoDcN3ZsMci5qikXO
         dp9ZQvmpht/ysQq/45bi+x1SGn24wC0Lpo2yMtjil+85an/9muHFTPgBGO3fdZK3KEJ7
         LMQPQKAJi9vkzWesJViqxOfO6Too2aa2YqUCi122jYiMgXValjBeOwn10HcqYUT4luL3
         2eaa7ge9iESgJR1tUo8QHzDFZf5cgM3sxNQTgbZJzjRP77r+5DXCnrupV5sliWBUub/A
         O2ypbALm85ICU/QPG/5Y610gTMChy/pL4aZ5Z6ecRp3xY0CyBOUoROZXMXCqNhO8uYwu
         Sj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787274513; x=1787879313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mRGcQvnKLAeLq/zsHD6Ma8Ccz7ec9Urq2bWU0+6yeKw=;
        b=jcsrHUlkdm1mfD6/41RA2Mj8hOufSKkczSqVbqwKkIAmethB37/wqV04Z8Ao2/n9Pd
         2qN/xrgW/whEcUPSAwxf1Jfv5pdIa/J557Vsqm/GaBI0BuiAJOk2I8dFXq689ggcWaru
         CFmzroipZmnMIsW+KT8Wx1JHv2d2EE2SuVYDkkkK8w+6sJZTgaZa1xJ1spKuBO/WTkIo
         dabRCXTdeBQFSsUBwQpNuBRG7JaJl2hN9ATi5bEVhYt8wDXi0QTHsZw4Mx874A5m9498
         qcCndTM2D0+gblT8OP9YwPbVaAL4UG81HB7kPAMNy1bxytswHN8HVd/nIsFx0scW2sXn
         14gw==
X-Forwarded-Encrypted: i=1; AHgh+RpbF/ps7cTIlGvOXSnU1HBrDSqrxNP/WYyqnPKNfXk9aVLsk5EgPgkJpZibuOi7p0bNTkEPutw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhgt4lyoS/tw91mP6+TDEnQlAWROTqzFT1sVdPEm0dhWfR5ZV8
	FVh9zd1GQlaskIGt0sUWW8wNMp0yl/fuPtfZNeJrWv/5+F0i0ntDCUSq
X-Gm-Gg: AR+sD137/mxuiW3yGZ1gCj+Os9XCDOyK9iMd2FzIv9wXwcjKSGOxg2ZVpEis2aq1Asw
	eQlEwh0dToH2T23ZSfEZvI6LYu+h4dvf46ylX7bbbJfve0gl+7USqJ0MBmC4BfWuvUcNxlD/VrI
	eDGCf2zOg/iilSiB1IqcJvBJgY5swFLi7DQ5WUxy5PaPqaQuhgg2IoeawyTFtbMLJMiYJ/9/cmC
	cuWFsKgoWnel9Rwe437Fy/PA1t1vYA2mG1UTV34yENL9n9vAWT6caSHDwgoRU04tRd60L2poAfL
	TsfyWppQJ/p54IULkqkW3WbMWFzYp+MnKLSKy/5iTzp7LAZdilB/zicmj2azznrUOENPAfGjH8p
	zUy9TUf4XXU6GeL2vRjl6YO1TOCYLjsy7PTywPhTCLW7C2pScBmkNgyZ5kdFEJwwSEr15LRFCSG
	cAD1cqinhQHHkZUVeNFRsGZwlYpAJy1U+209l0aA7b9De8cuuT04ajdJ3EthU4C0D/ggKRkXw+V
	ng82LPon7NmW28U5OOspeC8G7sSdTFsjDsJzP3Qqq4ojm0efHDkz7mlVkP89Pl5hw==
X-Received: by 2002:a17:907:3e9b:b0:c21:9870:c4f7 with SMTP id a640c23a62f3a-c246a6799e3mr240994766b.20.1787274512882;
        Thu, 20 Aug 2026 18:08:32 -0700 (PDT)
Received: from localhost.localdomain ([151.251.247.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1563c5sm3913104a12.14.2026.08.20.18.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:08:32 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	wenst@chromium.org,
	rafael.beims@toradex.com,
	avraham.stern@intel.com,
	error27@gmail.com,
	s.kerkmann@pengutronix.de,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	chunfan.chen@gmail.com,
	arend.vanspriel@broadcom.com,
	peddolla.reddy@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH v6 3/3] ARM: dts: armada: WRT3200ACM: add marvell,invalid-reg-hint-in-rom
Date: Fri, 21 Aug 2026 04:07:28 +0300
Message-ID: <20260821010728.45065-3-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821010728.45065-1-gvalkov@gmail.com>
References: <20260821010728.45065-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
from the mwifiex ROM, which conflicts with the platform regulatory
configuration on units sold outside the US market. For example:
- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
- phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
- phy2 mwifiex 2.4 and 5 GHz, hard-coded region US

When the system boots, it detects a conflict between the user selected
region and the radios, e.g. BG FR US, and applies extreme restrictions,
preventing phy0 from starting on any DFS channel. phy2 works.

Add a flag marvell,invalid-reg-hint-in-rom to the WRT3200ACM device-tree,
which signals mwifiex that its regulatory hint from ROM conflicts with
the platform and should be ignored, so the platform regulatory domain can
be used. This does not allow the user to change the regulatory config of
any radio. It only allows phy0 to start and operate according to its
certified configuration. All radios in WRT3200ACM/WRT32x are locked to
the hard-coded configuration for which they are certified.

On WRT3200ACM, the platform configuration is stored on the devinfo mtd3
partition, which is read-only: cert_region=EU modelNumber=WRT3200ACM-EU

The Linux kernel sources do not have support for WRT32x. An equivalent
patch for these routers has to be sent to OpenWrt.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
index 4ab45f294de2..2bf29981a031 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
@@ -165,6 +165,15 @@ &sdhci {
 	wp-inverted;
 	bus-width = <8>;
 	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi@1 {
+		compatible = "marvell,sd8897";
+		reg = <1>;
+		marvell,invalid-reg-hint-in-rom;
+	};
 };
 
 &usb3_1_vbus {
-- 
2.55.0

