Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A92EEE73
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690750; cv=none; b=V54i2GnzXgYm9KboaDSHQICcUv3DHgK8WyNcdmtDUtqGlRLFr15hgiBWdMU1lqBtH9DezYEFxXDAot//XqQYGeojF0i+0OCkRYybuJpsVF8QXKN+Cfj4kQm3yPrJrufiyidv2s2Pyg4bdcodf6m0Vg/ZmabItmCz4RaDCvcFo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690750; c=relaxed/simple;
	bh=OoF9Xm4zEceiVun1U4P/sU/e+H8GRtR4qWLoIVDocR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RnguzFs/ZnpGtY99Lmf2K0BPsuLKCf4jxaThB+JXyE6yztsRNE5bc69STAZo6/w9PnSKHl0D61RE+um/Mpfkzl5vQIaQm1GyX+WXzWf/0Iy2ems6KxDSTLz5axNjfQ5uwDP4XtHsdu7dIviUVGhQm4ugzm7ZiCQQbYITLmbg8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6OiBpFC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6OiBpFC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4908b92904fso26606045e9.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780690748; x=1781295548; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV2TWmv6e3Y0iXxtyydvRw2ubePqc7/64NdStyqTFkI=;
        b=X6OiBpFCrxJbjlJ03ze5J3NWppdVGJPXM2Q42Ph13oQBGQM9cn6lSHkocV/G8CMBSj
         ru1qdNZBg2Q/OObI2gGSRgyhzSaLRGz4lF1z83zBJjaJvwZd4/Zn/skQS5l4pRxtLtEg
         BD/tL6x9TtdpybmYIf2kKzml/xfGzyh2YP5qQvrb03zd06YydrnWewXYtjHcthGNcaDg
         0+7LmcUEqQ/j1VGNGihIdkXUzGP8yZBPCipqrIKQMf0dAKUvXmYRYpTf3obbCUHYJbAz
         cM2ukIjiYB8OPjJSHKdy3qnxy+YrnTrM3MVxm9rON2hqsfCHAkFci6gKBwz7kafJBgm1
         IFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690748; x=1781295548;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV2TWmv6e3Y0iXxtyydvRw2ubePqc7/64NdStyqTFkI=;
        b=Gz8EoxHSfxLdCaxTAcqgYXvNbXTI41NqBCc30mKqJX6n2+ysU2fGjjs8zuj8wMkdZM
         +UW4UzWNLbkpGk3/MV6R1juDNDe9rEonEURRM+ru4IdBURii1kt6QnwInim7t6P4oiGF
         JLplhSAdZz3LYKK3NPCxiB+/GlupwepIsqkCfglXhJ+19fLtzCEWsmKp5/pZQPh2ejjh
         +5A4+ritHuGZGXQWEI7ZNYzuTtZIfkaRmC1MiFiyy4pRkop4OGlfES8ZcnEkRt+TngZJ
         1oFs/nCenlqrDQxVLPA+LyWxFxkfRMxM/556otvTWOFKdP2wtnxtwhWs9eshB4g+FEed
         /7TA==
X-Forwarded-Encrypted: i=1; AFNElJ/F58r+8Vsh3/Kr0CHXxM4qtN+qJeoDwU/4wq+WkbZy6C1uXy9aXXkqKvkaQNO6xB5TkL99p1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtQJDzXV/Hxf6dXgQpW0CvP8g77xxqqyyWCMjMx2rUBWMBQCo
	Ve4qJg7MZKWvELlwrPwmTqSvsPA3XFGnix96w9D4y8sy3lFTYK0066142RW/zJXVa6w=
X-Gm-Gg: Acq92OGth1ZUyeyVW1sKbEO1JlaviI22qUJUfugWEX7dXAun1AMr0pSAtcNDgOdK9my
	KeZ2/IR7Ca8H7VluN06+/uQYMvgTzWGIvIiMEWi52REy9gNPtPRmGb7u375ZZYcxZB1cdnmAeYk
	ti8mAMJw0NnHbL98a2A6ez+L9dUs8+T1P5uStn2YbNdSRxi4Dg3BNUdwN8Ht0FoTZpvdGlFsRzb
	znM7IcWRzDTqgYFKdx/fWvicj/w4Nt20QFnczHcrK39OCg/p3KfzOoZodN1y5oNS4V0alYsYHCs
	120omPlXysOcbxn6P9oUV/IXQdiG0Jd8uKnJ6VB80Zdz2qhCDgWPr1j6Ty2Yk3cjZGPs91KRwr6
	zTjmHMsWMjVxo0hT9cA7Pz/d/V22m6DJlJsDpEcvOAafweqvMkBgfrjH3nttesMdqnyJInLpYI+
	vnWfUhfzzsYfI1LFKf0JVeBOUnURCj1i1CzNSD286t6MInOjXeCZVkyRHbMUND+7+0Xs+fIAEKQ
	peOIhpmJpDL8x5X+hyG8zUIQ2k=
X-Received: by 2002:a05:600d:6444:20b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490c26e1acbmr64974595e9.12.1780690747723;
        Fri, 05 Jun 2026 13:19:07 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm190533895e9.14.2026.06.05.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:19:06 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH 0/3] Exynos PMU fixes for cpu hotplug and cpuidle routines
Date: Fri, 05 Jun 2026 21:18:49 +0100
Message-Id: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkvI2oC/x3MQQrCMBBG4auUWTsQI43Uq4gLSf+0A5qGDC2R0
 rs7dPn44O2kqAKlR7dTxSYqS7a4XjqK8ztPYBmtyTsfXHA9o/3yoly+K8eyzsX8A07SoHzzqcd
 4j0MYEtmhVJxgg+frOP7sYMawbQAAAA==
X-Change-ID: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3

This was reported by Sashiko here:
https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
and was mainly introduced by enabling cpu hotplug
support and cpuidle for gs101-based SoCs.

One patch removes strange usage of smp_processor_id() and
other patches deal with a few missing error paths issues
here and there in setup_cpuhp_and_cpuidle() and around.

Tested on gs101-raven device, I don't see any regressions
but testing from others will be appreciated.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Alexey Klimov (3):
      soc: samsung: exynos-pmu: use target cpu ID in hotplug callbacks
      soc: samsung: exynos-pmu: fix use-after-free of interrupt generator node
      soc: samsung: exynos-pmu: fix error paths in cpuhotplug/idle states setup

 drivers/soc/samsung/exynos-pmu.c | 75 ++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 15 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260605-exynos-pmu-cpuhp-idle-fixes-32f5ed7c969f

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

