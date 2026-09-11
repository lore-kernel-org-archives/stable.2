Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C191DF980
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085737; cv=none; b=dP2F+a1rlxtJJa0dL0T1BCO8saHSUN4han0bfTBch8tIn56qkPHmNntpiK8E2nTZfFOSUlw9vot50WRna3kH5LxlMiMERCE1qPm5Tb9TX38mS7fH8OIcbzvQ/aB+SGARdx/wWojk4TAbOOQ8tmrcOj84HnKGaRJoPUkVC0UsXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085737; c=relaxed/simple;
	bh=/1rNP0Ahm84/EjfO6qDbRODv+gMHgSOJbY4lKeBMOPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD8KFfHAZ+GdPET5ooJ3AItbelRc9S4jpfT2oSmIxbwc6wYns9Zma7IPmh0SxS/UUTslKCqE/Dxy1+Kuj8rTicm7NwA2GfmnpKad5KP1z+SVNOXnbzzane2oyDQcLR4AAwuOtNMEKR6pkr/zLEXuRjtkUQtWH7LkQ7ZLuKwdr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m98tg+FV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m98tg+FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D31F000FF;
	Fri, 11 Sep 2026 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085735;
	bh=Y9J7AYRZczgl5Q3YPZy1CvJKS9t4RJsxEG/ewO/zfKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m98tg+FV4emRGGTkxxKy9PYwvbcW+fJ6tInebOBCdQXz4Uokev34x6GWzEZuI3NB3
	 R5yu9kJ7pKbW0VG/w1lVdzXGKX0h0PVOoJfUZx3MWFUx/MIKWKUetkKAND6I6ZoJlh
	 ZFE2DO733A9VzJraqztZDiChJ4+tfqixFszCJ4zH0nqsiTnZlkYbXwaSjbAh6Nj8PS
	 1UrMgkfOJyedbZEeAn2uYXIUaxcJeJw7Z3C3k5GjT5qWL7hniLf3bJ6rkVAx40TX5k
	 Yh+ll6JlgtKGsgNELo+ZyabO4uWcgzjPBRsc03awUpmb44AlX/jkYv2z1tLGc94RJ+
	 zScwLdTryrcJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] i2c: qcom-cci: Do not check return value of cci_init()
Date: Thu, 10 Sep 2026 20:15:28 -0400
Message-ID: <20260911001529.3302151-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911001529.3302151-1-sashal@kernel.org>
References: <2026090910-covenant-freestyle-77a9@gregkh>
 <20260911001529.3302151-1-sashal@kernel.org>
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

Stable dependency adaptation for 5.10:

Resolve the probe conflict against the earlier dependency's IRQ cleanup,
which renamed the failure destination from error to disable_clocks.
cci_init() only writes registers and always returned zero in this tree,
so retain the void conversion and replace its checked probe call with
an unconditional call. Keep the real cci_reset() failure path unchanged.

Retain the separate cci_init() calls in probe, queue timeout recovery,
and runtime resume because this branch does not have the later upstream
refactor moving initialization into cci_reset(). No functions are added.
The target f98d49864821 applies cleanly with Git's three-way merge;
its runtime PM cleanup changes remain in the target.

Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index c13cc1509b166..e11aa8e495020 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -247,7 +247,7 @@ static int cci_reset(struct cci *cci)
 	return 0;
 }
 
-static int cci_init(struct cci *cci)
+static void cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -288,8 +288,6 @@ static int cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
-
-	return 0;
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -634,9 +632,7 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto disable_clocks;
 
-	ret = cci_init(cci);
-	if (ret < 0)
-		goto disable_clocks;
+	cci_init(cci);
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
-- 
2.53.0

