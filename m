Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C447ACEB
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933135; cv=none; b=iQu+uSLv3ZZ9kMkpctLz+8dMOM2QsinpObiz/Gwm7Vbc+vVcFJvIAjsZTWQJhP77g3xlRZ3XNqcnjcx26lUlvcly/cfH1ZQlDXAUWl/FWP3MJxTdkHIcnH9jk0lGzPxV74Vx6JAxIqzE6lEP0NfWhYTjCywtiDy4Ql1nGdQVrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933135; c=relaxed/simple;
	bh=19HvXXEGNkAEh7k742QsXcb6guSh20svj/hb0jKC2xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJgsGbJHy3Np5rF9RAsbAahx5IFYTBQ/ufLDaF/l2//yGuNGEO3H536JYns0MgSM+xHn9x6841ebg6TOyLDJODinHHzIhkbrgGC25jr8siOrSGrjhlDzEMvwEuyq2Z2mVOIGFHfOh4LuXijFdGV3VeW/Q1qoUgO6zzJXrWyvflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lizi.moe; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lizi.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so1311854a12.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933133; x=1790537933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7TXkf8HfG5PaX8N7Gibawm3cKOzVqiXxqGBVj7YLTM=;
        b=ZP81FF6dXzp0qxLuBDXBBF0P/MlTy/eR+OYY83Ud4pDARU+cuI7Zgrnkl3gHrJcZCK
         4KF66ScT+FfsghtQ1fM4/1W7K8sT9D2MS5xA48OBlpL1ExnFisrygOjzBK6Dlrs1qtce
         Ej6MnMnQ68+WAJzUH8LhQVYvTrnjOMeK51KOi9Tp+SXLod7EVFYp4RZ0b0G9mAtsX8Hv
         uMW5Umi38TMYj/Gc0Mf2mbta98y+ZqpKEJqT2VSTzoH+0cKt9JAkR4qCZvjG6W44/jH8
         cZdnlU67cVWy45jLlmP06iZVmHDD/B3K5PVBn+ODbGsFoEkNW6xpozM7QKGgHh0VUj8H
         +KXw==
X-Forwarded-Encrypted: i=1; AKwUvBwXANAPZZg7ilS9CuW5JOmp99Ezj0gdBY7l5aQWxZ2kxgXNvlImmI+z53DP4gwUg2lfLtMqMzU=@vger.kernel.org
X-Gm-Message-State: AFuF++kraz0oYB3GfHZhtSFA7q7LjeJIZJdVvhAEuyVUFfpD5D0FOcdz
	aZ6SpFPQL9Z60JWVYZ9/NS9V3F5JH7RRM+zxqvOcmTog1HhItfXX8X0M
X-Gm-Gg: AYBFou0eobhSO8NFI3m//Tp3ajHkySlZG8rGjbzfPMOHuo2TkQQyLY2istJhG58S2wB
	YTywNrmFkdNTe4oOGs8WIcBJIjE2jx7KJVZEiRNnSbmyayCWjh6JmiErqF68XIdG6xhxAtwbPdl
	yDcWCQVrJxY4n69qMn1obS6y6Ht5b2/40eIeh8xJn9ahHIxehWsP6FqMLUrTUnIA/cFmyxxr8yh
	aXSp+wxGz5GhFruwzpA0Hw+92BCqT9A7f8Eq8kWRTNJF6QrSz9004YeDqSlurCQkur2SY30b1iC
	ZGOkMRS2ryMzHMwemfHrcJeqfbCc2y+PD2tF/mslKZbBZj7wG/GCmj34BIDzNMmPT6pYntPfve3
	UgSgxxRm8XJamjmQQPBNKs7rdMsyRqNadoSFrlkpWQcR0HWIpBq4apkCM1E7ZXHnWL9xSM0DsA8
	cDPaf3h7RCv3SJ+z4kKnf8eLYMRO5s3R1yDXGmcAXM9V+gZzgP7SxzLzBaRXA0kA==
X-Received: by 2002:a05:6a00:f86:b0:848:76c4:fba9 with SMTP id d2e1a72fcca58-874dbee3c12mr12028698b3a.7.1789933133005;
        Sun, 20 Sep 2026 12:38:53 -0700 (PDT)
Received: from navi ([61.185.198.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9b0c516sm2222132b3a.34.2026.09.20.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:52 -0700 (PDT)
From: Zimeng Li <me@lizi.moe>
To: srini@kernel.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org,
	Zimeng Li <me@lizi.moe>
Subject: [PATCH v2] ASoC: qcom: lpass-cpu: use DAI table index for playback constraints
Date: Mon, 21 Sep 2026 03:38:30 +0800
Message-ID: <20260920193830.53706-1-me@lizi.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920145848.44521-1-me@lizi.moe>
References: <20260920145848.44521-1-me@lizi.moe>
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
Assisted-by: GPT-6 Astra
---
Changes in v2:
- Add stable to Cc.
- Identify the model in the Assisted-by trailer.
- Clarify that the IPQ806x out-of-bounds access requires QUAD01 mode
  and probe to reach the affected branch.

Compile-tested with LLVM for ARM using multi_v7_defconfig with
CONFIG_SND_SOC_STORM=m. The lpass-cpu.o, lpass-ipq806x.o and
lpass-platform.o targets built successfully. Not hardware-tested;
the IPQ806x example is based on static analysis, not a reproduced crash.
The code change is unchanged from v1.

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
