Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210E3CEB8F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193300; cv=none; b=m1tl5RTH7QkXCV4SP9XXrGuREqPEtdU0AVFZ0oYUptt45em9GfEfIH0bmddJIJpErhVCC9VbtikKomlXFMcA3JNZESUR5eBsjhG86m+YEXS6X6zBSmgnMJnRVx8zOrvdB7sDgcuOgVcepTy3UKWoK0MqOjL9gZUak6quuyukpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193300; c=relaxed/simple;
	bh=o6kdkAZEToRtv0bcStkT85Ju116In3ipVIQYN1vFQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKS2gVu2O/cz/y05FS7TI6KWLhUWb7+1u65Hqh17NvsFuWJk7LGqTWXPju53D6uDe+0x1VLcFeUGVkaDlTZIC5ltXnKDCYuj3GRwbDDbOL1YB7tk/5VQ7iNn6pGt8O1rKRHaAl8FJCXfiYDSYltyD0WTOqq/ZtOLO0z9xh14XNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCkEbz70; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCkEbz70"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e4d95e3e55so142028e0c.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792193298; x=1792798098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AsagHKk4Izz9QG2y+9vzDv+u1V8rfrHnbTHd/Qn0ZOc=;
        b=tCkEbz70daDBfGVysLFWA+jL1QBnVxROzjopkkBTt+fYxUDZouVLfHaFw3+8Nydwih
         cPXHXRDoXHJulF2fAXMlRp3Cj4XnLkVZCw2idAQNV9zKKx8mCAw6AcypfHguHj6Xjst1
         3ZlH7O0KmONPk7Ua7+/dce8IvSCKka8AdI7ty65iug9do+K5sFYZGcRDUiSx7eIxQDYz
         91U3zx554AyEPvwV7e53fpSupg0vi8k24+8VyR0/C4SCmHwfKFTkGHCIfR43nM8uXOiG
         rD9BUCoiL/73oUzqrfV/caJhvaiRp0ipf9Xb+KFeGgY7q5rwL8ZIajc6q7PCmPsLLSHI
         MiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792193298; x=1792798098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AsagHKk4Izz9QG2y+9vzDv+u1V8rfrHnbTHd/Qn0ZOc=;
        b=f2hkDWGfFqgnJUMa4hZVYKEYuZBKKsz8KgkBO+odV+k7oSGCZ6vhilS5U4h3o8yE5v
         ZAelvn/B3NwylT3pXo601+ryA2gCyG1mTpT9UIHS2Phn5h7MvU1b9xqwgpuGAzfCOi/Y
         iULMjr3hxT03/PTsA5n8W/zqEZQckptW45BcfqZpE+YDAJ0hWwfeGPjzeepTifc4MXl1
         ARZlYD9njxptBrF5cXwvL9IWBO2Xy9qEhuucK0iGP+/SlqfdeOyIpiGB4U6v9uH/yG7J
         l+PJxit5nDaVVcbJRHelDlWEkD6aKy44PUWX6PexLPy1yFfmNfQUddeDe5vk07mg7f9S
         BfsQ==
X-Forwarded-Encrypted: i=1; AKwUvByB1PStzDspGHgzzgMvjO3VB02h/VCSRHdFelqnrT83TzBXi5aIoJjw+CuC1kuCk0FwFMPnD4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgpsJ9qtrgZWQqruL6sR6EwqB7MsMHc7DOAwFpqxn/+hG7PWM8
	0rv5qTIKc6rt6wGPq6NGPMB2mh0E0drw9qMrJw9rrhzOWaA1fwcE6fgj
X-Gm-Gg: AYBFou3Dy5pl1N5jLNPsa3BoV7BXjUy47aaMCMt3anV5KiXWBB4BRXOwP1Id0QZ7pem
	e5v/a1VwHf/hnPtgy8IGf8Tv7uLnU4GlPdy8nfG3c+59i0LX27A7eKuE89/mPWgny/0Q9pM7Adj
	UpJjIvh6RXXH/LaRAEoXhhKizPIEQ9XAbwfEi044bFTtmWd8w6zI/XkR7Pe+qnd5H7L1LWQAWiR
	7x0SDlRedWiB5j66CkEVFBYzkLrF+in+FOeglVGyfJaeHy+DpZ3pU+t6VC7okjwVTcQR11RQQCZ
	MxHv/6T89wKUn4lyTqjPm/NyDOMGAZTEXjlg/ApcmdYiYJZa59ASo+JSmxh9IbAOH9+TsXeSiTE
	TLKqHHOiTEFvqyV/bjApVlmNpP/OTtbJ5/shyo0RLn2EXM+XWgQJKK/ln1Ubob8+5+SBqLO2BlV
	atF3f0NaB45UdCVDq2YXKWsRl9072q82V5UN40x4cNo3VyET8+f/xyRZietx9WCSZQ65JozFp/4
	huZmomgtleZUNlzx7sCCbuqoFTB3MRiFpVOgIvnYqq1stg/S4FAiaHoBg==
X-Received: by 2002:ac5:c007:0:20b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5eaaa61b5e1mr428147e0c.13.1792193297779;
        Fri, 16 Oct 2026 16:28:17 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:42fc:16d8:d66b:d6c1:caeb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4f58bbsm2804299e0c.10.2026.10.16.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 16:28:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Frank.Li@nxp.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx5: Restore IIM syscon fallback
Date: Fri, 16 Oct 2026 20:28:00 -0300
Message-ID: <20261016232800.536654-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016232800.536654-1-festevam@gmail.com>
References: <20261016232800.536654-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5b55c35e033 ("ARM: dts: imx: Fix the iim compatible string")
removed all IIM fallback compatibles because the binding only accepted one
compatible. The i.MX51 and i.MX53 SoC device code still looks up the IIM
with syscon_regmap_lookup_by_compatible(), though. Without the syscon
fallback, syscon_node_to_regmap() cannot instantiate the regmap and boot
reports:

  imx_soc_device_init: failed to find fsl,imx53-iim regmap!

Restore the syscon fallback on i.MX51 and i.MX53.

Fixes: d5b55c35e033 ("ARM: dts: imx: Fix the iim compatible string")
Cc: stable@vger.kernel.org
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/nxp/imx/imx51.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
index c8698a9af1a7..e0494aa30a6b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
@@ -476,7 +476,7 @@ aipstz2: bridge@83f00000 {
 			};
 
 			iim: efuse@83f98000 {
-				compatible = "fsl,imx51-iim";
+				compatible = "fsl,imx51-iim", "syscon";
 				reg = <0x83f98000 0x4000>;
 				interrupts = <69>;
 				clocks = <&clks IMX5_CLK_IIM_GATE>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
index 93225a56896f..13550d12f694 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
@@ -668,7 +668,7 @@ aipstz2: bridge@63f00000 {
 			};
 
 			iim: efuse@63f98000 {
-				compatible = "fsl,imx53-iim";
+				compatible = "fsl,imx53-iim", "syscon";
 				reg = <0x63f98000 0x4000>;
 				interrupts = <69>;
 				clocks = <&clks IMX5_CLK_IIM_GATE>;
-- 
2.43.0

