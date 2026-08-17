Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A43AF662
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003731; cv=none; b=PkKMizUyABrohjWtRD8uuQY6PHGsV1NMjtbxWoAvY3g3GmVXT8TinwU+Wc71F8q5p9r7dVsZ0QEnQ9d3W8km4yexBMoAuJBcejQNMYVuCQeSeWcsk4Kt3Zh3DUoOGCoYOoqGFPTg2CwJzollqnOhblamWfsBKqE1VuaDS8YZ3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003731; c=relaxed/simple;
	bh=ZpKYehF5OAFiXqHvT/wU3yvfoAZi9NS1PO2rZIotS64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG9ru44lxKsA59h7FbGQHWA/46Sx/Xl/JU7Ent2tV3qVh4S9UAO6TXqd/fZeEGJuX0dCjzwEm+3U3zIzG7+M02/QbM6cSG/8oQULnqQBPAQeKHuHm/JSB+9GCMJjhO/VXpFL0/+Md+fliyhYOpv5QtEF5lxRHOZNBlz3dohkM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQp6dC75; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQp6dC75"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49954b88fffso44553625e9.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003718; x=1787608518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y756HdfLaSb69/zEjo9fJeL8LylUgwNNsMBSux8mExc=;
        b=oQp6dC75qRa2FkcTl3XEwGXcsV3BxKsus7qy4vfWOzhGpJM/dkEod7qKxosm6YBtiF
         dEbO+7KEJ10cUAVABf171SMsjaprVFb+L4c0Kto0KR3qcZg92bOaadcI1D+TybE93pSy
         +psaxtXfk4V3ApCumtVA2vCnzLDNRQL00DpoAfUT2fhEx3XUgQ9LNi8DVc0KnM6f/STO
         h/QO2vRlVqqoba6AyeZCM9fgGF0yzS8hUbjAJEh9QA3B5zE8fxaCeTLBnAvrD9Pf9k/U
         emTVvi0LTHnw8kTHdrsAVbiWs171oNa2kO8pi8MDZQD1wUDHWhBDtiyGgvbf4Aa1n2kc
         mC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003718; x=1787608518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y756HdfLaSb69/zEjo9fJeL8LylUgwNNsMBSux8mExc=;
        b=BKlz3p/zIutLZYT9TlDZItDjVvY4gmd2riywWB3K1EGYW3ok0w6kGuB29OeXvJvIDd
         i737XIi5VGqxzNEpGo72H1dCCUqEMgvLJ9ZoQuDzymSHYIly/WB61D3ipg3hbYbwez+N
         +1tC5oRKfKVyij0jAXuJVvifUB1B1dbMKfZxlYkKJDPEBl9oIXI5IYg1xYJLCYNrEDjj
         LqLYA+lpN2jKxasMT9S/MpjO2laQkHXckTnvFwf/qzzeEDrKslD+2r65l8Ps/q/vxSdx
         IIFYndB72zsc3gjYGG+Suk2WwJLEDBIi75jFTTd+u1baD3YnDK8M/HB6LecyZkc2VBB0
         ielA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7IS7pgsgasQg1S6pueOUI+1MebG8fe339nQDl6OXjfMesdkOg6TEux/oQcmrz/orTPW85W0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtDEGmCpXVksElPaoWy4rw2fOaBwp3kE6pRGMMzliPONuxfhY
	d7VCRe7cGdmwDbcTkjj46h2mtxm8HxzCOekgGpuX/SYU991hi3CL0fuO
X-Gm-Gg: AR+sD10knrAW8CTIjPV2OaNdnxGZNeOeWy+MIMQm2tgTWQ+lyaO6KwnSGmKgHGbXaki
	QpaaHdlX9K6ApjvRxthLpz/1UoCoYCK9+i9JETQijtaM8l0QK7LOCrz+fTdjbn+zK6dEHRQnm2a
	tgBWPFNBPHwp7iG4NzAnj/TebQNNmgIejdrZeq3xxH7MkB8lZt5sTu0UsKpUvm/q9kfREXyuwH2
	ENKAzEAvvYw4jqp0HbFJPHNV6bqSC/D1z78mu5UJtIUoDb3aok1hoLgOAPblR+IbLYlWku01Zhn
	DPbOP4/JYTkJCKMR+VotHkqfKBJLUp6Ltao1J4KXrwpHlXkPhEX1DBzZFp3elI5z8/mjEJkRadk
	iyW4YfhVJl3xlyR3L1o1GggHmOkfr99Hk2wsCLgf2QrIf40RM7pNze1ox9EPup+y3ppqkzz3+zA
	FrRRW1UQUNVkW80Zj7u9gqIYD0ldracv10LuSxvWPRTjphK407hIgeV/HoTXnVWCohcwTo69q2O
	I3Yr8SkY+0LAIBo5KYHKEmy4jLOy5WGxKVmG9DkBpyRnq1tn8pk3tc23mboGLORiD9Q8vFlMDII
	6fqv+9QRAQ==
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr460386255e9.1.1787003718146;
        Mon, 17 Aug 2026 14:55:18 -0700 (PDT)
Received: from localhost.localdomain (85-118-76-205.mtel.net. [85.118.76.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b2a176sm309622525e9.4.2026.08.17.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:55:17 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH v5 2/3] ARM: dts: armada: WRT3200ACM: add marvell,ignore-regulatory-hint
Date: Tue, 18 Aug 2026 00:54:27 +0300
Message-ID: <20260817215428.84740-2-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817215428.84740-1-gvalkov@gmail.com>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
index 4ab45f294de2..b93c5c419962 100644
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
+		marvell,ignore-regulatory-hint;
+	};
 };
 
 &usb3_1_vbus {
-- 
2.55.0

