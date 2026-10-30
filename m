Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356467;
	b=d3XbxMWoD26ac0HbaZIitLxrAB5wVibxL3dVoga4qXwy/DZqsuBdxhcyDjFUEbk7+AU1
	 UsrWht/FCfCkhHZ7xYYH6070leECO98IM3VHDWgaPTtyaxVIyGEqxELV7PMNsCqPUalsI
	 6s0hkRHu5GRyJUYmLSTh05fWdERz2FLCPDgwW2w1EjkFtfkyRNUMebDAiMWjxFJef3BvG
	 5n7X2M2ceMvyw64A0u7jMkHzKQR3wCaYho5ipLfaIrm5pB0tOyTSiT+1F3T2uG18D5SEP
	 roh4lbbdK9ERkK3WBr486/06r6MRKqEQY/UhdFrUeyQG6yEXcKB6IQEzIQzCXqgj7Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M7JJASl+nuTr5h0hwNfOIsigjQbehWTAWvZV7+ghWJc=;
	b=Ztq00MXVjS6yf0VRspv2BGgUzZ7vYxv8CdVu9OQXqta11GfWZYbXr+VtZzqFPKAAYWGX
	 ng5hScMeR21ExLvQKRJU0kZcI8yuWmA79DgofMiGQO8kGNh/sETsTWkGLlpyrg1FsnR7Z
	 zcr6A1bt38V9kk8rXEWBWhKAxmTGOnKdIiNic973M8ZwsFOyoirQ/rZA0LZztfJmE9zfv
	 qTs4Ye/0thx0Rns1ZaMWavE5yFH+6G92Bjig3yP87qrq7/63LOMeamNfwRE4ZfWGb7fNx
	 uyL3bZgpQo4XVQ0icWcxZTwJbHvaKBzDbuejw4L3UUCf5iB/heD1C83noizPnQJnFpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YUrSWzpf;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0B60A260C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF0B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YUrSWzpf
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so903397eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793356465; x=1793961265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7JJASl+nuTr5h0hwNfOIsigjQbehWTAWvZV7+ghWJc=;
        b=YUrSWzpf7rEQ3aAa0oXonD5YmD6ZNwZ8VIsDTCVuQwMQ2onrHFnzF/GURSkjiLUapc
         Vuf5A0cdueIwto/xKYl05FqMDLpavE7zk9wAagx3QuBWKGpYPEnhEZyq5cBLqHDv+/DP
         29xDN5BV0pRM8YISl3l7Yn8tg0OaKhRGDuf8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356465; x=1793961265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7JJASl+nuTr5h0hwNfOIsigjQbehWTAWvZV7+ghWJc=;
        b=B5puWMR7fXwtbLTZ+vMucyB7aUj9VXBI6S3HjQBcRJJNKFrGNPLSTD5Xy9Vl1/7oQ6
         lvcj12Ms5AU7tTMBEvHz6Zx1IGghxMCq+USdSK9/dS5xWHeSShDXUxQpbiChcfuyzG4p
         f1lrF8fydIeuws69mvS1viCyWiqqR1YUQxQAIe3sEwe+MdQ3v69yF/wP3syscnpg5cqT
         5GJTMndTgvAO7U5IOCPUoc+n8aGQhSuracjx4OPcGu757Yd/D19lqoBnn9qi9Hb4faqB
         2eksxdAfIUsyFRCvL7ebEZBxRjcMYU9dEun8Xz0aeX4D+O9KLU6QY0qVW6Oay6H/Utct
         XiUQ==
X-Forwarded-Encrypted: i=1; AKwUvByZq/F2pdmb/pgnw4uUaiaXFRnmOvF5EIR7pgXWtv2gN5lvcj4FWl2YaJpd+CENS+rehY0ygNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGRmbsNTkkawWlcp0zqnQvS1dqSeJRHlGVdcHiSYgXGcHAT2GN
	x2BJk13qetAdze2zVrsOAaGz2X6cLM763RVkGGnA3wbthXvpX+IRxCeARfKdrZeKAA==
X-Gm-Gg: AYBFou3j3LIAdvGEGU19mMIYbnIJLrXFL88SZwbfL+2lk1FPdKy6PTIQZn9T2ashL2D
	WbSB3rcRAccmqisw93hOa3gLay253JxP848etiU1Lb5QvV8IJAJkFjJxyp2AifZKKzdli0eYD8U
	e6jI4izNtzGpXLxAnw6KWduXmlZ+Dr51taQ4H6G1MEXGK129Xl7wkFBY7zCW0gIBxEAhUDDj3sD
	6wmYnl0HlRcJzu/0Ux7xobiASpt+Xi9D8ucl2mYSSxbKIV8BQqbV6BVFnFcskU/rjVo2A6+wNBX
	DRrFJVoUX8Ia1rbr2AXNnrcF4UOyJPmgASt1QZVOG3RIwSzlN8gufsqNklTBu9bnDhvUGNjRvQL
	XOsEOYNO/nVc53WyjwOVS9QTMzJjmGPxQ5PN244ua2+JVM5yRuCvkP0iOOFMhExJU+R6FWVVObU
	n+Qd5ng2vsXb+jhIoVQ6/w+i97DC8IorIg0RLCe4otf3rxBepmv8dc4l25xR7Ac/kaDmLiHXAMy
	88EYskFx+0lZsL5hdjBwaYkWJWI998lRMuNwkrN5dTWVG+p2elBBrNhCErDMyBnRg0J7rIMCRqF
	brk60VJs4HmUQo7W9ikx3tGvrWTR2zLrBjMjtKEXx7k2w6JAvG2sjyjQaFPsNaNa99HoR2MvRGO
	km1lVXlrcuZ8l
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr4378368eec.22.1793356465021;
        Fri, 30 Oct 2026 03:34:25 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:6ef0:e162:ed32:a99f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm7471774eec.22.2026.10.30.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:34:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: mediatek: mt8192-asurada: Add ramp-delay for MT6315 regulators
Date: Fri, 30 Oct 2026 18:34:15 +0800
Message-ID: <20261030103418.2355854-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
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

On Asurada, the MT6315 buck regulators (Vbcpu, Vlcpu, and Vgpu) are
missing the regulator-ramp-delay property. Without the slew rate
specified, voltage increases may not have settled before switching CPU
or GPU to higher operating points, risking undervoltage crashes.

Add regulator-ramp-delay properties matching the slew rates configured
by firmware, with values provided by MediaTek: 8000 uV/us for Vbcpu, and
4500 uV/us for Vlcpu and Vgpu.

Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Patch created with LLM. Values were translated from raw register values
by MediaTek.
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index d1993b80f9ce..43286241cd22 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1812,6 +1812,7 @@ mt6315_6_vbuck1: vbuck1 {
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <8000>;
 				regulator-allowed-modes = <0 1 2>;
 				regulator-always-on;
 			};
@@ -1821,6 +1822,7 @@ mt6315_6_vbuck3: vbuck3 {
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <4500>;
 				regulator-allowed-modes = <0 1 2>;
 				regulator-always-on;
 			};
@@ -1841,6 +1843,7 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <4500>;
 				regulator-allowed-modes = <0 1 2>;
 				regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
 				regulator-coupled-max-spread = <10000>;
-- 
2.56.0.317.g454f8302e1-goog

