Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536C3793BA
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127252; cv=none; b=Zj0HdLE4wHZLl4muE9Ig8iIfiL1ApkrGHOXVRY2UKF/0X8EUrFZ8TwC4/JOb85bHwEqPbr3aoPKC40fXufcwuA/E/8c2441AMClGvANo98WCya5oktM3oQXwn096UoFq3Ny341XjV6/0k0x/PS+wBkEhvzpC1yjJOSkASBZjEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127252; c=relaxed/simple;
	bh=Kk/Th42Le0i+/EVJjXBpuhzcRB4NEw90hZMlGQNKPFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5cB9cHiYFjzBN+ZjAbj2q7u/AWBQDckWGSghkwUaFXR5FIIim99PYzVpLNsbjvDjfbf0XiD41v5a2T2vD3iNA0U3qvvN6JIWkWdgF/++NxFsL0QBvEOmj8d6/82YjcixEjmDmUYZCE9LZ36ovq7Hpfs/Od1BOLeMO9bKHo4KCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHS45aHx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHS45aHx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so1501868f8f.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127249; x=1786732049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3QOegBrxpOQoOf5XBMAtesiyJaIZB0qfo5JK8U5SZE=;
        b=BHS45aHxaHuk0CZLulMxbzJ5qctEZCBHh/51I3G9onS+3+5nzBYX4zmL0Td+csO4x/
         qAwOhYe3C1k29OvT8ZxViQhwN2Q0ct1YPqqrNBfCyl7wk/6fsMaj49fq/cxNL2wO2CnT
         1dH+MCnUREMOEj58//1YEuG/9ZUCQOwQWH1NFl97VkEg2g+tFXs1OH6vtck21HkbBSEf
         s4BpByvTQBHLJQpgUruRKotuVaaLblKccGmjglbM7y7c5iemZnC8yuUY+5UQX6nuXQh6
         kBl+6vseIE7m0vbjJTZ2eADPi5CmefQI+URUtCR4lPdNXut0V2So5qlGBB9CMD5b0AYu
         5LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127249; x=1786732049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r3QOegBrxpOQoOf5XBMAtesiyJaIZB0qfo5JK8U5SZE=;
        b=bbq08xw80yYzh1ZpKm3tShM2d1XZL1ASDk6QF73Y3tQSEczcLw4Hsf66cZL/KJOfNY
         Qpy9EdvHoJdWB283IrRuJ2kjDWWznjO1SsinwCFfrBMOKYFdbFXaMm6R4pCWUuNQsyeU
         A+nacp/ugAE1KbvM+3DmZIuUKtkd+caOsEf1qcU8eJSY37F9O9gAwPwFzwabc5iiW2rm
         1q6Uo8JEJhcHsYI9ezXvC7zNBzN5yn0vkMGB/IYWgtPB8bqHhwwGQNvxbW+cE/8/Dopa
         Jdjw4KCerxqjM/i2clf5jIx4Wfrsh6YstXEVvjChd5LMGMqSZNqrjUBoRbCZS60C77BA
         CEWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAXj6uoKbIUBW1T5cExT+CENWy1/lFvi5NzjYL+5mRzeZ72qk4WucDRfaGFXpE/JUfe/L2M4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrt1cMdO18NTjhpEMDT0SZlPbX4kdzYH0UIV/hqKaARL4Y8K2
	iah853HMrfuXzuMrO7KrZDer05bk7008mxhqrB3SPtc5bCl8IBO/8lBA
X-Gm-Gg: AR+sD128rcMMZMDpouWk+XQVsZZDjkE126idQLqD35DWOmxInnukcNAyBIQpxXPacDa
	EqqR/3Y1CtUtYbI7zvBEnwBcJc2h3EfpHoLpTgZEPNyUe04MOT5ljLL4ki3PC2v6WY5BW0vEI0a
	4yBWx+AcSqgoNtO+/jK4XSgM0qqcYQBD//9+2Pe/upTo1LZ7jG0DLoSkosWT2uRp1CwCN9u8fnz
	PNgJEWyJM5TJN9YCcrcS4lZgV3gew9TnOhF5uQ64vMhrbvjWe02gH6ASQLAC4caXqDSuT/1n7hd
	NyFd0HmtVyEVbUGMfRj5oZzESX7psDRNVbmJc8e8fXzvDJNVPju6xUhcQ0bCrgENS87z/FC9U6X
	qiLWW48+okiweA45SDrXUpl1o9TlOQITAPhPXUimnYN2nVH7YF00I9Xn2fPFc2QjBjYvzU29x0a
	QLXuYSKL7/0roCKFiV1rQj0RKsnktXyAVvbIOqj0o9cTP0EmyV5cUsZ3PM33UuB+ZwY7jmNqO9s
	suc4geRhK+U6g4RARe2sePGTGr1JHVhR2VCBy5Y9RzeejLDYo1nRBNT2rG6LZSpRfy7jha5h9k=
X-Received: by 2002:a05:6000:2889:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-48131915e4cmr788570f8f.1.1786127249329;
        Fri, 07 Aug 2026 11:27:29 -0700 (PDT)
Received: from localhost.localdomain ([176.222.12.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm8543886f8f.20.2026.08.07.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:27:29 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	andrew@lunn.ch,
	chunfan.chen@gmail.com
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	wenst@chromium.org,
	rafael.beims@toradex.com,
	avraham.stern@intel.com,
	peddolla.reddy@oss.qualcomm.com,
	error27@gmail.com,
	s.kerkmann@pengutronix.de,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH v3 2/2] ARM: dts: armada: WRT3200ACM: add marvell,ignore-regulatory-hint
Date: Fri,  7 Aug 2026 21:21:24 +0300
Message-ID: <20260807182124.41572-2-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807182124.41572-1-gvalkov@gmail.com>
References: <anWWr80yAcOQaVVS@nxpwireless-Inspiron-14-Plus-7440>
 <20260807182124.41572-1-gvalkov@gmail.com>
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

Add a device-tree flag marvell,ignore-regulatory-hint to the WRT3200ACM
device-tree, which signals mwifiex to ignore an incorrect regulatory hint
in the ROM, so userspace can set the correct platform regulatory domain.
The radios in WRT3200ACM/WRT32x are locked to the hard-coded configuration
for which they are certified, so the only impact is that the region
conflict is avoided and the 5 GHz radios can be used.

The Linux kernel sources do not have support for WRT32x. An equivalent
patch for these routers has to be sent to OpenWrt.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Tested-on: WRT3200ACM, OpenWrt
Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
index 4ab45f294de2..6e283e223ca4 100644
--- a/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts
@@ -14,6 +14,7 @@ / {
 	model = "Linksys WRT3200ACM";
 	compatible = "linksys,rango", "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
+	marvell,ignore-regulatory-hint;
 };
 
 &expander0 {
-- 
2.55.0

