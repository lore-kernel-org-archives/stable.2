Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA03B8406
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058810; cv=none; b=XExW7RxU5Jh7dJLsdnoMkaRFJvqk0itlWXQk4vTGFzKjZTiCvMfl5ApVMl0Ot3BgGSHoN0+tFO5xrAPOAkaaXK9mo7Bs5PDxSCvEM7xN1z45peghU0GYbphtQ7obwDpEEKhAjSW0o09qr6NCg52xh/lzSGJGMM86auQgU8MigF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058810; c=relaxed/simple;
	bh=O8HM4+q5Ye/cPWUS2BT8Wncms841/goBUH8TO/fyW4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui2vbRsinWOfWOJun5hwA3T4D4nhU9aEX+Qax+S6L5iq1EN3NNkktsh1mSo2OMILvxpXP1xci+lP9UexHvO0dCZHJKZwLLsch5qPE4IQSaPZMedjNjk4jc+dEEnOQfJP9XxfnpBe8RBr0yuCFNKE6RI1IkN7gxkg65WkMWjml0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC6SVrRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC6SVrRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06A11F000FF;
	Thu, 10 Sep 2026 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058805;
	bh=9aMIiDRO4WVqKyuKAiy2weHAKtCr756f06vw2HBX/XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WC6SVrRlXxnZyWJKuKlqSYLhautuXJ7FfNSWhftk34VI02YGawFEzXf34eg2VqW7P
	 HrUNvQjcwruceYAnQTOFZADXpWemwGey1Cz3bfdDCEC27YPa0DWiuPeD9phSe/XYHM
	 IhOw0FeWK3vMPz3wp4d264PXXA8VZ903fU94AjdHiaOgUfLZWm61dHljDwnrkvrvZr
	 0S/ihi/HQS+GFklL9ZU0NrGxdE7QVym+9I0zkPze3RyFYMExQ1IXaoC27JgqKwfa7d
	 bdohCVrOyZqiR2DrcPGLvLoyj+vhEFsHl15IV6zdGnLRLfgACrSrCES8q8S7Uql8mg
	 fQslSmtMNSkJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] i2c: qcom-cci: Do not check return value of cci_init()
Date: Thu, 10 Sep 2026 12:46:40 -0400
Message-ID: <20260910164643.1250786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090908-bobbing-backlog-313f@gregkh>
References: <2026090908-bobbing-backlog-313f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 17c5d247e3e4708cac05ff087c8013c0dda383a2 ]

The cci_init() function is not supposed to fail, and it never returns
a non-zero, so it'd make sense to convert its signature to void.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260515234121.1607425-3-vladimir.zapolskiy@linaro.org
Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 791e1a9fd1ba2..a72455dda58c2 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -246,7 +246,7 @@ static int cci_reset(struct cci *cci)
 	return 0;
 }
 
-static int cci_init(struct cci *cci)
+static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -287,8 +287,6 @@ static int cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
-
-	return 0;
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -598,9 +596,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error;
 
-	ret = cci_init(cci);
-	if (ret < 0)
-		goto error;
+	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
-- 
2.53.0

