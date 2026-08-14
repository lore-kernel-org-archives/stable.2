Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D9470E8B
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711893; cv=none; b=IYD8LE/lkG2NYtryeZB8JXDe8JhgPVTY+Vp1O7/XSDjyOVSMPVJYn/YR5WTpUP1NVcIzq3hBcFjIdGN0QHOhFhZg1SqwX0XKh+010V4AKAqomcMd1wV22hM316iIdEvD9GJiMEobDmvXXWUoX2F8SpmM9ERK16OEh8tIB+nBPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711893; c=relaxed/simple;
	bh=OHGL18JNsV6IVQVjmPUIlUU1PvpdUGkcQSXTvXzb80I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtpDpapx/y/wMviSnhTK1KyWS08emM/hHPbZ/PSPZGJO6n6MrvPeCedbjQDak1L803aDwxCUEYmj0XF3sbNDGjb1zHWK2+9ybXvVxBfklzDXDkHWf5EfZiQCy6s0lILWZU2opUEA5DEmlihGqvUgzDl/Tj5Gte/V9/DaekVo0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eInI9stt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eInI9stt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so641846f8f.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711887; x=1787316687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zb0qDDFJvzSa8yRML0htKvOY5KPeiSCo7J7EimJJcYU=;
        b=eInI9stt3Ss4IoDLZ0szqWxobNxU6Tiyj3adcfyE5A79WW6v2s8aemQzlRiouL8IIL
         5phKI0ClCTyGmp5hLrZBv1JO1jbEGw3pNmddcZRIjHNDHm/dZw/bVCeaRK+U6ICHEkap
         +XbWNMF+xDyssj60OMt3s+0R5uWmmJ3329kXJwwsGxyEL4ZqAfbi318Yq+Ge6MDmfPtO
         J19rGUV2ptv0qcO+dIKSuRPRJl0WgbiQzbvS96jsShnXxhyWoW+wUOj1VAqefeakTZJv
         aiTzt3fV144racccmADSWSfzuVgDaKIS274KRa5CdTfTGlf+0q0CnoIV6wTcr76qF8Zd
         y2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711887; x=1787316687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zb0qDDFJvzSa8yRML0htKvOY5KPeiSCo7J7EimJJcYU=;
        b=Jdnuyn8TNDg7y1bxMEjs2WyU6SwzYhZoAf43QSlrc1gEmMbGJ8m7FSNXDR8vgwFHlT
         lDXz17coyl2ILN7FNoJFOv6HS6o1EfeT3TFSB2UICE/WPKSUI4OLzaeE+V6+WHblE+BU
         9Ey2JpQkEJaYuMOqFMnB+g5NwNGhdHHluHQcJQEFEZ78WzfZ1Ij3obZKNmPx0ebFRK4l
         rBhx1jFXxyr7KnVAzGGxsf4I7MDM86AxiJTUT+Ck0FqO/auFUNwWXm23AmVKa599vdo9
         RXf0UUutxqk4T2yE8p8RhnrqC3F1ZsqMv8R07K4H+L6IvyQ0VVIhw95cYNlY82MyRe1n
         Y+VQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPzlm2+cJ1HBG7sVlhzFoo0b01/Rug0OmLjFI8mQBjgN4Coe3dW/1gYAdXcCoggHdtH9xjSdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SxwI3rPq/N5xtuITbAcJr5D+THgwvtR6Q/DNPRNBGJBCZpGq
	Nj4UP6BgRbK+thVhmZVdymfkbJU/3QXvGDfJs64DAyNM2J1Yoa/1sIQ3
X-Gm-Gg: AR+sD12JeNtK1hICciSMAQGaHL6NQXGnMH0Y0kJ4LgLDuJ9lsV5odSrNWwlcwioylDe
	NkRGdZI+SF1mB4t4zdHlJA0iF6o9CGQR5c46sH53mpaOboRwuoGWbarN9xYPSXTl1HqLHc9ERew
	3COQ+uFs57bpztTyGVtm44Pou/y/qhTlqS+ylmdv5xWKUCmmvMnLWBgii6PHmnKdntxvHYcTQ1D
	2zWKY4as4Rl5Mgv2fgZ9rzgX0FyhacpxcrhKLg22MQ4uSSa+5qG5vpz1ohWByHsMEtlLCnkaL+S
	KVu71DfhvL4hpQs4RzV4P6hmw5MfLI1hHCFZdvA7C/2FDHJQcY0l79ZvG7I/ZbJk/vfNSAENkkN
	UaUP3uUWvezmg7YozZxSHJN08gs6uj0YDoi/WJobW55FOD4bzPpj7LMkHlJKbcciMe1C/1sbiAR
	6Hz0gb7Efq8FDXZ5fCucxPKJ7PT6Lf4/fTLJ/z1kFDIAxMnab1F44kXpZF610HGoJtulI9Xd+5K
	jfU9cBZxjnpUju+plWuBAUGUifAiOma8eJ/xbeBmjb7xIoTCHAbYFwJ/+4SKTOPaw==
X-Received: by 2002:a7b:cb1a:0:b0:498:519:e660 with SMTP id 5b1f17b1804b1-49987935847mr52299035e9.4.1786711887107;
        Fri, 14 Aug 2026 05:51:27 -0700 (PDT)
Received: from localhost.localdomain ([151.251.241.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988ae8b62sm49727315e9.5.2026.08.14.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:51:26 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch
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
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	chunfan.chen@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH 2/3] ARM: dts: armada: WRT3200ACM: add marvell,ignore-regulatory-hint
Date: Fri, 14 Aug 2026 15:50:24 +0300
Message-ID: <20260814125025.90522-2-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814125025.90522-1-gvalkov@gmail.com>
References: <anoYr9H4KojJv-aZ@google.com>
 <20260814125025.90522-1-gvalkov@gmail.com>
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
preventing use of 5 GHz and DFS channels. This also affects phy0.

Add a flag marvell,ignore-regulatory-hint to the WRT3200ACM device-tree,
which signals mwifiex to ignore an incorrect regulatory hint from ROM,
so userspace can set the correct platform regulatory domain. The radios
in WRT3200ACM/WRT32x are locked to the hard-coded configuration for which
they are certified, so the only impact is that the region conflict is
avoided and the 5 GHz radios can be used.

The Linux kernel sources do not have support for WRT32x. An equivalent
patch for these routers has to be sent to OpenWrt.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Tested-on: WRT3200ACM, OpenWrt, make dt_binding_check: pass
Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
index 4ab45f294de2..c5f94463ef71 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
@@ -165,6 +165,12 @@ &sdhci {
 	wp-inverted;
 	bus-width = <8>;
 	status = "okay";
+
+	wifi@1 {
+		compatible = "marvell,sd8897";
+		reg = <1>;
+		marvell,ignore-regulatory-hint;
+	};
 };
 
 &usb3_1_vbus {
-- 
2.55.0

