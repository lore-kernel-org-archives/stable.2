Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9921D3E8
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790471421; cv=none; b=NRby7rxv4W6mK1cf6hTXUYz15dOEBrzn6u07cyZWkoTH7+p+LvSoBsFmL98E/cj8bHCK22azTKr06IfOSn5Rbxz7M7KHnpjKnyB6RsXx31mcSH2tbXzxTyA/XeoN3reijpRJ+aRELh+mHXcrCh9Nwj84dqUyIvKyuWbApzCWP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790471421; c=relaxed/simple;
	bh=GNR4fpZUGJ21uZ1t/ZUAIEe6gTLZnkX4Ug2geMzO4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icpLlP7rrmmM4L/Ak91Htn2l+LUUlXaOUwFF8Yvrl0797HUTVNuxyvScAnEh85ShNFOcK0Zd5OOXu+7jWjlfVCuu/mfATN05sVhevKyYdrSWB4b7NmRulI8+Xek5kTHnqowXSCCQiflny2c7HG/r2Y7NeKKj+iEYMQJr7fegqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lizi.moe; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lizi.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so7211405ad.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 18:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790471420; x=1791076220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHub96pVZHtUuiGqtZ06K3QF0eNyRXbrpGkCUdoQKHg=;
        b=YGkfzN2KCzSgl3JYnZQEN0aTasu6uJTQ7iVHSD53AddErmKBV+2T5Rza3DfwTuDDAU
         ZJiMS51NJVJ47FYMxK0Yiv+E7SCLXiH7JCN8L1Na/XCOLCsWQkowNIIaqRQ0edfpXnvr
         UUbLZ+ukpSd7hlDOjkb6pH8rdwh7BYRjy9PxzRAWCvN0RDm4bgzzntEE9OZc3umivjl1
         faaFBmyJVIC6tXRz7DJXzQYJkMugFfFQhg4q99u2uxyDhASAqXf7Fq9Y2mzjUlgvagI8
         JFe1Okvh9NhvOkigaykJ/1banJFPlHADIqEI+Zfpr2ixlDh3qBscwEMYC39e7z4gOawS
         siLQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1JIe5yKpS35sHsmKoUL4DNOjwMah1AdS9d9fY2612ZmdLyZaFHNzNMZexPxrp57gs3OEXbeg=@vger.kernel.org
X-Gm-Message-State: AFuF++mxSTHxrqgm8G7/u9IYCnybHdkpWTQsRSqEhpvLcJ7AZ9pS399+
	C3/N4PrHe3vriiC7zMQtSeuADtdly2A+FIvpPFIm1rK4eDae8IXEvgjT
X-Gm-Gg: AYBFou37IbzLrn28QC0tvoY/CIp73ZuoVV7YZxl1pAuBDnjunz1Mfq2GEixJwHGxt95
	JGoNtAfiomKjf3aGl3rwkJx9Y2bL25ZP9f6/EcvhwpggJKbeGgXS5ODhZXeimzqADydr7ggklGh
	ej2op9bXE2RH5TD4gPc53oRwwcRwwRNQp9j7sT/kvmSXsGx+oniCmzcANe+2c0rDhGvnlBpuEYb
	c3g6utfeXejdczoYrVPnHG4OSKO3QiyWZmjQh4tRKzxjvF5fEI74wff90pReivF8rTyVAgYTo+k
	+yfq22vs10O3clUT43/NcecD1AXnCn9KYilFBRUbboHe+HspT0oaqP/w0bkKAPNYUXv+nAMGNtM
	CM0NxyDUrzu3V0DIOFvkIoSjP3xicS3XEe+nl3XqtUxNX1IA7ipoYlAY3NFijnYJeeGACmrHPQJ
	xhS/PGEEvCNRYPfQCPM1Q/WmyCBBvmRP7OQdaorBqxAeJhqx7v1ZCReCh+JQe0Q1CzhPj44rYj7
	3W8YRO/g0m1rW9ZkoNs
X-Received: by 2002:a05:6300:6cc5:10b0:3de:489a:7530 with SMTP id adf61e73a8af0-3de489a77c8mr1267646637.72.1790471419502;
        Sat, 26 Sep 2026 18:10:19 -0700 (PDT)
Received: from navi ([113.140.3.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feaf89651sm2514829b3a.41.2026.09.26.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 18:10:18 -0700 (PDT)
From: Zimeng Li <me@lizi.moe>
To: srini@kernel.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org,
	Zimeng Li <me@lizi.moe>
Subject: [PATCH v3] ASoC: qcom: lpass-cpu: use DAI table index for playback constraints
Date: Sun, 27 Sep 2026 09:09:11 +0800
Message-ID: <20260927010911.51980-1-me@lizi.moe>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAI ID is a hardware port ID and is not necessarily the index of
the corresponding entry in variant->dai_driver.

When configuring a DAI with LPAIF_I2SCTL_MODE_QUAD01, the probe code
currently uses dai_id to index variant->dai_driver. This is incorrect
for platforms where DAI IDs are sparse. For example, the IPQ806x MI2S
DAI has ID 4 while it is the only entry in the DAI driver table. If
that DAI is configured for QUAD01 and probe reaches this branch, the
code writes beyond that single entry via dai_driver[4] instead of
updating the DAI being processed.

Use the loop index i when updating the current DAI's playback channel
constraints, while retaining dai_id for indexing the hardware-port
specific playback SD-line mode array.

This fixes the incorrect DAI table access for platforms where the DAI
ID does not match its position in the driver table.

Fixes: c223f41c1a52 ("ASoC: qcom: Add four speaker support on MI2S secondary")
Cc: stable@vger.kernel.org
Signed-off-by: Zimeng Li <me@lizi.moe>
Assisted-by: LLM-assisted source analysis
---
Changes in v3:
- Describe the assistance in Assisted-by, no longer name the model.

Changes in v2:
- Add stable to Cc.
- Identify the model in the Assisted-by trailer (superseded in v3).
- Clarify the conditions for the IPQ806x out-of-bounds access.

The code change is unchanged from v1 and v2.
Compile-tested with LLVM for ARM using multi_v7_defconfig with
CONFIG_SND_SOC_STORM=m. The lpass-cpu.o, lpass-ipq806x.o and
lpass-platform.o targets built successfully. Not hardware-tested;
the IPQ806x example is based on static analysis, not a reproduced crash.

 sound/soc/qcom/lpass-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 242bc16da..079177a6d 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1234,8 +1234,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 		if (drvdata->mi2s_playback_sd_mode[dai_id] ==
 			LPAIF_I2SCTL_MODE_QUAD01) {
-			variant->dai_driver[dai_id].playback.channels_min = 4;
-			variant->dai_driver[dai_id].playback.channels_max = 4;
+			variant->dai_driver[i].playback.channels_min = 4;
+			variant->dai_driver[i].playback.channels_max = 4;
 		}
 	}
 

base-commit: 0ed6f7f62318a581fe9698f8a4e98c7ca01160e4
-- 
2.55.0
