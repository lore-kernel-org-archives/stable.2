Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35F31D759
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780287304; cv=none; b=NI8w9QjKZEVseOZJdnSJDutWD9R2FO7XJksWT35Auzuwkorcrii+gvXTYQRnVlpF9JL7GZ+5qSocMhvz6OapOsOD1UEIBtGskyGooBJiZPOWTipEh96aU8SBhCRGTET80HJGEgk/hDF1ZLUxZ+gVp+YQjvgfsrqrKKSANuzPkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780287304; c=relaxed/simple;
	bh=qP1yh5897y52gQrS74KSiUYqrl7D3oKp/uam3uTjwNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kge2Teuj/9U30G+lghu2nHcco8IIFkYn+Lk0sJGNJSq8DCQNwJDvjp+zWRtGtpS6FMYZhASH/d693s/edAzSNvaSDAVRAvmuKEHZPBTgZmGpKgKKtSSuMPrCLBC8smCinopA9wu0DhMbYlmQa0TasXQCeMPn6BaKPLMvLhLoeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=OBQu9TFU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="OBQu9TFU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so5741605ad.1
        for <stable@vger.kernel.org>; Sun, 31 May 2026 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1780287301; x=1780892101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY0Jgb/4pMElVA1zHn/XIVXj9XsaeotvHlofGf2Tv8E=;
        b=OBQu9TFUlrgkRa0pqSee9VE6S4ewBtzjEs5r9lxuWGntjsPgRyEpY+NQAyXv1HQxD2
         EnFEEZtTq19D10YeRd1SbJ6H7z1eR0vOXKEjDaq1HHrsZzO5hwgTlPm9zu11KwhO4Y58
         yQr5v/WflKgcWzALA0GOvAJxIMEzlAfF97W9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780287301; x=1780892101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bY0Jgb/4pMElVA1zHn/XIVXj9XsaeotvHlofGf2Tv8E=;
        b=K+L+izkOBxHGtMChaH60gJ6SZwLecRMQIe8DEOdr6k4XSX4kEYeXTah7LYooBUVxwG
         9kbYQKM/NgPxZ/awUbsLZxGCtBP+IU/zSXiWdt09ngaV+93H7u4SNHqC7K/SI0FJSVqZ
         Q3uEKRo3XxKB+SdHuzoiITFVPxmlvA1+ruleF4pTnp8ug+Y8x/8fpWNMYLAq4otN3+q2
         QkzQZRWe7kYZklik+r1Hry+QE7Odq955XLr09egjBUTSZ1xOrlZ5f+A043/CW1XvBgZm
         IvOPMp6SxKtM1N3akjzp9ejGawPPTdimd6cIc5mETB7bgBLlDf34XWlvVEpTIYueqCU5
         I+oA==
X-Forwarded-Encrypted: i=1; AFNElJ97QBWtm0+gW4Yxc+kYIMFgiZP3CqnFCixHHagYUtaRfm/ZqR6RJHwy5jMNaKK9q+62pX5DHLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDy4Pps5CmYNjCaT2UeWx691u8sNOVpDCr0yNVU90S4VzDRPv
	YIH/5iex5ePwr0e/Lu2BDPlCTsW+QKAsjsDq5NpDUdgtroIIpGoiECt/XtoQ2HuAtrg=
X-Gm-Gg: Acq92OG47ROc6tNxKT+78atxY4Fcr3v0E3yNo8EitvvyuBz+Z8ks+3EG28LC8388ZA3
	Jxe3sjU3Un71zokLg6FKsft07398dkV6VXjHsBGVGeNyY1YV1Pn6aP7+5x6e97uzHbB/wbFeE+H
	op2h+dGyBsgu59tTY8ve6gShIlXsiZYdeUIFiEf/evdO4jEb9rT0c0wN4d3e2vI2NtAjilbE58M
	JyMiizi1qL/N9isw/VXJ9Cs7XyiM7M+6p3GaXk17ec+zSgg4skV1yzsFkEzlD1XYUi9utqQfZ89
	pxX4++xai/B3o96UvrzLc0wFpMGHpN6YAPGX7AOXYtkdYoR6rmriktLOMu+kPk0wp9FZD17FGN/
	8SVXeXltyD0UUEX2uEopVYmRGkCCyHTCL6aBnQEtRgIphwPoXh10vzk68wt8XizbFbm0RHcL/lm
	kefiaw96K/PwazOtyABTYwDAoVMB+722GDqmMNfZgNOoWmtY2aDgOql75S/AqB99yjWEApb+iRS
	IW5BikKmfFrXJNRA94ZMwEFaNbm1VAJjWKEKUzVFYVy43fbWPHsH9pBuQXM4H9yw7CCtZKnXPn+
	RmpGoorxhYEDdEKrQNEae/HTQ8GKQlE96Q818R4Rin5/OKxfDjx9aC3eXOBJdanwfm0gyaAaouf
	nUm8=
X-Received: by 2002:a17:903:1207:b0:2be:bb7f:ae2f with SMTP id d9443c01a7336-2bf36846815mr104349185ad.27.1780287301511;
        Sun, 31 May 2026 21:15:01 -0700 (PDT)
Received: from aegis ([175.176.67.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3f496sm92980405ad.76.2026.05.31.21.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:15:01 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: "Bryan O'Donoghue" <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris
Date: Mon,  1 Jun 2026 12:13:34 +0800
Message-ID: <20260601041336.9497-2-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601041336.9497-1-daniel@quora.org>
References: <20260601041336.9497-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
triggers unhandled SMMU page faults that cause spontaneous device
reboots. This is readily reproduced with web pages that drive
multiple concurrent video decode streams, eg ui.com.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000)
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

This applies to all current hamoa.dtsi consumers (X1E80100/X1P42100/
X1P64100 boards); other Iris-bearing SoCs (sm8550/sm8650/sa8775p/
qcs8300) do not include hamoa.dtsi thus not affected.

Backports also require the preceding binding patch ("dt-bindings:
media: qcom,sm8550-iris: Allow IOVA reservation memory-region");
without it, dtbs_check rejects the second memory-region entry.

Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..e2af0bc5e064 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -724,6 +724,15 @@ smem_mem: smem@ffe00000 {
 			hwlocks = <&tcsr_mutex 3>;
 			no-map;
 		};
+
+		/*
+		 * Iris DMA below IOVA 0x25800000 triggers unhandled SMMU
+		 * faults on hamoa platforms; reserve the range so the IOMMU
+		 * layer keeps allocations above this boundary.
+		 */
+		iris_iova: iris-iova {
+			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
+		};
 	};

 	qup_opp_table_100mhz: opp-table-qup100mhz {
@@ -5479,7 +5488,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			interconnect-names = "cpu-cfg",
 					     "video-mem";

-			memory-region = <&video_mem>;
+			memory-region = <&video_mem>, <&iris_iova>;

 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
--
2.53.0

