Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A491C2324
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250467; cv=none; b=DzqE/vKgLb+CHDCcVrw2QJT2lUl6h+ik1hlTuJ1ig5Cx8E/QoJSfgDOBjNN7Qw2pl1GLXJNiMyu/AW3zcYbRk3eFFwWiUXJY4LBZsJswzoAa/LxPYQtybwaBdTJ+JziTB9pF/zPxMn19/DgZOMol5ECyuWTGxTrYz8a89XDrJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250467; c=relaxed/simple;
	bh=VdqhTe5E6Jj/iVUwSVdXARd1GcmnBZjNc7q2mmQq1Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9yjKHBTsGdv233u7lpR4uUwSCyrWv5cExhI76VKtplBh5o7rE4AIThf5iWmprJJafIlxqKrApFK+oBQshhZiZquSQ+WNe2W9kzvmrhLcO5mSfW/dbRaBST0Y5fQqfUOIJ4KBNarUBH9YdZf3pJSO8W4DMyqWQdnRxsi/WoZJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWQVTtWR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWQVTtWR"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81e9d8f3289so49987657b3.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784250465; x=1784855265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E+jMtOYXd86aOtbSew6YfEy4o+UUtHTJcq8MN5yVYKM=;
        b=TWQVTtWRh5Bmo6E83eRMCepLv78+VP6ZeVwFoqEkBjBDeFGNEpt+gyw6kRQ2Dmr9nx
         R8jFm4BO9w7NQLZ6ldwlq3/FwfGlEYAL6thI7i+NSkz7n7AmAnTcjT8LA7sQeNl1TdED
         H+pKTMCyvlAwZHuKH9ilwUfU0lTGXc9SIrUUa8jbuQFEVgy4MVF5edCnTTogUpEpbGJ9
         LunY+OQoMGCX67scftuwNxd3brKeRoOs3I0EaTkahs6BTTyBHyQNV+7baMHr+uH02vGu
         9UkASA3HTnclTCBb+Om+1kqUCGLUa2ts2I3obu/C55AEnK50RIokoFrlbpW82yBocZot
         29UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784250465; x=1784855265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E+jMtOYXd86aOtbSew6YfEy4o+UUtHTJcq8MN5yVYKM=;
        b=TePCKQLfQh9MEk6zF7D1eodmr+at63D6FjeAp4cw8eBLblzad6EdvYvSj8ifQnXWV8
         qUs+u77xUmBUp73iyCdBXMmzvmV07pFOsDxfI/KBSIc49jSt89+CjVg4yGWBHslijvb4
         TW6CqXMctMfRKG5Dp07Z012tmlctjrBJ4YAwtFJ6rt5TAAqKZ8bC+X8AVqr5cd/7aUcp
         BFwKH4uEam40EKG2HbHSeeyX5Vb8ePrJdZrL//RJPPV06tc/uVrun1n7x1KmkzjxyJaS
         fCLRhDofkhsAlIqW+gwqzxUyWGFfAi5XdRolE818RGzDT5/ve6k1ufjLizGIG92opqHM
         8ZnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1CLcBby+og9jQp1232ClsCz3mlYQL+odnjsHo4oxUzlcDcNFuAJfknf0RR3RYhGKmX3TmnOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxZ7M+wKc3qxbUOF1cCFelw3gsjOmsFWW6NF5OJFORoitrUiy
	J6AtRsfYS9VCGx3hCUam7AwNy9GoL09e5eK/ZB6cyt8JDV6FV4HhiHNl
X-Gm-Gg: AfdE7ckg4YlPBMUE7v8TQlvxgdu8R7MB6Vm+S6SPn/TKKQi2wV2A7mzNSzBspGCqTNb
	vl5w0KD/D58RqNDf0UDFUEaTi8upsWOUEKy8nP4g+y3jX5QND6aLbif/aJXTiCKNPWfk/ZQ4XKV
	I77cvXMZ/tjun5zh7KWycbbh1zYqJrzV/qcCK9bkPmwfgvlnajm33MWsQj6hwpWJZDR8wOesJsx
	jXjNPMWXv6yL7DhTkKmoc8fAmKr8wY5alCIMYaQ8b2zhkgz29skT4lAdUtvfRmBegfYRYS9sSPe
	dUQ3xnLa+YuYzWbkit1OsnXVlvR96avFqUZmtz5rQrFBLMhimHRnfiHo653/LXef9NtlibOf/4O
	et77FRHmfJtX2SaVayS34k/9sYc8IstzVp82kMEAn3Azabuj8wZM/8XQgrDtfMuoqUqHc6t9Ixw
	NTDqOEZK6Wc+TXhTJpvZn6CPPgdi3iCfEEX3v/tV8+DlQWkRw=
X-Received: by 2002:a05:690c:6b82:b0:7dc:e96a:26ed with SMTP id 00721157ae682-81ef22ef44cmr481287b3.9.1784250465041;
        Thu, 16 Jul 2026 18:07:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:e2d1:829c:ccde:e84f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e8f4c5d3csm159095057b3.15.2026.07.16.18.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 18:07:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: Fix rk3399-roc-pc-plus analog audio
Date: Thu, 16 Jul 2026 22:07:34 -0300
Message-ID: <20260717010736.578419-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The ES8388 sound card on the rk3399-roc-pc-plus fails to probe because
i2s1 cannot claim its MCLK pin:

pinctrl: pin gpio4-0 already requested by ff880000.i2s; cannot claim for ff890000.i2s
pinctrl: error -EINVAL: pin-128 (ff890000.i2s)
pinctrl: error -EINVAL: could not request pin 128 (gpio4-0) from group i2s-8ch-mclk-pin
on device rockchip-pinctrl

GPIO4_A0 is routed as SCLK_I2S_8CH_OUT and is used by i2s1 as the
external MCLK for the ES8388 codec. The board dts already removes
GPIO4_A0 from the i2s0_8ch_bus pin group, but i2s0 still claims the
same pin through its bclk_off state.

Since the i2s driver requests both states, this blocks i2s1 pinctrl
setup and leaves the simple-audio-card deferred with a parse error.

Override i2s0_8ch_bus_bclk_off as well, matching the existing
i2s0_8ch_bus override, so GPIO4_A0 is left for i2s1/ES8388 audio.

Cc: stable@vger.kernel.org
Fixes: 6d9a7bd6a13c ("arm64: dts: rockchip: add support for Firefly ROC-RK3399-PC-PLUS")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 4f2831097624..f6d62ee51f1b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -136,6 +136,18 @@ &i2s0_8ch_bus {
 		<3 RK_PD7 1 &pcfg_pull_none>;
 };
 
+&i2s0_8ch_bus_bclk_off {
+	rockchip,pins =
+		<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+		<3 RK_PD1 1 &pcfg_pull_none>,
+		<3 RK_PD2 1 &pcfg_pull_none>,
+		<3 RK_PD3 1 &pcfg_pull_none>,
+		<3 RK_PD4 1 &pcfg_pull_none>,
+		<3 RK_PD5 1 &pcfg_pull_none>,
+		<3 RK_PD6 1 &pcfg_pull_none>,
+		<3 RK_PD7 1 &pcfg_pull_none>;
+};
+
 &i2s1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s_8ch_mclk_pin>, <&i2s1_2ch_bus>;
-- 
2.43.0

