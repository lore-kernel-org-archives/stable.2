Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18458499F09
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851203; cv=none; b=D8OssO159w3bMdAaftQrq5lIbI4hqZDvTkDl33r70qzPnssA7OSG/K7/A5Ep6oBbKpw12Ng1VQoivTZQoCpyQBfCS8dsnQC/Pj3LFMT2MQ5akjtEof6gWZbudfFgdds7bo1xZNGh/nx1WMRxU1PSEhTbENdOiAECGwSsBJnG5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851203; c=relaxed/simple;
	bh=sarQEdrSbBSoaCcKumeb7DKx9O4YVpY+WCIk3ge9e4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYdB6MTn5JJ5Zc6Qf4hOwlSX+cdsaAa4y1heVkuNJp6TvJwrSnEuEmrH7E7azHUladwAhjisvaJfmcxPA2WLLem43BqPuS3cxfPpOlCHnOntyYBFZUs44tSlR+sGyAwxyAYCfHIlLKISEGxvxYrUNLlcFyCsXiyK4RR0szpyS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEps2p9e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEps2p9e"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so905e9.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851199; x=1788455999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QF2zBpTs1xbQ8vVeDBrFP8mtx1WkUete3RSSn/zfKZ4=;
        b=tEps2p9e7u6LtM/r7j+mxS7RQVGVczPGAZqMWu3/0e5WIi60MLN/cbsY5sMq/zmTKA
         OepblmJnA1Nk5Hbe8HBM0uvzkH4vlY+S9sUgK/HsogUzzVt3C3iPxhi7cIulS9yDUjkA
         93kRClvP1yj3NIM06fNQkDBMQgeMRklqllV/AKuG6L2HZqMtWvu/VvhsGouGUoOApXqk
         1cZeqLWngayNaGavonG4NhReCmS5Q81IEKUm6SfKSYueWEaUHAaa+y33D4gyakgU8DIZ
         8bT7S2+uqnPNDM5y0/JBGREFFYhMoP+/P6rzpHvaev0ccS5kuD0g8+VRgUqoT/rC7sM5
         gYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851199; x=1788455999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QF2zBpTs1xbQ8vVeDBrFP8mtx1WkUete3RSSn/zfKZ4=;
        b=eT7wk9+/DLvwdyjX++nnU+4Ke1CnnQvyjfXjQACO30JutcEywipuU0Lji8RtxpzEPL
         E9AnNe5ULc1VnwP3KvzED9kfJ1yb5MIjuvbCE1g0tFO5crhhO7XO2DEPMa4mJPWaVSpz
         8Xh4jWlHIJW6pAcxp6kIsH9tOiVVrHDDQGojEAMVoqgDqgJmzK+piSOP9nC9FtwgItPO
         fdSjD9CHq5feCOjf6jHyeoABqOICuVOW3w7/8y+L6F0XPEEIbJCM6CCdUfJJw1FIeGvL
         zUob+FcViBXO5g79eBgvxyQUBLiY5RkqW/bNIomoHu8qDKutLTaWwzkjAt2Ms9haDlFQ
         JoyA==
X-Forwarded-Encrypted: i=1; AHgh+RpGWEB4nK/tPu5tTZkNRs/eiwLRjansjo15xQobGi3lnHuw74n5FSXrtSSoBchbwiWbuC94kIo=@vger.kernel.org
X-Gm-Message-State: AFuF++n4YZtJb0XQX7g/3sskyN6etH1SVpmKRhjtf78UglPdCzmXaLBQ
	TxO2+qQ1KPAWmCOL8h5ngGkrxZ1Uis0QFzVHhrP0zQBhCY6zprouHmv7
X-Gm-Gg: AR+sD13R3fHR6WnyRZIsdzyYCdFfvvebldMApiFj/2wAGaqGcWFc3L6NBwnbIJbw8xL
	r4JPaxZMUnO233FzvvKKQINGw3J0MPSRAjS3U9Ws5aFpuoP1cX/H8yQHZIRrjuNVoYrsRGobBi6
	jUudTkfeULt96sD4/ipQhs3cYeYFNopPHwOKqLv/ZuuOTdfrgiej/A0wVWUEzL4VvsK820DiAYF
	ecEB8KdnPGDq67liACf2lD29Bs7Du5SGRSc0BHtG2nU5uJRgDVEPOlCoWyDrsiKME7+0wn6uS3A
	+UD/syeL8H7mavEn3/p/LlIQjXAzSIVNU0FLaXk+jKlEPtQ/fHldqROkQbdd8Cs6sxri3QmIyX+
	vzlUsODQL6v6hTuVkDvmdL4TxK9+IRFpEF3mnw5HFWLhW7VuRqz0v4jyy6yZiJ17YZof1mi+nxh
	6fCkgKyad5c9De4GOmQJ7J0Ffa7B8wFAAnSuxG+mIPAgQH6lTIyHIluZ/iWV6bTkNwpJae3cRse
	rDzLankD3UUfTM+cwAwmzEkQzBplyYabeqgPBMQKBmvwUiwjsYiJY3DhtgKiZ/T
X-Received: by 2002:a05:600c:c493:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49b91c20914mr7700005e9.3.1787851199182;
        Thu, 27 Aug 2026 10:19:59 -0700 (PDT)
Received: from localhost.localdomain ([85.118.83.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4ad16262sm54259995e9.11.2026.08.27.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:19:58 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	rongqianfeng@vivo.com,
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
Subject: [PATCH v8 3/3] ARM: dts: armada: WRT3200ACM: add marvell,invalid-reg-hint-in-rom
Date: Thu, 27 Aug 2026 20:19:37 +0300
Message-ID: <20260827171937.28878-3-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827171937.28878-1-gvalkov@gmail.com>
References: <20260827171937.28878-1-gvalkov@gmail.com>
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

Add node wifi@1 with a flag marvell,invalid-reg-hint-in-rom to the
WRT3200ACM device-tree, which signals mwifiex that its regulatory
hint from ROM conflicts with the platform and should be ignored, so the
platform regulatory domain can be used. This does not allow the user to
change the regulatory config of any radio. It only allows phy0 to start
and operate according to its certified configuration. All radios in
WRT3200ACM/WRT32x are locked to the hard-coded configuration for which
they are certified.

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

