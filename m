Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB724BD355
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689595; cv=none; b=GOX9hl43NX6qhqVeUPY+imX+10FocmkYnsct0IGJtaJWytXKVMro22BUXKFRZD1bZXUuIhtnmRLqd2AMgHhB5Habjc1+eRqgB5o/y2vcGrk5mAhkLQ3iNm0ylV5HD+p0QnUgo1l03W7YwhpBn2ZTU1kBE+wOHIJU9sIvuCCdE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689595; c=relaxed/simple;
	bh=X5fBI29rdRgQVD/lVN6Y+RY6XP/n3DxCK2eTWygRAJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1z7gOpHXjHB6u4yK8TFi6hCylaaeahgcPB6zMGTn/FgI2mZZbYuXCYAR6NTDFHbUHrc4q/XUiSNnc9p7jF7tPfjOwPZr40fV187N6SLqGM/qnJph9M6WTx8hatrojH2Qs+3XY5NNSckYtD4NJEJmZOnUNxgnlfwi0AtFh+WcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnfiiOZF; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnfiiOZF"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b4bff33d18so63659eaf.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789689585; x=1790294385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXNjnaKjCC9zA9Voyk96teJyXfaJqLPqZodkmIpeNdc=;
        b=bnfiiOZF9vVf60nLw/WuDtszEvQJREgpavcWGqg8LOBIW98u+ziHqNVyvWimISovqh
         FEfY5wevRgbIIfZgluZjW0TGKlHcaLPb8QrBG7F/Ykba7/tboZAS4RTK1YWecZsrE7cm
         lqseVNuonJMhkRcpp7x42MwgAQUp1APM1YfhpvIAD2h/0NCSJ4JzH0gKV49WdwQwG6r0
         2Kd5K1+KuO8Yij1inpsK8/W24QzGWJqe6fBoPP1/1xjCmTC6WLnLaNWwnqdncnt/vEx8
         JqiJjaPEq09QgwT5vgINdFaechkY5Uil5DMew1/hlFE+Ma/kCobE35ZEZz3ADpn9XIZ0
         YL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789689585; x=1790294385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXNjnaKjCC9zA9Voyk96teJyXfaJqLPqZodkmIpeNdc=;
        b=qSUXZyR3NBFbtGcp7kUtC+nrks7yxcaJ38U4Bif20nwWhv+LQM6zPqTaijsr5cVFLN
         qmoj2SQzeGURtzKvhM5YjqxmOqCiJgFKVGcL9ogquTNkzTo8OrjmISUwf9+dMo7sP4CX
         T5Hp/VxlOT5mG+jWk3+qU2f/84KGHzKLbQhMz48XITe+wNxj3yEPP/oAq+GslKnPjiS/
         Y8oLu+vinYmCYYxahYo5dzQJJUbFhBe8m4Q5gruEoQ2H48V19+ShH9J+AsVWgMpF3IEP
         xO5Lo+R8ahNUqZFIA6wO/QNA/g3V4ghAqcCZ7vMZ18hDxiv4NFNdovCIW4IE4+O9Ze2s
         dCvA==
X-Forwarded-Encrypted: i=1; AKwUvBzT8s6CI4l3L9T62Q86090Mqa80EaWQLfcUCSGxuobHBwxPoZ4++7zVfDrWsSCd9156Mt918fI=@vger.kernel.org
X-Gm-Message-State: AFuF++lMVLrfDhH0Mg/kVTh8L7h3WKFYmAWaGDMvl+wPbGSl6AUi4L1l
	oWpyY0Xa7iO2fQfQsID/pplWj9vD1MMHZL1fyDwd9R2WTpBkv71e2eV6
X-Gm-Gg: AYBFou1kdTqnuhmTZkyAF6gqd1Tx68MbXNAJ69jMB2z9E7UBVSUPWqIIGUpexMYi3P9
	5R+X2Iwd5QkxGAPIfdClDWHHYEucnxvu2Zuh45CPS/A2mb/x+Sa1LO//iCvnpcCJCEdsoaEX0pg
	23RJK8UvpLvowO1IjA9LOm5F53u1ypo+Q55QA44EYqtYa4tuy90k8cqpr0+7pCknys+4Nite8vi
	txvvrFdQsnTuIwreyWu9xQ9csT5KotKM3SbhCDfHEs+B0qtAHxhYc2V/QGtF2e5WeL1vl68l12F
	rHdSL0vkvdnT6+WNcTwSk0EC74pHYotVNWjWZX7UFeSkn0MWke9d6yNPrnuxJLFCDXk2Rc/kR4d
	FcejK7ohmKifjGJKa2kVXZd779d4ZVJI5v/YOI87l97YzujEYXixh9NS31Pa/PWuAxyHQoG4Bbb
	PNr4ga7KfukE0NREgPxQTOPtxHizq42P/BSqYAzL1EqSAwfLjCzrOwX2iA/6JNdWe+WAgG+3jAB
	n8/lV33jG56Z8Rws2SnTwrlKrW1pHxGxOKoOk4EE0m+Ow==
X-Received: by 2002:a05:6820:4d06:b0:6be:7782:5a40 with SMTP id 006d021491bc7-6ca9ac3f6f7mr779525eaf.28.1789689584793;
        Thu, 17 Sep 2026 16:59:44 -0700 (PDT)
Received: from cachyos-x8664 (fixed-186-96-141-48.totalplay.net. [186.96.141.48])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4870b228179sm237307fac.9.2026.09.17.16.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:59:41 -0700 (PDT)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Subject: [PATCH] memory: stm32_omm: fix child clock leak on set_amcr() error path
Date: Thu, 17 Sep 2026 17:59:25 -0600
Message-ID: <20260917235925.44185-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mux is enabled, stm32_omm_configure() enables the two OSPI
child clocks via stm32_omm_toggle_child_clock(dev, true); they are meant
to stay enabled for the device's lifetime and are disabled again in
stm32_omm_remove() and on the devm_of_platform_populate() error path.

However, if the subsequent stm32_omm_set_amcr() call fails, the function
jumps to the "error:" label which only calls pm_runtime_put_sync_suspend()
before returning, leaving the two child clocks enabled. As this happens
during probe, the error is propagated and .remove() is never called, so
the clock enable references are leaked. devm_clk_bulk_get() only releases
the clock handles on unwind, it does not undo clk_prepare_enable().

Disable the child clocks on the set_amcr() error path, mirroring the
cleanup already done on the devm_of_platform_populate() failure path.

Fixes: 8181d061dcff ("memory: Add STM32 Octo Memory Manager driver")
Cc: stable@vger.kernel.org
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
 drivers/memory/stm32_omm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
index 84eb23c824f5..3599683ab04a 100644
--- a/drivers/memory/stm32_omm.c
+++ b/drivers/memory/stm32_omm.c
@@ -274,6 +274,8 @@ static int stm32_omm_configure(struct device *dev)
 	writel_relaxed(omm->cr, omm->io_base + OMM_CR);
 
 	ret = stm32_omm_set_amcr(dev, true);
+	if (ret && (mux & CR_MUXEN))
+		stm32_omm_toggle_child_clock(dev, false);
 
 error:
 	pm_runtime_put_sync_suspend(dev);
-- 
2.55.0

