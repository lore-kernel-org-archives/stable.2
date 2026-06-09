Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155523EE1E4
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993138; cv=none; b=CMSgUZCfPJhIwoNdjKAvytReoTu4DZ2Nci9AGBvNUpEBlJWa7ESf4811HMQqAeuoKpGFnxLhuxEgfkXP6d24NAXRbpoZCwswOirJJi0zJ9LAEXMgi1CRygFi5u88Ql9ABbgsNHSH5bgIsIeMRhPBXl9yhPgrFmhQVPSyY8e9xdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993138; c=relaxed/simple;
	bh=4/7xqhlg7fsTO36c9sQAAogQIKyQWEKJcViI8s2wyAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oovoCdFwtywrATnxvOvFs3/Zt/tlJ1MwbMt9Fk+HKdqjLVctsmba4gLeGchZEg3wGuYRhPCv/zi0t4d/A4ewB30vwEQS1EtAUo/l1FTxAh8+ofqCPiHzOcqKbmfwSq1SkukNC4egcevYUGnpPB0OLJTKk013OYSNpLakF6jDXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCWAgMYA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCWAgMYA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4905529b933so56457095e9.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780993134; x=1781597934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFTsAOv1hKm4xZTbT6xMW++1uFPeFFAKMUDBgYxH4Gw=;
        b=fCWAgMYAHN34l9Rl+XsZ/nkXSUllqS4gZv72NoebKTQvjWqSZfo1n1qMdlOdR4ihdu
         r0iJmuhP0wvhweAvLWgeZYLf8iUZLhrguyIyX7FSrLSR6jyzyA+QMNJ/AsWde2KyUsHL
         B4A8HEHTooo7hm7byJIymUkcztukBc+V95hiyfeikxces6i6vAKXP8agnXPdB1a7hhVB
         6hGKHA7RDBK2l9sN1rxPxOrikaXMi/l+t4Oj9TIjSbu9s/KoHPLN7wcsh3bbKT972sEr
         nJAm+yfCpoTfxAxtBveTK7/3UMYAUc/VmzW6wjRy2SQ0eUq55aeF9UkwGDiMX+7tZ/ti
         Rt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993134; x=1781597934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFTsAOv1hKm4xZTbT6xMW++1uFPeFFAKMUDBgYxH4Gw=;
        b=FcGZmL6VPEenOy+ntOBbiuUoX30t+wSLfWC3LiGwbcqVll0GzJeu3Xe61wWEHKXj61
         CwPKaZlfLWVzKaG1FRnPA2LZRxQZobeUf3F6GcPco1d+E7DcIHl56t6J4B8aL3SZnNif
         G+G35JUVusV3J7QlbqHqhmgDiapjSKUsWN3wScrid7Ouj8QKvwINFJD5TVYX3Np+FEIr
         dydtf4erUT0Evh+dyIflZv2xaKUoVAM5vezGSzufuLD0/J0QoxVfOz8twkq3VyWJXY8x
         /ZG2ANdKtO8vT+Cb7+jVj+B+/L51HtiLb/XBWwXvaPdUrZRtaK3S8Vkg945E8MHuB5Xl
         kKbA==
X-Gm-Message-State: AOJu0YxIM5nNFPVtZBbKNiNGEErDquCSq1a9qOfKY9tiZvSlPkFYAgES
	47ROkH2VqPBfdbsc5gX3KXtqwCJXJHiYyE2+A/PRp7Ute1cBEquuqHbv
X-Gm-Gg: Acq92OEuNHZgku6phMHL/0PZ9aB9+35tqF68qRjV0UZleHwCLo9QSgSXNTRQ3w1yLlR
	cseHNXAk09tedJV6BkRc0/vR7uYdIlMtvZSuh6YWD452mFCo3XxQchSIdjgg36AYQ2q8KkHDfCw
	f7f1L62ZaPxBwWfcxGpZv4czWfzU/voeka1UBAwyGdSE72AWzBeZJhbDpXUTXUJonh0SW1ZL6Tx
	WodwIcjzWWXHZ3PbvzalvxZ9gJbOSTjglO3CZJFetNIy+usuk1/yTiM/dlj0kvYQG8eT1yzeTq1
	MpS9qQtJdy/2fOUkCWFwziygNyOhUMkmGUACVGLOWvkC8fhLj9GTgCIeuhldeNOOHR+1gmG1b4m
	MqLYNwcJJkyHFmulro87aA13nfeoin8NdQOeApN3H+JOA4Mt5cOrnVrAraKEjP20wwteyIgFj4A
	0SNvl5x8jlYgSKmXDCuaBzCFGbXKonXJfrFrG9Iy1MPVR+BOWt2uIhQ7WGYQbpZ5UYds6V17Yxs
	yIr2nHt3w21YvHJcARuBlzWc05h
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-490c25b09a2mr318781815e9.16.1780993134354;
        Tue, 09 Jun 2026 01:18:54 -0700 (PDT)
Received: from thinkpad-l14-ju.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d60a7csm43053615e9.2.2026.06.09.01.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:18:53 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
Date: Tue,  9 Jun 2026 10:17:25 +0200
Message-ID: <20260609081728.30616-2-jakobunt@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Technically, the reset signal is active low - it's called RST_n after all.

But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
is set in the emmc. It is 0 per default.

For emmcs that have RST_n_FUNCTION=1 we failed like this:

	[    3.074480] mmc1: Failed to initialize a non-removable card

With this change they work normally.

Cc: stable@vger.kernel.org
Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v2: Add correct "From: " line

 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
index b7e669d8ba4d..90751b04f95c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
@@ -35,7 +35,7 @@ emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
 	};
 
 	gpio-leds {
-- 
2.47.3

