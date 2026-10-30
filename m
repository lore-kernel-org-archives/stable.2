Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356468;
	b=OukICc45s/LUEAeCDsykv+ERvo1Wqqxz0jVDUdAwsg0Fd7OI4pYLnYpNAUC4kn8yccLF
	 4dHPBv5eaFaGJflnWJdLt1WHbtYRuC4UZ+H1p//7eC53FcRElDsiV5YJ1iq0ATQhxfJCj
	 aP6flDbctIsON3ZLGgJOMTgHUjyZljAxxuO+5VMfg7qTDkErmU02KLTWzRtuV35xEAFQ0
	 kyLrOtGfJWDgbXSC8SlRaAOBSglDIUf7XeI5KX/nGf3OBQOd2N4HggW0SJjY89qWFvzli
	 dNWqPRKd9zIiOi92sv6/1mXazuzpifp6iuYJRwWAUQgU4UdgS7cdpOTXppE01SB4/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1aNoVlnvFcsOYz3yDk1hH8WlV460c2AuvXHcDZPvdOA=;
	b=S8yBeRgAlkQxgrlPuAg3xXEeGrXi8BeWAPSONW5snTLqELqvix3ggraoNBP6EDF3/5LM
	 FCX0gRmWaddA8qLN4sCyP+oxhjg/iLGqM86KT8h/lcc4FTELpNkNve0DzxTxC8+m1P98p
	 /qWfuYjZz49LwnJBDOF8++jZoIhbX9ctrByIaa/b6RuroEJlppSChLsHEIfhYAPVn6CWJ
	 quka5jmopuPP1Qc5hBgbrw5JSkuM4OIVWlDCwCk2Q85qbJOX4lD43knAvIbUQBqyobyJ+
	 whYrlY1CdA8eC9lJedQdZpB3VyDWkF/+MTDsvDjQS7yWFblMM/t8657PLBtVsQxI5dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=noS3Vf1k;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4B606A329
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D4B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=noS3Vf1k
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36661f953e4so889803eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793356467; x=1793961267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aNoVlnvFcsOYz3yDk1hH8WlV460c2AuvXHcDZPvdOA=;
        b=noS3Vf1kr/+GOezZJ9DB1R4TAxZnNL0nA3ywDtpZrGsVu8F5Nw2k2Z6yA9wUKd0Dm4
         EwfdKdP1MDYH1aqpdHJU0JoOTYqh7Uq3B5dkunGKhuJ4OLqLlDfB02svFakSXqANew3l
         FlSXwO4cK3D5coJpKrZYGZqGE0BEsf7R1SeG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356467; x=1793961267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aNoVlnvFcsOYz3yDk1hH8WlV460c2AuvXHcDZPvdOA=;
        b=VQbYGLOrY+jCyjBcvTgZ/ngL9G8VdMu3xu19WRIcRHw9xRqFvIbZhsrXpEBY2ZejWh
         XqxTOkZkJ/iHH/vNU1gyMEcnBKI64CDV84Lr4Brm4/jBdKX5fXpbHeY4twIFvUQ1hhdv
         x/mjGrOQK4ep2WldF9bXYceJuasQMzS0bKn2QaevM2W2w1KM7H1Ypig2WTzDry3tMeQy
         2tcXaIO1oTIC5fAh4yt5bUYhULRAKSg3l9eVMVlQ20LDQMRNHcHBY9nS3OuAtQTyfWBy
         Pgzx7U6XVe3Pb3kA+n1Y+h24TKT3HUJgbvLqV/b8vmq9aP0Il+Vxhr1ptJGxYzwE678T
         JiJw==
X-Forwarded-Encrypted: i=1; AKwUvBwJvkPfeYEh6dNgrB7wAHyVK5wPnIyhHtNnpaaczMHU6Ep9bsGW2mwOZUCSkHKMDd0r8YVR28Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn58cmcpe8YGTIIaWYZRUFhj6Ndia7qtoh3rAFLg2apDjIYUdq
	qajghcaHWlnWDl9Pm7uJu1WszKTE9IpiqWGrbrn5dEdTisqTj6QCh7uS5WlKWWbImA==
X-Gm-Gg: AYBFou1CXZEWEcoptcRJghVNR5sk6FgZMzD11IKIvRLOi2g3Oo0UEsiV11xyYUxyxCI
	RTAvtQ3h3DVgRuh36LCJhNU6PA1U7KG+YAh3FNkPvM+BXlb8/xsVCFwZyhkne6w3vCrzlls+q5a
	WLBUfrTeSqrJLeflP63i6PrNn5iwDN5yqkCStbxw04j+F7GAhh8xUF10QT3ePXXrfmAcHBmLIFJ
	OQYDU0ZkDP2e6MPAPSEffmwuFO7Gswc+uOxVcRl1i2UIPyB6/P7mZkmKoeNchcxmzNPE0Xzp6+f
	hPJcaO+ZkwQp7xo+6c1IilLoJoNkMX3QtL5IVrWMUC2lEaCZEKOgyLJxufbIu0Gh8L3dw8JBuDA
	bmQyBR13ljeAYA54lzYNJVrwn4DxipOuV/Z2PL0oCHxngtOCxGKKFndMCStX20pJutWu2Ut7jzC
	1KzX/84kiuj78N3e5hs30B1XiVyDgLHUN+Cr/yfw4rN5kAlb/Mdns9ZvbjU0/MDi5e6xX6twIZF
	hKrwmFMX6/shSXkZlztMprYeuJT/ZjbidIY72eANh5MbdVDlmiAJv6xx7IAWRvOoZRTQzdGecDL
	0fQ2orsU50JeTs/4knUJ2cUQ5Raen9dr39haFPnuytrDC11G/tGOOQQI1w+CEHj/Z1re1b+Bz2k
	upNeQ8RsR+vJv2msqyU6ZHh5c2kb1PFjjGQ==
X-Received: by 2002:a05:7300:559e:b0:36a:1846:5c77 with SMTP id 5a478bee46e88-36a42204585mr3068442eec.3.1793356467068;
        Fri, 30 Oct 2026 03:34:27 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:6ef0:e162:ed32:a99f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm7471774eec.22.2026.10.30.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:34:26 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8195-cherry: Fix ramp-delay for Vgpu
Date: Fri, 30 Oct 2026 18:34:16 +0800
Message-ID: <20261030103418.2355854-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030103418.2355854-1-wenst@chromium.org>
References: <20261030103418.2355854-1-wenst@chromium.org>
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

On Cherry, the MT6315 PMIC at USID 0x7 powering Vgpu has its slew rate
configured by firmware to 4500 uV/us, rather than the 6250 uV/us
currently specified in the device tree.

Since regulator-ramp-delay is specified in uV/us, specifying a higher
slew rate than what the PMIC actually uses results in an underestimated
voltage ramp time, risking GPU undervoltage when switching to higher
operating points.

Update regulator-ramp-delay on mt6315_7_vbuck1 to 4500 to match the
configured slew rate provided by MediaTek. (Vbcpu on USID 0x6 is
configured to 6250 uV/us and needs no change.)

Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Patch created with LLM. Values were translated from raw register values
by MediaTek.
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f23a0c7aa87e..81628d8a4b0e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1596,7 +1596,7 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
-				regulator-ramp-delay = <6250>;
+				regulator-ramp-delay = <4500>;
 				regulator-allowed-modes = <0 1 2>;
 			};
 		};
-- 
2.56.0.317.g454f8302e1-goog

