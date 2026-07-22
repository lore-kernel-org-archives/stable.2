Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63083EA957;
	Wed, 22 Jul 2026 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707025; cv=none; b=V4RvzLua4Ou2SFl6W2aj8qZN0gvZpO2GwCasyp+M3Rhun+msvnCCpKQIhXuvPUSqjydt80Unj6Rhyz3i62hzHjN4vaOls/BAEUFuVp6x47DLdVkyMm7AKzjmPqUin4j764MKXXxobnYpGQxqhfUEjgdk02xLlKoOeKsvyECSaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707025; c=relaxed/simple;
	bh=lgYHRmXyfFLmY4PgSfB2rGzdrDFMyEVA2+ZpR28zC+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An17k1O/gSg6UfVVddx9mXKNfscx6IawMAWRRmXSWTjeMsbylHpnd4tlEYmH6mN3zucyK5QidAdKWvDPT04KnI9yrXC794LRKemX+DbSRbc0Os16iLj58j8tNldzExgoxJybKitR4a7FP6IohloH0toFR8riZ7XZG0rxiFbwISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5fd4ca085a211f1aa26b74ffac11d73-20260722
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0d6e5194-cbed-4433-be23-d14ef524f2fe,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0d6e5194-cbed-4433-be23-d14ef524f2fe,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:2dee7de93c52b85bc6510bdb81b05211,BulkI
	D:260722155654I1AGSK68,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|136|86
	5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e5fd4ca085a211f1aa26b74ffac11d73-20260722
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 844874772; Wed, 22 Jul 2026 15:56:51 +0800
From: Can Peng <pengcan@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] thermal/drivers/qoriq: Disable clock on resume failure
Date: Wed, 22 Jul 2026 15:56:25 +0800
Message-ID: <20260722075625.452684-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qoriq_tmu_resume() enables the TMU clock before clearing the
power-down bit and enabling monitoring.

If either register update fails, the function returns with the clock
still enabled. This leaves the clock enable count unbalanced after a
failed resume.

Disable the clock on those failure paths before returning the error.

Fixes: 51904045d4aa ("thermal: qoriq: Add clock operations")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 35439ec5f8bc..297724e81593 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -415,11 +415,20 @@ static int qoriq_tmu_resume(struct device *dev)
 	if (data->ver > TMU_VER1) {
 		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
 		if (ret)
-			return ret;
+			goto disable_clk;
 	}
 
 	/* Enable monitoring */
-	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
+	ret = regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
+	if (ret)
+		goto disable_clk;
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(data->clk);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
-- 
2.53.0

