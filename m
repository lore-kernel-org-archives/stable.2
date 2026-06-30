Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2B37A481
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833206; cv=none; b=G6UTU/dQzCKYLuXuxpqMYm5XAUuNQJF4YmziZ4fyKtPCQhl2JUKBbyjJfYdnlPHBv5wmuRxaZNdu6fgVbPSFEtHx0DORLAPAErbmOf7efq5sscHFqiv7yC9zNlRBWfYZtUWKgmwfQUPB6uot2fy+keOOxVnh3dWSOhb5uzcfLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833206; c=relaxed/simple;
	bh=doSc5723l2PG2WxzuN3Ze28Lq5RF7ENx8sRWIhTL2QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrzEPQSLWmv+SxGpO7Ga4RyttceMg5k5eRloFmT1s7QmfY/1DAbScUOmMsFwNeTZdPJgORw/hQ66F0fB0z1DAIE3Rlmp8kJ7EyyMd+S1XnEliotZhcJFmYierE10E9SWjGWgu86AZXXeLHwhSQet9ZihpBve7OHbnAN3eL+4V2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nstg+tOa; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nstg+tOa"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-30df5854e1eso647005eec.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833200; x=1783438000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d35k5C/hmD6Rx5Ssjkeq6spgQa2fwGIsCqaARISvLAs=;
        b=Nstg+tOa1wJunxqH4j+NrpyIeTHVEEfilyQ/vUAG9/X8I4dnYK2LhjEHzaYfXT83so
         lpd+TrfwYLbIX2Lzz4eenjlOvECNI0TZj2s/E/ZcP12JkXQgtEafUamwzDzGlKG1SqOc
         slwvaEK+e3Gqx0QVcyvCqy5ULjD/UGgmAaM5yuSfWRz9dy2ZUlHQapzTc/U75M/nMV7K
         wxjJnQedPUBdO4ua42wty7llHUz7eT4Y3U9ckVWJv066CVOc76zWTwJ6m1J1mPEIiln0
         lWWhskJSyt853zL2GhofrpOOfN1dfsmzeUFHSEtTlG90wF+rWcEjhhOGvCujmvaR0cYs
         7NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833200; x=1783438000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d35k5C/hmD6Rx5Ssjkeq6spgQa2fwGIsCqaARISvLAs=;
        b=o4u2mqrKtWXsZoUNq/XtYSSS4t5P3tDTsoDt3fDy8q6OyeidV3j51JxFxikKOjIljd
         pVXzIImzvl0FA65ZP+rZ4b4MLkrmS+VWzhoETb+RLRzD2513mUV6fefOB+jE83INSrp2
         pxCofXEEUGiqa17071cjQNld7iLbDtHDwbC2sm/viJHZF7b7bKChSdZpHkwoLTDS0irb
         OAFYukYEvFh4mfkSuV4bv+TgjAMFmrdILfByBPZJJq83g2/59++mG+lePJq7ehubbO9Z
         3onx98ui5XjI8S7PIO5IoeXLL/VICC0PkYhL2hBHxlhfYqkj7JxQELQ0ZmZ1mpeBFjL/
         ZWJw==
X-Forwarded-Encrypted: i=1; AHgh+Rp36X42L0AcHA0KBDEivBTjb5rijQoJHUosYJhyPECJ9J5KeJC0ROMiAW7Jzv12PqQrqFp28VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVQUQNmgmEAT+LzrQvEi0MIrfQ02Pj1wGhDYBJAADbrh7ahp8
	u56sta9DRSS2rh2AiTg4K97SbEQQoK0WSS+x4eLqeMCBt9gnM+5Sb0Z2
X-Gm-Gg: AfdE7ckXxx98+2lUQRolSuQp61ZAx9A2s/jecMS3sqGcIdLFuFP5Ww9bPmEVAkg8dmd
	7dhWTaD38EqIFZe3uQf0xNDnS0CLeJANnhSe7wL6igG+ENtYBAJEF64sSoaHh0y+0Ux0fnlRKl/
	dC3PLy6366CBbTmQjHXfDc1zccAu0l+0P0uihoqjjkGZAJeJDBqT/x0DTOqSTPqJ132tCtlgyWr
	uBVkXZT1yvysjOgvKi/gsrBdopPxuNQyIjqUf3U/3eDcJFgnuBTJ11kPrVDB8u1WfahQysxc4fR
	PIT/iKY8km2RiXzf+MAPWKGQEF08Ut4pWuAe3tp2itlJCdP7Neio332CGVmzXJ1SGt4lNf0IUoq
	WI2cqNHf+u9ibCjzrtP6j3fj9xqzenjmIUG6A90g4E/LZ6S9ZZjit+Uz+LWPBYHcRAnbrymPnaF
	v3XY8QOR7LMUM1jmj6PXti9kfDKZXszD/SqYwxeC57eWJ6
X-Received: by 2002:a05:7301:46a0:b0:30e:d6b3:ba54 with SMTP id 5a478bee46e88-30eea0fc2bdmr1153386eec.17.1782833199855;
        Tue, 30 Jun 2026 08:26:39 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fc21casm8995033eec.10.2026.06.30.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:26:39 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linux-media@vger.kernel.org
Cc: vikash.garodia@oss.qualcomm.com,
	abhinav.kumar@linux.dev,
	bod@kernel.org,
	mchehab@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v6] media: qcom: iris: use disable_irq() during power-off
Date: Tue, 30 Jun 2026 15:26:17 +0000
Message-Id: <20260630152617.568-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ is registered as a threaded IRQ.

Using disable_irq_nosync() in iris_vpu_power_off() does not wait
for an already queued threaded IRQ handler to complete before
returning.

As a result, a threaded IRQ handler may still run after the VPU has
been powered down and access hardware registers after power-off.

Replace disable_irq_nosync() with disable_irq() so the power-off path
waits for any in-flight threaded IRQ handler to complete before
returning.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 69e6126dc4d9..538659284c7b 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -236,7 +236,7 @@ void iris_vpu_power_off(struct iris_core *core)
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
-		disable_irq_nosync(core->irq);
+		disable_irq(core->irq);
 }
 
 int iris_vpu_power_on_controller(struct iris_core *core)
-- 
2.34.1

